<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.Product"%>
<%@page import="model.Category"%>
<%@page import="model.Inventory"%>
<%@page import="service.ProductService"%>
<%@page import="service.CategoryService"%>
<%@page import="service.InventoryService"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>

<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

ProductService productService = new ProductService();
CategoryService categoryService = new CategoryService();
InventoryService inventoryService = new InventoryService();

String search = request.getParameter("search");
String added  = request.getParameter("added");
String catParam = request.getParameter("cat"); // categoryId as String, "" or null = All Products

List<Product> allProducts;
if (search != null && !search.trim().isEmpty()) {
    allProducts = productService.searchProduct(search.trim());
} else {
    allProducts = productService.getAllProducts();
}

List<Category> categories = categoryService.getAllCategories();

// Real sidebar badge counts - same source used on dashboard.jsp / lowstock.jsp / notifications.jsp
int sidebarExpiryCount = inventoryService.getExpiringItems(7).size();
int sidebarLowStockCount = inventoryService.getLowStockItems().size();

// Real live stock levels + per-product reorder level, keyed by productId.
// (Product.quantity is only the initial seed value and never changes after
// checkout — the inventory table is what actually tracks live stock, so
// that's what "Low Stock" / "Out of Stock" must be based on.)
Map<Integer, Inventory> inventoryMap = new HashMap<Integer, Inventory>();
for (Inventory inv : inventoryService.getAllInventory()) {
    inventoryMap.put(inv.getProductId(), inv);
}
Map<Integer, String> categoryNames = new HashMap<Integer, String>();
for (Category c : categories) {
    categoryNames.put(c.getCategoryId(), c.getName());
}

// ============================================================
// PRODUCT IMAGES — paste your own image URL for each product ID below.
// Key = productId, Value = full image URL (e.g. from imgur, your own server, etc.)
// Leave the value as "" (empty) for any product you haven't added an image for yet —
// it will automatically fall back to the default image.
// ============================================================
Map<Integer, String> productImages = new HashMap<Integer, String>();
productImages.put(1,  "https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Apple 1kg
productImages.put(2,  "https://images.unsplash.com/photo-1603833665858-e61d17a86224?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Banana 1 Dozen
productImages.put(3,  "https://images.unsplash.com/photo-1590868309235-ea34bed7bd7f?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Carrot 1kg
productImages.put(4,  "https://images.unsplash.com/photo-1582284540020-8acbe03f4924?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Tomato 1kg
productImages.put(5,  "https://images.unsplash.com/photo-1590165482129-1b8b27698780?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Potato 1kg
productImages.put(6,  "https://images.unsplash.com/photo-1604503468506-a8da13d82791?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Chicken 1kg
productImages.put(7,  "https://images.unsplash.com/photo-1534948216015-843149f72be3?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Fish 1kg
productImages.put(8,  "https://images.unsplash.com/photo-1579113800032-c38bd7635818?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Fresh Vegetables Pack
productImages.put(9,  "https://plus.unsplash.com/premium_photo-1674382739389-338645e7dd8c?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Mango 1kg
productImages.put(10, "https://images.unsplash.com/photo-1611080626919-7cf5a9dbab5b?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Orange 1kg
productImages.put(11, "https://plus.unsplash.com/premium_photo-1705338026411-00639520a438?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Rice 5kg
productImages.put(12, "https://images.unsplash.com/photo-1627735483792-233bf632619b?q=80&w=1185&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Wheat Flour 1kg
productImages.put(13, "https://plus.unsplash.com/premium_photo-1726072362679-2b2023862024?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Sugar 1kg
productImages.put(14, "https://plus.unsplash.com/premium_photo-1726072357017-0af7b90a463d?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Black Pepper 100g
productImages.put(15, "https://images.unsplash.com/photo-1583949885751-23b7d1909378?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Turmeric Powder 100g
productImages.put(16, "https://plus.unsplash.com/premium_photo-1726072356923-bf1a9f8faeb0?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Salt 1kg
productImages.put(17, "https://plus.unsplash.com/premium_photo-1726862790171-0d6208559224?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Curry Powder 100g
productImages.put(18, "https://plus.unsplash.com/premium_photo-1726880501641-c7072313efd2?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Red Chili Powder 100g
productImages.put(19, "https://plus.unsplash.com/premium_photo-1701064865147-48dcd4d63015?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Dhal 1kg
productImages.put(20, "https://images.unsplash.com/photo-1598720290281-9f26ae6d6f81?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Pasta 500g
productImages.put(21, "https://images.unsplash.com/photo-1550583724-b2692b85b150?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Milk 1L
productImages.put(22, "https://images.unsplash.com/photo-1563636619-e9143da7973b?q=80&w=765&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Fresh Milk 1L
productImages.put(23, "https://images.unsplash.com/photo-1641196936589-7df4db18de66?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Yoghurt 500ml
productImages.put(24, "https://plus.unsplash.com/premium_photo-1691939610797-aba18030c15f?q=80&w=722&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Cheese 200g
productImages.put(25, "https://plus.unsplash.com/premium_photo-1700440539073-c769891a9e3f?q=80&w=688&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Butter 250g
productImages.put(26, "https://images.unsplash.com/photo-1559811814-e2c57b5e69df?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Bread 500g
productImages.put(27, "https://images.unsplash.com/photo-1606313564200-e75d5e30476c?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Chocolate Cake
productImages.put(28, "https://plus.unsplash.com/premium_photo-1671403964089-d00ea8d6645b?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Bun Pack
productImages.put(29, "https://images.unsplash.com/photo-1639194335563-d56b83f0060c?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Eggs 10pcs
productImages.put(30, "https://images.unsplash.com/photo-1583130879758-db8ac95a9b68?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Cream 200ml
productImages.put(31, "https://images.unsplash.com/photo-1546173159-315724a31696?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Orange Juice 1L
productImages.put(32, "https://images.unsplash.com/photo-1638688569176-5b6db19f9d2a?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Mineral Water 1.5L
productImages.put(33, "https://images.unsplash.com/photo-1699666397768-0126340e880a?q=80&w=688&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Potato Chips 100g
productImages.put(34, "https://plus.unsplash.com/premium_photo-1667621220861-5f297728dd39?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Chocolate Biscuits
productImages.put(35, "https://images.unsplash.com/photo-1556881286-fc6915169721?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Soft Drink 1L
productImages.put(36, "https://plus.unsplash.com/premium_photo-1681701892390-efd3cd37bff6?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Tea Pack 200g
productImages.put(37, "https://images.unsplash.com/photo-1447933601403-0c6688de566e?q=80&w=1061&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Coffee 100g
productImages.put(38, "https://images.unsplash.com/photo-1578849278619-e73505e9610f?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Popcorn 100g
productImages.put(39, "https://plus.unsplash.com/premium_photo-1725384940666-8c04394eda4d?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Nuts 200g
productImages.put(40, "https://images.unsplash.com/photo-1642532560930-77d5018c68f7?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Energy Drink
productImages.put(41, "https://plus.unsplash.com/premium_photo-1664372899205-7cccbe1ad0b0?q=80&w=688&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Dish Wash Liquid
productImages.put(42, "https://plus.unsplash.com/premium_photo-1664443944764-08d21b62665e?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Laundry Powder 1kg
productImages.put(43, "https://plus.unsplash.com/premium_photo-1664544673662-e80e311da294?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Soap Bar
productImages.put(44, "https://images.unsplash.com/photo-1747858989102-cca0f4dc4a11?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Shampoo 400ml
productImages.put(45, "https://images.unsplash.com/photo-1610216690558-4aee861f4ab3?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Toothpaste
productImages.put(46, "https://images.unsplash.com/photo-1649944607215-33cea628763f?q=80&w=647&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Toilet Cleaner
productImages.put(47, "https://images.unsplash.com/photo-1631524254770-03abe3f42a0d?q=80&w=1025&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Tissue Pack
productImages.put(48, "https://plus.unsplash.com/premium_photo-1661591285003-9abbde56bf8a?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Hand Wash
productImages.put(49, "https://images.unsplash.com/photo-1544816155-12df9643f363?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Garbage Bags
productImages.put(50, "https://images.unsplash.com/photo-1577369117918-7e3785e39cb7?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"); // Cleaning Sponge

// Fallback image shown when a product has no URL set above
String defaultProductImage = "https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=600&q=80";

// --- Filter products by selected category (if any) ---
List<Product> products;
Integer selectedCatId = null;
if (catParam != null && !catParam.trim().isEmpty()) {
    try {
        selectedCatId = Integer.parseInt(catParam.trim());
    } catch (NumberFormatException e) {
        selectedCatId = null;
    }
}

if (selectedCatId != null) {
    products = new ArrayList<Product>();
    for (Product p : allProducts) {
        if (p.getCategoryId() == selectedCatId) {
            products.add(p);
        }
    }
} else {
    products = allProducts;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop Groceries | Smart Grocery</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>
        *{ margin:0; padding:0; box-sizing:border-box; font-family:'Inter',sans-serif; }
        :root{
            --green:#22c55e;
            --greenDark:#16a34a;
            --black:#0b0b0b;
            --card:#181818;
            --border:#2b2b2b;
            --text:#ffffff;
            --soft:#9ca3af;
        }
        body{ background:#0b0b0b; color:white; }
        a{ color:inherit; }
        button{ font-family:'Inter',sans-serif; }

        /* SIDEBAR */
        .sidebar{
            position:fixed; left:0; top:0; width:260px; height:100vh;
            background:#111; border-right:1px solid #222; padding:25px;
            display:flex; flex-direction:column; overflow-y:auto;
        }
        .logo{ display:flex; align-items:center; gap:12px; font-size:24px; font-weight:800; margin-bottom:5px; text-decoration:none; }
        .logo i{ color:var(--green); background:rgba(34,197,94,.15); width:42px; height:42px; border-radius:12px; display:flex; align-items:center; justify-content:center; }
        .logo-sub{ font-size:11px; color:var(--soft); margin-bottom:35px; margin-left:54px; margin-top:-2px; }
        .menu{ list-style:none; }
        .menu li{ margin-bottom:6px; }
        .menu a{ display:flex; align-items:center; gap:15px; padding:12px 16px; text-decoration:none; color:#cbd5e1; border-radius:12px; transition:.25s; font-size:14.5px; font-weight:500; position:relative; }
        .menu a:hover{ background:#1c1c1c; color:white; }
        .menu a.active{ background:var(--green); color:white; }
        .menu-count{ margin-left:auto; background:#ef4444; color:white; font-size:11px; font-weight:700; padding:2px 8px; border-radius:20px; }
        .menu a.active .menu-count{ background:rgba(255,255,255,.25); }
        .side-label{ font-size:11px; letter-spacing:.08em; color:#666; text-transform:uppercase; margin:22px 0 10px 16px; font-weight:700; }
        .help-card{ margin-top:auto; background:linear-gradient(135deg,#16a34a,#22c55e); border-radius:16px; padding:18px; text-decoration:none; display:block; color:white; }
        .help-card i{ font-size:22px; margin-bottom:8px; display:block; }
        .help-card b{ display:block; font-size:14px; }
        .help-card span{ font-size:12px; opacity:.85; }

        /* MAIN */
        .main{ margin-left:260px; }
        .navbar{ height:80px; display:flex; justify-content:space-between; align-items:center; padding:0 40px; background:#111; border-bottom:1px solid #222; position:sticky; top:0; z-index:5; }
        .search{ width:420px; position:relative; display:flex; }
        .search input{ width:100%; padding:13px 20px; padding-left:45px; background:#1b1b1b; border:1px solid #333; border-radius:12px 0 0 12px; border-right:none; color:white; outline:none; }
        .search i.fa-magnifying-glass{ position:absolute; left:16px; top:15px; color:#888; }
        .search button{ width:46px; background:var(--green); border:none; border-radius:0 12px 12px 0; color:white; cursor:pointer; font-size:15px; }
        .user{ display:flex; align-items:center; gap:22px; }
        .icon-btn{ position:relative; width:44px; height:44px; border-radius:12px; background:#1b1b1b; border:1px solid #2b2b2b; display:flex; align-items:center; justify-content:center; font-size:17px; color:#cbd5e1; cursor:pointer; text-decoration:none; }
        .icon-btn:hover{ border-color:var(--green); color:var(--green); }
        .profile-chip{ display:flex; align-items:center; gap:10px; padding:6px 12px 6px 6px; background:#1b1b1b; border:1px solid #2b2b2b; border-radius:30px; cursor:pointer; text-decoration:none; }
        .avatar{ width:34px; height:34px; background:var(--green); border-radius:50%; display:flex; justify-content:center; align-items:center; font-weight:bold; font-size:14px; overflow:hidden; }
        .avatar img{ width:100%; height:100%; object-fit:cover; }
        .profile-chip span{ font-size:14px; font-weight:600; color:white; }
        .content{ padding:40px; }

        /* PAGE HEADER */
        .page-header{ display:flex; justify-content:space-between; align-items:center; margin-bottom:28px; flex-wrap:wrap; gap:16px; }
        .page-header h1{ font-size:28px; font-weight:800; }
        .page-header p{ color:var(--soft); font-size:14px; margin-top:4px; }
        .success-banner{ background:rgba(34,197,94,.12); border:1px solid rgba(34,197,94,.35); color:var(--green); padding:12px 18px; border-radius:12px; margin-bottom:22px; font-size:14px; font-weight:600; }

        /* CATEGORY FILTER CHIPS */
        .cat-filters{ display:flex; gap:10px; flex-wrap:wrap; margin-bottom:30px; }
        .cat-chip{ padding:9px 18px; border-radius:100px; background:var(--card); border:1px solid var(--border); color:var(--soft); font-size:13px; font-weight:600; text-decoration:none; transition:.2s; }
        .cat-chip:hover{ border-color:var(--green); color:white; }
        .cat-chip.active{ background:var(--green); color:white; border-color:var(--green); }

        /* PRODUCT GRID */
        .product-grid{ display:grid; grid-template-columns:repeat(auto-fill,minmax(230px,1fr)); gap:20px; }
        .product-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden; 
            transition: .25s;
            display: flex;
            flex-direction: column;
        }
        .product-card:hover{ border-color:var(--green); transform:translateY(-3px); }
        .product-img { 
            height: 150px; 
            background: #1a1a1a; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            overflow: hidden; 
            border-bottom: 1px solid var(--border); 
        }
        .product-img img { width: 100%; height: 100%; object-fit: cover; }
        .product-body { padding: 16px; display: flex; flex-direction: column; flex: 1; background: var(--card); }
        .product-cat{ font-size:10.5px; font-weight:700; color:var(--green); text-transform:uppercase; letter-spacing:.04em; margin-bottom:6px; }
        .product-name{ font-size:15px; font-weight:700; margin-bottom:6px; }
        .product-meta{ font-size:12px; color:var(--soft); margin-bottom:12px; }
        .stock-tag{ display:inline-block; font-size:10.5px; font-weight:700; padding:3px 9px; border-radius:20px; margin-bottom:10px; width:fit-content; }
        .stock-in{ background:rgba(34,197,94,.15); color:var(--green); }
        .stock-low{ background:rgba(245,158,11,.15); color:#f59e0b; }
        .stock-out{ background:rgba(239,68,68,.15); color:#ef4444; }
        .product-footer{ margin-top:auto; display:flex; align-items:center; justify-content:space-between; gap:10px; }
        .product-price{ font-size:17px; font-weight:800; color:white; }
        .product-price span{ font-size:11px; color:var(--soft); font-weight:500; }
        .add-cart-btn{ background:var(--green); border:none; color:white; width:38px; height:38px; border-radius:10px; font-size:15px; cursor:pointer; display:flex; align-items:center; justify-content:center; transition:.2s; }
        .add-cart-btn:hover{ background:var(--greenDark); }
        .add-cart-btn:disabled{ background:#333; color:#666; cursor:not-allowed; }

        .empty-state{ text-align:center; padding:80px 20px; color:var(--soft); }
        .empty-state i{ font-size:40px; margin-bottom:16px; color:#444; display:block; }
        .footer{ margin-top:45px; padding:25px; text-align:center; color:#888; border-top:1px solid #222; font-size:13px; }

        @media(max-width:800px){ .product-grid{ grid-template-columns:repeat(2,1fr); } }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <a href="dashboard.jsp" class="logo">
        <i class="fa-solid fa-cart-shopping"></i>
        <span>Smart Grocery</span>
    </a>
    <div class="logo-sub">Manage Smart, Eat Smart</div>

    <ul class="menu">
        <li><a href="dashboard.jsp"><i class="fa-solid fa-house"></i> Dashboard</a></li>
        <li><a class="active" href="products.jsp"><i class="fa-solid fa-cart-shopping"></i> Shop Groceries</a></li>
        <li><a href="inventory.jsp"><i class="fa-solid fa-warehouse"></i> My Inventory</a></li>
        <li><a href="MealDashboardController"><i class="fa-solid fa-utensils"></i> Meal Planner</a></li>
        <li><a href="cart.jsp"><i class="fa-solid fa-list-check"></i> Shopping List</a></li>
        <li><a href="RecipeController"><i class="fa-solid fa-book-open"></i> Recipes</a></li>
        <li><a href="notifications.jsp"><i class="fa-solid fa-bell"></i> Expiry Alerts
        <% if (sidebarExpiryCount > 0) { %><span class="menu-count"><%= sidebarExpiryCount %></span><% } %>
        </a></li>
        <li><a href="lowstock.jsp"><i class="fa-solid fa-triangle-exclamation"></i> Low Stock
        <% if (sidebarLowStockCount > 0) { %><span class="menu-count"><%= sidebarLowStockCount %></span><% } %>
        </a></li>
    </ul>

    <div class="side-label">Meal Optimization</div>

<ul class="menu">

<li>
<a href="RecommendationController">
<i class="fa-solid fa-wand-magic-sparkles"></i>
Recommendations
</a>
</li>

<li>
<a href="ShoppingListController">
<i class="fa-solid fa-basket-shopping"></i>
Meal Shopping List
</a>
</li>

<li>
<a href="UserDietaryRestrictionController">
<i class="fa-solid fa-leaf"></i>
Dietary Restrictions
</a>
</li>

<li>
<a href="FoodWasteController">
<i class="fa-solid fa-recycle"></i>
Food Waste
</a>
</li>

</ul>

<div class="side-label">Account</div>
    <ul class="menu">
        <li><a href="profile.jsp"><i class="fa-solid fa-user"></i> Profile</a></li>
        <li><a href="settings.jsp"><i class="fa-solid fa-gear"></i> Settings</a></li>
        <li><a href="LogoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a></li>
    </ul>

    <a href="tel:+94112345678" class="help-card">
        <i class="fa-solid fa-phone"></i>
        <b>Need Help?</b>
        <span>Emergency Call</span>
    </a>
</div>

<!-- Main Section -->
<div class="main">
    <div class="navbar">
        <form class="search" action="products.jsp" method="get">
            <i class="fa-solid fa-magnifying-glass"></i>
            <input type="text" name="search" placeholder="Search products..." value="<%= search != null ? search : "" %>">
            <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
        </form>

        <div class="user">
            <a href="cart.jsp" class="icon-btn"><i class="fa-solid fa-cart-shopping"></i></a>
            <a href="notifications.jsp" class="icon-btn"><i class="fa-regular fa-bell"></i></a>
            <a href="profile.jsp" class="profile-chip">
                <div class="avatar"><% if (user.hasProfilePhoto()) { %><img src="<%= user.getProfilePhoto() %>" alt="Profile photo"><% } else { %><%= user.getName().substring(0,1).toUpperCase() %><% } %></div>
                <span><%= user.getName() %></span>
                <i class="fa-solid fa-chevron-down" style="font-size:11px;color:#888;"></i>
            </a>
        </div>
    </div>

    <div class="content">
        <div class="page-header">
            <div>
                <h1>Shop Groceries</h1>
                <p><%= products.size() %> products available<% if (search != null && !search.trim().isEmpty()) { %> for "<%= search %>"<% } %></p>
            </div>
        </div>

        <% if ("1".equals(added)) { %>
            <div class="success-banner"><i class="fa-solid fa-circle-check"></i> Item added to your cart successfully.</div>
        <% } %>

        <!-- Category Filter Chips -->
        <div class="cat-filters">
            <a href="products.jsp<%= (search != null && !search.trim().isEmpty()) ? "?search=" + search : "" %>"
               class="cat-chip <%= (selectedCatId == null) ? "active" : "" %>">All Products</a>
            <%
            for (Category c : categories) {
                boolean isCatActive = selectedCatId != null && selectedCatId == c.getCategoryId();
                String catLink = "products.jsp?cat=" + c.getCategoryId();
                if (search != null && !search.trim().isEmpty()) {
                    catLink += "&search=" + search;
                }
            %>
                <a href="<%= catLink %>" class="cat-chip <%= isCatActive ? "active" : "" %>"><%= c.getName() %></a>
            <% } %>
        </div>

        <!-- Product Grid -->
        <% if (products.isEmpty()) { %>
            <div class="empty-state">
                <i class="fa-solid fa-box-open"></i>
                No products found<% if (search != null) { %> for "<%= search %>"<% } %>.
            </div>
        <% } else { %>
            <div class="product-grid">
            <%
            for (Product p : products) {
                String catName = categoryNames.get(p.getCategoryId());
                if (catName == null) catName = "General";

                // Prefer the live inventory record; fall back to the product's
                // seed quantity only if no inventory row exists for it yet.
                Inventory prodInv = inventoryMap.get(p.getProductId());
                int stockQty = (prodInv != null) ? prodInv.getQuantity() : p.getQuantity();
                boolean isOutOfStock = stockQty <= 0;
                boolean isLowStock = (prodInv != null) ? prodInv.isLowStock() : (stockQty < 10);

                String stockClass = isOutOfStock ? "stock-out" : (isLowStock ? "stock-low" : "stock-in");
                String stockLabel = isOutOfStock ? "Out of Stock" : (isLowStock ? "Low Stock" : "In Stock");

                // --- IMAGE: looks up the URL you pasted into the productImages map above ---
                String mappedUrl = productImages.get(p.getProductId());
                String imageUrl = (mappedUrl != null && !mappedUrl.trim().isEmpty()) ? mappedUrl.trim() : defaultProductImage;
            %>
            <div class="product-card">
                <div class="product-img">
                    <img src="<%= imageUrl %>" alt="<%= p.getName() %>" loading="lazy"
                         onerror="this.onerror=null;this.src='<%= defaultProductImage %>';">
                </div>
                <div class="product-body">
                    <div class="product-cat"><%= catName %></div>
                    <div class="product-name"><%= p.getName() %></div>
                    <div class="product-meta"><%= stockQty %> <%= p.getUnit() %> available</div>
                    <div class="stock-tag <%= stockClass %>"><%= stockLabel %></div>
                    <div class="product-footer">
                        <!-- Rupees and Cents Format (.2f handles the decimals perfectly) -->
                        <div class="product-price">Rs. <%= String.format("%.2f", p.getPrice()) %><span> / <%= p.getUnit() %></span></div>
                        <% if (isOutOfStock) { %>
                            <button type="button" class="add-cart-btn" disabled><i class="fa-solid fa-plus"></i></button>
                        <% } else { %>
                            <a href="CartServlet?action=add&productId=<%= p.getProductId() %>&price=<%= p.getPrice() %>" class="add-cart-btn">
                                <i class="fa-solid fa-plus"></i>
                            </a>
                        <% } %>
                    </div>
                </div>
            </div>
            <%
            }
            %>
            </div>
        <% } %>
    </div>

    <div class="footer">
        © 2026 Smart Grocery Management System
    </div>
</div>

</body>
</html>
