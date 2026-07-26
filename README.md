# Smart Grocery Management and Meal Optimization System

**CSC 2032 – Object Oriented Programming | Project Documentation**

A web-based application that combines online grocery shopping, household inventory tracking, and intelligent, nutrition-aware meal planning into a single, cohesive platform.

---

## Overview

The Smart Grocery Management and Meal Optimization System simplifies grocery shopping while promoting efficient household food management and healthier eating habits. Users can purchase groceries online, maintain an up-to-date inventory, and monitor stock and expiry dates in real time, with automatic low-stock and expiry notifications that help reduce food waste.

Beyond traditional grocery management, the system includes an intelligent meal optimization engine. Using real-time inventory data, ingredient expiry proximity, recipe nutrition facts, and each user's declared dietary restrictions or allergies, the system recommends recipes that make effective use of ingredients already on hand while excluding anything unsafe for that user.

Recommended recipes can be organized into weekly meal plans, generated automatically or built manually, from which the system produces an optimized shopping list containing only the ingredients the user is actually missing. This reduces unnecessary purchases and helps minimize food waste.

The two halves of the system, grocery management and meal optimization, were developed independently by two team members and integrated into a single application sharing a common database, authentication session, and user interface.

---

## Objectives

- Simplify online grocery shopping with a full product-browsing and checkout flow
- Track household food inventory, including quantities and expiry dates
- Reduce food waste through proactive expiry and low-stock alerts
- Recommend recipes based on ingredient availability, freshness, and nutrition
- Respect individual dietary restrictions and allergies when suggesting meals
- Automate weekly meal planning and generate accurate, shortfall-only shopping lists
- Provide administrators with a central dashboard for products, categories, orders, users, and recipes

---

## System Architecture

The system follows a **layered, MVC-inspired architecture** built directly on Jakarta Servlets and JSP:

```
User
  │
  ▼
1. Presentation Layer   →  JSP views (shared sidebar/topbar shell)
  │
  ▼
2. Controller Layer     →  Servlets (one per feature area)
  │
  ▼
3. Service Layer        →  Business logic (RecommendationEngine, InventoryService, CartService, etc.)
  │
  ▼
4. Data Access Layer    →  DAO classes (one per table, JDBC PreparedStatements)
  │
  ▼
5. Database             →  MySQL (smart_grocery_system)
```

Both modules share a single database connection utility (`DBConnection`) and the same session-based authentication, which is the primary integration point between the two members' code — the Meal Optimization module reads the logged-in user's ID from the session and reads product/inventory data directly from the Grocery Management tables to check ingredient availability.

---

## Technologies Used

| Category | Technology |
|---|---|
| Language | Java |
| Web Framework | Jakarta Servlet / JSP (Jakarta EE Web Profile) |
| Templating | JavaServer Pages (JSP) with JSTL |
| Application Server | Apache Tomcat |
| Database | MySQL |
| Database Driver | MySQL Connector/J (JDBC) |
| IDE / Build Tool | Apache NetBeans (Ant-based web project) |
| Frontend | HTML5, CSS3, vanilla JavaScript |
| Icons / Fonts | Font Awesome, Google Fonts (Inter) |
| Version Control | Git / GitHub |

---

## Features

### Grocery Management
- User registration, login, and session-based authentication
- Product browsing, search, and category filtering
- Shopping cart with quantity adjustment and running totals
- Order placement, order history, and status tracking
- Per-user inventory tracking with quantity and expiry dates
- Automatic low-stock and expiry alerts
- Admin dashboard for managing products, categories, orders, users, and recipes

### Meal Optimization
- Recipe catalogue with full nutrition facts and NutriScore-style grading (A–E)
- Dietary restriction and allergy management, with hard exclusion of unsafe recipes
- Recommendation engine scoring recipes on nutrition, inventory match, and expiry proximity
- One-click automatic weekly meal plan generation, plus manual meal planning
- Automatic shopping list generation from a meal plan, based on real inventory shortfall
- Dedicated "Reduce Food Waste" view prioritizing recipes that use soon-to-expire ingredients

---

## Recommendation Algorithm (Summary)

Recipes are filtered and scored in four stages:

1. **Hard exclusion** — any recipe containing an ingredient that conflicts with the user's dietary restrictions is dropped entirely.
2. **Scoring** — each remaining recipe is scored using:
   - Nutrition grade (0–20 pts, based on NutriScore A–E)
   - Inventory match (0–10 pts, based on % of ingredients already in stock)
   - Expiry priority (+5 pts per ingredient expiring within 3 days)
   - Missing ingredient penalty (−3 pts per ingredient not in stock)
3. **Sorting** — recipes are ranked by total score.
4. **Meal-plan assignment** — for automatic weekly planning, the best-scoring recipe for each meal slot is chosen, with a bonus/penalty for matching the correct meal type (breakfast/lunch/dinner).

Shopping lists are generated by aggregating ingredient requirements across an entire meal plan and subtracting what's already in inventory — so only genuine shortfalls appear.

---

## Database Design

The system uses a single shared MySQL database across both modules.

| Table(s) | Module | Purpose |
|---|---|---|
| `users` | Grocery | User accounts, credentials, and role |
| `categories` | Grocery | Product category list |
| `products` | Grocery | Grocery product catalogue |
| `inventory` | Grocery | Per-user stock quantity and expiry date |
| `cart_items` | Grocery | Items in a user's shopping cart |
| `orders` / `order_items` | Grocery | Placed orders and line items |
| `notifications` | Grocery | System-generated alerts |
| `recipes` | Meal Optimization | Recipe catalogue |
| `ingredients` | Meal Optimization | Ingredients, linked to products |
| `recipeingredients` | Meal Optimization | Join table: quantity of ingredient per recipe |
| `nutritionfacts` | Meal Optimization | Nutrition label data per recipe |
| `mealplans` / `mealplandetails` | Meal Optimization | User meal plans and scheduled meals |
| `dietaryrestrictions` / `userdietaryrestrictions` | Meal Optimization | Restriction types and per-user assignment |
| `shoppinglists` / `shoppinglistitems` | Meal Optimization | Generated shopping lists and items |

Every relationship linking the two modules is enforced with foreign keys — most notably `ingredients.productId → products.productId`, which lets the recommendation engine check real inventory stock against recipe requirements.

---

## Team Members & Contributions

| Member | ID | Module | Contributions |
|---|---|---|---|
| **P.D.U. Kavisha** | AS20240494 | Grocery Management | Authentication, product & category management, shopping cart, orders, inventory, admin dashboard; use case diagram, individual class/ER diagrams, SQL file, project documentation, demo video |
| **N.R. Perera** | AS20240628 | Healthy Meal Optimization | Recipe management, meal planning, recommendation engine, dietary restrictions, shopping list generation, food waste reduction; Git repository setup, final class/ER/sequence diagrams, final SQL file, finalized project documentation |

---

## Project Structure & Workflow

- Each member developed their module independently before integration into a single repository.
- Feature work was done on individual branches and merged into `main` after review.
- Git/GitHub was used throughout for version control and collaboration, with both members' repositories eventually unified into one integrated codebase.

---

## Future Enhancements

- Real payment gateway integration
- AI/ML-based recommendations (replacing the current rule-based scoring model)
- Proactive email/SMS notifications for expiry, low stock, and order status
- Expanded admin analytics dashboard (sales trends + food-waste metrics)
- Hashed password storage for improved security
- AI-based demand forecasting for inventory
- AI chatbot for customer assistance
- Native mobile app (Android/iOS)
- Two-factor authentication (OTP via email)
- Real-time multi-admin conflict notifications
- Barcode scanning for inventory entry
- Personal nutrition tracking and weekly nutrition reports
- Configurable, database-driven dietary restriction rules (replacing hard-coded keyword lists)

---

## License

This project was developed as part of the **CSC 2032 – Object Oriented Programming** module and is intended for academic purposes.
