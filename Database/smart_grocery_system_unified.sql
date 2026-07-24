-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 24, 2026 at 04:33 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smart_grocery_system_unified`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `cartItemId` int(11) NOT NULL,
  `cartId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart_items`
--

INSERT INTO `cart_items` (`cartItemId`, `cartId`, `productId`, `quantity`, `price`) VALUES
(5, 4, 1, 2, 1450),
(9, 4, 6, 1000, 380);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `categoryId` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`categoryId`, `name`, `description`) VALUES
(1, 'Proteins', 'Meat, fish, seafood and eggs'),
(2, 'Grains & Carbs', 'Rice, pasta, noodles, bread, oats and flour'),
(3, 'Vegetables & Fruits', 'Fresh vegetables and fruits'),
(4, 'Dairy & Alternatives', 'Milk, yogurt, cheese and coconut milk'),
(5, 'Sauces, Oils & Spices', 'Condiments, sauces, oils and seasoning');

-- --------------------------------------------------------

--
-- Table structure for table `dietaryrestrictions`
--

CREATE TABLE `dietaryrestrictions` (
  `restrictionId` int(11) NOT NULL,
  `restrictionName` varchar(50) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dietaryrestrictions`
--

INSERT INTO `dietaryrestrictions` (`restrictionId`, `restrictionName`, `description`) VALUES
(3, 'Peanut allergy', 'Peanut allergy is a type of food allergy that can cause a range of symptoms, from mild reactions to severe anaphylaxis. Symptoms typically occur within 1 to 2 hours after exposure and can include skin reactions, gastrointestinal issues, respiratory symptoms, and cardiovascular effects. Anaphylaxis is a life-threatening reaction that requires immediate treatment with epinephrine. The condition is increasing in prevalence, particularly among children, and is managed through avoidance of peanuts and the use of epinephrine autoinjectors. '),
(4, 'Lactose intolerance', 'Lactose intolerance is a digestive disorder caused by a deficiency of the enzyme lactase.'),
(5, 'Gluten intolerance or sensitivity', 'Gluten is one of the main proteins in wheat, but it is also found in barley and rye.'),
(6, 'Vegetarianism', 'Vegetarianism is a dietary pattern that relies mainly on plant-based foods and avoids meat, poultry, and fish.');

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `ingredientId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ingredients`
--

INSERT INTO `ingredients` (`ingredientId`, `productId`, `name`, `category`, `unit`) VALUES
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
(35, 35, 'Shredded Cheese', 'Dairy', 'g'),
(36, 37, 'Mixed Berries', 'Fruits', 'g'),
(37, 38, 'Sugar', 'Condiments', 'g'),
(38, 39, 'Lemon Juice', 'Condiments', 'ml');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventoryId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `quantity` int(11) DEFAULT 0,
  `reorderLevel` int(11) DEFAULT 5,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`inventoryId`, `productId`, `quantity`, `reorderLevel`, `updated_at`) VALUES
(1, 1, 50, 10, '2026-07-17 12:47:20'),
(2, 2, 100, 20, '2026-07-17 12:47:20'),
(3, 3, 40, 15, '2026-07-17 12:47:20'),
(4, 4, 60, 15, '2026-07-17 12:47:20'),
(5, 5, 30, 5, '2026-07-17 12:47:20'),
(6, 6, 45, 12, '2026-07-17 12:47:20'),
(7, 7, 55, 15, '2026-07-17 12:47:20'),
(8, 8, 20, 5, '2026-07-17 12:47:20'),
(9, 9, 200, 8, '2026-07-18 04:00:31'),
(10, 10, 70, 20, '2026-07-17 12:47:20'),
(11, 11, 80, 25, '2026-07-17 12:47:20'),
(12, 12, 50, 10, '2026-07-17 12:47:20'),
(13, 13, 120, 30, '2026-07-17 12:47:20'),
(14, 14, 65, 15, '2026-07-17 12:47:20'),
(15, 15, 25, 8, '2026-07-17 12:47:20'),
(16, 16, 15, 5, '2026-07-17 12:47:20'),
(17, 17, 40, 12, '2026-07-17 12:47:20'),
(18, 18, 85, 15, '2026-07-17 12:47:20'),
(19, 19, 20, 5, '2026-07-17 12:47:20'),
(20, 20, 40, 10, '2026-07-17 12:47:20'),
(21, 21, 30, 8, '2026-07-17 12:47:20'),
(22, 22, 18, 6, '2026-07-17 12:47:20'),
(23, 23, 22, 5, '2026-07-17 12:47:20'),
(24, 37, 500, 100, '2026-07-23 06:12:22'),
(25, 38, 1000, 200, '2026-07-23 06:12:22'),
(26, 39, 200, 50, '2026-07-23 06:12:22');

-- --------------------------------------------------------

--
-- Table structure for table `mealplandetails`
--

CREATE TABLE `mealplandetails` (
  `mealPlanDetailId` int(11) NOT NULL,
  `mealPlanId` int(11) NOT NULL,
  `recipeId` int(11) NOT NULL,
  `mealDate` date DEFAULT NULL,
  `mealType` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mealplandetails`
--

INSERT INTO `mealplandetails` (`mealPlanDetailId`, `mealPlanId`, `recipeId`, `mealDate`, `mealType`) VALUES
(3, 2, 5, '2026-07-07', 'Lunch'),
(52, 8, 6, '2026-07-07', 'Breakfast'),
(53, 8, 9, '2026-07-07', 'Lunch'),
(54, 8, 5, '2026-07-07', 'Dinner'),
(55, 8, 7, '2026-07-08', 'Breakfast'),
(56, 8, 4, '2026-07-08', 'Lunch'),
(57, 8, 10, '2026-07-08', 'Dinner'),
(58, 8, 8, '2026-07-09', 'Breakfast'),
(59, 8, 12, '2026-07-09', 'Lunch'),
(60, 8, 3, '2026-07-09', 'Dinner'),
(61, 8, 11, '2026-07-10', 'Breakfast'),
(62, 8, 6, '2026-07-10', 'Lunch'),
(63, 8, 9, '2026-07-10', 'Dinner'),
(64, 8, 5, '2026-07-11', 'Breakfast'),
(65, 8, 7, '2026-07-11', 'Lunch'),
(66, 8, 4, '2026-07-11', 'Dinner'),
(67, 8, 10, '2026-07-12', 'Breakfast'),
(68, 8, 8, '2026-07-12', 'Lunch'),
(69, 8, 12, '2026-07-12', 'Dinner'),
(70, 8, 3, '2026-07-13', 'Breakfast'),
(71, 8, 11, '2026-07-13', 'Lunch'),
(72, 8, 6, '2026-07-13', 'Dinner'),
(73, 2, 3, '2026-07-13', 'Lunch'),
(74, 2, 6, '2026-07-14', 'Breakfast'),
(78, 9, 6, '2026-07-18', 'Breakfast'),
(79, 9, 4, '2026-07-18', 'Lunch'),
(80, 9, 25, '2026-07-19', 'Snack'),
(81, 10, 6, '2026-07-18', 'Breakfast'),
(82, 10, 25, '2026-07-18', 'Lunch'),
(83, 10, 4, '2026-07-18', 'Dinner'),
(84, 10, 7, '2026-07-19', 'Breakfast'),
(85, 10, 9, '2026-07-19', 'Lunch'),
(86, 10, 12, '2026-07-19', 'Dinner'),
(88, 10, 19, '2026-07-20', 'Lunch'),
(89, 10, 20, '2026-07-20', 'Dinner'),
(90, 10, 6, '2026-07-21', 'Breakfast'),
(91, 10, 25, '2026-07-21', 'Lunch'),
(92, 10, 4, '2026-07-21', 'Dinner'),
(93, 10, 7, '2026-07-22', 'Breakfast'),
(94, 10, 9, '2026-07-22', 'Lunch'),
(95, 10, 12, '2026-07-22', 'Dinner'),
(97, 10, 19, '2026-07-23', 'Lunch'),
(98, 10, 20, '2026-07-23', 'Dinner'),
(99, 10, 6, '2026-07-24', 'Breakfast'),
(100, 10, 25, '2026-07-24', 'Lunch'),
(101, 10, 4, '2026-07-24', 'Dinner'),
(102, 11, 6, '2026-07-19', 'Breakfast'),
(103, 11, 25, '2026-07-19', 'Lunch'),
(104, 11, 4, '2026-07-19', 'Dinner'),
(105, 11, 7, '2026-07-20', 'Breakfast'),
(106, 11, 9, '2026-07-20', 'Lunch'),
(107, 11, 12, '2026-07-20', 'Dinner'),
(109, 11, 19, '2026-07-21', 'Lunch'),
(110, 11, 20, '2026-07-21', 'Dinner'),
(111, 11, 6, '2026-07-22', 'Breakfast'),
(112, 11, 25, '2026-07-22', 'Lunch'),
(113, 11, 4, '2026-07-22', 'Dinner'),
(114, 11, 7, '2026-07-23', 'Breakfast'),
(115, 11, 9, '2026-07-23', 'Lunch'),
(116, 11, 12, '2026-07-23', 'Dinner'),
(118, 11, 19, '2026-07-24', 'Lunch'),
(119, 11, 20, '2026-07-24', 'Dinner'),
(120, 11, 6, '2026-07-25', 'Breakfast'),
(121, 11, 25, '2026-07-25', 'Lunch'),
(122, 11, 4, '2026-07-25', 'Dinner'),
(123, 12, 6, '2026-07-19', 'Breakfast'),
(124, 12, 25, '2026-07-19', 'Lunch'),
(125, 12, 4, '2026-07-19', 'Dinner'),
(126, 12, 7, '2026-07-20', 'Breakfast'),
(127, 12, 9, '2026-07-20', 'Lunch'),
(128, 12, 12, '2026-07-20', 'Dinner'),
(130, 12, 19, '2026-07-21', 'Lunch'),
(131, 12, 20, '2026-07-21', 'Dinner'),
(132, 12, 28, '2026-07-22', 'Breakfast'),
(133, 12, 6, '2026-07-22', 'Lunch'),
(134, 12, 25, '2026-07-22', 'Dinner'),
(135, 12, 4, '2026-07-23', 'Breakfast'),
(136, 12, 7, '2026-07-23', 'Lunch'),
(137, 12, 9, '2026-07-23', 'Dinner'),
(138, 12, 12, '2026-07-24', 'Breakfast'),
(140, 12, 19, '2026-07-24', 'Dinner'),
(141, 12, 20, '2026-07-25', 'Breakfast'),
(142, 12, 28, '2026-07-25', 'Lunch'),
(143, 12, 6, '2026-07-25', 'Dinner'),
(144, 13, 25, '2026-07-20', 'Breakfast'),
(145, 13, 6, '2026-07-20', 'Lunch'),
(146, 13, 9, '2026-07-20', 'Dinner'),
(147, 13, 25, '2026-07-21', 'Breakfast'),
(148, 13, 6, '2026-07-21', 'Lunch'),
(149, 13, 9, '2026-07-21', 'Dinner'),
(150, 13, 25, '2026-07-22', 'Breakfast'),
(151, 13, 6, '2026-07-22', 'Lunch'),
(152, 13, 9, '2026-07-22', 'Dinner'),
(153, 13, 25, '2026-07-23', 'Breakfast'),
(154, 13, 6, '2026-07-23', 'Lunch'),
(155, 13, 9, '2026-07-23', 'Dinner'),
(156, 13, 25, '2026-07-24', 'Breakfast'),
(157, 13, 6, '2026-07-24', 'Lunch'),
(158, 13, 9, '2026-07-24', 'Dinner'),
(159, 13, 25, '2026-07-25', 'Breakfast'),
(160, 13, 6, '2026-07-25', 'Lunch'),
(161, 13, 9, '2026-07-25', 'Dinner'),
(162, 13, 25, '2026-07-26', 'Breakfast'),
(163, 13, 6, '2026-07-26', 'Lunch'),
(164, 13, 9, '2026-07-26', 'Dinner'),
(166, 14, 6, '2026-07-20', 'Lunch'),
(167, 14, 9, '2026-07-20', 'Dinner'),
(168, 14, 25, '2026-07-21', 'Breakfast'),
(169, 14, 6, '2026-07-21', 'Lunch'),
(170, 14, 9, '2026-07-21', 'Dinner'),
(171, 14, 25, '2026-07-22', 'Breakfast'),
(172, 14, 6, '2026-07-22', 'Lunch'),
(173, 14, 9, '2026-07-22', 'Dinner'),
(174, 14, 25, '2026-07-23', 'Breakfast'),
(175, 14, 6, '2026-07-23', 'Lunch'),
(176, 14, 9, '2026-07-23', 'Dinner'),
(177, 14, 25, '2026-07-24', 'Breakfast'),
(178, 14, 6, '2026-07-24', 'Lunch'),
(179, 14, 9, '2026-07-24', 'Dinner'),
(180, 14, 25, '2026-07-25', 'Breakfast'),
(181, 14, 6, '2026-07-25', 'Lunch'),
(182, 14, 9, '2026-07-25', 'Dinner'),
(183, 14, 25, '2026-07-26', 'Breakfast'),
(184, 14, 6, '2026-07-26', 'Lunch'),
(186, 14, 8, '2026-07-20', 'Breakfast'),
(187, 15, 25, '2026-07-20', 'Breakfast'),
(188, 15, 6, '2026-07-20', 'Lunch'),
(189, 15, 9, '2026-07-20', 'Dinner'),
(190, 15, 25, '2026-07-21', 'Breakfast'),
(191, 15, 6, '2026-07-21', 'Lunch'),
(192, 15, 9, '2026-07-21', 'Dinner'),
(193, 15, 25, '2026-07-22', 'Breakfast'),
(194, 15, 6, '2026-07-22', 'Lunch'),
(195, 15, 9, '2026-07-22', 'Dinner'),
(196, 15, 25, '2026-07-23', 'Breakfast'),
(197, 15, 6, '2026-07-23', 'Lunch'),
(198, 15, 9, '2026-07-23', 'Dinner'),
(199, 15, 25, '2026-07-24', 'Breakfast'),
(200, 15, 6, '2026-07-24', 'Lunch'),
(201, 15, 9, '2026-07-24', 'Dinner'),
(202, 15, 25, '2026-07-25', 'Breakfast'),
(203, 15, 6, '2026-07-25', 'Lunch'),
(204, 15, 9, '2026-07-25', 'Dinner'),
(205, 15, 25, '2026-07-26', 'Breakfast'),
(206, 15, 6, '2026-07-26', 'Lunch'),
(207, 15, 9, '2026-07-26', 'Dinner'),
(208, 16, 25, '2026-07-20', 'Breakfast'),
(209, 16, 6, '2026-07-20', 'Lunch'),
(210, 16, 9, '2026-07-20', 'Dinner'),
(211, 16, 25, '2026-07-21', 'Breakfast'),
(212, 16, 6, '2026-07-21', 'Lunch'),
(213, 16, 9, '2026-07-21', 'Dinner'),
(214, 16, 25, '2026-07-22', 'Breakfast'),
(215, 16, 6, '2026-07-22', 'Lunch'),
(216, 16, 9, '2026-07-22', 'Dinner'),
(217, 16, 25, '2026-07-23', 'Breakfast'),
(218, 16, 6, '2026-07-23', 'Lunch'),
(220, 16, 25, '2026-07-24', 'Breakfast'),
(221, 16, 6, '2026-07-24', 'Lunch'),
(222, 16, 9, '2026-07-24', 'Dinner'),
(223, 16, 25, '2026-07-25', 'Breakfast'),
(224, 16, 6, '2026-07-25', 'Lunch'),
(225, 16, 9, '2026-07-25', 'Dinner'),
(226, 16, 25, '2026-07-26', 'Breakfast'),
(227, 16, 6, '2026-07-26', 'Lunch'),
(228, 16, 9, '2026-07-26', 'Dinner'),
(229, 17, 25, '2026-07-21', 'Breakfast'),
(230, 17, 6, '2026-07-21', 'Lunch'),
(231, 17, 9, '2026-07-21', 'Dinner'),
(232, 17, 25, '2026-07-22', 'Breakfast'),
(233, 17, 6, '2026-07-22', 'Lunch'),
(234, 17, 9, '2026-07-22', 'Dinner'),
(235, 17, 25, '2026-07-23', 'Breakfast'),
(236, 17, 6, '2026-07-23', 'Lunch'),
(237, 17, 9, '2026-07-23', 'Dinner'),
(238, 17, 25, '2026-07-24', 'Breakfast'),
(239, 17, 6, '2026-07-24', 'Lunch'),
(240, 17, 9, '2026-07-24', 'Dinner'),
(241, 17, 25, '2026-07-25', 'Breakfast'),
(242, 17, 6, '2026-07-25', 'Lunch'),
(243, 17, 9, '2026-07-25', 'Dinner'),
(244, 17, 25, '2026-07-26', 'Breakfast'),
(245, 17, 6, '2026-07-26', 'Lunch'),
(246, 17, 9, '2026-07-26', 'Dinner'),
(247, 17, 25, '2026-07-27', 'Breakfast'),
(248, 17, 6, '2026-07-27', 'Lunch'),
(250, 18, 8, '2026-07-23', 'Breakfast'),
(251, 18, 6, '2026-07-23', 'Lunch'),
(252, 18, 5, '2026-07-23', 'Dinner'),
(253, 18, 8, '2026-07-24', 'Breakfast'),
(254, 18, 6, '2026-07-24', 'Lunch'),
(255, 18, 5, '2026-07-24', 'Dinner'),
(256, 18, 8, '2026-07-25', 'Breakfast'),
(257, 18, 6, '2026-07-25', 'Lunch'),
(258, 18, 5, '2026-07-25', 'Dinner'),
(259, 18, 8, '2026-07-26', 'Breakfast'),
(260, 18, 6, '2026-07-26', 'Lunch'),
(261, 18, 5, '2026-07-26', 'Dinner'),
(262, 18, 8, '2026-07-27', 'Breakfast'),
(263, 18, 6, '2026-07-27', 'Lunch'),
(264, 18, 5, '2026-07-27', 'Dinner'),
(265, 18, 8, '2026-07-28', 'Breakfast'),
(266, 18, 6, '2026-07-28', 'Lunch'),
(267, 18, 5, '2026-07-28', 'Dinner'),
(268, 18, 8, '2026-07-29', 'Breakfast'),
(269, 18, 6, '2026-07-29', 'Lunch'),
(270, 18, 5, '2026-07-29', 'Dinner'),
(271, 19, 17, '2026-07-23', 'Breakfast'),
(272, 19, 6, '2026-07-23', 'Lunch'),
(273, 19, 5, '2026-07-23', 'Dinner'),
(274, 19, 17, '2026-07-24', 'Breakfast'),
(275, 19, 6, '2026-07-24', 'Lunch'),
(276, 19, 5, '2026-07-24', 'Dinner'),
(277, 19, 17, '2026-07-25', 'Breakfast'),
(278, 19, 6, '2026-07-25', 'Lunch'),
(279, 19, 5, '2026-07-25', 'Dinner'),
(280, 19, 17, '2026-07-26', 'Breakfast'),
(281, 19, 6, '2026-07-26', 'Lunch'),
(282, 19, 5, '2026-07-26', 'Dinner'),
(283, 19, 17, '2026-07-27', 'Breakfast'),
(284, 19, 6, '2026-07-27', 'Lunch'),
(285, 19, 5, '2026-07-27', 'Dinner'),
(286, 19, 17, '2026-07-28', 'Breakfast'),
(287, 19, 6, '2026-07-28', 'Lunch'),
(288, 19, 5, '2026-07-28', 'Dinner'),
(289, 19, 17, '2026-07-29', 'Breakfast'),
(290, 19, 6, '2026-07-29', 'Lunch'),
(291, 19, 5, '2026-07-29', 'Dinner');

-- --------------------------------------------------------

--
-- Table structure for table `mealplans`
--

CREATE TABLE `mealplans` (
  `mealPlanId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `planName` varchar(100) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mealplans`
--

INSERT INTO `mealplans` (`mealPlanId`, `userId`, `planName`, `startDate`, `endDate`) VALUES
(2, 1, 'Healthy Weekly Plan', '2026-07-07', '2026-07-13'),
(3, 1, 'Healthy Weekly Plan', '2026-07-07', '2026-07-13'),
(4, 1, 'Healthy Weekly Plan', '2026-07-07', '2026-07-13'),
(5, 1, 'Healthy Weekly Plan', '2026-07-07', '2026-07-13'),
(6, 1, 'Weekly Healthy Meal Plan', '2026-07-07', '2026-07-13'),
(7, 1, 'Weekly Healthy Meal Plan', '2026-07-07', '2026-07-13'),
(8, 1, 'Weekly Healthy Meal Plan', '2026-07-07', '2026-07-13'),
(9, 6, 'My Healthy Weekly Plan', '2026-07-18', '2026-07-19'),
(10, 6, 'Weekly Healthy Meal Plan', '2026-07-18', '2026-07-24'),
(11, 6, 'Weekly Healthy Meal Plan', '2026-07-19', '2026-07-25'),
(12, 6, 'Weekly Healthy Meal Plan', '2026-07-19', '2026-07-25'),
(13, 6, 'Weekly Healthy Meal Plan', '2026-07-20', '2026-07-26'),
(14, 6, 'Weekly Healthy Meal Plan', '2026-07-20', '2026-07-26'),
(15, 6, 'Weekly Healthy Meal Plan', '2026-07-20', '2026-07-26'),
(16, 6, 'Weekly Healthy Meal Plan', '2026-07-20', '2026-07-26'),
(17, 2, 'Weekly Healthy Meal Plan', '2026-07-21', '2026-07-27'),
(18, 3, 'Weekly Healthy Meal Plan', '2026-07-23', '2026-07-29'),
(19, 4, 'Weekly Healthy Meal Plan', '2026-07-23', '2026-07-29');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notifId` int(11) NOT NULL,
  `productId` int(11) DEFAULT NULL,
  `message` varchar(255) NOT NULL,
  `type` enum('LOW_STOCK','EXPIRY') NOT NULL,
  `isRead` tinyint(1) DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notifId`, `productId`, `message`, `type`, `isRead`, `timestamp`) VALUES
(1, 16, 'Sourdough Bread stock is critically low (only 1 remaining).', 'LOW_STOCK', 0, '2026-07-17 12:48:44'),
(2, 8, 'Salmon Fillet is approaching its expiration date.', 'EXPIRY', 0, '2026-07-17 12:48:44'),
(3, 1, 'Chicken Breast has fallen below its reorder level.', 'LOW_STOCK', 1, '2026-07-17 12:48:44'),
(4, 6, 'Whole Milk stock updated successfully.', 'LOW_STOCK', 1, '2026-07-17 12:48:44'),
(5, 22, 'Feta Cheese requires immediate restocking.', 'LOW_STOCK', 0, '2026-07-17 12:48:44');

-- --------------------------------------------------------

--
-- Table structure for table `nutritionfacts`
--

CREATE TABLE `nutritionfacts` (
  `nutritionId` int(11) NOT NULL,
  `recipeId` int(11) NOT NULL,
  `servingSize` varchar(50) DEFAULT NULL,
  `servingsPerContainer` int(11) DEFAULT NULL,
  `calories` decimal(6,2) DEFAULT NULL,
  `totalFat` decimal(6,2) DEFAULT NULL,
  `saturatedFat` decimal(6,2) DEFAULT NULL,
  `transFat` decimal(6,2) DEFAULT NULL,
  `cholesterol` decimal(6,2) DEFAULT NULL,
  `sodium` decimal(6,2) DEFAULT NULL,
  `totalCarbohydrates` decimal(6,2) DEFAULT NULL,
  `dietaryFiber` decimal(6,2) DEFAULT NULL,
  `totalSugar` decimal(6,2) DEFAULT NULL,
  `addedSugar` decimal(6,2) DEFAULT NULL,
  `protein` decimal(6,2) DEFAULT NULL,
  `vitaminA` decimal(6,2) DEFAULT NULL,
  `vitaminC` decimal(6,2) DEFAULT NULL,
  `vitaminD` decimal(6,2) DEFAULT NULL,
  `calcium` decimal(6,2) DEFAULT NULL,
  `iron` decimal(6,2) DEFAULT NULL,
  `potassium` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nutritionfacts`
--

INSERT INTO `nutritionfacts` (`nutritionId`, `recipeId`, `servingSize`, `servingsPerContainer`, `calories`, `totalFat`, `saturatedFat`, `transFat`, `cholesterol`, `sodium`, `totalCarbohydrates`, `dietaryFiber`, `totalSugar`, `addedSugar`, `protein`, `vitaminA`, `vitaminC`, `vitaminD`, `calcium`, `iron`, `potassium`) VALUES
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
(23, 24, '200g', 1, 460.00, 24.00, 19.50, 0.00, 0.00, 510.00, 54.00, 8.00, 3.00, 0.00, 9.00, 75.00, 18.00, 0.00, 50.00, 3.10, 410.00),
(24, 25, '180g', 1, 230.00, 9.00, 1.50, 0.00, 5.00, 85.00, 29.00, 11.00, 14.00, 8.00, 6.00, 45.00, 1.00, 1.50, 220.00, 2.10, 280.00),
(25, 26, '220g', 1, 510.00, 23.00, 11.00, 0.50, 85.00, 840.00, 38.00, 3.00, 2.00, 0.00, 34.00, 90.00, 4.00, 0.80, 310.00, 2.40, 360.00),
(26, 28, '60g', 4, 70.00, 0.20, 0.00, 0.00, 0.00, 5.00, 18.00, 2.00, 14.00, 8.00, 0.50, 2.00, 15.00, 0.00, 10.00, 0.30, 80.00);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `orderId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `totalAmount` decimal(10,2) NOT NULL,
  `status` enum('PENDING','PROCESSING','SHIPPED','DELIVERED','CANCELLED') DEFAULT 'PENDING',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `orderDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`orderId`, `userId`, `totalAmount`, `status`, `created_at`, `orderDate`) VALUES
(1, 3, 3820.00, 'DELIVERED', '2026-07-17 12:52:25', '2026-07-15'),
(2, 4, 2410.00, 'PENDING', '2026-07-17 12:52:25', '2026-07-15'),
(3, 6, 9025.00, 'PENDING', '2026-07-17 12:52:25', '2026-07-16'),
(4, 7, 2200.00, 'PROCESSING', '2026-07-17 12:52:25', '2026-07-16'),
(5, 8, 24550.00, 'DELIVERED', '2026-07-17 12:52:25', '2026-07-16'),
(6, 9, 5380.00, 'CANCELLED', '2026-07-17 12:52:25', '2026-07-17'),
(7, 10, 3800.00, 'PENDING', '2026-07-17 12:52:25', '2026-07-17'),
(8, 11, 810.00, 'PROCESSING', '2026-07-17 12:52:25', '2026-07-17'),
(9, 3, 880.00, 'DELIVERED', '2026-07-23 06:02:40', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `orderItemId` int(11) NOT NULL,
  `orderId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`orderItemId`, `orderId`, `productId`, `quantity`, `price`, `subtotal`) VALUES
(1, 1, 1, 2, 1450.00, 2900.00),
(2, 1, 15, 1, 890.00, 890.00),
(3, 1, 11, 1, 30.00, 30.00),
(4, 2, 6, 2, 380.00, 760.00),
(5, 2, 9, 1, 1650.00, 1650.00),
(6, 3, 8, 3, 2800.00, 8400.00),
(7, 3, 5, 1, 550.00, 550.00),
(8, 3, 10, 3, 25.00, 75.00),
(9, 4, 23, 1, 2200.00, 2200.00),
(10, 5, 8, 5, 2800.00, 14000.00),
(11, 5, 1, 5, 1450.00, 7250.00),
(12, 5, 19, 1, 1950.00, 1950.00),
(13, 5, 22, 1, 1350.00, 1350.00),
(14, 6, 21, 5, 420.00, 2100.00),
(15, 6, 12, 4, 750.00, 3000.00),
(16, 6, 2, 1, 280.00, 280.00),
(17, 7, 18, 5, 320.00, 1600.00),
(18, 7, 23, 1, 2200.00, 2200.00),
(19, 8, 7, 10, 45.00, 450.00),
(20, 8, 16, 2, 120.00, 240.00),
(21, 8, 13, 6, 20.00, 120.00),
(22, 9, 37, 1, 450.00, 450.00),
(23, 9, 38, 1, 180.00, 180.00),
(24, 9, 39, 1, 250.00, 250.00);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `productId` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `quantity` int(11) DEFAULT 0,
  `expiryDate` date DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`productId`, `name`, `price`, `quantity`, `expiryDate`, `unit`, `categoryId`, `photo`, `created_at`, `updated_at`) VALUES
(1, 'Chicken Breast', 1450.00, 5000, '2026-07-23', 'g', 1, 'https://images.unsplash.com/photo-1587593810167-a84920ea0781?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:18:40'),
(2, 'White Rice', 280.00, 20000, NULL, 'g', 2, 'https://images.unsplash.com/photo-1686820740687-426a7b9b2043?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:19:07'),
(3, 'Broccoli', 950.00, 3000, '2026-07-18', 'g', 3, 'https://plus.unsplash.com/premium_photo-1702403157830-9df749dc6c1e?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:19:43'),
(4, 'Carrots', 320.00, 4000, NULL, 'g', 3, 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:20:41'),
(5, 'Soy Sauce', 550.00, 2000, NULL, 'ml', 5, 'https://images.unsplash.com/photo-1721024250728-e100fc947b36?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:22:28'),
(6, 'Whole Milk', 380.00, 6000, '2026-07-19', 'ml', 4, 'https://images.unsplash.com/photo-1523473827533-2a64d0d36748?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:23:06'),
(7, 'Eggs', 45.00, 300, NULL, 'pcs', 1, 'https://images.unsplash.com/photo-1506976785307-8732e854ad03?q=80&w=1043&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:23:40'),
(8, 'Salmon Fillet', 2800.00, 2500, NULL, 'g', 1, 'https://images.unsplash.com/photo-1641898378373-0ef528eec4be?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:24:10'),
(9, 'Quinoa', 1650.00, 2000, NULL, 'g', 2, 'https://plus.unsplash.com/premium_photo-1671130295828-efd9019faee0?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:24:46'),
(10, 'Cucumber', 25.00, 150, NULL, 'pcs', 3, 'https://images.unsplash.com/photo-1694153192731-ab5445654427?q=80&w=759&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:25:23'),
(11, 'Tomatoes', 30.00, 200, NULL, 'pcs', 3, 'https://images.unsplash.com/photo-1582284540020-8acbe03f4924?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:26:06'),
(12, 'Rolled Oats', 750.00, 5000, NULL, 'g', 2, 'https://plus.unsplash.com/premium_photo-1675237625821-c30234f71cba?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:26:36'),
(13, 'Banana', 20.00, 300, NULL, 'pcs', 3, 'https://images.unsplash.com/photo-1603833665858-e61d17a86224?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:27:06'),
(14, 'Red Lentils', 650.00, 5000, NULL, 'g', 2, 'https://images.unsplash.com/photo-1770617476260-1addeea7c826?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:27:52'),
(15, 'Greek Yogurt', 890.00, 3000, NULL, 'g', 4, 'https://images.unsplash.com/photo-1641196936589-7df4db18de66?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:29:09'),
(16, 'Sourdough Bread', 120.00, 100, NULL, 'slices', 2, 'https://images.unsplash.com/photo-1549413468-cd78edb7e75c?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:30:00'),
(17, 'Avocado', 250.00, 150, NULL, 'pcs', 3, 'https://images.unsplash.com/photo-1573566291259-fd494a326b60?q=80&w=637&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:30:31'),
(18, 'All-Purpose Flour', 320.00, 10000, NULL, 'g', 2, 'https://plus.unsplash.com/premium_photo-1671377375657-5286f40ec0c7?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:31:04'),
(19, 'Maple Syrup', 1950.00, 1000, NULL, 'ml', 5, 'https://images.unsplash.com/photo-1552314971-d2feb3513949?q=80&w=661&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:31:40'),
(20, 'Coconut Milk', 480.00, 3000, NULL, 'ml', 4, 'https://images.unsplash.com/photo-1588413335367-e49d32c5b50b?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:34:18'),
(21, 'Curry Powder', 420.00, 2000, NULL, 'g', 5, 'https://images.unsplash.com/photo-1702041295331-840d4d9aa7c9?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:34:50'),
(22, 'Feta Cheese', 1350.00, 2000, NULL, 'g', 4, 'https://images.unsplash.com/photo-1624806992221-12d8062c35e5?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:35:23'),
(23, 'Olive Oil', 2200.00, 3000, NULL, 'ml', 5, 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?q=80&w=718&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:35:53'),
(24, 'Beef Patty', 1650.00, 4000, NULL, 'g', 1, 'https://images.unsplash.com/photo-1723893905879-0e309c2a8e06?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:37:53'),
(25, 'Burger Buns', 60.00, 200, NULL, 'pcs', 2, 'https://images.unsplash.com/photo-1632552544552-3ca612a328ac?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:38:39'),
(26, 'Potatoes', 220.00, 8000, NULL, 'g', 3, 'https://images.unsplash.com/photo-1590165482129-1b8b27698780?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:39:19'),
(27, 'Rice Noodles', 480.00, 4000, NULL, 'g', 2, 'https://images.unsplash.com/photo-1633352615955-f0c99e8b7e5a?q=80&w=688&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:39:53'),
(28, 'Shrimp', 2400.00, 2500, NULL, 'g', 1, 'https://images.unsplash.com/photo-1550951791-cbf1ff280109?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:40:36'),
(29, 'Pad Thai Sauce', 780.00, 1500, NULL, 'ml', 5, 'https://images.unsplash.com/photo-1568657704598-602700bd9694?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:41:41'),
(30, 'Penne Pasta', 490.00, 6000, NULL, 'g', 2, 'https://images.unsplash.com/photo-1673971372358-769a28fa4c81?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:42:16'),
(31, 'Tomato Marinara', 560.00, 3000, NULL, 'g', 5, 'https://plus.unsplash.com/premium_photo-1725902075652-837a57b4f4d9?q=80&w=1169&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:43:16'),
(32, 'Grated Coconut', 380.00, 2500, NULL, 'g', 5, 'https://images.unsplash.com/photo-1655558133164-555eae72edb7?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:43:49'),
(33, 'Chili Flakes', 350.00, 1500, NULL, 'g', 5, 'https://plus.unsplash.com/premium_photo-1671130295775-e20b130ab22f?q=80&w=694&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D\r\n', '2026-07-22 08:35:07', '2026-07-22 09:44:35'),
(34, 'Flour Tortillas', 90.00, 250, NULL, 'pcs', 2, 'https://images.unsplash.com/photo-1591266123515-46149ea0b0a9?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:45:40'),
(35, 'Shredded Cheese', 1250.00, 3000, NULL, 'g', 4, 'https://images.unsplash.com/photo-1657047869556-11105810779a?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 09:46:27'),
(36, 'Tomatoes', 30.00, 200, NULL, 'pcs', 3, 'https://images.unsplash.com/photo-1582284540020-8acbe03f4924?q=80&w=735&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '2026-07-22 08:35:07', '2026-07-22 08:35:07'),
(37, 'Mixed Berries', 450.00, 1000, NULL, 'g', 3, 'https://images.unsplash.com/photo-1696504831684-1e8352620998?auto=format&fit=crop&w=600&q=80', '2026-07-23 05:51:59', '2026-07-23 06:00:35'),
(38, 'Sugar', 180.00, 5000, NULL, 'g', 5, 'https://images.unsplash.com/photo-1685967836908-7d3b4921a670?auto=format&fit=crop&w=600&q=80', '2026-07-23 05:51:59', '2026-07-23 06:00:35'),
(39, 'Lemon Juice', 250.00, 2000, NULL, 'ml', 5, 'https://images.unsplash.com/photo-1650939604035-9e259114d0ca?auto=format&fit=crop&w=600&q=80', '2026-07-23 05:51:59', '2026-07-23 06:00:35');

-- --------------------------------------------------------

--
-- Table structure for table `recipeingredients`
--

CREATE TABLE `recipeingredients` (
  `recipeIngredientId` int(11) NOT NULL,
  `recipeId` int(11) NOT NULL,
  `ingredientId` int(11) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `unit` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recipeingredients`
--

INSERT INTO `recipeingredients` (`recipeIngredientId`, `recipeId`, `ingredientId`, `quantity`, `unit`) VALUES
(1, 4, 2, 200.00, 'g'),
(2, 4, 3, 50.00, 'g'),
(3, 4, 4, 50.00, 'g'),
(4, 4, 5, 15.00, 'ml'),
(5, 9, 14, 150.00, 'g'),
(6, 9, 4, 100.00, 'g'),
(7, 17, 16, 2.00, 'slices'),
(8, 17, 17, 1.00, 'pcs'),
(9, 17, 7, 1.00, 'pcs'),
(10, 18, 18, 100.00, 'g'),
(11, 18, 6, 50.00, 'ml'),
(12, 18, 19, 30.00, 'ml'),
(13, 19, 14, 200.00, 'g'),
(14, 19, 20, 150.00, 'ml'),
(15, 19, 21, 10.00, 'g'),
(16, 20, 10, 150.00, 'g'),
(17, 20, 22, 100.00, 'g'),
(18, 20, 23, 15.00, 'ml'),
(19, 21, 24, 300.00, 'g'),
(20, 21, 25, 2.00, 'pcs'),
(21, 21, 26, 200.00, 'g'),
(22, 22, 27, 150.00, 'g'),
(23, 22, 28, 100.00, 'g'),
(24, 22, 29, 30.00, 'ml'),
(25, 23, 30, 200.00, 'g'),
(26, 23, 31, 150.00, 'g'),
(27, 23, 4, 50.00, 'g'),
(28, 3, 1, 500.00, 'g'),
(29, 3, 21, 20.00, 'g'),
(30, 3, 20, 200.00, 'ml'),
(31, 5, 8, 250.00, 'g'),
(32, 5, 23, 15.00, 'ml'),
(33, 5, 3, 100.00, 'g'),
(34, 6, 9, 150.00, 'g'),
(35, 6, 10, 1.00, 'pcs'),
(36, 6, 11, 2.00, 'pcs'),
(37, 7, 12, 75.00, 'g'),
(38, 7, 6, 200.00, 'ml'),
(39, 7, 13, 1.00, 'pcs'),
(40, 8, 7, 3.00, 'pcs'),
(41, 8, 6, 30.00, 'ml'),
(42, 8, 11, 50.00, 'g'),
(43, 10, 1, 150.00, 'g'),
(44, 10, 23, 20.00, 'ml'),
(45, 11, 24, 300.00, 'g'),
(46, 11, 3, 150.00, 'g'),
(47, 11, 4, 100.00, 'g'),
(48, 12, 13, 1.00, 'pcs'),
(49, 12, 15, 150.00, 'g'),
(50, 12, 6, 100.00, 'ml'),
(53, 24, 32, 150.00, 'g'),
(54, 24, 33, 15.00, 'g'),
(55, 24, 18, 100.00, 'g'),
(56, 25, 6, 200.00, 'ml'),
(57, 25, 19, 20.00, 'ml'),
(58, 26, 34, 2.00, 'pcs'),
(59, 26, 1, 100.00, 'g'),
(60, 26, 35, 75.00, 'g'),
(61, 28, 36, 300.00, 'g'),
(62, 28, 37, 60.00, 'g'),
(63, 28, 38, 15.00, 'ml');

-- --------------------------------------------------------

--
-- Table structure for table `recipes`
--

CREATE TABLE `recipes` (
  `recipeId` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `mealType` varchar(50) DEFAULT NULL,
  `cuisine` varchar(50) DEFAULT NULL,
  `cookingTime` int(11) DEFAULT NULL,
  `difficulty` varchar(20) DEFAULT NULL,
  `servings` int(11) DEFAULT NULL,
  `imageUrl` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recipes`
--

INSERT INTO `recipes` (`recipeId`, `name`, `description`, `mealType`, `cuisine`, `cookingTime`, `difficulty`, `servings`, `imageUrl`) VALUES
(3, 'Chicken Curry With Sauce', 'Traditional Sri Lankan spicy chicken curry', 'Dinner', 'Sri Lankan', 45, 'Medium', 4, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733198/Chicken_curry_with_sauce_qzkxma.png'),
(4, 'Vegetable Fried Rice', 'Healthy fried rice with mixed vegetables', 'Lunch', 'Asian', 30, 'Easy', 2, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733332/Vegetable_Fried_Rice_k4xcau.png'),
(5, 'Grilled Salmon', 'Grilled salmon with steamed vegetables', 'Dinner', 'Western', 35, 'Hard', 2, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733273/Grilled_Salmon_oolzfc.png'),
(6, 'Quinoa Salad', 'Fresh quinoa salad with cucumber and tomatoes', 'Lunch', 'Mediterranean', 20, 'Easy', 2, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733329/Quinoa_Salad_wqey18.png'),
(7, 'Oatmeal with Fruits', 'Healthy oatmeal topped with bananas and berries', 'Breakfast', 'International', 10, 'Easy', 1, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733304/Oatmeal_with_Fruits_no0zzi.png'),
(8, 'Egg Omelette', 'Protein-rich vegetable omelette', 'Breakfast', 'International', 15, 'Easy', 1, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733229/Egg_Omelette_sehu49.png'),
(9, 'Lentil Soup', 'Nutritious red lentil soup', 'Dinner', 'Middle Eastern', 40, 'Easy', 4, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733288/Lentil_Soup_gzpz9h.png'),
(10, 'Chicken Caesar Salad', 'Grilled chicken with fresh lettuce', 'Lunch', 'Western', 25, 'Easy', 2, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733153/Chicken_Caesar_Salad_jhqbyo.png'),
(11, 'Beef Stir Fry', 'Lean beef with broccoli and carrots', 'Dinner', 'Asian', 30, 'Medium', 3, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733125/Beef_Stir_Fry_a5adui.png'),
(12, 'Fruit Smoothie', 'Mixed fruit smoothie with yogurt', 'Breakfast', 'International', 10, 'Easy', 1, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733242/Fruit_Smoothie_jfrhrt.png'),
(17, 'Avocado Toast with Egg', 'Crispy sourdough toast topped with mashed avocado and a poached egg', 'Breakfast', 'International', 10, 'Easy', 1, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784732784/Avocado_Toast_with_Egg_slusc5.png'),
(18, 'Pancakes with Maple Syrup', 'Fluffy buttermilk pancakes served with butter and fresh maple syrup', 'Breakfast', 'Western', 15, 'Easy', 2, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733931/pancakes_with_maple_syrup_xeqxfa.png'),
(19, 'Dhal Curry', 'Traditional Sri Lankan red lentil curry cooked in rich coconut milk', 'Lunch', 'Sri Lankan', 20, 'Easy', 4, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733219/Dhal_Curry_omaeap.png'),
(20, 'Greek Salad', 'Crisp cucumbers, tomatoes, red onions, olives, and feta cheese blocks', 'Lunch', 'Mediterranean', 15, 'Easy', 2, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733260/Greek_Salad_xsse8m.png'),
(21, 'Beef Burgers with Fries', 'Juicy grilled beef patties on toasted buns with a side of crispy fries', 'Dinner', 'Western', 30, 'Medium', 2, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733112/Beef_Burgers_with_Fries_nvmn8u.png'),
(22, 'Shrimp Pad Thai', 'Classic Thai stir-fried rice noodles with shrimp, tofu, and bean sprouts', 'Dinner', 'Asian', 25, 'Medium', 2, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733330/Shrimp_Pad_Thai_i3n6xi.png'),
(23, 'Vegetable Pasta', 'Penne pasta tossed with mixed garden vegetables in a rich marinara sauce', 'Dinner', 'Western', 20, 'Easy', 3, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733331/Vegetable_Pasta_lryzdq.png'),
(24, 'Pol Sambol with Roti', 'Spicy coconut sambol served alongside warm, flaky flatbread rotis', 'Dinner', 'Sri Lankan', 25, 'Medium', 2, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733326/Pol_Sambol_with_Roti_dztcr5.png'),
(25, 'Chia Seed Pudding', 'Healthy chia seeds soaked in almond milk with vanilla and honey', 'Breakfast', 'International', 10, 'Easy', 1, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733138/Chia_Seed_Pudding_budk6w.png'),
(26, 'Chicken Quesadilla', 'Toasted flour tortillas filled with melted cheese and seasoned chicken', 'Lunch', 'Mexican', 15, 'Easy', 2, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784733207/Chicken_Quesadilla_rzoxrl.png'),
(28, 'Any Berry Sauce', 'Any Berry Sauce is a simple and versatile sauce made by mixing together sugar, cornstarch, water, and fresh berries.', 'Breakfast', 'Western', 30, 'Easy', 9, 'https://res.cloudinary.com/h94oooy5/image/upload/v1784732693/Any_Berry_Sauce_mj6jkv.png');

-- --------------------------------------------------------

--
-- Table structure for table `shoppinglistitems`
--

CREATE TABLE `shoppinglistitems` (
  `shoppingListItemId` int(11) NOT NULL,
  `shoppingListId` int(11) NOT NULL,
  `ingredientId` int(11) NOT NULL,
  `quantity` decimal(10,2) DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shoppinglistitems`
--

INSERT INTO `shoppinglistitems` (`shoppingListItemId`, `shoppingListId`, `ingredientId`, `quantity`, `unit`, `status`) VALUES
(4, 2, 1, 2.00, 'pcs', 'Pending'),
(7, 2, 1, 2.00, 'pcs', 'Pending'),
(8, 7, 9, 1.00, 'g', 'Pending'),
(9, 7, 14, 1.00, 'g', 'Pending'),
(10, 7, 4, 1.00, 'g', 'Pending'),
(11, 7, 8, 1.00, 'g', 'Pending'),
(12, 7, 3, 1.00, 'g', 'Pending'),
(13, 7, 12, 1.00, 'g', 'Pending'),
(14, 7, 6, 1.00, 'ml', 'Pending'),
(15, 7, 2, 1.00, 'g', 'Pending'),
(16, 7, 3, 1.00, 'g', 'Pending'),
(17, 7, 1, 1.00, 'g', 'Pending'),
(18, 7, 15, 1.00, 'g', 'Pending'),
(19, 7, 6, 1.00, 'ml', 'Pending'),
(20, 7, 1, 1.00, 'g', 'Pending'),
(21, 7, 20, 1.00, 'ml', 'Pending'),
(22, 7, 24, 1.00, 'g', 'Pending'),
(23, 7, 3, 1.00, 'g', 'Pending'),
(24, 7, 4, 1.00, 'g', 'Pending'),
(25, 7, 9, 1.00, 'g', 'Pending'),
(26, 7, 14, 1.00, 'g', 'Pending'),
(27, 7, 4, 1.00, 'g', 'Pending'),
(28, 7, 8, 1.00, 'g', 'Pending'),
(29, 7, 3, 1.00, 'g', 'Pending'),
(30, 7, 12, 1.00, 'g', 'Pending'),
(31, 7, 6, 1.00, 'ml', 'Pending'),
(32, 7, 2, 1.00, 'g', 'Pending'),
(33, 7, 3, 1.00, 'g', 'Pending'),
(34, 7, 1, 1.00, 'g', 'Pending'),
(35, 7, 15, 1.00, 'g', 'Pending'),
(36, 7, 6, 1.00, 'ml', 'Pending'),
(37, 7, 1, 1.00, 'g', 'Pending'),
(38, 7, 20, 1.00, 'ml', 'Pending'),
(39, 7, 24, 1.00, 'g', 'Pending'),
(40, 7, 3, 1.00, 'g', 'Pending'),
(41, 7, 4, 1.00, 'g', 'Pending'),
(42, 7, 9, 1.00, 'g', 'Pending'),
(43, 8, 1, 4.00, 'g', 'Pending'),
(44, 8, 2, 2.00, 'g', 'Pending'),
(45, 8, 3, 6.00, 'g', 'Pending'),
(46, 8, 4, 4.00, 'g', 'Pending'),
(47, 8, 20, 2.00, 'ml', 'Pending'),
(48, 8, 6, 4.00, 'ml', 'Pending'),
(49, 8, 8, 2.00, 'g', 'Pending'),
(50, 8, 24, 2.00, 'g', 'Pending'),
(51, 8, 9, 3.00, 'g', 'Pending'),
(52, 8, 12, 2.00, 'g', 'Pending'),
(53, 8, 14, 2.00, 'g', 'Pending'),
(54, 8, 15, 2.00, 'g', 'Pending'),
(55, 9, 2, 1.00, 'g', 'Pending'),
(56, 9, 3, 1.00, 'g', 'Pending'),
(57, 9, 6, 2.00, 'ml', 'Pending'),
(58, 9, 9, 1.00, 'g', 'Pending'),
(59, 9, 15, 1.00, 'g', 'Pending'),
(60, 10, 2, 100.00, 'g', 'Pending'),
(61, 10, 3, 10.00, 'g', 'Pending'),
(62, 10, 6, 155.00, 'ml', 'Pending'),
(63, 11, 2, 700.00, 'g', 'Pending'),
(64, 11, 3, 110.00, 'g', 'Pending'),
(65, 11, 4, 390.00, 'g', 'Pending'),
(66, 11, 5, 15.00, 'ml', 'Pending'),
(67, 11, 6, 1155.00, 'ml', 'Pending'),
(68, 11, 9, 250.00, 'g', 'Pending'),
(69, 11, 10, 233.00, 'pcs', 'Pending'),
(70, 11, 12, 100.00, 'g', 'Pending'),
(71, 11, 14, 635.00, 'g', 'Pending'),
(72, 11, 15, 275.00, 'g', 'Pending'),
(73, 11, 19, 40.00, 'ml', 'Pending'),
(74, 11, 20, 260.00, 'ml', 'Pending'),
(75, 11, 22, 182.00, 'g', 'Pending'),
(76, 11, 23, 8.00, 'ml', 'Pending'),
(77, 12, 2, 100.00, 'g', 'Pending'),
(78, 12, 3, 10.00, 'g', 'Pending'),
(79, 12, 6, 155.00, 'ml', 'Pending'),
(80, 13, 6, 155.00, 'ml', 'Pending'),
(81, 13, 2, 100.00, 'g', 'Pending'),
(82, 13, 3, 10.00, 'g', 'Pending'),
(83, 14, 9, 250.00, 'g', 'Pending'),
(84, 14, 23, 8.00, 'ml', 'Pending'),
(85, 14, 10, 230.00, 'g', 'Pending'),
(86, 14, 5, 15.00, 'ml', 'Pending'),
(87, 14, 6, 1155.00, 'ml', 'Pending'),
(88, 14, 20, 260.00, 'ml', 'Pending'),
(89, 14, 2, 900.00, 'g', 'Pending'),
(90, 14, 15, 275.00, 'g', 'Pending'),
(91, 14, 3, 110.00, 'g', 'Pending'),
(92, 14, 19, 40.00, 'ml', 'Pending'),
(93, 14, 14, 635.00, 'g', 'Pending'),
(94, 14, 4, 490.00, 'g', 'Pending'),
(95, 14, 12, 100.00, 'g', 'Pending'),
(96, 14, 22, 182.00, 'g', 'Pending'),
(97, 15, 6, 155.00, 'ml', 'Pending'),
(98, 15, 2, 100.00, 'g', 'Pending'),
(99, 15, 3, 10.00, 'g', 'Pending'),
(100, 16, 6, 155.00, 'ml', 'Pending'),
(101, 16, 2, 100.00, 'g', 'Pending'),
(102, 16, 3, 10.00, 'g', 'Purchased');

-- --------------------------------------------------------

--
-- Table structure for table `shoppinglists`
--

CREATE TABLE `shoppinglists` (
  `shoppingListId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `createdDate` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shoppinglists`
--

INSERT INTO `shoppinglists` (`shoppingListId`, `userId`, `createdDate`, `status`) VALUES
(2, 1, '2026-07-06', 'Pending'),
(3, 1, '2026-07-07', 'Pending'),
(4, 1, '2026-07-13', 'Pending'),
(5, 1, '2026-07-13', 'Pending'),
(6, 1, '2026-07-13', 'Pending'),
(7, 1, '2026-07-18', 'Pending'),
(8, 1, '2026-07-18', 'Pending'),
(9, 6, '2026-07-18', 'Pending'),
(10, 6, '2026-07-20', 'Pending'),
(11, 6, '2026-07-20', 'Pending'),
(12, 6, '2026-07-20', 'Pending'),
(13, 6, '2026-07-20', 'Pending'),
(14, 6, '2026-07-20', 'Pending'),
(15, 6, '2026-07-20', 'Pending'),
(16, 6, '2026-07-20', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `userdietaryrestrictions`
--

CREATE TABLE `userdietaryrestrictions` (
  `userId` int(11) NOT NULL,
  `restrictionId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userdietaryrestrictions`
--

INSERT INTO `userdietaryrestrictions` (`userId`, `restrictionId`) VALUES
(1, 4),
(2, 6),
(3, 3),
(4, 4),
(5, 5),
(6, 5),
(6, 6),
(7, 4),
(8, 3),
(9, 6),
(10, 5),
(11, 3),
(12, 6);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userId` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `profilePhoto` varchar(255) DEFAULT NULL,
  `notifyExpiry` tinyint(1) NOT NULL DEFAULT 1,
  `notifyLowStock` tinyint(1) NOT NULL DEFAULT 1,
  `notifyMealPlanner` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userId`, `name`, `email`, `password`, `role`, `created_at`, `profilePhoto`, `notifyExpiry`, `notifyLowStock`, `notifyMealPlanner`) VALUES
(1, 'Sarah Jenkins', 'sarah.j@grocery.com', 'password123', 'admin', '2026-07-16 10:53:15', NULL, 1, 1, 0),
(2, 'David Miller', 'david.m@grocery.com', 'password123', 'user', '2026-07-16 10:53:15', NULL, 1, 1, 0),
(3, 'Emma Watson', 'emma.w@example.com', 'password123', 'user', '2026-07-16 10:53:15', NULL, 1, 1, 0),
(4, 'James Smith', 'james.s@example.com', 'password123', 'user', '2026-07-16 10:53:15', NULL, 1, 1, 0),
(5, 'Elena Rostova', 'elena.r@grocery.com', 'password123', 'admin', '2026-07-16 10:53:15', NULL, 1, 1, 0),
(6, 'Michael Chang', 'm.chang@example.com', 'password123', 'user', '2026-07-16 10:53:15', NULL, 1, 1, 0),
(7, 'Aisha Rahman', 'aisha.r@example.com', 'password123', 'user', '2026-07-16 10:53:15', NULL, 1, 1, 0),
(8, 'Carlos Mendez', 'carlos.m@example.com', 'password123', 'user', '2026-07-16 10:53:15', NULL, 1, 1, 0),
(9, 'Chloe Bennett', 'chloe.b@example.com', 'password123', 'user', '2026-07-16 10:53:15', NULL, 1, 1, 0),
(10, 'Liam O Connor', 'liam.o@example.com', 'password123', 'user', '2026-07-16 10:53:15', NULL, 1, 1, 0),
(11, 'Sophia Patel', 'sophia.p@example.com', 'password123', 'user', '2026-07-16 10:53:15', NULL, 1, 1, 0),
(12, 'Marcus Vance', 'marcus.v@example.com', 'password123', 'user', '2026-07-16 10:53:15', NULL, 1, 1, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`cartItemId`),
  ADD KEY `fk_cart_items_product` (`productId`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`categoryId`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `dietaryrestrictions`
--
ALTER TABLE `dietaryrestrictions`
  ADD PRIMARY KEY (`restrictionId`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`ingredientId`),
  ADD KEY `fk_ingredient_product` (`productId`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventoryId`),
  ADD UNIQUE KEY `unique_product` (`productId`);

--
-- Indexes for table `mealplandetails`
--
ALTER TABLE `mealplandetails`
  ADD PRIMARY KEY (`mealPlanDetailId`),
  ADD KEY `fk_detail_plan` (`mealPlanId`),
  ADD KEY `fk_detail_recipe` (`recipeId`);

--
-- Indexes for table `mealplans`
--
ALTER TABLE `mealplans`
  ADD PRIMARY KEY (`mealPlanId`),
  ADD KEY `fk_mealplan_user` (`userId`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notifId`),
  ADD KEY `fk_notif_product` (`productId`);

--
-- Indexes for table `nutritionfacts`
--
ALTER TABLE `nutritionfacts`
  ADD PRIMARY KEY (`nutritionId`),
  ADD KEY `fk_nutrition_recipe` (`recipeId`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderId`),
  ADD KEY `fk_order_user` (`userId`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`orderItemId`),
  ADD KEY `fk_orderitem_order` (`orderId`),
  ADD KEY `fk_orderitem_product` (`productId`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`productId`),
  ADD KEY `fk_product_category` (`categoryId`);

--
-- Indexes for table `recipeingredients`
--
ALTER TABLE `recipeingredients`
  ADD PRIMARY KEY (`recipeIngredientId`),
  ADD KEY `fk_recipeingredient_recipe` (`recipeId`),
  ADD KEY `fk_recipeingredient_ingredient` (`ingredientId`);

--
-- Indexes for table `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`recipeId`);

--
-- Indexes for table `shoppinglistitems`
--
ALTER TABLE `shoppinglistitems`
  ADD PRIMARY KEY (`shoppingListItemId`),
  ADD KEY `fk_item_list` (`shoppingListId`),
  ADD KEY `fk_item_ingredient` (`ingredientId`);

--
-- Indexes for table `shoppinglists`
--
ALTER TABLE `shoppinglists`
  ADD PRIMARY KEY (`shoppingListId`),
  ADD KEY `fk_shoplist_user` (`userId`);

--
-- Indexes for table `userdietaryrestrictions`
--
ALTER TABLE `userdietaryrestrictions`
  ADD PRIMARY KEY (`userId`,`restrictionId`),
  ADD KEY `restrictionId` (`restrictionId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userId`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `cartItemId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `categoryId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `dietaryrestrictions`
--
ALTER TABLE `dietaryrestrictions`
  MODIFY `restrictionId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `ingredientId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inventoryId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `mealplandetails`
--
ALTER TABLE `mealplandetails`
  MODIFY `mealPlanDetailId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=292;

--
-- AUTO_INCREMENT for table `mealplans`
--
ALTER TABLE `mealplans`
  MODIFY `mealPlanId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notifId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `nutritionfacts`
--
ALTER TABLE `nutritionfacts`
  MODIFY `nutritionId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `orderId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `orderItemId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `productId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `recipeingredients`
--
ALTER TABLE `recipeingredients`
  MODIFY `recipeIngredientId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `recipes`
--
ALTER TABLE `recipes`
  MODIFY `recipeId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `shoppinglistitems`
--
ALTER TABLE `shoppinglistitems`
  MODIFY `shoppingListItemId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `shoppinglists`
--
ALTER TABLE `shoppinglists`
  MODIFY `shoppingListId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `fk_cart_items_product` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON UPDATE CASCADE;

--
-- Constraints for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD CONSTRAINT `fk_ingredient_product` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`);

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `fk_inventory_product` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`);

--
-- Constraints for table `mealplandetails`
--
ALTER TABLE `mealplandetails`
  ADD CONSTRAINT `fk_detail_plan` FOREIGN KEY (`mealPlanId`) REFERENCES `mealplans` (`mealPlanId`),
  ADD CONSTRAINT `fk_detail_recipe` FOREIGN KEY (`recipeId`) REFERENCES `recipes` (`recipeId`);

--
-- Constraints for table `mealplans`
--
ALTER TABLE `mealplans`
  ADD CONSTRAINT `fk_mealplan_user` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notif_product` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`);

--
-- Constraints for table `nutritionfacts`
--
ALTER TABLE `nutritionfacts`
  ADD CONSTRAINT `fk_nutrition_recipe` FOREIGN KEY (`recipeId`) REFERENCES `recipes` (`recipeId`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_order_user` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_orderitem_order` FOREIGN KEY (`orderId`) REFERENCES `orders` (`orderId`),
  ADD CONSTRAINT `fk_orderitem_product` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_product_category` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`);

--
-- Constraints for table `recipeingredients`
--
ALTER TABLE `recipeingredients`
  ADD CONSTRAINT `fk_recipeingredient_ingredient` FOREIGN KEY (`ingredientId`) REFERENCES `ingredients` (`ingredientId`),
  ADD CONSTRAINT `fk_recipeingredient_recipe` FOREIGN KEY (`recipeId`) REFERENCES `recipes` (`recipeId`);

--
-- Constraints for table `shoppinglistitems`
--
ALTER TABLE `shoppinglistitems`
  ADD CONSTRAINT `fk_item_ingredient` FOREIGN KEY (`ingredientId`) REFERENCES `ingredients` (`ingredientId`),
  ADD CONSTRAINT `fk_item_list` FOREIGN KEY (`shoppingListId`) REFERENCES `shoppinglists` (`shoppingListId`);

--
-- Constraints for table `shoppinglists`
--
ALTER TABLE `shoppinglists`
  ADD CONSTRAINT `fk_shoplist_user` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`);

--
-- Constraints for table `userdietaryrestrictions`
--
ALTER TABLE `userdietaryrestrictions`
  ADD CONSTRAINT `userdietaryrestrictions_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`),
  ADD CONSTRAINT `userdietaryrestrictions_ibfk_2` FOREIGN KEY (`restrictionId`) REFERENCES `dietaryrestrictions` (`restrictionId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
