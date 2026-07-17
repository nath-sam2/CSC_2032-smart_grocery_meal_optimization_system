-- ============================================================
-- MERGED SCHEMA: smart_grocery_system
--            + smart_grocery_management_and_meal_optimization_system
--
-- Strategy:
--   - `products` and `users` existed as STUB tables (ID only) in
--     the meal-planning dump, and as FULL tables in the
--     inventory/e-commerce dump. We keep the FULL versions and
--     repoint every foreign key at them.
--   - All other tables from both dumps are kept as-is.
--
-- ASSUMPTIONS / PLACEHOLDER DATA (please review before using):
--   - products.name / unit  <- derived from `ingredients` table
--     (1 ingredient per product in the source data)
--   - products.price, quantity <- set to 0.00 / 0 (no source data)
--   - users.name/email/password <- placeholder values, REPLACE
--     with real data before using in production
-- ============================================================

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
SET NAMES utf8mb4;

-- ------------------------------------------------------------
-- Core reference tables (from inventory/e-commerce dump)
-- ------------------------------------------------------------

CREATE TABLE categories (
  categoryId int(11) NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  description text DEFAULT NULL,
  PRIMARY KEY (categoryId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE users (
  userId int(11) NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  email varchar(100) NOT NULL,
  password varchar(255) NOT NULL,
  role enum('USER','ADMIN') DEFAULT 'USER',
  created_at timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (userId),
  UNIQUE KEY email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE products (
  productId int(11) NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  price decimal(10,2) NOT NULL DEFAULT 0.00,
  quantity int(11) DEFAULT 0,
  expiryDate date DEFAULT NULL,
  unit varchar(50) DEFAULT NULL,
  categoryId int(11) DEFAULT NULL,
  created_at timestamp NOT NULL DEFAULT current_timestamp(),
  updated_at timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (productId),
  KEY fk_product_category (categoryId),
  CONSTRAINT fk_product_category FOREIGN KEY (categoryId) REFERENCES categories (categoryId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE inventory (
  inventoryId int(11) NOT NULL AUTO_INCREMENT,
  productId int(11) NOT NULL,
  quantity int(11) DEFAULT 0,
  reorderLevel int(11) DEFAULT 5,
  updated_at timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (inventoryId),
  KEY fk_inventory_product (productId),
  CONSTRAINT fk_inventory_product FOREIGN KEY (productId) REFERENCES products (productId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE notifications (
  notifId int(11) NOT NULL AUTO_INCREMENT,
  productId int(11) DEFAULT NULL,
  message varchar(255) NOT NULL,
  type enum('LOW_STOCK','EXPIRY') NOT NULL,
  isRead tinyint(1) DEFAULT 0,
  timestamp timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (notifId),
  KEY fk_notif_product (productId),
  CONSTRAINT fk_notif_product FOREIGN KEY (productId) REFERENCES products (productId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE orders (
  orderId int(11) NOT NULL AUTO_INCREMENT,
  userId int(11) NOT NULL,
  totalAmount decimal(10,2) NOT NULL,
  status enum('PENDING','PROCESSING','DELIVERED','CANCELLED') DEFAULT 'PENDING',
  created_at timestamp NOT NULL DEFAULT current_timestamp(),
  orderDate date DEFAULT NULL,
  PRIMARY KEY (orderId),
  KEY fk_order_user (userId),
  CONSTRAINT fk_order_user FOREIGN KEY (userId) REFERENCES users (userId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE order_items (
  orderItemId int(11) NOT NULL AUTO_INCREMENT,
  orderId int(11) NOT NULL,
  productId int(11) NOT NULL,
  quantity int(11) NOT NULL,
  price decimal(10,2) NOT NULL,
  subtotal decimal(10,2) NOT NULL,
  PRIMARY KEY (orderItemId),
  KEY fk_orderitem_order (orderId),
  KEY fk_orderitem_product (productId),
  CONSTRAINT fk_orderitem_order FOREIGN KEY (orderId) REFERENCES orders (orderId),
  CONSTRAINT fk_orderitem_product FOREIGN KEY (productId) REFERENCES products (productId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ------------------------------------------------------------
-- Meal-planning tables (from meal-planning dump), FKs repointed
-- at the real `products` / `users` tables above
-- ------------------------------------------------------------

CREATE TABLE dietaryrestrictions (
  restrictionId int(11) NOT NULL AUTO_INCREMENT,
  restrictionName varchar(50) NOT NULL,
  description text DEFAULT NULL,
  PRIMARY KEY (restrictionId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE ingredients (
  ingredientId int(11) NOT NULL AUTO_INCREMENT,
  productId int(11) NOT NULL,
  name varchar(100) NOT NULL,
  category varchar(50) DEFAULT NULL,
  unit varchar(20) DEFAULT NULL,
  PRIMARY KEY (ingredientId),
  KEY fk_ingredient_product (productId),
  CONSTRAINT fk_ingredient_product FOREIGN KEY (productId) REFERENCES products (productId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE recipes (
  recipeId int(11) NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  description text DEFAULT NULL,
  mealType varchar(50) DEFAULT NULL,
  cuisine varchar(50) DEFAULT NULL,
  cookingTime int(11) DEFAULT NULL,
  difficulty varchar(20) DEFAULT NULL,
  servings int(11) DEFAULT NULL,
  PRIMARY KEY (recipeId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE recipeingredients (
  recipeIngredientId int(11) NOT NULL AUTO_INCREMENT,
  recipeId int(11) NOT NULL,
  ingredientId int(11) NOT NULL,
  quantity decimal(10,2) NOT NULL,
  unit varchar(20) DEFAULT NULL,
  PRIMARY KEY (recipeIngredientId),
  KEY fk_recipeingredient_recipe (recipeId),
  KEY fk_recipeingredient_ingredient (ingredientId),
  CONSTRAINT fk_recipeingredient_recipe FOREIGN KEY (recipeId) REFERENCES recipes (recipeId),
  CONSTRAINT fk_recipeingredient_ingredient FOREIGN KEY (ingredientId) REFERENCES ingredients (ingredientId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE nutritionfacts (
  nutritionId int(11) NOT NULL AUTO_INCREMENT,
  recipeId int(11) NOT NULL,
  servingSize varchar(50) DEFAULT NULL,
  servingsPerContainer int(11) DEFAULT NULL,
  calories decimal(6,2) DEFAULT NULL,
  totalFat decimal(6,2) DEFAULT NULL,
  saturatedFat decimal(6,2) DEFAULT NULL,
  transFat decimal(6,2) DEFAULT NULL,
  cholesterol decimal(6,2) DEFAULT NULL,
  sodium decimal(6,2) DEFAULT NULL,
  totalCarbohydrates decimal(6,2) DEFAULT NULL,
  dietaryFiber decimal(6,2) DEFAULT NULL,
  totalSugar decimal(6,2) DEFAULT NULL,
  addedSugar decimal(6,2) DEFAULT NULL,
  protein decimal(6,2) DEFAULT NULL,
  vitaminA decimal(6,2) DEFAULT NULL,
  vitaminC decimal(6,2) DEFAULT NULL,
  vitaminD decimal(6,2) DEFAULT NULL,
  calcium decimal(6,2) DEFAULT NULL,
  iron decimal(6,2) DEFAULT NULL,
  potassium decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (nutritionId),
  KEY fk_nutrition_recipe (recipeId),
  CONSTRAINT fk_nutrition_recipe FOREIGN KEY (recipeId) REFERENCES recipes (recipeId) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE mealplans (
  mealPlanId int(11) NOT NULL AUTO_INCREMENT,
  userId int(11) NOT NULL,
  planName varchar(100) DEFAULT NULL,
  startDate date DEFAULT NULL,
  endDate date DEFAULT NULL,
  PRIMARY KEY (mealPlanId),
  KEY fk_mealplan_user (userId),
  CONSTRAINT fk_mealplan_user FOREIGN KEY (userId) REFERENCES users (userId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE mealplandetails (
  mealPlanDetailId int(11) NOT NULL AUTO_INCREMENT,
  mealPlanId int(11) NOT NULL,
  recipeId int(11) NOT NULL,
  mealDate date DEFAULT NULL,
  mealType varchar(30) DEFAULT NULL,
  PRIMARY KEY (mealPlanDetailId),
  KEY fk_detail_plan (mealPlanId),
  KEY fk_detail_recipe (recipeId),
  CONSTRAINT fk_detail_plan FOREIGN KEY (mealPlanId) REFERENCES mealplans (mealPlanId),
  CONSTRAINT fk_detail_recipe FOREIGN KEY (recipeId) REFERENCES recipes (recipeId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE shoppinglists (
  shoppingListId int(11) NOT NULL AUTO_INCREMENT,
  userId int(11) NOT NULL,
  createdDate date DEFAULT NULL,
  status varchar(20) DEFAULT NULL,
  PRIMARY KEY (shoppingListId),
  KEY fk_shoplist_user (userId),
  CONSTRAINT fk_shoplist_user FOREIGN KEY (userId) REFERENCES users (userId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE shoppinglistitems (
  shoppingListItemId int(11) NOT NULL AUTO_INCREMENT,
  shoppingListId int(11) NOT NULL,
  ingredientId int(11) NOT NULL,
  quantity decimal(10,2) DEFAULT NULL,
  unit varchar(20) DEFAULT NULL,
  status varchar(20) DEFAULT 'Pending',
  PRIMARY KEY (shoppingListItemId),
  KEY fk_item_list (shoppingListId),
  KEY fk_item_ingredient (ingredientId),
  CONSTRAINT fk_item_list FOREIGN KEY (shoppingListId) REFERENCES shoppinglists (shoppingListId),
  CONSTRAINT fk_item_ingredient FOREIGN KEY (ingredientId) REFERENCES ingredients (ingredientId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE userdietaryrestrictions (
  userId int(11) NOT NULL,
  restrictionId int(11) NOT NULL,
  PRIMARY KEY (userId, restrictionId),
  KEY restrictionId (restrictionId),
  CONSTRAINT userdietaryrestrictions_ibfk_1 FOREIGN KEY (userId) REFERENCES users (userId),
  CONSTRAINT userdietaryrestrictions_ibfk_2 FOREIGN KEY (restrictionId) REFERENCES dietaryrestrictions (restrictionId)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================================
-- DATA
-- ============================================================

-- users (placeholder data — REPLACE with real names/emails/passwords)
INSERT INTO users (userId, name, email, password, role) VALUES
(1,'User 1','user1@example.com','CHANGEME','USER'),
(2,'User 2','user2@example.com','CHANGEME','USER'),
(3,'User 3','user3@example.com','CHANGEME','USER'),
(4,'User 4','user4@example.com','CHANGEME','USER'),
(5,'User 5','user5@example.com','CHANGEME','USER'),
(6,'User 6','user6@example.com','CHANGEME','USER'),
(7,'User 7','user7@example.com','CHANGEME','USER'),
(8,'User 8','user8@example.com','CHANGEME','USER'),
(9,'User 9','user9@example.com','CHANGEME','USER'),
(10,'User 10','user10@example.com','CHANGEME','USER'),
(11,'User 11','user11@example.com','CHANGEME','USER'),
(12,'User 12','user12@example.com','CHANGEME','USER');

-- products (name/unit derived from `ingredients`; price/quantity are placeholders)
INSERT INTO products (productId, name, price, quantity, unit) VALUES
(1,'Chicken Breast',0.00,0,'g'),
(2,'White Rice',0.00,0,'g'),
(3,'Broccoli',0.00,0,'g'),
(4,'Carrots',0.00,0,'g'),
(5,'Soy Sauce',0.00,0,'ml'),
(6,'Whole Milk',0.00,0,'ml'),
(7,'Eggs',0.00,0,'pcs'),
(8,'Salmon Fillet',0.00,0,'g'),
(9,'Quinoa',0.00,0,'g'),
(10,'Cucumber',0.00,0,'pcs'),
(11,'Tomatoes',0.00,0,'pcs'),
(12,'Rolled Oats',0.00,0,'g'),
(13,'Banana',0.00,0,'pcs'),
(14,'Red Lentils',0.00,0,'g'),
(15,'Greek Yogurt',0.00,0,'g'),
(16,'Sourdough Bread',0.00,0,'slices'),
(17,'Avocado',0.00,0,'pcs'),
(18,'All-Purpose Flour',0.00,0,'g'),
(19,'Maple Syrup',0.00,0,'ml'),
(20,'Coconut Milk',0.00,0,'ml'),
(21,'Curry Powder',0.00,0,'g'),
(22,'Feta Cheese',0.00,0,'g'),
(23,'Olive Oil',0.00,0,'ml'),
(24,'Beef Patty',0.00,0,'g'),
(25,'Burger Buns',0.00,0,'pcs'),
(26,'Potatoes',0.00,0,'g'),
(27,'Rice Noodles',0.00,0,'g'),
(28,'Shrimp',0.00,0,'g'),
(29,'Pad Thai Sauce',0.00,0,'ml'),
(30,'Penne Pasta',0.00,0,'g'),
(31,'Tomato Marinara',0.00,0,'g'),
(32,'Grated Coconut',0.00,0,'g'),
(33,'Chili Flakes',0.00,0,'g'),
(34,'Flour Tortillas',0.00,0,'pcs'),
(35,'Shredded Cheese',0.00,0,'g');

-- dietaryrestrictions
INSERT INTO dietaryrestrictions (restrictionId, restrictionName, description) VALUES
(3, 'Peanut allergy', 'Peanut allergy is a type of food allergy that can cause a range of symptoms, from mild reactions to severe anaphylaxis. Symptoms typically occur within 1 to 2 hours after exposure and can include skin reactions, gastrointestinal issues, respiratory symptoms, and cardiovascular effects. Anaphylaxis is a life-threatening reaction that requires immediate treatment with epinephrine. The condition is increasing in prevalence, particularly among children, and is managed through avoidance of peanuts and the use of epinephrine autoinjectors. '),
(4, 'Lactose intolerance', 'Lactose intolerance is a digestive disorder caused by a deficiency of the enzyme lactase.'),
(5, 'Gluten intolerance or sensitivity', 'Gluten is one of the main proteins in wheat, but it is also found in barley and rye.'),
(6, 'Vegetarianism', 'Vegetarianism is a dietary pattern that relies mainly on plant-based foods and avoids meat, poultry, and fish.');

-- ingredients
INSERT INTO ingredients (ingredientId, productId, name, category, unit) VALUES
(1, 1, 'Chicken Breast', 'Meat & Poultry', 'g'),
(2, 2, 'White Rice', 'Grains & Pasta', 'g'),
(3, 3, 'Broccoli', 'Vegetables', 'g'),
(4, 4, 'Carrots', 'Vegetables', 'g'),
(5, 5, 'Soy Sauce', 'Condiments', 'ml'),
(6, 6, 'Whole Milk', 'Dairy', 'ml'),
(7, 7, 'Eggs', 'Dairy & Eggs', 'pcs'),
(8, 8, 'Salmon Fillet', 'Seafood', 'g'),
(9, 9, 'Quinoa', 'Grains & Pasta', 'g'),
(10, 10, 'Cucumber', 'Vegetables', 'pcs'),
(11, 11, 'Tomatoes', 'Vegetables', 'pcs'),
(12, 12, 'Rolled Oats', 'Grains & Pasta', 'g'),
(13, 13, 'Banana', 'Fruits', 'pcs'),
(14, 14, 'Red Lentils', 'Legumes', 'g'),
(15, 15, 'Greek Yogurt', 'Dairy', 'g'),
(16, 16, 'Sourdough Bread', 'Bakery', 'slices'),
(17, 17, 'Avocado', 'Fruits', 'pcs'),
(18, 18, 'All-Purpose Flour', 'Grains & Pasta', 'g'),
(19, 19, 'Maple Syrup', 'Condiments', 'ml'),
(20, 20, 'Coconut Milk', 'Condiments', 'ml'),
(21, 21, 'Curry Powder', 'Condiments', 'g'),
(22, 22, 'Feta Cheese', 'Dairy', 'g'),
(23, 23, 'Olive Oil', 'Condiments', 'ml'),
(24, 24, 'Beef Patty', 'Meat & Poultry', 'g'),
(25, 25, 'Burger Buns', 'Bakery', 'pcs'),
(26, 26, 'Potatoes', 'Vegetables', 'g'),
(27, 27, 'Rice Noodles', 'Grains & Pasta', 'g'),
(28, 28, 'Shrimp', 'Seafood', 'g'),
(29, 29, 'Pad Thai Sauce', 'Condiments', 'ml'),
(30, 30, 'Penne Pasta', 'Grains & Pasta', 'g'),
(31, 31, 'Tomato Marinara', 'Condiments', 'g'),
(32, 32, 'Grated Coconut', 'Groceries', 'g'),
(33, 33, 'Chili Flakes', 'Condiments', 'g'),
(34, 34, 'Flour Tortillas', 'Bakery', 'pcs'),
(35, 35, 'Shredded Cheese', 'Dairy', 'g');

-- recipes
INSERT INTO recipes (recipeId, name, description, mealType, cuisine, cookingTime, difficulty, servings) VALUES
(3, 'Chicken Curry With Sauce', 'Traditional Sri Lankan spicy chicken curry', 'Dinner', 'Sri Lankan', 45, 'Medium', 4),
(4, 'Vegetable Fried Rice', 'Healthy fried rice with mixed vegetables', 'Lunch', 'Asian', 30, 'Easy', 2),
(5, 'Grilled Salmon', 'Grilled salmon with steamed vegetables', 'Dinner', 'Western', 35, 'Hard', 2),
(6, 'Quinoa Salad', 'Fresh quinoa salad with cucumber and tomatoes', 'Lunch', 'Mediterranean', 20, 'Easy', 2),
(7, 'Oatmeal with Fruits', 'Healthy oatmeal topped with bananas and berries', 'Breakfast', 'International', 10, 'Easy', 1),
(8, 'Egg Omelette', 'Protein-rich vegetable omelette', 'Breakfast', 'International', 15, 'Easy', 1),
(9, 'Lentil Soup', 'Nutritious red lentil soup', 'Dinner', 'Middle Eastern', 40, 'Easy', 4),
(10, 'Chicken Caesar Salad', 'Grilled chicken with fresh lettuce', 'Lunch', 'Western', 25, 'Easy', 2),
(11, 'Beef Stir Fry', 'Lean beef with broccoli and carrots', 'Dinner', 'Asian', 30, 'Medium', 3),
(12, 'Fruit Smoothie', 'Mixed fruit smoothie with yogurt', 'Breakfast', 'International', 10, 'Easy', 1),
(16, 'Test Recipe', 'Lunch', 'Dinner', 'Sri Lankan', 30, 'Easy', 7),
(17, 'Avocado Toast with Egg', 'Crispy sourdough toast topped with mashed avocado and a poached egg', 'Breakfast', 'International', 10, 'Easy', 1),
(18, 'Pancakes with Maple Syrup', 'Fluffy buttermilk pancakes served with butter and fresh maple syrup', 'Breakfast', 'Western', 15, 'Easy', 2),
(19, 'Dhal Curry', 'Traditional Sri Lankan red lentil curry cooked in rich coconut milk', 'Lunch', 'Sri Lankan', 20, 'Easy', 4),
(20, 'Greek Salad', 'Crisp cucumbers, tomatoes, red onions, olives, and feta cheese blocks', 'Lunch', 'Mediterranean', 15, 'Easy', 2),
(21, 'Beef Burgers with Fries', 'Juicy grilled beef patties on toasted buns with a side of crispy fries', 'Dinner', 'Western', 30, 'Medium', 2),
(22, 'Shrimp Pad Thai', 'Classic Thai stir-fried rice noodles with shrimp, tofu, and bean sprouts', 'Dinner', 'Asian', 25, 'Medium', 2),
(23, 'Vegetable Pasta', 'Penne pasta tossed with mixed garden vegetables in a rich marinara sauce', 'Dinner', 'Western', 20, 'Easy', 3),
(24, 'Pol Sambol with Roti', 'Spicy coconut sambol served alongside warm, flaky flatbread rotis', 'Dinner', 'Sri Lankan', 25, 'Medium', 2),
(25, 'Chia Seed Pudding', 'Healthy chia seeds soaked in almond milk with vanilla and honey', 'Breakfast', 'International', 10, 'Easy', 1),
(26, 'Chicken Quesadilla', 'Toasted flour tortillas filled with melted cheese and seasoned chicken', 'Lunch', 'Mexican', 15, 'Easy', 2);

-- recipeingredients
INSERT INTO recipeingredients (recipeIngredientId, recipeId, ingredientId, quantity, unit) VALUES
(1, 4, 2, 200.00, 'g'),(2, 4, 3, 50.00, 'g'),(3, 4, 4, 50.00, 'g'),(4, 4, 5, 15.00, 'ml'),
(5, 9, 14, 150.00, 'g'),(6, 9, 4, 100.00, 'g'),
(7, 17, 16, 2.00, 'slices'),(8, 17, 17, 1.00, 'pcs'),(9, 17, 7, 1.00, 'pcs'),
(10, 18, 18, 100.00, 'g'),(11, 18, 6, 50.00, 'ml'),(12, 18, 19, 30.00, 'ml'),
(13, 19, 14, 200.00, 'g'),(14, 19, 20, 150.00, 'ml'),(15, 19, 21, 10.00, 'g'),
(16, 20, 10, 150.00, 'pcs'),(17, 20, 22, 100.00, 'g'),(18, 20, 23, 15.00, 'ml'),
(19, 21, 24, 300.00, 'g'),(20, 21, 25, 2.00, 'pcs'),(21, 21, 26, 200.00, 'g'),
(22, 22, 27, 150.00, 'g'),(23, 22, 28, 100.00, 'g'),(24, 22, 29, 30.00, 'ml'),
(25, 23, 30, 200.00, 'g'),(26, 23, 31, 150.00, 'g'),(27, 23, 4, 50.00, 'g'),
(28, 3, 1, 500.00, 'g'),(29, 3, 21, 20.00, 'g'),(30, 3, 20, 200.00, 'ml'),
(31, 5, 8, 250.00, 'g'),(32, 5, 23, 15.00, 'ml'),(33, 5, 3, 100.00, 'g'),
(34, 6, 9, 150.00, 'g'),(35, 6, 10, 1.00, 'pcs'),(36, 6, 11, 2.00, 'pcs'),
(37, 7, 12, 75.00, 'g'),(38, 7, 6, 200.00, 'ml'),(39, 7, 13, 1.00, 'pcs'),
(40, 8, 7, 3.00, 'pcs'),(41, 8, 6, 30.00, 'ml'),(42, 8, 11, 50.00, 'g'),
(43, 10, 1, 150.00, 'g'),(44, 10, 23, 20.00, 'ml'),
(45, 11, 24, 300.00, 'g'),(46, 11, 3, 150.00, 'g'),(47, 11, 4, 100.00, 'g'),
(48, 12, 13, 1.00, 'pcs'),(49, 12, 15, 150.00, 'g'),(50, 12, 6, 100.00, 'ml'),
(51, 16, 2, 200.00, 'g'),(52, 16, 4, 100.00, 'g'),
(53, 24, 32, 150.00, 'g'),(54, 24, 33, 15.00, 'g'),(55, 24, 18, 100.00, 'g'),
(56, 25, 6, 200.00, 'ml'),(57, 25, 19, 20.00, 'ml'),
(58, 26, 34, 2.00, 'pcs'),(59, 26, 1, 100.00, 'g'),(60, 26, 35, 75.00, 'g');

-- nutritionfacts
INSERT INTO nutritionfacts (nutritionId, recipeId, servingSize, servingsPerContainer, calories, totalFat, saturatedFat, transFat, cholesterol, sodium, totalCarbohydrates, dietaryFiber, totalSugar, addedSugar, protein, vitaminA, vitaminC, vitaminD, calcium, iron, potassium) VALUES
(5, 3, '250g', 1, 320.00, 12.00, 3.00, 0.00, 70.00, 380.00, 15.00, 3.00, 4.00, 1.00, 30.00, 20.00, 15.00, 2.00, 120.00, 2.50, 450.00),
(6, 4, '250g', 1, 290.00, 8.00, 1.20, 0.00, 0.00, 250.00, 45.00, 6.00, 4.00, 0.00, 8.00, 40.00, 35.00, 0.00, 80.00, 2.00, 500.00),
(7, 5, '200g', 1, 280.00, 10.00, 2.00, 0.00, 65.00, 180.00, 5.00, 2.00, 0.00, 0.00, 32.00, 15.00, 10.00, 12.00, 60.00, 1.50, 550.00),
(8, 6, '220g', 1, 210.00, 6.00, 1.00, 0.00, 0.00, 90.00, 28.00, 7.00, 3.00, 0.00, 10.00, 45.00, 30.00, 0.00, 90.00, 3.00, 600.00),
(9, 7, '180g', 1, 180.00, 4.00, 1.00, 0.00, 0.00, 70.00, 30.00, 5.00, 8.00, 0.00, 7.00, 10.00, 25.00, 5.00, 150.00, 2.00, 400.00),
(10, 8, '180g', 1, 240.00, 15.00, 4.00, 0.00, 180.00, 300.00, 5.00, 1.00, 2.00, 0.00, 18.00, 8.00, 6.00, 4.00, 100.00, 2.00, 250.00),
(11, 9, '250g', 1, 200.00, 3.00, 0.50, 0.00, 0.00, 220.00, 32.00, 9.00, 2.00, 0.00, 14.00, 30.00, 18.00, 0.00, 90.00, 4.00, 650.00),
(12, 10, '220g', 1, 270.00, 9.00, 2.00, 0.00, 60.00, 320.00, 12.00, 4.00, 3.00, 0.00, 28.00, 18.00, 12.00, 2.00, 110.00, 2.50, 420.00),
(13, 11, '250g', 1, 350.00, 14.00, 4.00, 0.00, 75.00, 410.00, 18.00, 5.00, 3.00, 0.00, 30.00, 25.00, 10.00, 2.00, 80.00, 3.50, 500.00),
(14, 12, '300ml', 1, 170.00, 2.00, 0.50, 0.00, 5.00, 60.00, 32.00, 4.00, 18.00, 0.00, 6.00, 35.00, 60.00, 2.00, 180.00, 1.50, 450.00),
(15, 17, '180g', 1, 350.00, 22.00, 4.50, 0.00, 185.00, 420.00, 28.00, 7.00, 3.00, 0.00, 14.00, 80.00, 12.00, 1.50, 60.00, 2.50, 450.00),
(16, 18, '220g', 1, 480.00, 12.00, 5.00, 0.00, 65.00, 580.00, 82.00, 2.00, 35.00, 25.00, 9.00, 50.00, 0.00, 1.10, 150.00, 1.80, 180.00),
(17, 19, '250g', 1, 290.00, 9.00, 7.00, 0.00, 0.00, 340.00, 38.00, 12.00, 2.00, 0.00, 15.00, 110.00, 4.00, 0.00, 40.00, 4.20, 620.00),
(18, 20, '220g', 1, 210.00, 16.00, 6.00, 0.00, 25.00, 610.00, 11.00, 3.00, 5.00, 0.00, 6.00, 140.00, 22.00, 0.00, 180.00, 1.10, 320.00),
(19, 21, '250g', 1, 850.00, 42.00, 14.00, 1.20, 95.00, 980.00, 78.00, 6.00, 8.00, 2.00, 38.00, 40.00, 15.00, 0.50, 120.00, 5.50, 890.00),
(20, 22, '250g', 1, 540.00, 14.00, 2.50, 0.00, 145.00, 1050.00, 76.00, 4.00, 18.00, 12.00, 26.00, 90.00, 18.00, 0.00, 80.00, 3.20, 410.00),
(21, 23, '250g', 1, 410.00, 8.00, 1.50, 0.00, 0.00, 490.00, 68.00, 6.00, 9.00, 0.00, 12.00, 210.00, 34.00, 0.00, 70.00, 2.80, 530.00),
(22, 16, '250g', 1, 310.00, 6.00, 1.00, 0.00, 0.00, 190.00, 52.00, 4.00, 2.00, 0.00, 7.00, 85.00, 14.00, 0.00, 40.00, 1.80, 290.00),
(23, 24, '200g', 1, 460.00, 24.00, 19.50, 0.00, 0.00, 510.00, 54.00, 8.00, 3.00, 0.00, 9.00, 75.00, 18.00, 0.00, 50.00, 3.10, 410.00),
(24, 25, '180g', 1, 230.00, 9.00, 1.50, 0.00, 5.00, 85.00, 29.00, 11.00, 14.00, 8.00, 6.00, 45.00, 1.00, 1.50, 220.00, 2.10, 280.00),
(25, 26, '220g', 1, 510.00, 23.00, 11.00, 0.50, 85.00, 840.00, 38.00, 3.00, 2.00, 0.00, 34.00, 90.00, 4.00, 0.80, 310.00, 2.40, 360.00);

-- mealplans
INSERT INTO mealplans (mealPlanId, userId, planName, startDate, endDate) VALUES
(2, 1, 'Healthy Weekly Plan', '2026-07-07', '2026-07-13'),
(3, 1, 'Healthy Weekly Plan', '2026-07-07', '2026-07-13'),
(4, 1, 'Healthy Weekly Plan', '2026-07-07', '2026-07-13'),
(5, 1, 'Healthy Weekly Plan', '2026-07-07', '2026-07-13'),
(6, 1, 'Weekly Healthy Meal Plan', '2026-07-07', '2026-07-13'),
(7, 1, 'Weekly Healthy Meal Plan', '2026-07-07', '2026-07-13'),
(8, 1, 'Weekly Healthy Meal Plan', '2026-07-07', '2026-07-13');

-- mealplandetails
INSERT INTO mealplandetails (mealPlanDetailId, mealPlanId, recipeId, mealDate, mealType) VALUES
(3, 2, 5, '2026-07-07', 'Lunch'),
(52, 8, 6, '2026-07-07', 'Breakfast'),(53, 8, 9, '2026-07-07', 'Lunch'),(54, 8, 5, '2026-07-07', 'Dinner'),
(55, 8, 7, '2026-07-08', 'Breakfast'),(56, 8, 4, '2026-07-08', 'Lunch'),(57, 8, 10, '2026-07-08', 'Dinner'),
(58, 8, 8, '2026-07-09', 'Breakfast'),(59, 8, 12, '2026-07-09', 'Lunch'),(60, 8, 3, '2026-07-09', 'Dinner'),
(61, 8, 11, '2026-07-10', 'Breakfast'),(62, 8, 6, '2026-07-10', 'Lunch'),(63, 8, 9, '2026-07-10', 'Dinner'),
(64, 8, 5, '2026-07-11', 'Breakfast'),(65, 8, 7, '2026-07-11', 'Lunch'),(66, 8, 4, '2026-07-11', 'Dinner'),
(67, 8, 10, '2026-07-12', 'Breakfast'),(68, 8, 8, '2026-07-12', 'Lunch'),(69, 8, 12, '2026-07-12', 'Dinner'),
(70, 8, 3, '2026-07-13', 'Breakfast'),(71, 8, 11, '2026-07-13', 'Lunch'),(72, 8, 6, '2026-07-13', 'Dinner'),
(73, 2, 3, '2026-07-13', 'Lunch'),
(74, 2, 6, '2026-07-14', 'Breakfast');

-- shoppinglists
INSERT INTO shoppinglists (shoppingListId, userId, createdDate, status) VALUES
(2, 1, '2026-07-06', 'Pending'),
(3, 1, '2026-07-07', 'Pending'),
(4, 1, '2026-07-13', 'Pending'),
(5, 1, '2026-07-13', 'Pending'),
(6, 1, '2026-07-13', 'Pending');

-- shoppinglistitems
INSERT INTO shoppinglistitems (shoppingListItemId, shoppingListId, ingredientId, quantity, unit, status) VALUES
(4, 2, 1, 2.00, 'pcs', 'Pending'),
(7, 2, 1, 2.00, 'pcs', 'Pending');

-- userdietaryrestrictions
INSERT INTO userdietaryrestrictions (userId, restrictionId) VALUES
(1, 4),(2, 6),(3, 3),(4, 4),(5, 5),(6, 5),(6, 6),(7, 4),(8, 3),(9, 6),(10, 5),(11, 3),(12, 6);

COMMIT;
