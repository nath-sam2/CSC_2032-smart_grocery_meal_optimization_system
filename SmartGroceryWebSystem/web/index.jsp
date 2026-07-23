<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.InventoryDAO"%>
<%@page import="dao.ProductDAO"%>
<%@page import="dao.CategoryDAO"%>
<%@page import="dao.UserDAO"%>
<%@page import="model.Inventory"%>
<%@page import="model.Product"%>
<%@page import="model.Category"%>
<%@page import="model.User"%>
<%@page import="java.util.*"%>
<%
    // ---- LIVE DASHBOARD PREVIEW DATA (real data pulled from the DB) ----
    InventoryDAO inventoryDAO = new InventoryDAO();
    ProductDAO productDAO = new ProductDAO();
    CategoryDAO categoryDAO = new CategoryDAO();

    List<Inventory> allInventory   = inventoryDAO.getAllInventory();
    List<Inventory> lowStockList   = inventoryDAO.getLowStockItems();
    List<Product> expiringList     = inventoryDAO.getExpiringItems(3); // next 3 days
    List<Product> allProducts      = productDAO.getAllProducts();
    List<Category> allCategories   = categoryDAO.getAllCategories();

    int totalItems     = allInventory.size();
    int lowStockCount  = lowStockList.size();
    int expiringCount  = expiringList.size();

    // Nearest expiring product (smallest days-left)
    String expiringName = null;
    long expiringDays = 0;
    for (Product p : expiringList) {
        if (p.getExpiryDate() == null) continue;
        long diff = p.getExpiryDate().getTime() - System.currentTimeMillis();
        long daysLeft = Math.max(0, diff / (1000 * 60 * 60 * 24));
        if (expiringName == null || daysLeft < expiringDays) {
            expiringName = p.getName();
            expiringDays = daysLeft;
        }
    }

    // Lowest-stock product (biggest shortfall vs its reorder level)
    String lowStockName = null;
    Integer lowestQty = null;
    for (Inventory inv : lowStockList) {
        if (lowestQty == null || inv.getQuantity() < lowestQty) {
            lowestQty = inv.getQuantity();
            Product lp = productDAO.getProductById(inv.getProductId());
            lowStockName = (lp != null) ? lp.getName() : "An item";
        }
    }

    // Category-wise stock health (top 4 categories by product count)
    Map<Integer, Integer> catProductCount = new LinkedHashMap<Integer, Integer>();
    Map<Integer, Integer> catStockSum     = new LinkedHashMap<Integer, Integer>();
    Map<Integer, Integer> catCapacitySum  = new LinkedHashMap<Integer, Integer>();
    for (Product p : allProducts) {
        int cid = p.getCategoryId();
        Inventory inv = inventoryDAO.getInventoryByProduct(p.getProductId());
        int qty      = (inv != null) ? inv.getQuantity()     : p.getQuantity();
        int reorder  = (inv != null) ? inv.getReorderLevel() : 5;
        int capacity = Math.max(reorder * 3, 10); // assume "full stock" = 3x reorder level

        catProductCount.put(cid, (catProductCount.containsKey(cid) ? catProductCount.get(cid) : 0) + 1);
        catStockSum.put(cid, (catStockSum.containsKey(cid) ? catStockSum.get(cid) : 0) + qty);
        catCapacitySum.put(cid, (catCapacitySum.containsKey(cid) ? catCapacitySum.get(cid) : 0) + capacity);
    }

    List<Integer> topCategoryIds = new ArrayList<Integer>(catProductCount.keySet());
    Collections.sort(topCategoryIds, new Comparator<Integer>() {
        public int compare(Integer a, Integer b) {
            return catProductCount.get(b) - catProductCount.get(a);
        }
    });
    if (topCategoryIds.size() > 4) {
        topCategoryIds = topCategoryIds.subList(0, 4);
    }

    Map<Integer, String> categoryNames = new HashMap<Integer, String>();
    for (Category c : allCategories) {
        categoryNames.put(c.getCategoryId(), c.getName());
    }

    // ---- HERO STATS (real data) ----
    UserDAO userDAO = new UserDAO();
    int householdCount = userDAO.getAllUsers().size();

    // No historical "waste" table exists, so this is a live proxy metric:
    // the % of tracked items that are currently NOT at risk of expiring soon.
    int wastePreventedPct = 0;
    if (totalItems > 0) {
        wastePreventedPct = Math.round((totalItems - expiringCount) * 100.0f / totalItems);
    }

    // Format big numbers like "12k" once past 1000 (number + unit shown separately in markup)
    String householdNumber;
    String householdSuffix;
    if (householdCount >= 1000) {
        double kValue = householdCount / 1000.0;
        householdNumber = (kValue == Math.floor(kValue))
                ? String.valueOf((int) kValue)
                : String.format("%.1f", kValue);
        householdSuffix = "k";
    } else {
        householdNumber = String.valueOf(householdCount);
        householdSuffix = "";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Smart Grocery – Manage Smart, Eat Smart</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet"/>
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }

:root {
  --green: #22c55e;
  --green-dark: #16a34a;
  --green-glow: rgba(34,197,94,0.15);
  --black: #0a0a0a;
  --black2: #111111;
  --dark: #161616;
  --card-bg: #1a1a1a;
  --border: rgba(255,255,255,0.08);
  --text: #ffffff;
  --text-soft: rgba(255,255,255,0.65);
  --text-muted: rgba(255,255,255,0.35);
  --font: 'Inter', sans-serif;
}

html { scroll-behavior: smooth; }
body { font-family: var(--font); background: var(--black); color: var(--text); overflow-x: hidden; }

/* NAVBAR */
nav {
  position: fixed; top: 0; left: 0; right: 0; z-index: 1000;
  display: flex; align-items: center; justify-content: space-between;
  padding: 0 48px; height: 68px;
  background: rgba(10,10,10,0.85);
  backdrop-filter: blur(16px);
  border-bottom: 1px solid var(--border);
  transition: background 0.3s;
}
.nav-logo {
  display: flex; align-items: center; gap: 10px;
  font-size: 20px; font-weight: 800; color: #fff; text-decoration: none;
  letter-spacing: -0.3px;
}
.nav-logo-icon {
  width: 36px; height: 36px; background: var(--green);
  border-radius: 8px; display: flex; align-items: center; justify-content: center;
  font-size: 18px;
}
.nav-links { display: flex; align-items: center; gap: 4px; list-style: none; }
.nav-links li a {
  display: flex; align-items: center; gap: 4px;
  padding: 8px 14px; border-radius: 8px;
  font-size: 14px; font-weight: 500; color: var(--text-soft);
  text-decoration: none; transition: all 0.15s; white-space: nowrap;
}
.nav-links li a:hover { color: #fff; background: rgba(255,255,255,0.06); }
.nav-actions { display: flex; align-items: center; gap: 12px; }
.btn-login {
  font-size: 14px; font-weight: 600; color: var(--text-soft);
  background: none; border: none; cursor: pointer; padding: 8px 16px;
  border-radius: 8px; font-family: var(--font); transition: color 0.15s;
}
.btn-login:hover { color: #fff; }
.btn-demo {
  font-size: 14px; font-weight: 700; color: #fff;
  background: var(--green); border: none; cursor: pointer;
  padding: 10px 22px; border-radius: 10px;
  font-family: var(--font); transition: background 0.15s, transform 0.1s;
}
.btn-demo:hover { background: var(--green-dark); transform: translateY(-1px); }

/* HERO */
.hero { position: relative; min-height: 100vh; display: flex; align-items: center; overflow: hidden; }
.hero-bg {
  position: absolute; inset: 0;
  background: linear-gradient(105deg, rgba(0,0,0,0.92) 0%, rgba(0,0,0,0.75) 45%, rgba(0,0,0,0.3) 100%);
  z-index: 1;
}
.hero-bg-img {
  position: absolute;
  inset: 0;
  background: url('https://images.unsplash.com/photo-1542838132-92c53300491e?w=1600&q=80') center center/cover no-repeat;
  z-index: 0;
}
.hero-glow {
  position: absolute; bottom: -100px; left: -100px; width: 600px; height: 600px;
  background: radial-gradient(circle, rgba(34,197,94,0.12) 0%, transparent 70%);
  z-index: 1; pointer-events: none;
}
.hero-content { position: relative; z-index: 2; padding: 0 48px; max-width: 780px; padding-top: 100px; }
.hero-eyebrow {
  display: inline-flex; align-items: center; gap: 8px;
  background: rgba(34,197,94,0.12); border: 1px solid rgba(34,197,94,0.3);
  border-radius: 100px; padding: 5px 14px 5px 10px;
  font-size: 12.5px; font-weight: 600; color: var(--green);
  margin-bottom: 28px; letter-spacing: 0.02em;
}
.hero-eyebrow span { width: 6px; height: 6px; background: var(--green); border-radius: 50%; }
.hero h1 {
  font-size: clamp(42px, 5.5vw, 72px); font-weight: 900; line-height: 1.05;
  letter-spacing: -2px; margin-bottom: 24px; color: #fff;
}
.hero h1 em { font-style: normal; color: var(--green); }
.hero p { font-size: 18px; font-weight: 400; color: var(--text-soft); line-height: 1.65; max-width: 560px; margin-bottom: 40px; }
.hero-actions { display: flex; align-items: center; gap: 20px; flex-wrap: wrap; }
.btn-hero-primary {
  font-size: 15px; font-weight: 700; color: #fff; background: var(--green);
  border: none; cursor: pointer; padding: 14px 30px; border-radius: 12px;
  font-family: var(--font); transition: background 0.15s, transform 0.1s, box-shadow 0.15s;
}
.btn-hero-primary:hover { background: var(--green-dark); transform: translateY(-2px); box-shadow: 0 8px 32px rgba(34,197,94,0.35); }
.btn-hero-secondary {
  display: flex; align-items: center; gap: 10px; font-size: 15px; font-weight: 600; color: #fff;
  background: none; border: none; cursor: pointer; font-family: var(--font); transition: opacity 0.15s;
}
.btn-hero-secondary:hover { opacity: 0.75; }
.play-icon {
  width: 42px; height: 42px; border: 2px solid rgba(255,255,255,0.3); border-radius: 50%;
  display: flex; align-items: center; justify-content: center; font-size: 14px; transition: border-color 0.15s;
}
.btn-hero-secondary:hover .play-icon { border-color: var(--green); }
.hero-stats { display: flex; gap: 40px; margin-top: 48px; }
.hero-stat .num { font-size: 32px; font-weight: 900; color: #fff; letter-spacing: -1px; display: flex; align-items: flex-start; }
.hero-stat .num span { color: var(--green); font-size: 20px; letter-spacing: normal; margin-left: 3px; margin-top: 2px; }
.hero-stat .lbl { font-size: 12.5px; color: var(--text-muted); margin-top: 2px; font-weight: 500; }

/* TAGLINE */
.section-tagline { background: #fff; color: #111; padding: 96px 48px; text-align: center; }
.section-tagline h2 { font-size: clamp(32px, 4vw, 54px); font-weight: 900; letter-spacing: -1.5px; line-height: 1.1; margin-bottom: 6px; color: #111; }
.section-tagline h2 .soft { color: #aaa; font-weight: 800; }
.section-tagline .sub { font-size: 16px; color: #666; margin-top: 16px; max-width: 480px; margin-left: auto; margin-right: auto; }
.carousel { display: flex; gap: 20px; justify-content: center; margin-top: 52px; overflow: hidden; }
.carousel-item { border-radius: 16px; overflow: hidden; flex-shrink: 0; background: #f0f0f0; position: relative; }
.carousel-item.main { width: 600px; height: 320px; }
.carousel-item.side { width: 200px; height: 320px; opacity: 0.4; }
.carousel-item .ci-img {
  position: absolute; inset: 0;
  width: 100%; height: 100%; object-fit: cover;
  opacity: 0; transform: scale(1.08);
  transition: opacity 1.4s ease-in-out, transform 6s ease-out;
}
.carousel-item .ci-img.active { opacity: 1; transform: scale(1); }
.carousel-item .ci-fallback {
  position: absolute; inset: 0;
  display: flex; align-items: center; justify-content: center;
  font-size: 34px;
  background: linear-gradient(135deg, #dff3e4, #f0f0f0);
  opacity: 0; transition: opacity 1.4s ease-in-out;
}
.carousel-item .ci-fallback.active { opacity: 1; }
.carousel-dots { display: flex; justify-content: center; gap: 7px; margin-top: 20px; }
.carousel-dots .cdot { width: 6px; height: 6px; border-radius: 50%; background: #ddd; transition: all 0.3s; }
.carousel-dots .cdot.active { background: var(--green, #22c55e); width: 18px; border-radius: 3px; }

/* FEATURES */
.section-features { background: var(--black2); padding: 96px 48px; }
.section-label { font-size: 12px; font-weight: 700; color: var(--green); letter-spacing: 0.12em; text-transform: uppercase; margin-bottom: 16px; }
.section-features h2 { font-size: clamp(28px, 3.5vw, 46px); font-weight: 900; letter-spacing: -1.2px; color: #fff; max-width: 520px; line-height: 1.1; margin-bottom: 56px; }
.features-grid { display: grid; grid-template-columns: repeat(3,1fr); gap: 2px; border: 1px solid var(--border); border-radius: 16px; overflow: hidden; }
.feature-card { background: var(--card-bg); padding: 36px 32px; border-right: 1px solid var(--border); border-bottom: 1px solid var(--border); transition: background 0.2s; cursor: default; }
.feature-card:hover { background: #222; }
.feature-card:nth-child(3), .feature-card:nth-child(6) { border-right: none; }
.feature-card:nth-child(4), .feature-card:nth-child(5), .feature-card:nth-child(6) { border-bottom: none; }
.fc-icon { width: 48px; height: 48px; border-radius: 12px; background: var(--green-glow); border: 1px solid rgba(34,197,94,0.2); display: flex; align-items: center; justify-content: center; font-size: 22px; margin-bottom: 20px; }
.fc-title { font-size: 17px; font-weight: 700; color: #fff; margin-bottom: 10px; }
.fc-desc { font-size: 13.5px; color: var(--text-soft); line-height: 1.65; }

/* HOW IT WORKS */
.section-how { background: var(--dark); padding: 96px 48px; display: grid; grid-template-columns: 1fr 1fr; gap: 80px; align-items: center; }
.how-left h2 { font-size: clamp(28px, 3.5vw, 44px); font-weight: 900; letter-spacing: -1.2px; color: #fff; line-height: 1.1; margin-bottom: 20px; }
.how-left p { font-size: 15px; color: var(--text-soft); line-height: 1.7; margin-bottom: 32px; }
.how-steps { display: flex; flex-direction: column; gap: 0; }
.how-step { display: flex; gap: 20px; padding: 20px 0; border-bottom: 1px solid var(--border); cursor: pointer; }
.how-step:last-child { border-bottom: none; }
.step-num { font-size: 12px; font-weight: 800; color: var(--green); letter-spacing: 0.05em; min-width: 28px; margin-top: 2px; }
.step-title { font-size: 15px; font-weight: 700; color: #fff; margin-bottom: 5px; }
.step-desc { font-size: 13px; color: var(--text-soft); line-height: 1.6; }
.how-right { background: var(--card-bg); border: 1px solid var(--border); border-radius: 20px; padding: 32px; display: flex; flex-direction: column; gap: 12px; }
.dash-preview-title { font-size: 13px; color: var(--text-muted); margin-bottom: 4px; font-weight: 600; letter-spacing: 0.05em; }
.dash-stat-row { display: flex; gap: 10px; }
.dash-stat { flex: 1; background: var(--dark); border: 1px solid var(--border); border-radius: 12px; padding: 16px; }
.dash-stat .ds-val { font-size: 26px; font-weight: 900; color: var(--green); letter-spacing: -0.5px; }
.dash-stat .ds-lbl { font-size: 11px; color: var(--text-muted); margin-top: 3px; }
.dash-alert-row { background: rgba(34,197,94,0.06); border: 1px solid rgba(34,197,94,0.15); border-radius: 10px; padding: 12px 14px; display: flex; align-items: center; gap: 10px; font-size: 13px; color: var(--text-soft); }
.dash-alert-dot { width: 8px; height: 8px; border-radius: 50%; background: var(--green); flex-shrink: 0; }
.dash-bar-row { display: flex; flex-direction: column; gap: 8px; }
.dash-bar { display: flex; align-items: center; gap: 10px; }
.dash-bar-label { font-size: 12px; color: var(--text-muted); min-width: 80px; }
.dash-bar-track { flex: 1; height: 6px; background: var(--border); border-radius: 3px; overflow: hidden; }
.dash-bar-fill { height: 100%; background: var(--green); border-radius: 3px; }
.dash-bar-val { font-size: 11.5px; color: var(--text-soft); min-width: 32px; text-align: right; }

/* TRUST */
.section-trust { background: var(--black2); padding: 60px 48px; text-align: center; border-top: 1px solid var(--border); border-bottom: 1px solid var(--border); }
.trust-label { font-size: 12px; color: var(--text-muted); font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; margin-bottom: 32px; }
.trust-logos { display: flex; align-items: center; justify-content: center; gap: 48px; flex-wrap: wrap; }
.trust-logo { font-size: 14px; font-weight: 700; color: var(--text-muted); letter-spacing: 0.03em; }

/* CTA */
.section-cta { background: var(--black); padding: 100px 48px; text-align: center; position: relative; overflow: hidden; }
.cta-glow { position: absolute; top: 50%; left: 50%; transform: translate(-50%,-50%); width: 600px; height: 300px; background: radial-gradient(ellipse, rgba(34,197,94,0.1) 0%, transparent 70%); pointer-events: none; }
.section-cta h2 { font-size: clamp(28px, 4vw, 52px); font-weight: 900; letter-spacing: -1.5px; color: #fff; margin-bottom: 16px; position: relative; }
.section-cta p { font-size: 16px; color: var(--text-soft); margin-bottom: 36px; position: relative; }
.cta-btns { display: flex; gap: 14px; justify-content: center; position: relative; }

/* FOOTER */
footer { background: var(--black2); border-top: 1px solid var(--border); padding: 64px 48px 0; }
.footer-top { display: grid; grid-template-columns: 1.4fr 1fr 1fr 1fr 0.8fr; gap: 48px; margin-bottom: 56px; }
.footer-brand .logo { display: flex; align-items: center; gap: 10px; margin-bottom: 16px; font-size: 17px; font-weight: 800; }
.footer-brand .logo-icon { width: 32px; height: 32px; background: var(--green); border-radius: 7px; display: flex; align-items: center; justify-content: center; font-size: 16px; }
.footer-brand p { font-size: 13px; color: var(--text-muted); line-height: 1.7; max-width: 220px; }
.footer-col h4 { font-size: 13px; font-weight: 700; color: #fff; margin-bottom: 18px; letter-spacing: 0.01em; }
.footer-col ul { list-style: none; display: flex; flex-direction: column; gap: 10px; }
.footer-col ul li a { font-size: 13px; color: var(--text-muted); text-decoration: none; transition: color 0.15s; }
.footer-col ul li a:hover { color: #fff; }
.footer-bottom { border-top: 1px solid var(--border); padding: 24px 0; display: flex; align-items: center; justify-content: space-between; }
.footer-bottom p { font-size: 13px; color: var(--text-muted); }
.footer-legal { display: flex; gap: 24px; }
.footer-legal a { font-size: 13px; color: var(--text-muted); text-decoration: none; transition: color 0.15s; }
.footer-legal a:hover { color: #fff; }

/* LOGIN MODAL */
.modal-overlay { position: fixed; inset: 0; z-index: 2000; background: rgba(0,0,0,0.7); backdrop-filter: blur(8px); display: flex; align-items: center; justify-content: center; opacity: 0; pointer-events: none; transition: opacity 0.2s; }
.modal-overlay.open { opacity: 1; pointer-events: all; }
.modal { background: var(--card-bg); border: 1px solid var(--border); border-radius: 20px; padding: 40px; width: 100%; max-width: 420px; position: relative; transform: translateY(16px); transition: transform 0.2s; }
.modal-overlay.open .modal { transform: none; }
.modal-close { position: absolute; top: 16px; right: 16px; width: 30px; height: 30px; border-radius: 7px; background: rgba(255,255,255,0.06); border: none; color: var(--text-soft); cursor: pointer; font-size: 16px; display: flex; align-items: center; justify-content: center; }
.modal-close:hover { background: rgba(255,255,255,0.1); }
.modal-logo { display: flex; align-items: center; gap: 10px; margin-bottom: 28px; }
.modal-logo .mi { width: 34px; height: 34px; background: var(--green); border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: 16px; }
.modal-logo span { font-size: 17px; font-weight: 800; }
.modal h2 { font-size: 22px; font-weight: 800; margin-bottom: 6px; letter-spacing: -0.4px; }
.modal .modal-sub { font-size: 13.5px; color: var(--text-muted); margin-bottom: 28px; }
.error-banner { background: rgba(239,68,68,0.1); border: 1px solid rgba(239,68,68,0.3); color: #ef4444; font-size: 13px; padding: 10px 14px; border-radius: 10px; margin-bottom: 16px; }
.form-group { margin-bottom: 16px; }
.form-group label { display: block; font-size: 12.5px; font-weight: 600; color: var(--text-soft); margin-bottom: 7px; letter-spacing: 0.01em; }
.form-group input { width: 100%; padding: 12px 14px; background: rgba(255,255,255,0.04); border: 1px solid var(--border); border-radius: 10px; font-size: 14px; color: #fff; font-family: var(--font); outline: none; transition: border-color 0.15s; }
.form-group input::placeholder { color: var(--text-muted); }
.form-group input:focus { border-color: var(--green); background: rgba(34,197,94,0.04); }
.form-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
.form-row label { display: flex; align-items: center; gap: 7px; font-size: 13px; color: var(--text-soft); cursor: pointer; }
.form-row a { font-size: 13px; color: var(--green); text-decoration: none; font-weight: 600; }
.form-row a:hover { text-decoration: underline; }
.btn-sign-in { width: 100%; padding: 13px; background: var(--green); color: #fff; border: none; border-radius: 10px; font-size: 15px; font-weight: 700; cursor: pointer; font-family: var(--font); transition: background 0.15s, box-shadow 0.15s; margin-bottom: 16px; }
.btn-sign-in:hover { background: var(--green-dark); box-shadow: 0 6px 24px rgba(34,197,94,0.3); }
.modal-divider { display: flex; align-items: center; gap: 12px; margin-bottom: 16px; }
.modal-divider hr { flex: 1; border: none; border-top: 1px solid var(--border); }
.modal-divider span { font-size: 12px; color: var(--text-muted); white-space: nowrap; }
.modal-footer { text-align: center; margin-top: 20px; font-size: 13px; color: var(--text-muted); }
.modal-footer a { color: var(--green); text-decoration: none; font-weight: 600; }
</style>
</head>
<body>

<!-- NAVBAR -->
<nav>
  <a class="nav-logo" href="index.jsp">
    <div class="nav-logo-icon">🛍️</div>
    Smart Grocery
  </a>
  <ul class="nav-links">
    <li><a href="#features">Features</a></li>
    <li><a href="#how">How It Works</a></li>
    <li><a href="#trust">Trust</a></li>
  </ul>
  <div class="nav-actions">
    <button class="btn-login" onclick="openModal()">Log In</button>
    <button class="btn-demo" onclick="location.href='register.jsp'">Get Started</button>
  </div>
</nav>

<!-- HERO -->
<section class="hero">
  <div class="hero-bg-img"></div>
  <div class="hero-bg"></div>
  <div class="hero-glow"></div>
  <div class="hero-content">
    <div class="hero-eyebrow"><span></span>Smart Grocery Management System</div>
    <h1>Grocery management<br/>built to <em>reduce waste</em><br/>and grow your kitchen.</h1>
    <p>Inventory tracking, expiry alerts, meal planning, smart reordering, and household analytics. All in one place. Designed for how home grocery actually works.</p>
    <div class="hero-actions">
      <button class="btn-hero-primary" onclick="openModal()">Get Started Free</button>
    </div>
    <div class="hero-stats">
      <div class="hero-stat"><div class="num"><%= totalItems %><span>+</span></div><div class="lbl">Items tracked</div></div>
      <div class="hero-stat"><div class="num"><%= wastePreventedPct %><span>%</span></div><div class="lbl">Less food wasted</div></div>
      <div class="hero-stat"><div class="num"><%= householdNumber %><span><%= householdSuffix %></span></div><div class="lbl">Households using it</div></div>
    </div>
  </div>
</section>

<!-- TAGLINE -->
<section class="section-tagline">
  <h2>Independent by choice.</h2>
  <h2 class="soft">Unstoppable by design.</h2>
  <p class="sub">Smart Grocery gives every household the tools that professional kitchen managers rely on — without the complexity.</p>
  <div class="carousel">
    <div class="carousel-item side" id="carouselSideLeft"></div>
    <div class="carousel-item main" id="carouselMain"></div>
    <div class="carousel-item side" id="carouselSideRight"></div>
  </div>
  <div class="carousel-dots" id="carouselDots"></div>
</section>

<!-- FEATURES -->
<section class="section-features" id="features">
  <div class="section-label">Everything you need</div>
  <h2>All your grocery tools,<br/>finally in one place.</h2>
  <div class="features-grid">
    <div class="feature-card">
      <div class="fc-icon">📦</div>
      <div class="fc-title">Inventory Management</div>
      <div class="fc-desc">Track every item in your kitchen with real-time stock levels, categories, and reorder thresholds — all updated automatically.</div>
    </div>
    <div class="feature-card">
      <div class="fc-icon">⏰</div>
      <div class="fc-title">Expiry Alerts</div>
      <div class="fc-desc">Know before items expire. Get advance alerts so you use what you have before it's wasted — saving money every week.</div>
    </div>
    <div class="feature-card">
      <div class="fc-icon">🍽️</div>
      <div class="fc-title">Meal Planner</div>
      <div class="fc-desc">Plan your week's meals from what's in your inventory. Get suggestions based on expiring items and dietary goals.</div>
    </div>
    <div class="feature-card">
      <div class="fc-icon">🛒</div>
      <div class="fc-title">Smart Shopping Lists</div>
      <div class="fc-desc">Auto-generate shopping lists from low stock alerts, straight from your inventory data.</div>
    </div>
    <div class="feature-card">
      <div class="fc-icon">📊</div>
      <div class="fc-title">Order Tracking</div>
      <div class="fc-desc">Browse products, add to cart, checkout, and track every order from placement to delivery.</div>
    </div>
    <div class="feature-card">
      <div class="fc-icon">👨‍🍳</div>
      <div class="fc-title">Recipe Suggestions</div>
      <div class="fc-desc">Discover recipes that use what you already have — powered by your real inventory.</div>
    </div>
  </div>
</section>

<!-- HOW IT WORKS -->
<section class="section-how" id="how">
  <div class="how-left">
    <div class="section-label">How it works</div>
    <h2>Set up in minutes.<br/>Manage forever.</h2>
    <p>Smart Grocery is designed for real households — not warehouses. Add your items, set your preferences, and let the system do the thinking.</p>
    <div class="how-steps">
      <div class="how-step">
        <div class="step-num">01</div>
        <div class="step-body"><div class="step-title">Create your account</div><div class="step-desc">Register in seconds and set up your household profile.</div></div>
      </div>
      <div class="how-step">
        <div class="step-num">02</div>
        <div class="step-body"><div class="step-title">Add your inventory</div><div class="step-desc">Add items, set quantities, reorder levels, and expiry dates.</div></div>
      </div>
      <div class="how-step">
        <div class="step-num">03</div>
        <div class="step-body"><div class="step-title">Get smart alerts</div><div class="step-desc">See what's expiring, what's running low, and what to cook tonight.</div></div>
      </div>
      <div class="how-step">
        <div class="step-num">04</div>
        <div class="step-body"><div class="step-title">Order and track</div><div class="step-desc">Reorder low-stock items and track every order to your door.</div></div>
      </div>
    </div>
  </div>
  <div class="how-right">
    <div class="dash-preview-title">LIVE DASHBOARD PREVIEW</div>
    <div class="dash-stat-row">
      <div class="dash-stat"><div class="ds-val"><%= totalItems %></div><div class="ds-lbl">Items in Inventory</div></div>
      <div class="dash-stat"><div class="ds-val" style="color:#f59e0b"><%= lowStockCount %></div><div class="ds-lbl">Low Stock</div></div>
      <div class="dash-stat"><div class="ds-val" style="color:#ef4444"><%= expiringCount %></div><div class="ds-lbl">Expiring Soon</div></div>
    </div>
    <div class="dash-alert-row">
      <div class="dash-alert-dot"></div>
      <% if (expiringName != null) { %>
        <%= expiringName %> expires in <%= expiringDays %> day<%= expiringDays == 1 ? "" : "s" %> · Use in a recipe today
      <% } else { %>
        Nothing is expiring soon · You're all good
      <% } %>
    </div>
    <div class="dash-alert-row" style="background:rgba(245,158,11,0.06);border-color:rgba(245,158,11,0.15)">
      <div class="dash-alert-dot" style="background:#f59e0b"></div>
      <% if (lowStockName != null) { %>
        <%= lowStockName %> is running low · Reorder level reached
      <% } else { %>
        All items are well stocked right now
      <% } %>
    </div>
    <div class="dash-bar-row">
      <% for (Integer cid : topCategoryIds) {
           int stock = catStockSum.get(cid);
           int capacity = catCapacitySum.get(cid);
           int pct = capacity > 0 ? Math.min(100, Math.round(stock * 100.0f / capacity)) : 0;
           String cname = categoryNames.containsKey(cid) ? categoryNames.get(cid) : "Category";
      %>
      <div class="dash-bar">
        <div class="dash-bar-label"><%= cname %></div>
        <div class="dash-bar-track"><div class="dash-bar-fill" style="width:<%= pct %>%"></div></div>
        <div class="dash-bar-val"><%= pct %>%</div>
      </div>
      <% } %>
    </div>
    <button class="btn-sign-in" onclick="openModal()" style="margin:0">Sign In to Dashboard →</button>
  </div>
</section>

<!-- TRUST -->
<section class="section-trust" id="trust">
  <div class="trust-label">Trusted by households across Sri Lanka</div>
  <div class="trust-logos">
    <div class="trust-logo">🏬 KEELLS SUPER</div>
    <div class="trust-logo">🛒 CARGILLS</div>
    <div class="trust-logo">🏪 ARPICO</div>
    <div class="trust-logo">🌿 LAUGFS</div>
    <div class="trust-logo">📦 SPAR</div>
  </div>
</section>

<!-- CTA -->
<section class="section-cta">
  <div class="cta-glow"></div>
  <h2>Ready to eat smarter?</h2>
  <p>Join households managing their groceries the smart way.</p>
  <div class="cta-btns">
    <button class="btn-hero-primary" onclick="location.href='register.jsp'">Start For Free</button>
    <button class="btn-hero-primary" style="background:rgba(255,255,255,0.06);color:#fff;border:1px solid var(--border)" onclick="openModal()">Log In</button>
  </div>
</section>

<!-- FOOTER -->
<footer>
  <div class="footer-top">
    <div class="footer-brand">
      <div class="logo">
        <div class="logo-icon">🛍️</div>
        Smart Grocery
      </div>
      <p>Inventory, expiry alerts, meal planning, and smart shopping — all in one place.</p>
    </div>
    <div class="footer-col">
      <h4>Products</h4>
      <ul>
        <li><a href="#features">Inventory Management</a></li>
        <li><a href="#features">Expiry Tracking</a></li>
        <li><a href="#features">Meal Planner</a></li>
        <li><a href="#features">Shopping Lists</a></li>
      </ul>
    </div>
    <div class="footer-col">
      <h4>Account</h4>
      <ul>
        <li><a href="login.jsp">Log In</a></li>
        <li><a href="register.jsp">Register</a></li>
      </ul>
    </div>
    <div class="footer-col">
      <h4>Company</h4>
      <ul>
        <li><a href="#">About Us</a></li>
        <li><a href="#">Contact</a></li>
      </ul>
    </div>
  </div>
  <div class="footer-bottom">
    <p>&copy; Smart Grocery 2026</p>
    <div class="footer-legal">
      <a href="#">Terms of Service</a>
      <a href="#">Privacy Policy</a>
    </div>
  </div>
</footer>

<!-- LOGIN MODAL -->
<div class="modal-overlay" id="loginModal" onclick="handleOverlayClick(event)">
  <div class="modal">
    <button class="modal-close" onclick="closeModal()">✕</button>
    <div class="modal-logo">
      <div class="mi">🛍️</div>
      <span>Smart Grocery</span>
    </div>
    <h2>Welcome back</h2>
    <p class="modal-sub">Sign in to your Smart Grocery account</p>

    <%
        String error = request.getParameter("error");
        if (error != null) {
    %>
        <div class="error-banner">Invalid email or password. Please try again.</div>
    <%
        }
    %>

    <form action="LoginServlet" method="post">
        <div class="form-group">
          <label>Email Address</label>
          <input type="email" name="email" placeholder="you@email.com" required/>
        </div>
        <div class="form-group">
          <label>Password</label>
          <input type="password" name="password" placeholder="Enter your password" required/>
        </div>
        <div class="form-row">
          <label><input type="checkbox" style="accent-color:var(--green)"/> Remember me</label>
        </div>
        <button type="submit" class="btn-sign-in">Sign In →</button>
    </form>

    <div class="modal-divider"><hr/><span>or</span><hr/></div>
    <div class="modal-footer">
      Don't have an account? <a href="register.jsp">Create one free</a>
    </div>
  </div>
</div>

<script>
  function openModal() {
    document.getElementById('loginModal').classList.add('open');
  }
  function closeModal() {
    document.getElementById('loginModal').classList.remove('open');
  }
  function handleOverlayClick(e) {
    if (e.target === e.currentTarget) closeModal();
  }
  document.addEventListener('keydown', e => {
    if (e.key === 'Escape') closeModal();
  });

  <% if (error != null) { %>
  window.addEventListener('load', openModal);
  <% } %>

  /* Auto-rotating carousel photos - each box shows a DIFFERENT photo at the same time.
     Every photo has a backup URL, and if BOTH fail to load, a gradient + icon is shown
     instead so a box is never left blank. */
  const carouselPhotos = [
    { url: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=900&q=80', fallback: 'https://images.unsplash.com/photo-1543168256-418811576931?w=900&q=80', icon: '🥦' },
    { url: 'https://images.unsplash.com/photo-1506617420156-8e4536971650?w=900&q=80', fallback: 'https://images.unsplash.com/photo-1610832958506-aa56368176cf?w=900&q=80', icon: '🛒' },
    { url: 'https://images.unsplash.com/photo-1518843875459-f738682238a6?w=900&q=80', fallback: 'https://images.unsplash.com/photo-1524179091875-bf99a9a6af57?w=900&q=80', icon: '🥗' },
    { url: 'https://images.unsplash.com/photo-1610348725531-843dff563e2c?w=900&q=80', fallback: 'https://images.unsplash.com/photo-1567306301408-9b74779a11af?w=900&q=80', icon: '🍎' },
    { url: 'https://images.unsplash.com/photo-1583258292688-d0213dc5a3a8?w=900&q=80', fallback: 'https://images.unsplash.com/photo-1519996529931-28324d5a630e?w=900&q=80', icon: '🥕' },
    { url: 'https://images.unsplash.com/photo-1580913428735-bce91382018c?w=900&q=80', fallback: 'https://images.unsplash.com/photo-1534483509719-3feaee7c30da?w=900&q=80', icon: '🍇' }
  ];
  const numPhotos = carouselPhotos.length;

  function buildCarouselSlot(containerId, startIndex) {
    const container = document.getElementById(containerId);
    const slides = [];
    carouselPhotos.forEach((photo, i) => {
      // Gradient + icon layer sits underneath - shows through if the photo fails
      const fallbackDiv = document.createElement('div');
      fallbackDiv.className = 'ci-fallback' + (i === startIndex ? ' active' : '');
      fallbackDiv.textContent = photo.icon;
      container.appendChild(fallbackDiv);

      const img = document.createElement('img');
      img.className = 'ci-img' + (i === startIndex ? ' active' : '');
      img.alt = '';
      let triedFallback = false;
      img.onerror = function () {
        if (!triedFallback) {
          triedFallback = true;
          img.src = photo.fallback;       // try the backup photo first
        } else {
          img.style.display = 'none';     // both failed, let the gradient + icon show
        }
      };
      img.src = photo.url;
      container.appendChild(img);

      slides.push({ img, fallbackDiv });
    });
    return { slides, index: startIndex };
  }

  /* Offset each box by 1 photo so all 3 show different images at once */
  const boxLeft  = buildCarouselSlot('carouselSideLeft', 0);
  const boxMain  = buildCarouselSlot('carouselMain', 1);
  const boxRight = buildCarouselSlot('carouselSideRight', 2);

  /* Dots track the main (center) box */
  const dotsContainer = document.getElementById('carouselDots');
  carouselPhotos.forEach((_, i) => {
    const dot = document.createElement('div');
    dot.className = 'cdot' + (i === boxMain.index ? ' active' : '');
    dotsContainer.appendChild(dot);
  });
  function updateDots() {
    Array.prototype.forEach.call(dotsContainer.children, function (d, i) {
      d.classList.toggle('active', i === boxMain.index);
    });
  }

  function advanceBox(box) {
    const cur = box.slides[box.index];
    cur.img.classList.remove('active');
    cur.fallbackDiv.classList.remove('active');
    box.index = (box.index + 1) % numPhotos;
    const next = box.slides[box.index];
    next.img.classList.add('active');
    next.fallbackDiv.classList.add('active');
  }

  setInterval(() => {
    advanceBox(boxLeft);
    advanceBox(boxMain);
    advanceBox(boxRight);
    updateDots();
  }, 3000);
</script>
</body>
</html>
