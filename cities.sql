-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 18, 2024 at 08:08 AM
-- Server version: 8.0.30
-- PHP Version: 8.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hrtest-db`
--

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint DEFAULT '1',
  `governorate_id` bigint UNSIGNED DEFAULT NULL COMMENT 'محافظة الموظف',
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `name`, `active`, `governorate_id`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(1, 'المعادي', 1, 1, 1, 1, 1, NULL, NULL),
(2, 'مدينة نصر', 1, 1, 1, 1, 1, NULL, NULL),
(3, 'سيدي بشر', 1, 3, 1, 1, 1, NULL, '2024-12-18 08:08:05'),
(4, 'الزقازيق', 1, 27, 1, 1, 1, NULL, '2024-12-18 08:07:59'),
(5, 'طنطا', 1, 10, 1, 1, 1, NULL, '2024-12-18 08:07:50'),
(6, 'دمنهور', 1, 9, 1, 1, 1, NULL, '2024-12-18 08:07:37'),
(7, 'باب الشعرية', 1, 1, 1, 1, 1, NULL, '2024-12-18 08:07:11'),
(8, 'الشيخ زايد', 1, 2, 1, 1, 1, NULL, '2024-12-18 07:46:18'),
(9, 'الهرم', 1, 2, 1, 1, 1, NULL, '2024-12-18 08:00:43'),
(10, 'العبور', 1, 1, 1, 1, 1, NULL, NULL),
(11, 'مصر القديمة', 1, 1, 1, 1, 1, NULL, NULL),
(12, 'الزمالك', 1, 1, 1, 1, 1, NULL, NULL),
(13, 'مدينة بدر', 1, 1, 1, 1, 1, NULL, NULL),
(14, 'الشروق', 1, 1, 1, 1, 1, NULL, NULL),
(15, 'الوايلى', 1, 1, 1, 1, 1, NULL, '2024-12-18 08:06:42'),
(16, 'العجمي', 1, 3, 1, 1, 1, NULL, '2024-12-18 08:06:32'),
(17, 'محطة الرمل', 1, 3, 1, 1, 1, NULL, '2024-12-18 08:06:26'),
(18, 'كرموز', 1, 3, 1, 1, 1, NULL, '2024-12-18 08:06:20'),
(19, 'الأنفوشي', 1, 3, 1, 1, 1, NULL, '2024-12-18 08:06:14'),
(20, 'عابدين', 1, 1, 1, 1, 1, NULL, '2024-12-18 08:06:08'),
(21, 'بلطيم', 1, 12, 1, 1, 1, NULL, '2024-12-18 08:05:51'),
(22, 'كفر الدوار', 1, 3, 1, 1, 1, NULL, NULL),
(23, 'أبو حمص', 1, 9, 1, 1, 1, NULL, '2024-12-18 08:05:27'),
(24, 'الازبكية', 1, 1, 1, 1, 1, NULL, '2024-12-18 08:05:11'),
(25, 'سفاجا', 1, 18, 1, 1, 1, NULL, '2024-12-18 08:04:45'),
(26, 'دهب', 1, 21, 1, 1, 1, NULL, '2024-12-18 08:04:23'),
(27, 'طابا', 1, 21, 1, 1, 1, NULL, '2024-12-18 08:03:54'),
(28, 'مصر الجديدة', 1, 1, 1, 1, 1, NULL, '2024-12-18 08:03:29'),
(29, 'العريش', 1, 22, 1, 1, 1, NULL, '2024-12-18 08:03:18'),
(30, 'م نصر', 1, 1, 1, 1, 1, NULL, '2024-12-18 08:03:08'),
(31, 'السلام', 1, 1, 1, 1, 1, NULL, '2024-12-18 08:02:51'),
(32, 'حلمية الزيتون', 1, 1, 1, 1, 1, NULL, '2024-12-18 08:02:35'),
(33, 'المهندسين', 1, 2, 1, 1, 1, NULL, '2024-12-18 08:01:26'),
(34, 'الوراق', 1, 2, 1, 1, 1, NULL, '2024-12-18 08:01:09'),
(35, 'العجوزة (حي)', 1, 2, 1, 1, 1, NULL, '2024-12-18 08:00:28'),
(36, 'إمبابة', 1, 2, 1, 1, 1, NULL, '2024-12-18 08:00:10'),
(37, 'البراجيل', 1, 2, 1, 1, 1, NULL, '2024-12-18 07:59:38'),
(38, 'مركز ناصر', 1, 26, 1, 1, 1, NULL, '2024-12-18 07:58:09'),
(39, 'مغاغة ', 1, 20, 1, 1, 1, NULL, '2024-12-18 07:57:59'),
(40, 'البداري', 1, 6, 1, 1, 1, NULL, '2024-12-18 07:56:54'),
(41, 'ديروط', 1, 6, 1, 1, 1, NULL, NULL),
(42, 'أبو قير', 1, 3, 1, 1, 1, NULL, '2024-12-18 07:55:00'),
(43, 'مدينة السادات', 1, 28, 1, 1, 1, NULL, '2024-12-18 07:54:49'),
(44, 'مدينة حلايب', 1, 18, 1, 1, 1, NULL, '2024-12-18 07:54:39'),
(45, 'دشنا ', 1, 19, 1, 1, 1, NULL, '2024-12-18 07:53:53'),
(46, 'حي الأربعين ', 1, 7, 1, 1, 1, NULL, '2024-12-18 07:52:48'),
(47, 'المحلة الكبرى', 1, 10, 1, 1, 1, NULL, '2024-12-18 07:51:56'),
(48, 'بلبيس', 1, 27, 1, 1, 1, NULL, '2024-12-18 07:51:17'),
(49, 'كفر الزيات', 1, 10, 1, 1, 1, NULL, '2024-12-18 07:51:08'),
(50, 'الزيتون', 1, 1, 1, 1, 1, NULL, NULL),
(51, 'المنصورة', 1, 5, 1, 1, 1, NULL, '2024-12-18 07:50:05'),
(52, 'بركة السبع', 1, 28, 1, 1, 1, NULL, '2024-12-18 07:49:49'),
(53, 'والباجور ', 1, 28, 1, 1, 1, NULL, '2024-12-18 07:49:29'),
(54, 'القصير', 1, 18, 1, 1, 1, NULL, '2024-12-18 07:47:48'),
(55, 'التل الكبير', 1, 4, 1, 1, 1, NULL, '2024-12-18 07:47:32'),
(56, 'القوصية', 1, 6, 1, 1, 1, NULL, '2024-12-18 07:47:08'),
(57, 'بولاق الدكرور', 1, 2, 1, 1, 1, NULL, '2024-12-18 07:46:12'),
(58, 'حلوان', 1, 1, 1, 1, 1, NULL, NULL),
(59, 'الرحاب', 1, 1, 1, 1, 1, NULL, '2024-12-18 07:45:22'),
(60, 'أبو تيج', 1, 6, 1, 1, 1, NULL, '2024-12-18 07:55:25'),
(61, 'الصف', 1, 1, 1, 1, 1, NULL, NULL),
(62, 'العاشر من رمضان', 1, 18, 1, 1, 1, NULL, NULL),
(63, 'أبوزعبل', 1, 8, 1, 1, 1, NULL, '2024-12-18 07:44:13'),
(64, 'البرلس', 1, 12, 1, 1, 1, NULL, '2024-12-18 07:43:55'),
(65, 'الجمرك', 1, 2, 1, 1, 1, NULL, NULL),
(66, 'المنيل', 1, 2, 1, 1, 1, NULL, '2024-12-18 07:43:31'),
(67, 'العطارين', 1, 3, 1, 1, 1, NULL, '2024-12-18 07:42:13'),
(68, 'الإبراهيمية', 1, 3, 1, 1, 1, NULL, '2024-12-18 07:41:56'),
(69, 'أبوزنيمة', 1, 21, 1, 1, 1, NULL, '2024-12-18 07:41:48'),
(70, 'أبو رديس', 1, 21, 1, 1, 1, NULL, '2024-12-18 07:41:26'),
(71, 'سهل حشيش', 1, 18, 1, 1, 1, NULL, '2024-12-18 07:40:54'),
(72, 'حوش عيسى', 1, 3, 1, 1, 1, NULL, NULL),
(73, 'القنطرة شرق', 1, 4, 1, 1, 1, NULL, NULL),
(74, 'المطرية', 1, 1, 1, 1, 1, NULL, NULL),
(75, 'البدرشين', 1, 2, 1, 1, 1, NULL, '2024-12-18 07:40:12'),
(76, 'المنيب', 1, 2, 1, 1, 1, NULL, '2024-12-18 07:40:07'),
(77, 'مينا البصل', 1, 3, 1, 1, 1, NULL, '2024-12-18 07:40:00'),
(78, 'الشروق', 1, 1, 1, 1, 77, NULL, NULL),
(79, 'طلخا', 1, 4, 1, 1, 78, NULL, NULL),
(80, 'كفر شكر', 1, 18, 1, 1, 79, NULL, NULL),
(81, 'الخانكة', 1, 18, 1, 1, 80, NULL, NULL),
(82, 'مركز دمياط', 1, 3, 1, 1, 81, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cities_governorate_id_foreign` (`governorate_id`),
  ADD KEY `cities_created_by_foreign` (`created_by`),
  ADD KEY `cities_updated_by_foreign` (`updated_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `cities_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cities_governorate_id_foreign` FOREIGN KEY (`governorate_id`) REFERENCES `governorates` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cities_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
