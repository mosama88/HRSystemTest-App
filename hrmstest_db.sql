-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 13, 2024 at 01:30 PM
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
-- Database: `hrmstest_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `additional_types`
--

CREATE TABLE `additional_types` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `additional_types`
--

INSERT INTO `additional_types` (`id`, `name`, `active`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(1, 'ساعات أضافية', 1, 1, 1, 1, NULL, NULL),
(2, 'مكافأة الأداء', 1, 1, 1, 1, NULL, NULL),
(3, 'حوافز الإنتاجية', 1, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `date` date DEFAULT NULL,
  `com_code` int DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `username`, `email`, `email_verified_at`, `password`, `created_by`, `updated_by`, `status`, `date`, `com_code`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'محمد أسامه', 'mosama', 'mosama@dt.com', NULL, '$2y$10$lzbE78ozm5qFuU378noyXOU3SOzuR3ygoj5kt04Fm5KYaDzRDUUcG', 1, 1, 'active', '2024-12-13', 1, NULL, NULL, NULL),
(2, 'Super Admin', 'superadmin', 'superadmin@dt.com', NULL, '$2y$10$NP/AOs100mZzQdH/x3RJfO4f5zkVBgCUTfFQ3hFQLL/.1bg20vtge', 1, NULL, 'active', NULL, NULL, NULL, '2024-12-13 13:29:42', '2024-12-13 13:29:42'),
(3, 'Admin', 'admin', 'admin@dt.com', NULL, '$2y$10$2b4KyOBHV/kqtquDKIDWFuDkaTmqxKzL1bDS0Yb8MSspB7f65Y8PG', 1, NULL, 'active', NULL, 1, NULL, '2024-12-13 13:29:42', '2024-12-13 13:29:42'),
(4, 'Staff', 'staff', 'staff@dt.com', NULL, '$2y$10$x8BO95.TuaQ9Gu3meXRIfOayhYTh5ysWusDVfX8Mg5kfsasmwWH4.', 1, NULL, 'active', NULL, 1, NULL, '2024-12-13 13:29:43', '2024-12-13 13:29:43');

-- --------------------------------------------------------

--
-- Table structure for table `admin_panel_settings`
--

CREATE TABLE `admin_panel_settings` (
  `id` bigint UNSIGNED NOT NULL,
  `company_name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `system_status` tinyint NOT NULL DEFAULT '1' COMMENT 'واحد مفعل - صفر معطل',
  `image` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo_cover` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phons` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `max_hours_take_fp_as_addtional` decimal(10,2) NOT NULL DEFAULT '4.00' COMMENT 'الحد الأقصى لاحتساب عدد ساعات عمل اضافية عند انصراف الموظف واحتسا بصمة الانصراف و الاستحتسب على انها بصمة حضور شفت جديد ',
  `less_than_minute_neglecting_fp` int NOT NULL DEFAULT '3' COMMENT 'أقل من كام دقيقة يتم إهمال البصمة التالية التأكدية للموظف خلال نفس الشيفت',
  `after_minute_calculate_delay` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'بعد كام دقيقة نحسب تاخير حضور',
  `after_minute_calculate_early_departure` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'بعد كام دقيقة نحسب انصراف مبكر',
  `after_minute_quarterday` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'بعد كام مره تأخير او إنصراف مبكر نخصم ربع يوم',
  `after_time_half_daycut` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'بعد كام مرة تأخير او انصراف مبكر نخصم نص يوم',
  `after_time_allday_daycut` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'نخصم بعد كام مره تاخير او انصراف مبكر يوم كامل',
  `monthly_vacation_balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'رصيد اجازات الموظف الشهري',
  `after_days_begin_vacation` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'بعد كام يوم ينزل للموظف رصيد اجازات',
  `first_balance_begin_vacation` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'الرصيد الاول المرحل عند تفعيل الاجازات للموظف مثل نزول 10 ايام ونص بعد 6 شهور للموظف',
  `sanctions_value_first_absence` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'قيمة خصم الايام بعد اول مرة غياب بدون اذن	',
  `sanctions_value_second_absence` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'قيمة خصم الايام بعد ثاني مرة غياب بدون اذن',
  `sanctions_value_thaird_absence` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'قيمة خصم الايام بعد ثالث مرة غياب بدون اذن',
  `sanctions_value_forth_absence` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'قيمة خصم الايام بعد رابع مرة غياب بدون اذن',
  `created_by` int NOT NULL,
  `updated_by` int DEFAULT NULL,
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_panel_settings`
--

INSERT INTO `admin_panel_settings` (`id`, `company_name`, `system_status`, `image`, `photo_cover`, `phons`, `address`, `email`, `max_hours_take_fp_as_addtional`, `less_than_minute_neglecting_fp`, `after_minute_calculate_delay`, `after_minute_calculate_early_departure`, `after_minute_quarterday`, `after_time_half_daycut`, `after_time_allday_daycut`, `monthly_vacation_balance`, `after_days_begin_vacation`, `first_balance_begin_vacation`, `sanctions_value_first_absence`, `sanctions_value_second_absence`, `sanctions_value_thaird_absence`, `sanctions_value_forth_absence`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(1, 'مستشفى المروة', 1, NULL, NULL, '01228759920', '45 شارع جامعه الدول ناصيه شهاب', 'info@almarwa.com', '4.00', 3, '15.00', '15.00', '30.00', '2.00', '4.00', '6.00', '180.00', '8.00', '8.00', '9.00', '10.00', '11.00', 1, 1, 1, '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(2, 'شركة FBA', 1, NULL, NULL, '01550565699', '45 شارع المعز ناصيه المحمدى مصر الجدية', 'info@fba.com', '4.00', 3, '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', 1, 1, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `allowances`
--

CREATE TABLE `allowances` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `allowances`
--

INSERT INTO `allowances` (`id`, `name`, `active`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(1, 'بدل انتقال', 1, 1, 1, 1, NULL, NULL),
(2, 'بدل سكن', 1, 1, 1, 1, NULL, NULL),
(3, 'بدل طعام', 1, 1, 1, 1, NULL, NULL),
(4, 'بدل سفر', 1, 1, 1, 1, NULL, NULL),
(5, 'بدل تدريب', 1, 1, 1, 1, NULL, NULL),
(6, 'بدل مخاطرة', 1, 1, 1, 1, NULL, NULL),
(7, 'بدل احتياجات خاصة', 1, 1, 1, 1, NULL, NULL),
(8, 'بدل عائلة', 1, 1, 1, 1, NULL, NULL),
(9, 'بدل أداء', 1, 1, 1, 1, NULL, NULL),
(10, 'بدل مبيعات', 1, 1, 1, 1, NULL, NULL),
(11, 'بدل نوبات', 1, 1, 1, 1, NULL, NULL),
(12, 'بدل اتصالات', 1, 1, 1, 1, NULL, NULL),
(13, 'بدل غلاء معيشة', 1, 1, 1, 1, NULL, NULL),
(14, 'بدل تعليم', 1, 1, 1, 1, NULL, NULL),
(15, 'بدل ملابس', 1, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `attendance_departures`
--

CREATE TABLE `attendance_departures` (
  `id` bigint UNSIGNED NOT NULL,
  `finance_cln_periods_id` bigint UNSIGNED NOT NULL COMMENT 'كود الشهر المالى',
  `employee_code` bigint NOT NULL COMMENT 'كود الموظف',
  `shift_hour_contract` decimal(10,2) DEFAULT NULL COMMENT 'عدد ساعات العمل اليومى المتعاقد عليها فى تلك الوقت',
  `status_move` tinyint DEFAULT NULL COMMENT '(1-Check in حضور)(2-Check out انصراف)',
  `the_day_date` date NOT NULL COMMENT 'تاريخ اليوم الفعلى من المفترض يكون فى سحب  بصمة و النظام من الممكن ان يضع له قيمه حتى اذا لم يتم وضع بصمه له',
  `date_in` date DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `time_in` time DEFAULT NULL,
  `time_out` time DEFAULT NULL,
  `variables` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'المتغيرات',
  `attendance_delay` decimal(10,2) DEFAULT '0.00' COMMENT 'قيمة عدد دقائق  الحضور المتأخر ان وجد',
  `early_departure` decimal(20,2) DEFAULT '0.00' COMMENT 'قيمة عدد الانصراف المبكر ان وجد',
  `permission_hours` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'تفاصيل الإذن إن وجد',
  `total_hours` decimal(10,2) DEFAULT '0.00' COMMENT 'عدد ساعات العمل بين الحضور والأنصراف',
  `absence_hours` decimal(10,2) DEFAULT '0.00' COMMENT 'عدد ساعات الغياب بهذا اليوم',
  `additional_hours` decimal(10,2) DEFAULT '0.00' COMMENT 'عدد ساعات الأضافى بهذا اليوم',
  `date_time_in` datetime DEFAULT NULL COMMENT 'توقيت البصمه الحضور',
  `date_time_out` datetime DEFAULT NULL COMMENT 'توقيت البصمه الأنصراف',
  `is_make_action_on_employee` tinyint DEFAULT '0' COMMENT 'هل تم أخذ إجراء على الموظف',
  `is_archived` tinyint DEFAULT '0' COMMENT 'حالة الأرشفه',
  `archived_date` datetime DEFAULT NULL,
  `archived_by` bigint UNSIGNED DEFAULT NULL,
  `is_updated_active_action` tinyint DEFAULT '0' COMMENT 'هل تم التعديل على البصمات الفعلية',
  `is_updated_active_action_date` datetime DEFAULT NULL COMMENT 'تاريخ التعديل على البصمات الفعلية',
  `is_updated_active_action_by` bigint UNSIGNED DEFAULT NULL,
  `vacations_types_id` int DEFAULT NULL COMMENT 'لو اجازه سيكون كود الأجازه',
  `occasions_id` int DEFAULT NULL COMMENT 'اجازات رسمية فى حالة نوع الأجازه رسمى',
  `cut` tinyint DEFAULT '0' COMMENT 'nothing == 0 | quarter Day = 25| half day = 5| one day = 1',
  `year_month` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'الشهر المالى للبصمة',
  `employee_status` enum('Employee','Unemployed') COLLATE utf8mb4_unicode_ci DEFAULT 'Employee' COMMENT 'حالة الموظف لحظة البصمة',
  `branch_id` bigint UNSIGNED NOT NULL COMMENT 'كود الفرع لحظة البصمة ',
  `main_salary_employees_id` bigint UNSIGNED DEFAULT NULL COMMENT 'كود الراتب بالشهر المالى ان وجد',
  `com_code` int NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendance_departure_actions`
--

CREATE TABLE `attendance_departure_actions` (
  `id` bigint UNSIGNED NOT NULL,
  `attendance_departure_id` bigint UNSIGNED NOT NULL,
  `finance_cln_periods_id` bigint UNSIGNED NOT NULL COMMENT 'كود الشهر المالى',
  `employee_code` bigint NOT NULL COMMENT 'كود الموظف',
  `attendance_departure_action_excel_id` bigint NOT NULL COMMENT 'رقم البصمة فى الارشيف',
  `date_time_action` datetime DEFAULT NULL COMMENT 'توقيت البصمه ',
  `action_type` tinyint NOT NULL COMMENT '(1 حضور) - (2 انصراف)نوع حركة البصمة',
  `is_active_with_parent` tinyint NOT NULL DEFAULT '0' COMMENT 'هل هى البصمه المستعملة بتقفيل الأب',
  `added_method` tinyint NOT NULL DEFAULT '1' COMMENT '(1 اتوماتيك) - (2 مانيوال) سحب البصمه',
  `is_make_action_on_employee` tinyint DEFAULT '0' COMMENT 'هل تم أخذ إجراء على الموظف',
  `is_archived` tinyint DEFAULT '0' COMMENT 'حالة الأرشفه',
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendance_departure_action_excels`
--

CREATE TABLE `attendance_departure_action_excels` (
  `id` bigint UNSIGNED NOT NULL,
  `finance_cln_periods_id` bigint UNSIGNED NOT NULL COMMENT 'كود الشهر المالى',
  `employee_code` bigint NOT NULL COMMENT 'كود الموظف',
  `date_time_action` datetime NOT NULL COMMENT 'توقيت البصمه من جهاز البصمة',
  `action_type` tinyint NOT NULL COMMENT '(1 حضور) - (2 انصراف)نوع حركة البصمة',
  `main_salary_employees_id` bigint UNSIGNED DEFAULT NULL COMMENT 'كود الراتب بالشهر المالى ان وجد',
  `created_by` bigint UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL COMMENT 'تاريخ الأضافة',
  `com_code` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blood_types`
--

CREATE TABLE `blood_types` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  `com_code` int NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blood_types`
--

INSERT INTO `blood_types` (`id`, `name`, `active`, `com_code`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'A +', 1, 1, 1, 1, NULL, NULL),
(2, 'A -', 1, 1, 1, 1, NULL, NULL),
(3, 'AB', 1, 1, 1, 1, NULL, NULL),
(4, 'B +', 1, 1, 1, 1, NULL, NULL),
(5, 'B -', 1, 1, 1, 1, NULL, NULL),
(6, 'O -', 1, 1, 1, 1, NULL, NULL),
(7, 'O +', 1, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phones` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `name`, `address`, `phones`, `email`, `active`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(1, 'فرع المعادى', ' 6 ش حسن محمد, متفرع من ش حسنين دسوقى, حدائق المعادى, المعادى, القاهرة.', '01226548830', 'maadi@gmail.com', 1, 1, 1, 1, NULL, NULL),
(2, 'فرع المهندسين', 'رقم 45 شارع جامعه الدول ناصيه شهاب ', '01060009780', 'mohandessin@gmail.com', 1, 1, 1, 1, NULL, NULL),
(3, 'فرع م نصر', '9 شارع محمد يوسف موسى – تقاطع شارع مصطفى النحاس', '011186671182', 'nasrcity@gmail.com', 1, 1, 1, 1, NULL, NULL),
(4, 'فرع الأسكندرية', '22 طريق الجيش ، الشاطبى الاسكندرية', '01550575788', 'alex@gmail.com', 1, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
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
(1, 'السبتيه', 1, 1, 1, 1, 1, NULL, NULL),
(2, 'الهرم', 1, 2, 1, 1, 1, NULL, NULL),
(3, 'مدية نصر', 1, 1, 1, 1, 1, NULL, NULL),
(4, 'مصر الجديده', 1, 1, 1, 1, 1, NULL, NULL),
(5, 'حلمية الزيتون', 1, 1, 1, 1, 1, NULL, NULL),
(6, 'المهندسين', 1, 2, 1, 1, 1, NULL, NULL),
(7, 'الدقى', 1, 2, 1, 1, 1, NULL, NULL),
(8, 'فيصل', 1, 2, 1, 1, 1, NULL, NULL),
(9, 'العمرانية', 1, 2, 1, 1, 1, NULL, NULL),
(10, '٦ أكتوبر', 1, 2, 1, 1, 1, NULL, NULL),
(11, 'بولاق الدكرور', 1, 2, 1, 1, 1, NULL, NULL),
(12, 'بولاق ابوالعلا', 1, 1, 1, 1, 1, NULL, NULL),
(13, 'جسر السويس', 1, 1, 1, 1, 1, NULL, NULL),
(14, 'الزمالك', 1, 1, 1, 1, 1, NULL, NULL),
(15, 'القاهرة الجديده', 1, 1, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  `com_code` int NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `name`, `active`, `com_code`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'مصر', 1, 1, 1, 1, NULL, NULL),
(2, 'سوريا', 1, 1, 1, 1, NULL, NULL),
(3, 'لبنان', 1, 1, 1, 1, NULL, NULL),
(4, 'اليمن', 1, 1, 1, 1, NULL, NULL),
(5, 'الهند', 1, 1, 1, 1, NULL, NULL),
(6, 'أنجلترا', 1, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phones` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `phones`, `notes`, `created_by`, `updated_by`, `active`, `com_code`, `created_at`, `updated_at`) VALUES
(1, 'إدارة المخاطر ', '01228759920', 'إدارة مستقلة', 1, 1, 1, 1, NULL, NULL),
(2, 'الإدارة المالية ', '01228759920', 'إدارة مستقلة', 1, 1, 1, 1, NULL, NULL),
(3, 'إدارة التغيير ', '01228759920', 'إدارة مستقلة', 1, 1, 1, 1, NULL, NULL),
(4, 'الإدارة التنفيذية', '01228759920', 'إدارة مستقلة', 1, 1, 1, 1, NULL, NULL),
(5, 'الإدارة الوسطى', '01228759920', 'إدارة مستقلة', 1, 1, 1, 1, NULL, NULL),
(6, 'إدارة الفريق', '01228759920', 'إدارة مستقلة', 1, 1, 1, 1, NULL, NULL),
(7, 'إدارة الموارد البشرية', '01228759920', 'إدارة مستقلة', 1, 1, 1, 1, NULL, NULL),
(8, 'إدارة الانتاج', '01228759920', 'إدارة مستقلة', 1, 1, 1, 1, NULL, NULL),
(9, 'الإدارة العامه', '01228759920', 'إدارة مستقلة', 1, 1, 1, 1, NULL, NULL),
(10, 'إدارة التكنولوجيا وعلوم الحاسب', '01228759920', 'إدارة مستقلة', 1, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `discount_types`
--

CREATE TABLE `discount_types` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `discount_types`
--

INSERT INTO `discount_types` (`id`, `name`, `active`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(1, 'الضرائب', 1, 1, 1, 1, NULL, NULL),
(2, 'التأمين الاجتماعي', 1, 1, 1, 1, NULL, NULL),
(3, 'التأمين الصحي', 1, 1, 1, 1, NULL, NULL),
(4, 'التأمين على الحياة', 1, 1, 1, 1, NULL, NULL),
(5, 'خصم القروض', 1, 1, 1, 1, NULL, NULL),
(6, 'غياب غير مبرر', 1, 1, 1, 1, NULL, NULL),
(7, 'تأخير عن العمل', 1, 1, 1, 1, NULL, NULL),
(8, 'خصم جزاءات', 1, 1, 1, 1, NULL, NULL),
(9, 'خصم مبيعات', 1, 1, 1, 1, NULL, NULL),
(10, ' خصم سلف', 1, 1, 1, 1, NULL, NULL),
(11, 'خصم تأمينات إضافية', 1, 1, 1, 1, NULL, NULL),
(12, 'خصم نفقات تدريب', 1, 1, 1, 1, NULL, NULL),
(13, 'خصم اشتراكات', 1, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_code` int DEFAULT NULL COMMENT 'كود الموظف التلقائي لايتغير',
  `fp_code` int DEFAULT NULL COMMENT 'كود بصمة الموظف من جهاز البصمة لايتغير',
  `name` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` enum('Male','Female') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Male',
  `branch_id` bigint UNSIGNED NOT NULL COMMENT 'الفرع التابع له الموظف ',
  `job_grade_id` bigint UNSIGNED NOT NULL COMMENT 'الدرجه الوظيفية للموظف',
  `qualification_id` bigint UNSIGNED DEFAULT NULL COMMENT 'المؤهل التعليمي',
  `qualification_year` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'سنة التخرج',
  `major` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'تخصص التخرج',
  `graduation_estimate` enum('Fair','Good','Very_Good','Excellent') COLLATE utf8mb4_unicode_ci DEFAULT 'Fair' COMMENT 'تقدير التخرج ',
  `brith_date` date DEFAULT NULL COMMENT 'تاريخ ميلاد الموظف',
  `national_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'رقم البطاقة الشخصية - او رقم الهوية',
  `end_national_id` date DEFAULT NULL COMMENT 'تاريخ نهاية البطاقة الشخصية - بطاقة الهوية',
  `national_id_place` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'مكان اصدار بطاقة الهوية الشخصية',
  `blood_types_id` bigint UNSIGNED DEFAULT NULL COMMENT 'فصيلة الدم',
  `religion` enum('Muslim','Christian') COLLATE utf8mb4_unicode_ci DEFAULT 'Muslim' COMMENT 'حقل الديانة',
  `language_id` bigint UNSIGNED DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT ' ايميل  الموظف',
  `country_id` bigint UNSIGNED DEFAULT NULL COMMENT 'دولة الموظف',
  `governorate_id` bigint UNSIGNED DEFAULT NULL COMMENT 'محافظة الموظف',
  `city_id` bigint UNSIGNED DEFAULT NULL COMMENT 'مدينة الموظف',
  `home_telephone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'رقم هاتف المنزل',
  `work_telephone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'رقم هاتف العمل',
  `mobile` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'رقم هاتف المحمول',
  `military` enum('Exemption','Exemption_Temporary','Complete') COLLATE utf8mb4_unicode_ci DEFAULT 'Exemption_Temporary' COMMENT 'الحالة العسكرية',
  `military_date_from` date DEFAULT NULL COMMENT 'تاريخ بداية الخدمة العسكرية',
  `military_date_to` date DEFAULT NULL COMMENT 'تاريخ نهاية الخدمة العسكرية',
  `military_wepon` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'نوع سلاح الخدمة العسكرية',
  `military_exemption_date` date DEFAULT NULL COMMENT 'تاريخ الاعفاء من الخدمه العسكرية',
  `military_exemption_reason` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'سبب الاعفاء من الخدمه العسكرية ',
  `military_postponement_reason` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'سبب التأجيل من الخدمه العسكرية ',
  `date_resignation` date DEFAULT NULL COMMENT 'تاريخ ترك العمل',
  `resignation_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'سبب ترك العمل',
  `driving_license` enum('Yes','No') COLLATE utf8mb4_unicode_ci DEFAULT 'No' COMMENT 'هل يمتلك رخصه قياده',
  `driving_license_type` enum('Special','First','Second','Third','Fourth','Pro','Motorcycle') COLLATE utf8mb4_unicode_ci DEFAULT 'Special' COMMENT 'نوع رخصه القيادة',
  `driving_License_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'رقم رخصه القيادة',
  `has_relatives` enum('Yes','No') COLLATE utf8mb4_unicode_ci DEFAULT 'No' COMMENT 'هل له اقارب بالعمل ',
  `relatives_details` varchar(600) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'تفاصيل الاقارب بالعمل',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `work_start_date` date DEFAULT NULL COMMENT 'تاريخ بدء العمل للموظف',
  `functional_status` enum('Employee','Unemployed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Employee' COMMENT 'حالة الموظف',
  `department_id` bigint UNSIGNED NOT NULL,
  `job_categories_id` bigint UNSIGNED DEFAULT NULL,
  `has_attendance` enum('Yes','No') COLLATE utf8mb4_unicode_ci DEFAULT 'Yes' COMMENT 'هل ملزم الموظف بعمل بصمه حضور وانصراف',
  `has_fixed_shift` enum('Yes','No') COLLATE utf8mb4_unicode_ci DEFAULT 'Yes' COMMENT 'هل للموظف شفت ثابت',
  `shift_types_id` bigint UNSIGNED DEFAULT NULL,
  `daily_work_hour` decimal(20,2) DEFAULT NULL COMMENT 'عدد ساعات العمل للموظف وهذا في حالة ان ليس له شفت ثابت',
  `salary` decimal(20,2) DEFAULT '0.00' COMMENT 'راتب الموظف',
  `day_price` decimal(10,2) DEFAULT NULL COMMENT 'سعر يوم الموظف',
  `motivation_type` enum('Changeable','None','Fixed') COLLATE utf8mb4_unicode_ci DEFAULT 'Fixed' COMMENT 'صفر لايوجد - واحد ثابت - اثنين متغير',
  `motivation` decimal(20,2) DEFAULT '0.00' COMMENT 'قيمة الحافز الثابت ان وجد',
  `social_insurance` enum('Yes','No') COLLATE utf8mb4_unicode_ci DEFAULT 'Yes' COMMENT 'هل للموظف تأمين اجتماعي',
  `social_insurance_cut_monthely` decimal(20,2) DEFAULT NULL COMMENT '  قيمة استقطاع التأمين الاجتماعي الشهري للموظف',
  `social_insurance_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `medical_insurance` enum('Yes','No') COLLATE utf8mb4_unicode_ci DEFAULT 'Yes' COMMENT 'هل للموظف تأمين طبي',
  `medical_insurance_cut_monthely` decimal(20,2) DEFAULT NULL COMMENT '  قيمة استقطاع التأمين الطبي الشهري للموظف',
  `medical_insurance_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Type_salary_receipt` enum('Cach','Visa') COLLATE utf8mb4_unicode_ci DEFAULT 'Visa' COMMENT 'نوع صرف الراتب - واحد كاش - اثنين فيزا بنكي',
  `active_vacation` enum('Yes','No') COLLATE utf8mb4_unicode_ci DEFAULT 'Yes' COMMENT 'هل هذا الموظف ينزل له رصيد اجازات	',
  `urgent_person_details` varchar(600) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'تفاصيل شخص يمكن الرجوع اليه للوصول للموظف',
  `staies_address` text COLLATE utf8mb4_unicode_ci COMMENT 'عنوان الاقامة الفعلي للموظف',
  `children_number` int DEFAULT '0',
  `social_status` enum('Divorced','Married','Single','Widowed') COLLATE utf8mb4_unicode_ci DEFAULT 'Single' COMMENT 'الحالة الاجتماعية',
  `resignation_id` bigint UNSIGNED DEFAULT NULL,
  `bank_number_account` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'رقم حساب البنك للموظف',
  `disabilities` enum('Yes','No') COLLATE utf8mb4_unicode_ci DEFAULT 'Yes' COMMENT 'هل له اعاقة  - واحد يوجد صفر لايوجد',
  `disabilities_type` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'نوع الاعاقة',
  `nationality_id` bigint UNSIGNED DEFAULT NULL,
  `name_sponsor` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'اسم الكفيل ',
  `pasport_identity` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'رقم الباسبور ان وجد',
  `pasport_from_place` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'مكان استخراج الباسبور',
  `pasport_exp_date` date DEFAULT NULL COMMENT 'تاريخ انتهاء الباسبور',
  `num_vacation_days` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'عدد ايام رصيد الأجازات',
  `add_service` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'أضافة خدمه مثل 3 سنوات تجنيد',
  `years_service` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'عدد سنوات الخدمه بالشركة',
  `cv` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_address_country` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'عنوان اقامة الموظف في بلده الام',
  `fixed_allowances` int DEFAULT '0' COMMENT 'هل له بدلات ثابته',
  `is_done_Vacation_formula` tinyint DEFAULT '0' COMMENT 'هل تمت المعادله التلقائية لاحتساب الرصيد السنوي للموظف',
  `is_Sensitive_manager_data` tinyint DEFAULT '0' COMMENT 'هل بيانات حساساه للمديرين مثلا ولاتظهر الا بصلاحيات خاصة	',
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `employee_code`, `fp_code`, `name`, `gender`, `branch_id`, `job_grade_id`, `qualification_id`, `qualification_year`, `major`, `graduation_estimate`, `brith_date`, `national_id`, `end_national_id`, `national_id_place`, `blood_types_id`, `religion`, `language_id`, `email`, `country_id`, `governorate_id`, `city_id`, `home_telephone`, `work_telephone`, `mobile`, `military`, `military_date_from`, `military_date_to`, `military_wepon`, `military_exemption_date`, `military_exemption_reason`, `military_postponement_reason`, `date_resignation`, `resignation_reason`, `driving_license`, `driving_license_type`, `driving_License_id`, `has_relatives`, `relatives_details`, `notes`, `work_start_date`, `functional_status`, `department_id`, `job_categories_id`, `has_attendance`, `has_fixed_shift`, `shift_types_id`, `daily_work_hour`, `salary`, `day_price`, `motivation_type`, `motivation`, `social_insurance`, `social_insurance_cut_monthely`, `social_insurance_number`, `medical_insurance`, `medical_insurance_cut_monthely`, `medical_insurance_number`, `Type_salary_receipt`, `active_vacation`, `urgent_person_details`, `staies_address`, `children_number`, `social_status`, `resignation_id`, `bank_number_account`, `disabilities`, `disabilities_type`, `nationality_id`, `name_sponsor`, `pasport_identity`, `pasport_from_place`, `pasport_exp_date`, `num_vacation_days`, `add_service`, `years_service`, `cv`, `basic_address_country`, `fixed_allowances`, `is_done_Vacation_formula`, `is_Sensitive_manager_data`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(1, 2991, 2021, 'باسم إبراهيم سهيل', 'Male', 2, 1, 4, '1991', 'الهندسة', 'Fair', '2015-06-12', '81929538768061', '2025-04-03', 'Bobbychester', 6, 'Muslim', 3, 'garnet.hirthe@example.net', 5, 4, 9, '0231611689', '0227658236', '01557265752', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '70014327355133', 'Yes', NULL, NULL, '2023-04-19', 'Employee', 6, 14, 'No', 'No', 3, '12.00', '14144.47', '471.48', 'Fixed', '1876.11', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '12018 Casey Islands Apt. 576\nVandervortton, AL 25940-7196', 0, 'Widowed', NULL, '225087917', 'Yes', NULL, 4, 'Terence Wisozk', '14676329727349', 'New Ozella', '2028-07-15', NULL, NULL, NULL, NULL, NULL, 457697527, 0, 0, 4, NULL, 1, '2024-12-13 13:29:51', '2024-12-13 13:29:51'),
(2, 1819, 613, 'رشا عبدالحكيم عبدالحي', 'Female', 1, 1, 1, '1993', 'الهندسة', 'Good', '2008-09-05', '35170379220882', '2025-08-25', 'West Miller', 7, 'Muslim', 9, 'candace.green@example.org', 3, 4, 15, '0234775676', '0223606140', '01555923575', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '94386973257835', 'No', NULL, NULL, '2022-05-12', 'Employee', 6, 28, 'No', 'No', 2, '7.00', '43289.41', '1442.98', 'Fixed', '1976.58', 'Yes', '785.20', '48199251947075', 'No', NULL, NULL, 'Visa', 'No', NULL, '290 Tremblay Summit\nNorth Kaceyborough, TN 38095', 0, 'Widowed', NULL, '303491780612', 'Yes', NULL, 4, 'Prof. Mable Moen', '07643937134281', 'Greenholtville', '2028-05-13', NULL, NULL, NULL, NULL, NULL, 1640457489, 0, 0, 3, NULL, 1, '2024-12-13 13:29:51', '2024-12-13 13:29:51'),
(3, 8607, 2030, 'نور أحمد يحيى', 'Male', 3, 2, 6, '2004', 'الفيزياء', 'Fair', '2015-03-24', '07651504280848', '2025-09-09', 'Gennaroville', 3, 'Muslim', 8, 'emerson12@example.org', 4, 20, 10, '0228467217', '0236424196', '01132441237', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '97878428786292', 'No', NULL, NULL, '2020-09-26', 'Employee', 1, 22, 'No', 'No', 4, '11.00', '39810.10', '1327.00', 'Fixed', '1045.44', 'Yes', '735.10', '59831519108173', 'No', NULL, NULL, 'Visa', 'No', NULL, '32996 Jeanette Extension Suite 602\nPort Caseyland, MO 43829-9612', 0, 'Widowed', NULL, '212727929170', 'Yes', NULL, 1, 'Prof. Mack Hand Jr.', '75257934182600', 'South Deondreberg', '2025-10-06', NULL, NULL, NULL, NULL, NULL, 52161291, 0, 0, 4, NULL, 1, '2024-12-13 13:29:51', '2024-12-13 13:29:51'),
(4, 6507, 427, 'جميلة أيمن جواد', 'Female', 4, 4, 4, '1999', 'الهندسة', 'Excellent', '2016-03-07', '72507881090934', '2028-04-29', 'Shanafurt', 1, 'Christian', 9, 'vkohler@example.org', 6, 17, 3, '0220133140', '0239386987', '01505294551', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '51170555530629', 'No', NULL, NULL, '2022-04-20', 'Employee', 9, 1, 'No', 'Yes', 2, '12.00', '22077.27', '735.91', 'Changeable', NULL, 'Yes', '609.51', '64668632889436', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '9654 Boehm Pike Apt. 151\nWest Shanachester, CT 83170', 0, 'Divorced', NULL, '960164998006315', 'Yes', NULL, 5, 'Heaven Ernser', '36699753572767', 'Lubowitzville', '2026-10-26', NULL, NULL, NULL, NULL, NULL, 1676725160, 0, 0, 3, NULL, 1, '2024-12-13 13:29:51', '2024-12-13 13:29:51'),
(5, 7729, 1644, 'باسل زياد أكرم', 'Male', 4, 1, 4, '2003', 'الهندسة', 'Good', '2011-06-09', '38197362180514', '2028-09-11', 'Jenkinsstad', 1, 'Muslim', 4, 'hillary.schuppe@example.com', 2, 9, 5, '0229469750', '0226511669', '01011254785', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '54489626558508', 'No', NULL, NULL, '2024-05-12', 'Employee', 9, 3, 'Yes', 'Yes', 2, '10.00', '33125.39', '1104.18', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '948.18', '06314729309720', 'Visa', 'No', NULL, '3499 Aileen Glen Suite 136\nNorth Anibalton, NV 29129-3164', 0, 'Single', NULL, '494134744244', 'Yes', NULL, 1, 'Veronica Gutkowski', '55045860104070', 'South Darrenville', '2026-11-12', NULL, NULL, NULL, NULL, NULL, 1093571190, 0, 0, 2, NULL, 1, '2024-12-13 13:29:51', '2024-12-13 13:29:51'),
(6, 6372, 2379, 'زين أنس منصور', 'Male', 2, 2, 4, '1998', 'الرياضيات', 'Very_Good', '2000-03-24', '03745960717408', '2025-06-21', 'South Bertram', 2, 'Muslim', 11, 'cody.hegmann@example.org', 6, 18, 11, '0231513041', '0227144611', '01222305039', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '95729580867928', 'No', NULL, NULL, '2023-02-05', 'Employee', 1, 29, 'Yes', 'Yes', 4, '9.00', '30614.17', '1020.47', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '1209 Morissette Mill Apt. 439\nFlatleyborough, LA 19560-0165', 0, 'Widowed', NULL, '9329952618', 'Yes', NULL, 4, 'Prof. Kim Considine Jr.', '98820928238982', 'Wilkinsonview', '2028-11-02', NULL, NULL, NULL, NULL, NULL, 1162337880, 0, 0, 2, NULL, 1, '2024-12-13 13:29:51', '2024-12-13 13:29:51'),
(7, 6868, 1895, 'كارما أحمد بدر', 'Female', 3, 1, 1, '1991', 'إدارة الأعمال', 'Fair', '2007-05-07', '68995828481762', '2028-04-07', 'Tillmanchester', 5, 'Christian', 13, 'eric.murray@example.org', 3, 11, 5, '0236597935', '0226591803', '01299256074', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '45899680447402', 'No', NULL, NULL, '2023-11-27', 'Employee', 10, 1, 'No', 'No', 2, '10.00', '48394.38', '1613.15', 'Fixed', '1407.61', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '8299 Morton Cape\nMadelynnhaven, WY 80142-6487', 0, 'Widowed', NULL, '07358154504', 'Yes', NULL, 1, 'Savanah Runolfsdottir', '62051249111058', 'Jaskolskifort', '2027-09-06', NULL, NULL, NULL, NULL, NULL, 1622780414, 0, 0, 2, NULL, 1, '2024-12-13 13:29:51', '2024-12-13 13:29:51'),
(8, 3284, 2336, 'نادر رامز نور', 'Male', 2, 3, 5, '1978', 'الفيزياء', 'Good', '2017-08-28', '33864997569396', '2029-01-01', 'Mannchester', 3, 'Muslim', 13, 'abatz@example.org', 5, 10, 11, '0232916095', '0234176775', '01174593407', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '96686627014179', 'Yes', NULL, NULL, '2023-01-08', 'Employee', 2, 16, 'Yes', 'No', 2, '11.00', '8853.18', '295.11', 'Fixed', '1187.22', 'No', NULL, NULL, 'Yes', '907.03', '83147678955805', 'Cach', 'No', NULL, '405 Wilkinson Inlet Suite 690\nMarqueschester, WI 63134-1370', 0, 'Widowed', NULL, '0744611660988', 'Yes', NULL, 6, 'Floy Reilly', '40146524674277', 'Lake Waylon', '2026-08-22', NULL, NULL, NULL, NULL, NULL, 1086744459, 0, 0, 1, NULL, 1, '2024-12-13 13:29:51', '2024-12-13 13:29:51'),
(9, 9329, 210, 'ميس أمجد رائد', 'Female', 2, 4, 2, '1970', 'الفيزياء', 'Fair', '2021-05-11', '51967434523896', '2027-07-01', 'Jeremiemouth', 1, 'Muslim', 10, 'braun.franz@example.net', 2, 24, 13, '0229756895', '0231248108', '01505113118', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '37867282343833', 'No', NULL, NULL, '2022-04-11', 'Employee', 9, 23, 'No', 'No', 2, '8.00', '23452.49', '781.75', 'Fixed', '1812.09', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '33520 Bradly Landing\nSanfordchester, CT 60928', 0, 'Single', NULL, '73811637738', 'Yes', NULL, 6, 'Ashly Hackett', '12689145160078', 'Schulistport', '2026-12-19', NULL, NULL, NULL, NULL, NULL, 1133378123, 0, 0, 2, NULL, 1, '2024-12-13 13:29:51', '2024-12-13 13:29:51'),
(10, 1836, 2630, 'فريدة جواد عبدالرزاق', 'Female', 2, 1, 2, '1986', 'علوم الحاسوب', 'Fair', '2000-04-23', '51092163066347', '2025-07-27', 'Port Hillard', 3, 'Muslim', 6, 'ebert.carmel@example.net', 1, 24, 1, '0236673778', '0228814710', '01551246839', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '70318580157072', 'Yes', NULL, NULL, '2020-10-07', 'Employee', 2, 17, 'Yes', 'Yes', 2, '7.00', '13331.66', '444.39', 'Fixed', '1372.84', 'No', NULL, NULL, 'Yes', '660.19', '10025986944204', 'Visa', 'No', NULL, '7962 Delbert Isle\nNorth Javonteside, NE 69283-3624', 0, 'Divorced', NULL, '85932726878964', 'Yes', NULL, 3, 'Peyton Glover', '83577520772373', 'East Jadon', '2026-07-17', NULL, NULL, NULL, NULL, NULL, 1047761805, 0, 0, 2, NULL, 1, '2024-12-13 13:29:51', '2024-12-13 13:29:51'),
(11, 9647, 914, 'عدنان رشيد عبدالباسط', 'Male', 4, 2, 2, '1990', 'إدارة الأعمال', 'Good', '1999-12-31', '40112267785267', '2025-06-11', 'Christophechester', 6, 'Muslim', 4, 'elenora.ortiz@example.net', 1, 16, 14, '0225169490', '0236932198', '01052572701', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '77979056133034', 'No', NULL, NULL, '2024-01-16', 'Employee', 5, 21, 'Yes', 'Yes', 1, '11.00', '30278.49', '1009.28', 'Changeable', NULL, 'Yes', '997.24', '08526114331397', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '618 Wilderman Highway Suite 585\nSouth Timothychester, SC 24078', 0, 'Single', NULL, '263103061', 'Yes', NULL, 3, 'Dr. Stacey Mills IV', '77204604117957', 'Autumnport', '2029-03-10', NULL, NULL, NULL, NULL, NULL, 1509274608, 0, 0, 3, NULL, 1, '2024-12-13 13:29:51', '2024-12-13 13:29:51'),
(12, 8241, 1866, 'فرح بكر عمار', 'Female', 1, 3, 5, '1994', 'علوم الحاسوب', 'Excellent', '2014-12-16', '67968661228163', '2029-11-07', 'New Stevie', 3, 'Muslim', 3, 'schaden.denis@example.net', 4, 23, 3, '0228701562', '0231430901', '01060344247', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '08817268624120', 'No', NULL, NULL, '2023-01-06', 'Employee', 4, 28, 'No', 'Yes', 1, '7.00', '48635.96', '1621.20', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '19383 Leffler Dale\nEmardborough, AL 06281', 0, 'Single', NULL, '38523761753', 'Yes', NULL, 4, 'Tyrique O\'Keefe III', '55134518046852', 'Hansenburgh', '2027-08-20', NULL, NULL, NULL, NULL, NULL, 372570317, 0, 0, 2, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(13, 7765, 2230, 'رائد علي شاكر', 'Male', 4, 2, 2, '2013', 'علم الأحياء', 'Fair', '2015-06-22', '57298996859990', '2026-03-18', 'Grahambury', 1, 'Muslim', 7, 'tia.breitenberg@example.net', 2, 9, 6, '0226331904', '0233903691', '01277898207', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '36194376065430', 'Yes', NULL, NULL, '2023-05-20', 'Employee', 8, 1, 'No', 'Yes', 4, '10.00', '41387.09', '1379.57', 'Fixed', '1409.57', 'Yes', '575.30', '21292013112514', 'No', NULL, NULL, 'Cach', 'No', NULL, '60790 Adams Throughway\nDenesikshire, SD 95719-7374', 0, 'Married', NULL, '11454757685273', 'Yes', NULL, 1, 'Rae Bartell', '41526308092233', 'South Kearamouth', '2028-11-17', NULL, NULL, NULL, NULL, NULL, 1624148203, 0, 0, 4, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(14, 2455, 1468, 'آية معاذ سالم', 'Female', 2, 1, 3, '1998', 'إدارة الأعمال', 'Excellent', '2019-03-18', '21209759872522', '2026-02-17', 'West Newton', 6, 'Muslim', 8, 'humberto53@example.com', 3, 15, 13, '0222700745', '0238268506', '01230343330', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '57775117161634', 'No', NULL, NULL, '2020-03-20', 'Employee', 9, 16, 'Yes', 'Yes', 2, '12.00', '24332.00', '811.07', 'Fixed', '1187.92', 'No', NULL, NULL, 'Yes', '809.83', '19057210919755', 'Visa', 'Yes', NULL, '37183 Walter Gardens\nCummingsfort, MT 53343', 0, 'Single', NULL, '69136679262541', 'Yes', NULL, 5, 'Rey Fisher', '62967430454353', 'South Lelah', '2028-08-02', NULL, NULL, NULL, NULL, NULL, 558071399, 0, 0, 3, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(15, 2220, 1026, 'جوري باسم راغب', 'Female', 2, 2, 5, '2014', 'علوم الحاسوب', 'Very_Good', '2018-04-26', '58808104434872', '2026-04-13', 'Lake Antwon', 4, 'Christian', 13, 'pierre.feest@example.com', 2, 19, 8, '0231849265', '0223765036', '01064029441', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '04424436374040', 'Yes', NULL, NULL, '2022-10-20', 'Employee', 7, 8, 'Yes', 'No', 4, '12.00', '8240.39', '274.68', 'Fixed', '1881.26', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '3270 John Mill Suite 179\nWest Joanny, AL 79671-8057', 0, 'Married', NULL, '66911871101', 'Yes', NULL, 4, 'Nova Marquardt', '91459297011537', 'Kenyattabury', '2026-07-07', NULL, NULL, NULL, NULL, NULL, 1201187256, 0, 0, 2, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(16, 8163, 1397, 'حذيفة رامز حامد', 'Male', 1, 1, 6, '1999', 'الهندسة', 'Very_Good', '2008-06-25', '78238747937458', '2026-07-27', 'Rosinaton', 1, 'Christian', 8, 'alvera.yost@example.org', 2, 21, 14, '0226868623', '0230035513', '01590159983', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '67833659030784', 'No', NULL, NULL, '2024-10-11', 'Employee', 10, 23, 'Yes', 'Yes', 2, '10.00', '22382.42', '746.08', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '46550 Berneice Corners Suite 339\nPort Roxane, NH 76103-6464', 0, 'Single', NULL, '5453799177362', 'Yes', NULL, 3, 'Genevieve Harvey I', '44985511138967', 'Bednarville', '2025-07-22', NULL, NULL, NULL, NULL, NULL, 582266741, 0, 0, 4, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(17, 6961, 1667, 'سارة مالك عبدالعزيز', 'Female', 4, 2, 3, '1984', 'إدارة الأعمال', 'Good', '2012-09-01', '98656474301103', '2026-08-17', 'North Rafaelshire', 4, 'Christian', 10, 'freddie.treutel@example.net', 6, 18, 11, '0228151450', '0236354380', '01087825035', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '31215272974952', 'No', NULL, NULL, '2022-11-29', 'Employee', 1, 21, 'Yes', 'No', 3, '9.00', '18648.05', '621.60', 'Changeable', NULL, 'Yes', '800.90', '55398975411039', 'Yes', '670.94', '04336182439449', 'Cach', 'Yes', NULL, '6093 Jimmy Walk\nAndersonside, IA 49895-9846', 0, 'Single', NULL, '94441032853', 'Yes', NULL, 1, 'Mr. Edmund Considine', '75086967105754', 'South Riley', '2028-05-27', NULL, NULL, NULL, NULL, NULL, 998141177, 0, 0, 1, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(18, 3814, 1390, 'روى لؤي علي', 'Female', 2, 1, 1, '1997', 'إدارة الأعمال', 'Fair', '2003-05-04', '99799908678122', '2026-10-09', 'Tyrafort', 1, 'Christian', 7, 'ward.lennie@example.net', 3, 4, 12, '0234239055', '0237307638', '01201307824', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '88522431475749', 'Yes', NULL, NULL, '2022-05-01', 'Employee', 5, 10, 'No', 'No', 4, '7.00', '36957.50', '1231.92', 'Fixed', '1105.72', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '446 Rossie Vista Suite 782\nLake Yesenia, NV 22669-7466', 0, 'Widowed', NULL, '7441073864376', 'Yes', NULL, 3, 'Fannie Jones', '40778570349802', 'East Rowenabury', '2026-11-16', NULL, NULL, NULL, NULL, NULL, 2094187164, 0, 0, 4, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(19, 1063, 1734, 'أماني عبدالرزاق رفيق', 'Female', 4, 1, 4, '2012', 'الهندسة', 'Excellent', '2008-07-30', '03451250564268', '2025-10-28', 'South Margret', 2, 'Christian', 5, 'jerrell55@example.org', 6, 23, 15, '0230527838', '0239511145', '01571443381', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '11871413230155', 'No', NULL, NULL, '2021-04-08', 'Employee', 1, 27, 'No', 'No', 4, '10.00', '26528.15', '884.27', 'Fixed', '1792.55', 'No', NULL, NULL, 'Yes', '882.48', '10191871213062', 'Cach', 'Yes', NULL, '5057 Hartmann Branch\nPort Destinchester, MT 98667-6759', 0, 'Married', NULL, '6276366', 'Yes', NULL, 1, 'Destinee Lindgren', '45319894816986', 'Lyricton', '2029-03-16', NULL, NULL, NULL, NULL, NULL, 385451273, 0, 0, 4, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(20, 3936, 2543, 'حذيفة بدر مازن', 'Male', 2, 1, 5, '1978', 'الهندسة', 'Fair', '2004-11-09', '85717524207046', '2027-02-20', 'Larkinberg', 3, 'Christian', 12, 'bryana.dietrich@example.net', 3, 3, 15, '0226975568', '0221455246', '01010548080', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '58909738550259', 'No', NULL, NULL, '2022-08-06', 'Employee', 10, 8, 'No', 'Yes', 4, '10.00', '37720.29', '1257.34', 'Fixed', '1755.47', 'Yes', '781.37', '21533045022825', 'Yes', '584.34', '83056116907802', 'Visa', 'Yes', NULL, '5711 Feest Key\nWolfburgh, WI 68629-9230', 0, 'Single', NULL, '64794433', 'Yes', NULL, 1, 'Valentin Stanton', '52981174203302', 'West Ravenmouth', '2025-04-20', NULL, NULL, NULL, NULL, NULL, 667017709, 0, 0, 2, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(21, 1038, 1360, 'شهد عمار سامر', 'Female', 4, 2, 5, '1990', 'الفيزياء', 'Fair', '2018-07-19', '59886418194570', '2025-02-12', 'Port Wilma', 4, 'Muslim', 10, 'yvette21@example.com', 1, 14, 11, '0226581768', '0239291181', '01184799657', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '96279457014027', 'Yes', NULL, NULL, '2021-04-24', 'Employee', 3, 8, 'No', 'Yes', 4, '9.00', '47871.44', '1595.71', 'Fixed', '1747.01', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '73996 Abbott Corner\nSouth Cierra, UT 53235-7819', 0, 'Married', NULL, '867914', 'Yes', NULL, 5, 'Mr. Neal Rempel', '10778722146635', 'South Liam', '2027-10-11', NULL, NULL, NULL, NULL, NULL, 1009690301, 0, 0, 3, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(22, 8895, 354, 'حمزة زيد أنور', 'Male', 2, 4, 6, '1997', 'إدارة الأعمال', 'Fair', '2014-06-24', '95376194103022', '2026-03-12', 'Allieborough', 5, 'Muslim', 8, 'timmothy51@example.com', 6, 9, 5, '0222057852', '0228909593', '01050253088', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '16710580223767', 'Yes', NULL, NULL, '2020-02-11', 'Employee', 1, 7, 'No', 'Yes', 2, '11.00', '32915.66', '1097.19', 'Changeable', NULL, 'Yes', '822.96', '03008246087368', 'No', NULL, NULL, 'Cach', 'No', NULL, '92149 Hyman Mill\nPort Jackelinemouth, AL 80169-0405', 0, 'Divorced', NULL, '691982', 'Yes', NULL, 4, 'Ms. Joelle Hoppe', '17809125684581', 'New Leonetown', '2026-12-22', NULL, NULL, NULL, NULL, NULL, 497510318, 0, 0, 2, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(23, 9191, 2592, 'هند عامر صهيب', 'Female', 4, 2, 6, '2006', 'الفيزياء', 'Fair', '2009-05-09', '52921119453008', '2024-12-30', 'Margiemouth', 6, 'Muslim', 2, 'zabbott@example.com', 6, 6, 14, '0224415473', '0226391812', '01026707017', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '06859630910130', 'No', NULL, NULL, '2022-10-05', 'Employee', 7, 14, 'No', 'Yes', 4, '9.00', '24114.38', '803.81', 'Changeable', NULL, 'Yes', '808.13', '36783167992246', 'Yes', '741.39', '79272050110741', 'Visa', 'No', NULL, '8952 Colleen Glen Apt. 926\nEast Chaunceyville, IN 93901-4432', 0, 'Widowed', NULL, '0085085858096', 'Yes', NULL, 5, 'Heloise Shields', '43776937126629', 'Russelhaven', '2028-06-04', NULL, NULL, NULL, NULL, NULL, 217793295, 0, 0, 4, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(24, 3978, 1399, 'ثامر زيد منصور', 'Male', 2, 1, 4, '1971', 'الهندسة', 'Excellent', '2005-04-14', '84861286066999', '2026-09-04', 'Lake Hattieport', 6, 'Muslim', 5, 'toy.buford@example.org', 6, 5, 11, '0236940256', '0228626763', '01500508588', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '90705404943353', 'Yes', NULL, NULL, '2020-11-21', 'Employee', 2, 16, 'No', 'Yes', 1, '11.00', '36341.62', '1211.39', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '99400 Twila Pike\nEast Nevaville, DE 32379-0227', 0, 'Married', NULL, '435552625411181', 'Yes', NULL, 1, 'Maymie Morissette', '34823525732045', 'New Marcelinabury', '2026-06-13', NULL, NULL, NULL, NULL, NULL, 604613944, 0, 0, 1, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(25, 7381, 1280, 'رباب عامر عبداللطيف', 'Female', 2, 4, 2, '1988', 'علوم الحاسوب', 'Fair', '2020-01-02', '36962352666453', '2029-02-16', 'Cliffordport', 4, 'Muslim', 10, 'uglover@example.com', 2, 1, 11, '0233708391', '0225734881', '01070728866', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '97449312571357', 'Yes', NULL, NULL, '2023-09-21', 'Employee', 2, 1, 'Yes', 'No', 1, '7.00', '45303.70', '1510.12', 'Changeable', NULL, 'Yes', '841.29', '46924282427141', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '856 Nader Landing Apt. 233\nWest Berniemouth, FL 79529-8355', 0, 'Divorced', NULL, '898677', 'Yes', NULL, 6, 'Abagail Cormier', '59033044058206', 'Rempelside', '2028-07-10', NULL, NULL, NULL, NULL, NULL, 908335196, 0, 0, 2, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(26, 5349, 2279, 'أنس وجيه مهند', 'Male', 2, 2, 5, '1992', 'إدارة الأعمال', 'Fair', '2018-11-24', '04505391501202', '2025-04-22', 'North Myriam', 4, 'Christian', 9, 'wisozk.kaylin@example.org', 6, 5, 12, '0222857518', '0224383725', '01161983561', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '86750310754477', 'No', NULL, NULL, '2019-12-29', 'Employee', 6, 4, 'Yes', 'Yes', 2, '7.00', '24968.07', '832.27', 'Fixed', '1242.10', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '43937 Murazik Center\nKeyshawnmouth, MT 65852-1132', 0, 'Married', NULL, '52510937', 'Yes', NULL, 6, 'Prof. Mayra Gleichner I', '42173673246003', 'East Jordane', '2026-06-07', NULL, NULL, NULL, NULL, NULL, 1339778492, 0, 0, 2, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(27, 9146, 2391, 'هند إسماعيل أحمد', 'Female', 1, 4, 5, '1991', 'علم الأحياء', 'Good', '2000-02-29', '32412668761394', '2029-04-11', 'Heathcotefort', 2, 'Christian', 4, 'ressie.heller@example.org', 4, 16, 8, '0231502446', '0230461452', '01557385053', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '71705035745813', 'No', NULL, NULL, '2022-10-27', 'Employee', 8, 18, 'No', 'No', 1, '12.00', '27011.84', '900.39', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '989.33', '25914249105115', 'Visa', 'No', NULL, '8053 Davis Corner Suite 996\nNorth Shadborough, HI 57676', 0, 'Widowed', NULL, '428655403269', 'Yes', NULL, 5, 'Willard Ortiz', '72606654444373', 'West Vanceland', '2029-04-16', NULL, NULL, NULL, NULL, NULL, 203016500, 0, 0, 3, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(28, 8831, 1960, 'فريدة عمر نور', 'Female', 1, 1, 2, '2011', 'الهندسة', 'Very_Good', '2010-12-09', '95448786694853', '2029-02-28', 'East Flossieborough', 6, 'Muslim', 9, 'andrew36@example.net', 5, 8, 4, '0236277112', '0238254832', '01250636976', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '99968053361511', 'No', NULL, NULL, '2022-05-20', 'Employee', 4, 2, 'Yes', 'No', 3, '10.00', '12458.65', '415.29', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '183 Arnaldo Parks\nPort Bart, CO 90715-0000', 0, 'Single', NULL, '031778849', 'Yes', NULL, 6, 'Mr. Barney Volkman I', '53552274100093', 'Altaberg', '2026-07-12', NULL, NULL, NULL, NULL, NULL, 456650462, 0, 0, 4, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(29, 6777, 1707, 'ريم سامر وائل', 'Female', 2, 4, 6, '2011', 'الهندسة', 'Fair', '2003-12-11', '41571601402812', '2028-05-14', 'North Ernestinastad', 2, 'Muslim', 2, 'stacey92@example.net', 2, 5, 15, '0221283288', '0231496869', '01567413188', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '44119215705132', 'No', NULL, NULL, '2021-12-07', 'Employee', 8, 11, 'Yes', 'Yes', 4, '11.00', '15235.50', '507.85', 'Fixed', '1147.48', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '4157 Leuschke Creek\nFletamouth, CT 51902', 0, 'Widowed', NULL, '53742746462010', 'Yes', NULL, 5, 'Dante Donnelly III', '38888835873170', 'Abdulborough', '2027-05-15', NULL, NULL, NULL, NULL, NULL, 475636985, 0, 0, 4, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(30, 3883, 2836, 'وجيه رياض يوسف', 'Male', 2, 1, 4, '1999', 'الفيزياء', 'Excellent', '2006-03-29', '08973989724719', '2029-06-09', 'Loweberg', 1, 'Muslim', 11, 'turner.priscilla@example.net', 4, 11, 14, '0228734022', '0238851259', '01044420251', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '94982735859311', 'No', NULL, NULL, '2024-06-08', 'Employee', 5, 19, 'No', 'No', 3, '7.00', '33569.95', '1119.00', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '4624 Kathleen Fork Apt. 580\nCroninmouth, TN 08627-8964', 0, 'Single', NULL, '4271119', 'Yes', NULL, 3, 'Prof. Anna Fritsch III', '31478195583103', 'South Rosalind', '2028-12-14', NULL, NULL, NULL, NULL, NULL, 1125887418, 0, 0, 1, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(31, 4908, 1838, 'سليمان إبراهيم باسم', 'Male', 1, 1, 3, '1975', 'الرياضيات', 'Good', '2022-08-06', '90681992721975', '2025-04-10', 'South Malvinastad', 6, 'Christian', 8, 'jane.rohan@example.com', 4, 19, 4, '0231353569', '0232842593', '01074564838', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '45680604632388', 'No', NULL, NULL, '2020-08-23', 'Employee', 8, 11, 'Yes', 'Yes', 2, '7.00', '36336.59', '1211.22', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '693.94', '99947227094668', 'Cach', 'No', NULL, '261 Maximillia Stream Apt. 500\nNorth Chanelchester, NE 86726-9997', 0, 'Married', NULL, '512685537', 'Yes', NULL, 4, 'Anastasia Gaylord', '57869311751142', 'Adityaburgh', '2029-08-04', NULL, NULL, NULL, NULL, NULL, 1394464299, 0, 0, 1, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(32, 5496, 2331, 'ماريا نبيل إلياس', 'Female', 2, 1, 5, '1992', 'إدارة الأعمال', 'Good', '2012-04-28', '93627571863834', '2028-05-29', 'Port Elsietown', 2, 'Muslim', 5, 'jtreutel@example.net', 6, 23, 2, '0224527118', '0229339569', '01537083311', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '44290973959493', 'No', NULL, NULL, '2024-06-10', 'Employee', 5, 7, 'No', 'Yes', 4, '12.00', '37314.77', '1243.83', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '5844 Virginia Lake\nWillmouth, MT 58805-9008', 0, 'Divorced', NULL, '4822334683', 'Yes', NULL, 3, 'Keara Cronin', '59961341789578', 'Reingerport', '2026-08-29', NULL, NULL, NULL, NULL, NULL, 299905883, 0, 0, 2, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(33, 3224, 361, 'منى جمال حسن', 'Female', 2, 4, 2, '1993', 'الفيزياء', 'Good', '2000-06-04', '83135819763686', '2025-04-27', 'Donnellyland', 3, 'Christian', 11, 'iherzog@example.org', 4, 11, 3, '0230663120', '0220190832', '01293168152', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '70726081766686', 'No', NULL, NULL, '2020-12-30', 'Employee', 5, 25, 'No', 'Yes', 2, '8.00', '38125.05', '1270.84', 'Fixed', '1294.11', 'No', NULL, NULL, 'Yes', '797.78', '15059487788067', 'Visa', 'Yes', NULL, '245 Elinor Unions Apt. 973\nGabriellefurt, OK 15572', 0, 'Divorced', NULL, '374403863', 'Yes', NULL, 2, 'Erich Thiel', '44579571744012', 'Port Amiraport', '2027-04-08', NULL, NULL, NULL, NULL, NULL, 622010469, 0, 0, 3, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(34, 3242, 2798, 'جمانة سعيد محمود', 'Female', 1, 3, 5, '1996', 'الفيزياء', 'Good', '2012-06-15', '22377339277585', '2028-12-24', 'Ankundingview', 6, 'Muslim', 9, 'kunde.celia@example.org', 3, 24, 5, '0230296923', '0229756902', '01229877018', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '19529288407935', 'Yes', NULL, NULL, '2021-04-04', 'Employee', 8, 6, 'No', 'No', 4, '7.00', '44370.20', '1479.01', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '769.85', '45486542420506', 'Cach', 'Yes', NULL, '806 Batz Field\nNew Lilyan, NH 74902', 0, 'Single', NULL, '7672571881', 'Yes', NULL, 2, 'Jazmyne Heaney', '62116595601891', 'South Kayla', '2025-02-25', NULL, NULL, NULL, NULL, NULL, 1752350881, 0, 0, 3, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(35, 7363, 2509, 'فريدة أكرم رائد', 'Female', 1, 1, 4, '1979', 'إدارة الأعمال', 'Good', '2012-04-02', '68676970745237', '2025-02-04', 'Daughertyton', 3, 'Muslim', 8, 'elda.hessel@example.com', 6, 20, 3, '0224961812', '0225484668', '01208939482', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '82166429056221', 'No', NULL, NULL, '2021-07-09', 'Employee', 4, 3, 'Yes', 'Yes', 1, '7.00', '22467.77', '748.93', 'Changeable', NULL, 'Yes', '715.87', '65457990282849', 'Yes', '931.78', '47276995584968', 'Visa', 'No', NULL, '805 Kilback Green\nPort Naomi, OH 85050', 0, 'Single', NULL, '428787491', 'Yes', NULL, 3, 'Carmel Muller', '06938491965160', 'Port Will', '2029-08-30', NULL, NULL, NULL, NULL, NULL, 1365537266, 0, 0, 2, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(36, 9497, 1373, 'دنيا فارس باسم', 'Female', 2, 2, 2, '2001', 'علم الأحياء', 'Excellent', '2000-05-12', '23792851723484', '2025-12-28', 'Leannonfurt', 4, 'Christian', 7, 'mkling@example.com', 1, 27, 4, '0229831345', '0221683262', '01054735481', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '12635268535061', 'Yes', NULL, NULL, '2020-02-13', 'Employee', 1, 19, 'No', 'No', 1, '7.00', '12570.74', '419.02', 'Fixed', '1546.21', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '78001 Michaela Streets Suite 373\nEast Macishire, MD 93295-3827', 0, 'Divorced', NULL, '8199201622', 'Yes', NULL, 5, 'Miss Daphne Lindgren Jr.', '57088177273663', 'West Dorothyfort', '2027-08-15', NULL, NULL, NULL, NULL, NULL, 2052929211, 0, 0, 1, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(37, 5516, 1107, 'هيفاء جواد وجيه', 'Female', 3, 1, 3, '2000', 'الفيزياء', 'Very_Good', '2006-02-25', '10476232692491', '2029-08-29', 'New Ubaldo', 4, 'Christian', 11, 'heloise.beatty@example.org', 3, 8, 15, '0226855282', '0224822991', '01103386133', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '83329719509530', 'Yes', NULL, NULL, '2021-08-12', 'Employee', 8, 1, 'No', 'Yes', 2, '12.00', '6932.88', '231.10', 'Fixed', '1453.03', 'Yes', '958.72', '87013807674196', 'Yes', '882.62', '21291904663211', 'Cach', 'No', NULL, '2281 Hyatt Plaza Apt. 210\nPort Genesismouth, OH 15081-9821', 0, 'Divorced', NULL, '738669000', 'Yes', NULL, 2, 'Prof. Haleigh Lueilwitz MD', '67361564392636', 'Jerdefurt', '2029-07-23', NULL, NULL, NULL, NULL, NULL, 439040705, 0, 0, 4, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(38, 2349, 2727, 'آية سالم رائد', 'Female', 2, 4, 6, '1990', 'الفيزياء', 'Excellent', '2017-04-22', '08408919725744', '2025-07-25', 'Quentinmouth', 2, 'Christian', 6, 'pleffler@example.org', 6, 27, 6, '0230863584', '0237175876', '01044306056', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '01747239578784', 'Yes', NULL, NULL, '2022-03-15', 'Employee', 6, 15, 'No', 'Yes', 3, '9.00', '12956.02', '431.87', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '959 Tyrel Center Suite 885\nWest Keven, MN 24322-5955', 0, 'Married', NULL, '033388124709', 'Yes', NULL, 5, 'Americo Feil', '85132374305030', 'Muellershire', '2027-03-27', NULL, NULL, NULL, NULL, NULL, 41832071, 0, 0, 1, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(39, 9180, 1656, 'شاكر باسم شريف', 'Male', 4, 1, 2, '1997', 'الرياضيات', 'Good', '2013-09-16', '30681684982318', '2028-12-10', 'Glennamouth', 6, 'Christian', 4, 'destany.glover@example.org', 5, 1, 1, '0236045600', '0230201366', '01249057986', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '32582858413537', 'Yes', NULL, NULL, '2020-07-12', 'Employee', 4, 3, 'No', 'Yes', 2, '8.00', '41725.72', '1390.86', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '6513 Diamond Burgs\nMadalynside, WA 40242', 0, 'Married', NULL, '91100081895', 'Yes', NULL, 6, 'Javon Abbott Sr.', '67780913630959', 'Sadyeberg', '2029-01-06', NULL, NULL, NULL, NULL, NULL, 1709788259, 0, 0, 4, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(40, 9628, 2208, 'بسمة نبيل سامي', 'Female', 3, 3, 5, '1978', 'علوم الحاسوب', 'Good', '2015-01-03', '89503786702961', '2025-02-10', 'Rathville', 4, 'Christian', 3, 'maude61@example.org', 2, 22, 4, '0232397281', '0230264844', '01541969447', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '75517232483175', 'Yes', NULL, NULL, '2024-04-25', 'Employee', 7, 29, 'No', 'No', 1, '12.00', '36362.00', '1212.07', 'Fixed', '1828.61', 'Yes', '745.13', '97411202647324', 'Yes', '507.03', '23204059592087', 'Visa', 'Yes', NULL, '47364 Blick Tunnel\nNew Chaya, CT 41882', 0, 'Single', NULL, '97087266', 'Yes', NULL, 5, 'Cesar Crist', '73384343495136', 'New Dale', '2029-06-13', NULL, NULL, NULL, NULL, NULL, 171158241, 0, 0, 3, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(41, 1922, 712, 'ربيع عبداللطيف شريف', 'Male', 2, 3, 6, '1986', 'علوم الحاسوب', 'Excellent', '2021-07-21', '88429147662695', '2028-03-27', 'Claraberg', 7, 'Christian', 3, 'sporer.liliana@example.org', 2, 9, 1, '0220213699', '0231679796', '01230703990', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '99005901716670', 'Yes', NULL, NULL, '2023-01-27', 'Employee', 4, 9, 'Yes', 'No', 2, '9.00', '13419.62', '447.32', 'Changeable', NULL, 'Yes', '805.34', '96826342268613', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '53604 Gardner Lane Suite 268\nFilomenaview, CT 10762', 0, 'Widowed', NULL, '0013022888', 'Yes', NULL, 2, 'Eulah Schinner', '67441857666318', 'North Ramonaton', '2026-01-25', NULL, NULL, NULL, NULL, NULL, 459669319, 0, 0, 2, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(42, 3542, 2236, 'رولا عبدالعزيز زياد', 'Female', 4, 1, 1, '2001', 'علوم الحاسوب', 'Excellent', '2008-12-24', '89556912080321', '2026-08-20', 'Port Aurelie', 3, 'Christian', 6, 'marquardt.roslyn@example.com', 4, 8, 5, '0236545190', '0229564143', '01215992047', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '46359088925183', 'Yes', NULL, NULL, '2024-09-01', 'Employee', 3, 25, 'No', 'No', 2, '11.00', '27564.25', '918.81', 'Fixed', '1106.04', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '9609 Zachery Expressway Apt. 295\nSouth Meghanburgh, RI 14520', 0, 'Married', NULL, '0319373904155516', 'Yes', NULL, 1, 'Kraig Haley', '60023543247022', 'New Wilfridburgh', '2029-01-17', NULL, NULL, NULL, NULL, NULL, 1828334923, 0, 0, 2, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(43, 1409, 904, 'آنا نور أيمن', 'Female', 3, 1, 5, '1999', 'الرياضيات', 'Good', '2016-03-20', '06667098978294', '2028-06-16', 'Kaitlinview', 5, 'Christian', 9, 'gaylord.wallace@example.com', 2, 22, 12, '0235739627', '0221028529', '01154829813', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '55153087709893', 'Yes', NULL, NULL, '2023-11-07', 'Employee', 4, 1, 'No', 'No', 3, '12.00', '29157.04', '971.90', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '9109 Alanis Trail\nNorth Orvilleborough, DC 74967-3390', 0, 'Married', NULL, '54059122335', 'Yes', NULL, 2, 'Mr. Andre Wintheiser V', '31600838552385', 'Janickside', '2026-06-20', NULL, NULL, NULL, NULL, NULL, 621657091, 0, 0, 2, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(44, 8175, 2823, 'تالين سالم سهيل', 'Female', 2, 1, 4, '1996', 'علم الأحياء', 'Excellent', '2020-02-27', '14779525130004', '2028-11-05', 'New Royal', 4, 'Christian', 12, 'hertha.hermiston@example.net', 6, 7, 4, '0233569129', '0234555827', '01504518601', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '11393408958877', 'No', NULL, NULL, '2021-09-08', 'Employee', 6, 27, 'Yes', 'No', 1, '12.00', '32896.25', '1096.54', 'Fixed', '1773.95', 'Yes', '717.27', '38269339333435', 'No', NULL, NULL, 'Cach', 'No', NULL, '28714 Salma Passage\nMichaelhaven, HI 78612-2461', 0, 'Married', NULL, '2215816975199', 'Yes', NULL, 2, 'Prof. Esther Batz Sr.', '66702492912155', 'South Lanebury', '2025-06-14', NULL, NULL, NULL, NULL, NULL, 896428764, 0, 0, 1, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(45, 9534, 1393, 'أكرم عبدالله ربيع', 'Male', 2, 1, 2, '1998', 'الرياضيات', 'Fair', '2012-10-17', '77504550031519', '2029-09-06', 'West Bertram', 7, 'Muslim', 10, 'mheaney@example.com', 2, 9, 1, '0238932118', '0230060967', '01143839589', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '81740594677470', 'No', NULL, NULL, '2023-12-03', 'Employee', 3, 28, 'Yes', 'Yes', 1, '10.00', '32247.05', '1074.90', 'Fixed', '1251.37', 'No', NULL, NULL, 'Yes', '999.60', '50199910049520', 'Cach', 'No', NULL, '9716 Marcia Ferry Suite 336\nMetzview, DE 91575-7774', 0, 'Divorced', NULL, '15583553733139', 'Yes', NULL, 1, 'London Heathcote DDS', '83178271457405', 'North Luciano', '2024-12-25', NULL, NULL, NULL, NULL, NULL, 2045304722, 0, 0, 3, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(46, 8611, 8, 'صابر أيوب شادي', 'Male', 3, 4, 2, '1990', 'إدارة الأعمال', 'Excellent', '2005-11-12', '58259199637341', '2026-02-13', 'New Reggieberg', 3, 'Muslim', 6, 'greenfelder.cecelia@example.org', 4, 21, 15, '0238354681', '0224816100', '01134983605', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '75606084291425', 'Yes', NULL, NULL, '2021-02-11', 'Employee', 5, 29, 'No', 'Yes', 2, '7.00', '37657.61', '1255.25', 'Fixed', '1240.31', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '339 Huels Radial Apt. 537\nLittlestad, NE 35299-8635', 0, 'Widowed', NULL, '906963017', 'Yes', NULL, 3, 'Tianna Mohr V', '22141566289108', 'Myronshire', '2028-10-31', NULL, NULL, NULL, NULL, NULL, 1677546867, 0, 0, 3, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(47, 2271, 2644, 'وسام سامر سهيل', 'Female', 1, 4, 4, '1985', 'الهندسة', 'Fair', '2013-02-02', '73145731355261', '2027-12-04', 'Lake Maeganfort', 7, 'Muslim', 11, 'howe.constantin@example.org', 1, 16, 9, '0238464983', '0232862110', '01049463013', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '70381609984733', 'Yes', NULL, NULL, '2021-07-01', 'Employee', 10, 3, 'Yes', 'No', 1, '10.00', '17616.99', '587.23', 'Fixed', '1544.46', 'No', NULL, NULL, 'Yes', '772.82', '16015665124416', 'Cach', 'No', NULL, '8886 Weimann Vista\nNorth Alvena, KY 10014', 0, 'Single', NULL, '47488617399', 'Yes', NULL, 2, 'Prof. Antwon Wuckert PhD', '29471955053701', 'North Reginaldfort', '2026-08-02', NULL, NULL, NULL, NULL, NULL, 1201964933, 0, 0, 1, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(48, 8622, 323, 'فاطمة مالك أمجد', 'Female', 1, 1, 6, '2004', 'الرياضيات', 'Fair', '2009-03-02', '96921282309327', '2025-01-14', 'Justinashire', 4, 'Christian', 7, 'tierra36@example.com', 4, 1, 3, '0237820553', '0238051996', '01250296915', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '83584036512647', 'Yes', NULL, NULL, '2020-10-25', 'Employee', 6, 24, 'Yes', 'No', 4, '12.00', '46734.48', '1557.82', 'Fixed', '1048.44', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '806 Clara Lane Apt. 570\nCartwrightberg, OK 68419-5764', 0, 'Widowed', NULL, '293873256354', 'Yes', NULL, 5, 'Genoveva Brekke', '14137319453921', 'Reichertton', '2029-10-24', NULL, NULL, NULL, NULL, NULL, 1882546916, 0, 0, 2, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(49, 9342, 1826, 'إلياس رفيق توفيق', 'Male', 2, 2, 1, '2005', 'علوم الحاسوب', 'Excellent', '2000-04-19', '28995336318786', '2028-11-18', 'East Caitlyn', 2, 'Muslim', 2, 'wkutch@example.org', 6, 22, 14, '0238103764', '0232306225', '01026704066', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '81048590063459', 'No', NULL, NULL, '2020-12-24', 'Employee', 10, 3, 'Yes', 'No', 4, '8.00', '22842.08', '761.40', 'Fixed', '1872.36', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '900 Evalyn Causeway Suite 930\nStammmouth, AZ 33830', 0, 'Married', NULL, '0947125914479836', 'Yes', NULL, 6, 'Ms. Tiara Emard Sr.', '92705926451048', 'VonRuedenland', '2025-06-17', NULL, NULL, NULL, NULL, NULL, 166592519, 0, 0, 3, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(50, 7064, 2982, 'حمزة عبدالحميد عبدالحكيم', 'Male', 4, 4, 6, '2007', 'الهندسة', 'Fair', '2009-06-11', '72754771548900', '2028-10-17', 'Port Mavisville', 5, 'Muslim', 10, 'jayme.crist@example.org', 6, 1, 10, '0221279949', '0237269501', '01108280060', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '25279457127158', 'Yes', NULL, NULL, '2024-10-09', 'Employee', 2, 27, 'Yes', 'No', 1, '7.00', '10665.80', '355.53', 'Changeable', NULL, 'Yes', '812.22', '91790796364410', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '727 Keebler Spring Suite 208\nNorth Gardnerchester, AZ 75782', 0, 'Widowed', NULL, '63636366290', 'Yes', NULL, 4, 'Nelda Jaskolski', '32531480293678', 'Walshview', '2026-08-21', NULL, NULL, NULL, NULL, NULL, 1955236156, 0, 0, 4, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(51, 6778, 561, 'صهيب سيف أديب', 'Male', 4, 1, 4, '2011', 'الهندسة', 'Excellent', '2022-07-05', '72547421950510', '2027-08-19', 'Quigleyburgh', 3, 'Christian', 1, 'kuhic.ransom@example.com', 1, 21, 3, '0236547293', '0236035489', '01104873998', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '54226220106250', 'No', NULL, NULL, '2022-01-30', 'Employee', 8, 23, 'Yes', 'No', 3, '10.00', '20877.35', '695.91', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '550.67', '18317891526462', 'Visa', 'No', NULL, '418 Stark Groves\nNew Deondreborough, IA 69597-2165', 0, 'Widowed', NULL, '50303648324169', 'Yes', NULL, 3, 'Mr. Alvah Connelly', '42472106803912', 'West Tate', '2029-09-10', NULL, NULL, NULL, NULL, NULL, 1012038564, 0, 0, 4, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(52, 1210, 437, 'لينا شريف زياد', 'Female', 3, 2, 4, '1978', 'علوم الحاسوب', 'Fair', '2000-04-25', '25262741204397', '2029-01-30', 'West Kianamouth', 5, 'Christian', 1, 'tyreek.mueller@example.org', 5, 2, 9, '0223744798', '0228432780', '01504320526', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '56365479186732', 'No', NULL, NULL, '2022-08-21', 'Employee', 7, 1, 'No', 'No', 4, '9.00', '31764.76', '1058.83', 'Fixed', '1523.97', 'No', NULL, NULL, 'Yes', '854.33', '81117016453946', 'Cach', 'No', NULL, '48271 McClure Fork Suite 887\nHahnland, DC 10418-1598', 0, 'Divorced', NULL, '538482286624', 'Yes', NULL, 6, 'Coby Treutel', '82024122189196', 'Port Bayleeton', '2027-09-28', NULL, NULL, NULL, NULL, NULL, 407189398, 0, 0, 3, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(53, 5105, 1766, 'هيثم رامز حامد', 'Male', 4, 1, 4, '1991', 'الفيزياء', 'Good', '2010-06-04', '40839367198087', '2028-03-04', 'Jamesonville', 6, 'Christian', 6, 'yhaag@example.com', 3, 5, 5, '0239496476', '0228060244', '01550943074', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '54291291106758', 'Yes', NULL, NULL, '2021-08-24', 'Employee', 4, 24, 'No', 'Yes', 4, '9.00', '34468.33', '1148.94', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '821 Mercedes Crossroad Apt. 485\nMetzland, NJ 83563', 0, 'Married', NULL, '645359876794', 'Yes', NULL, 5, 'Katheryn O\'Connell', '34323191424252', 'Gerrystad', '2029-11-05', NULL, NULL, NULL, NULL, NULL, 1708932832, 0, 0, 4, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(54, 6209, 2610, 'شهد عبدالرحمن مهند', 'Female', 3, 1, 4, '1976', 'الفيزياء', 'Good', '2006-01-21', '27590259504025', '2028-03-08', 'Dickensfurt', 7, 'Muslim', 5, 'pouros.ole@example.net', 6, 25, 14, '0228685770', '0236768430', '01197701529', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '95659275518843', 'No', NULL, NULL, '2024-05-28', 'Employee', 3, 30, 'Yes', 'Yes', 2, '11.00', '10777.33', '359.24', 'Fixed', '1972.97', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '497 Marianne Prairie\nPort Reillymouth, HI 87782', 0, 'Widowed', NULL, '910013751', 'Yes', NULL, 3, 'Ephraim Kassulke', '35814159304304', 'New Buddy', '2029-09-02', NULL, NULL, NULL, NULL, NULL, 1071003584, 0, 0, 2, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(55, 5223, 2145, 'جمانة عبدالحميد شادي', 'Female', 4, 1, 6, '1974', 'علم الأحياء', 'Fair', '2024-10-01', '25088019028800', '2025-07-23', 'Andresside', 7, 'Christian', 3, 'grayce.lesch@example.net', 3, 5, 6, '0230196600', '0237257815', '01020843285', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '77175133144200', 'Yes', NULL, NULL, '2020-09-05', 'Employee', 1, 27, 'No', 'No', 3, '12.00', '6759.59', '225.32', 'Fixed', '1678.24', 'Yes', '739.10', '09717769802817', 'Yes', '769.60', '31084951901594', 'Visa', 'Yes', NULL, '141 Gulgowski Parkways\nNew Jeraldmouth, LA 64381-6714', 0, 'Divorced', NULL, '976575824', 'Yes', NULL, 4, 'Earnest Keebler', '57483248554030', 'Lake Summerport', '2028-10-08', NULL, NULL, NULL, NULL, NULL, 758511142, 0, 0, 3, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(56, 1292, 2409, 'حاتم عمر سهيل', 'Male', 2, 2, 3, '1978', 'الهندسة', 'Good', '2008-11-01', '41384922664152', '2029-05-09', 'Lake Kirstinton', 5, 'Muslim', 3, 'thompson.kamryn@example.org', 1, 13, 1, '0238300760', '0237586615', '01009901074', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '06192127213173', 'Yes', NULL, NULL, '2020-10-26', 'Employee', 9, 3, 'Yes', 'Yes', 1, '9.00', '14467.94', '482.26', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '8972 Hermiston Centers\nMarciaview, KY 08792-4817', 0, 'Single', NULL, '93181985223', 'Yes', NULL, 1, 'Helen Stark', '89067153439641', 'Kemmerview', '2026-09-14', NULL, NULL, NULL, NULL, NULL, 388477510, 0, 0, 1, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(57, 5663, 1559, 'جميلة نور حسن', 'Female', 4, 3, 5, '2010', 'علم الأحياء', 'Good', '2006-10-23', '30619757834623', '2027-09-08', 'Maiaburgh', 2, 'Muslim', 3, 'soledad.corkery@example.org', 4, 1, 8, '0230476856', '0238967435', '01510546532', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '43760524761479', 'No', NULL, NULL, '2020-09-15', 'Employee', 7, 23, 'No', 'No', 2, '11.00', '12259.37', '408.65', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '581.26', '37005562328104', 'Cach', 'Yes', NULL, '154 Rodolfo Fork Suite 977\nZackerystad, MI 04425-9453', 0, 'Married', NULL, '3242541999', 'Yes', NULL, 5, 'Hilbert Sauer', '41109544555341', 'North Gunner', '2027-07-03', NULL, NULL, NULL, NULL, NULL, 224379277, 0, 0, 2, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(58, 7450, 1414, 'سهى مصطفى إبراهيم', 'Female', 3, 3, 5, '1970', 'الهندسة', 'Good', '2010-07-05', '47938445401034', '2025-11-26', 'West Enrico', 5, 'Muslim', 5, 'elta.mraz@example.org', 4, 10, 8, '0231766578', '0223555403', '01005166076', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '25989141331991', 'Yes', NULL, NULL, '2023-12-11', 'Employee', 9, 7, 'No', 'No', 3, '12.00', '42326.61', '1410.89', 'Changeable', NULL, 'Yes', '869.62', '05260526044612', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '963 Rowe Way\nEudoraburgh, CO 89540', 0, 'Widowed', NULL, '55892577278', 'Yes', NULL, 1, 'Carmel Huels', '21622198462868', 'Clementinashire', '2026-05-20', NULL, NULL, NULL, NULL, NULL, 959981022, 0, 0, 2, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52'),
(59, 6719, 512, 'رامي حمزة إبراهيم', 'Male', 1, 4, 5, '1990', 'إدارة الأعمال', 'Good', '2003-09-04', '96520734249879', '2029-07-14', 'South Malika', 4, 'Christian', 6, 'jaunita.ferry@example.net', 3, 10, 4, '0229637483', '0237601177', '01202936093', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '62962816653464', 'No', NULL, NULL, '2021-07-12', 'Employee', 6, 7, 'No', 'Yes', 2, '7.00', '31906.77', '1063.56', 'Fixed', '1614.06', 'Yes', '718.57', '92238644533639', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '381 Elmer Expressway Suite 935\nNorth Asha, AK 21514-5610', 0, 'Divorced', NULL, '503012285787', 'Yes', NULL, 3, 'Guiseppe VonRueden MD', '42085589259187', 'Lake Mathiasburgh', '2029-04-26', NULL, NULL, NULL, NULL, NULL, 1805390176, 0, 0, 2, NULL, 1, '2024-12-13 13:29:52', '2024-12-13 13:29:52');
INSERT INTO `employees` (`id`, `employee_code`, `fp_code`, `name`, `gender`, `branch_id`, `job_grade_id`, `qualification_id`, `qualification_year`, `major`, `graduation_estimate`, `brith_date`, `national_id`, `end_national_id`, `national_id_place`, `blood_types_id`, `religion`, `language_id`, `email`, `country_id`, `governorate_id`, `city_id`, `home_telephone`, `work_telephone`, `mobile`, `military`, `military_date_from`, `military_date_to`, `military_wepon`, `military_exemption_date`, `military_exemption_reason`, `military_postponement_reason`, `date_resignation`, `resignation_reason`, `driving_license`, `driving_license_type`, `driving_License_id`, `has_relatives`, `relatives_details`, `notes`, `work_start_date`, `functional_status`, `department_id`, `job_categories_id`, `has_attendance`, `has_fixed_shift`, `shift_types_id`, `daily_work_hour`, `salary`, `day_price`, `motivation_type`, `motivation`, `social_insurance`, `social_insurance_cut_monthely`, `social_insurance_number`, `medical_insurance`, `medical_insurance_cut_monthely`, `medical_insurance_number`, `Type_salary_receipt`, `active_vacation`, `urgent_person_details`, `staies_address`, `children_number`, `social_status`, `resignation_id`, `bank_number_account`, `disabilities`, `disabilities_type`, `nationality_id`, `name_sponsor`, `pasport_identity`, `pasport_from_place`, `pasport_exp_date`, `num_vacation_days`, `add_service`, `years_service`, `cv`, `basic_address_country`, `fixed_allowances`, `is_done_Vacation_formula`, `is_Sensitive_manager_data`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(60, 8938, 569, 'نور شاكر زياد', 'Male', 4, 3, 4, '2004', 'إدارة الأعمال', 'Excellent', '2019-08-17', '65254182762665', '2029-09-06', 'East Evans', 5, 'Muslim', 12, 'hahn.myra@example.net', 6, 26, 10, '0225248291', '0236316661', '01581308070', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '16024969890099', 'Yes', NULL, NULL, '2024-05-02', 'Employee', 10, 3, 'Yes', 'Yes', 2, '10.00', '15981.27', '532.71', 'Fixed', '1849.44', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '3941 Kautzer Corners Apt. 172\nAuroreville, MN 39434-0217', 0, 'Widowed', NULL, '01203330492', 'Yes', NULL, 3, 'Hilario West', '55528271637539', 'Goldnerfort', '2028-06-29', NULL, NULL, NULL, NULL, NULL, 2005044995, 0, 0, 3, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(61, 3805, 722, 'حمزة ربيع عبدالباسط', 'Male', 3, 1, 1, '1985', 'الرياضيات', 'Good', '2011-01-21', '17603725478324', '2029-07-21', 'East Albinaview', 5, 'Christian', 10, 'tgrant@example.org', 4, 13, 1, '0239535322', '0222605544', '01275584106', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '79672518455498', 'No', NULL, NULL, '2023-04-10', 'Employee', 6, 27, 'Yes', 'Yes', 2, '9.00', '46631.22', '1554.37', 'Fixed', '1698.56', 'Yes', '725.20', '87070888653168', 'Yes', '849.26', '30473853955332', 'Cach', 'Yes', NULL, '5510 Joana Camp\nEmmetport, FL 86590-8599', 0, 'Widowed', NULL, '033635621058', 'Yes', NULL, 1, 'Jazmyne Stanton', '69047684910209', 'New Adolphusfurt', '2029-06-27', NULL, NULL, NULL, NULL, NULL, 433410328, 0, 0, 2, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(62, 5853, 2117, 'رانيا قاسم إسماعيل', 'Female', 3, 1, 2, '1994', 'الرياضيات', 'Very_Good', '2001-06-01', '46233967500799', '2028-07-31', 'West Jessieberg', 3, 'Muslim', 4, 'graham.elyse@example.org', 5, 13, 12, '0239949230', '0229286329', '01240881862', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '63986925618343', 'No', NULL, NULL, '2024-04-04', 'Employee', 3, 14, 'Yes', 'Yes', 1, '11.00', '34089.45', '1136.32', 'Fixed', '1828.62', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '52092 Angie Summit\nAnneside, AK 03734-0318', 0, 'Widowed', NULL, '005509244189', 'Yes', NULL, 3, 'Rodolfo Bosco', '57985293424795', 'West Gus', '2026-10-26', NULL, NULL, NULL, NULL, NULL, 2000178042, 0, 0, 1, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(63, 7028, 2915, 'فايزة عبدالسلام قاسم', 'Female', 1, 4, 1, '2008', 'علوم الحاسوب', 'Very_Good', '2016-12-31', '89917587087963', '2027-01-18', 'Port Elfriedachester', 7, 'Christian', 7, 'nhegmann@example.org', 5, 10, 11, '0233186462', '0234901873', '01599002527', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '34286255204841', 'No', NULL, NULL, '2022-04-07', 'Employee', 3, 4, 'No', 'No', 3, '9.00', '42884.19', '1429.47', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '721.16', '82808420643645', 'Cach', 'No', NULL, '352 Davis Forges\nNew Kathrynchester, NH 08857-0733', 0, 'Married', NULL, '548558282047', 'Yes', NULL, 4, 'Mr. Brayan Kris', '15409313305444', 'South Zionmouth', '2026-11-21', NULL, NULL, NULL, NULL, NULL, 1681463069, 0, 0, 4, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(64, 4155, 2593, 'عماد عامر توفيق', 'Male', 1, 1, 1, '1995', 'إدارة الأعمال', 'Excellent', '2015-09-27', '34519904607250', '2025-09-23', 'North Chaya', 6, 'Muslim', 3, 'rex79@example.org', 2, 20, 12, '0239451201', '0223075006', '01290970006', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '26000286859161', 'Yes', NULL, NULL, '2024-05-11', 'Employee', 3, 5, 'Yes', 'Yes', 2, '9.00', '46661.15', '1555.37', 'Fixed', '1672.44', 'No', NULL, NULL, 'Yes', '998.00', '31732649093028', 'Cach', 'No', NULL, '644 Lueilwitz Shoal\nLake Billy, NJ 33944', 0, 'Married', NULL, '876060408', 'Yes', NULL, 3, 'Jonathon O\'Conner I', '45787009459955', 'New Sincere', '2027-04-15', NULL, NULL, NULL, NULL, NULL, 2113717031, 0, 0, 3, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(65, 3350, 671, 'ناهد رياض أيوب', 'Female', 1, 3, 1, '2005', 'علوم الحاسوب', 'Very_Good', '2011-04-17', '53997477643548', '2025-11-13', 'Gideonport', 6, 'Muslim', 12, 'okeefe.alessandro@example.com', 5, 13, 8, '0222078046', '0232543942', '01133916934', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '66831498576823', 'No', NULL, NULL, '2021-09-22', 'Employee', 9, 11, 'Yes', 'No', 3, '9.00', '49425.86', '1647.53', 'Fixed', '1612.39', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '20897 Dixie Mews\nSouth Felicitaville, MO 14256', 0, 'Divorced', NULL, '939785780', 'Yes', NULL, 1, 'Dr. Dariana Cole Jr.', '97825294558912', 'Baileyville', '2028-04-30', NULL, NULL, NULL, NULL, NULL, 1637734597, 0, 0, 4, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(66, 3221, 2733, 'أديب فارس عبدالحميد', 'Male', 2, 4, 5, '1982', 'الهندسة', 'Very_Good', '2011-01-12', '32500868137302', '2026-01-04', 'New Mireilleport', 2, 'Muslim', 7, 'qmills@example.net', 5, 15, 4, '0230930438', '0238577432', '01193729839', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '47970722617699', 'Yes', NULL, NULL, '2021-02-09', 'Employee', 7, 26, 'Yes', 'Yes', 4, '9.00', '42449.69', '1414.99', 'Fixed', '1290.43', 'No', NULL, NULL, 'Yes', '811.08', '94012418392341', 'Cach', 'No', NULL, '284 Douglas Throughway\nEast Clevefurt, NH 32554', 0, 'Married', NULL, '0221530167144', 'Yes', NULL, 4, 'Mr. Clyde Hartmann', '76808921450990', 'New Elza', '2029-05-14', NULL, NULL, NULL, NULL, NULL, 173944812, 0, 0, 4, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(67, 4969, 91, 'حنان عبدالعزيز سامي', 'Female', 2, 2, 3, '1985', 'علم الأحياء', 'Excellent', '2010-03-25', '95157650734829', '2029-11-09', 'Candelarioview', 2, 'Christian', 5, 'cecil.bashirian@example.com', 1, 12, 9, '0231483133', '0234979506', '01508008623', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '55499609387178', 'No', NULL, NULL, '2024-06-19', 'Employee', 4, 18, 'Yes', 'Yes', 2, '7.00', '46076.62', '1535.89', 'Changeable', NULL, 'Yes', '806.72', '27466672996594', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '628 Flavie Rapid Suite 231\nWest Janessa, KS 30846-1523', 0, 'Widowed', NULL, '0716004077025', 'Yes', NULL, 1, 'Glennie Bechtelar', '72249080280145', 'Bartellbury', '2026-08-19', NULL, NULL, NULL, NULL, NULL, 1934684250, 0, 0, 2, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(68, 5281, 135, 'عبدالكريم شريف نادر', 'Male', 3, 2, 1, '1983', 'الهندسة', 'Fair', '2019-12-13', '66986718496572', '2027-10-20', 'Bettyeton', 4, 'Christian', 12, 'rosetta72@example.com', 4, 23, 8, '0226691367', '0221445751', '01186738955', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '90866105151597', 'Yes', NULL, NULL, '2023-11-11', 'Employee', 6, 22, 'Yes', 'No', 3, '9.00', '39496.75', '1316.56', 'Fixed', '1494.72', 'No', NULL, NULL, 'Yes', '990.11', '41188114359690', 'Cach', 'No', NULL, '17079 Fritsch Mountain Suite 143\nLake Okeyborough, NC 87748-8317', 0, 'Divorced', NULL, '4796897631', 'Yes', NULL, 1, 'Mr. Hilton Zemlak PhD', '96084907349541', 'East Crystalburgh', '2026-07-31', NULL, NULL, NULL, NULL, NULL, 822004044, 0, 0, 3, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(69, 9188, 1164, 'ليان مالك عصام', 'Female', 3, 2, 2, '2006', 'الفيزياء', 'Excellent', '2016-04-04', '09029766384945', '2029-08-07', 'Greentown', 1, 'Christian', 1, 'tward@example.com', 5, 15, 9, '0238647132', '0220645368', '01137437507', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '32702287775136', 'Yes', NULL, NULL, '2022-06-03', 'Employee', 6, 2, 'No', 'No', 3, '8.00', '40281.83', '1342.73', 'Fixed', '1494.91', 'Yes', '998.42', '14989739410825', 'Yes', '865.80', '71487887292686', 'Visa', 'Yes', NULL, '40785 Amy Island Suite 689\nPort Sigmund, NE 07974', 0, 'Widowed', NULL, '20280689095', 'Yes', NULL, 1, 'Dr. Evangeline Sawayn', '65139662074488', 'Shieldsland', '2029-04-01', NULL, NULL, NULL, NULL, NULL, 621862942, 0, 0, 3, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(70, 3776, 819, 'نسرين عصام طلال', 'Female', 1, 4, 1, '1989', 'علوم الحاسوب', 'Fair', '2010-05-04', '72911531421828', '2029-09-09', 'Lake Othatown', 7, 'Christian', 10, 'nolan.juliet@example.net', 4, 6, 10, '0228393610', '0237769474', '01014581847', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '90871081054658', 'No', NULL, NULL, '2020-01-31', 'Employee', 8, 14, 'Yes', 'No', 1, '12.00', '12161.73', '405.39', 'Fixed', '1224.73', 'No', NULL, NULL, 'Yes', '606.28', '04458716695811', 'Visa', 'Yes', NULL, '191 VonRueden Extension Apt. 049\nAshleychester, AK 72074', 0, 'Single', NULL, '523647174791', 'Yes', NULL, 4, 'Letitia Frami', '67882873929915', 'Efrenstad', '2029-01-15', NULL, NULL, NULL, NULL, NULL, 1147009657, 0, 0, 4, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(71, 2388, 1451, 'باسم عبداللطيف تامر', 'Male', 4, 2, 2, '1987', 'علوم الحاسوب', 'Very_Good', '2014-04-11', '74850750688446', '2025-03-06', 'South Glennieville', 3, 'Christian', 10, 'awiza@example.org', 1, 8, 6, '0226842390', '0225165940', '01267394095', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '10098765615518', 'Yes', NULL, NULL, '2023-09-26', 'Employee', 6, 27, 'No', 'Yes', 1, '8.00', '46907.41', '1563.58', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '99392 Dibbert Springs Suite 045\nBartellton, WY 95483', 0, 'Divorced', NULL, '69983050338348', 'Yes', NULL, 3, 'Prof. Watson Cronin', '63175837097231', 'Alfonzotown', '2027-07-24', NULL, NULL, NULL, NULL, NULL, 102060340, 0, 0, 3, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(72, 2210, 514, 'راغب باسل رشيد', 'Male', 2, 2, 5, '1988', 'إدارة الأعمال', 'Very_Good', '2004-02-27', '56390944317430', '2026-02-17', 'Hauckville', 7, 'Christian', 9, 'alena.schmitt@example.net', 5, 8, 4, '0223138734', '0236717317', '01524462556', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '91904711035685', 'Yes', NULL, NULL, '2023-11-25', 'Employee', 3, 4, 'Yes', 'No', 4, '9.00', '9219.41', '307.31', 'Changeable', NULL, 'Yes', '968.59', '96043069247346', 'No', NULL, NULL, 'Visa', 'No', NULL, '2158 Reichel Flats Suite 671\nSouth Broderickside, DC 89526', 0, 'Widowed', NULL, '594377165424', 'Yes', NULL, 6, 'Jenifer Schaefer', '87029917854303', 'West Brooke', '2028-12-12', NULL, NULL, NULL, NULL, NULL, 1494765038, 0, 0, 4, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(73, 8063, 2707, 'غادة أحمد مصطفى', 'Female', 1, 3, 5, '1976', 'علوم الحاسوب', 'Very_Good', '2001-06-22', '42299408953030', '2029-01-28', 'New Alysson', 4, 'Muslim', 4, 'nichole.okon@example.com', 3, 25, 3, '0225517379', '0238230982', '01243228380', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '20107969533657', 'No', NULL, NULL, '2021-05-05', 'Employee', 10, 8, 'Yes', 'Yes', 1, '12.00', '43876.28', '1462.54', 'Fixed', '1744.56', 'Yes', '808.11', '78560424300197', 'Yes', '961.46', '62606942573671', 'Visa', 'No', NULL, '7042 Vernie Crossroad Suite 403\nSouth Johathantown, ND 45404-0271', 0, 'Divorced', NULL, '9990187122', 'Yes', NULL, 2, 'Hillard Terry', '50110785858280', 'West Angelport', '2027-06-18', NULL, NULL, NULL, NULL, NULL, 104495602, 0, 0, 4, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(74, 2869, 585, 'علاء رائد يحيى', 'Male', 4, 2, 5, '1972', 'الهندسة', 'Fair', '2017-02-04', '54920402160883', '2027-09-19', 'South Ashlymouth', 6, 'Muslim', 7, 'jarvis.stoltenberg@example.org', 2, 20, 13, '0229529151', '0239666275', '01032620317', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '71468379580547', 'Yes', NULL, NULL, '2024-06-03', 'Employee', 10, 28, 'Yes', 'Yes', 3, '7.00', '11234.44', '374.48', 'Fixed', '1967.30', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '37046 Paucek Harbors\nWest Keeleymouth, ME 95072-2186', 0, 'Divorced', NULL, '502242823665', 'Yes', NULL, 4, 'Graciela Becker', '01678988804571', 'Lake Kara', '2026-08-05', NULL, NULL, NULL, NULL, NULL, 959389322, 0, 0, 1, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(75, 6097, 2696, 'رنا حامد عبدالحميد', 'Female', 3, 3, 6, '2014', 'إدارة الأعمال', 'Excellent', '2008-09-07', '58350743900386', '2027-07-01', 'Violetteville', 2, 'Muslim', 10, 'skilback@example.org', 5, 14, 6, '0232618768', '0238325410', '01039581316', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '63464623621158', 'Yes', NULL, NULL, '2021-10-20', 'Employee', 9, 20, 'No', 'Yes', 1, '12.00', '20301.79', '676.73', 'Changeable', NULL, 'Yes', '932.93', '95404305091592', 'Yes', '571.02', '15486745023253', 'Visa', 'Yes', NULL, '7239 Steve Fords Apt. 385\nWest Reginald, WI 52803-0311', 0, 'Single', NULL, '7748080850', 'Yes', NULL, 1, 'Zora Fahey', '49546175219632', 'Wymanmouth', '2029-06-16', NULL, NULL, NULL, NULL, NULL, 1257823528, 0, 0, 2, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(76, 7301, 763, 'رامي طلال لؤي', 'Male', 3, 4, 2, '1995', 'إدارة الأعمال', 'Very_Good', '2009-11-27', '11288849278017', '2027-06-07', 'Gabrieltown', 5, 'Christian', 1, 'nader.michelle@example.org', 2, 3, 7, '0231047066', '0221195705', '01561170436', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '66533166665369', 'Yes', NULL, NULL, '2024-01-01', 'Employee', 3, 11, 'Yes', 'No', 1, '12.00', '27955.83', '931.86', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '746.02', '58240713088415', 'Cach', 'No', NULL, '52190 Cummerata Fork\nSouth Bailey, MI 38322', 0, 'Single', NULL, '918777741', 'Yes', NULL, 2, 'Waldo Collier', '78520584797799', 'Lake Nikkimouth', '2026-01-06', NULL, NULL, NULL, NULL, NULL, 1194928678, 0, 0, 4, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(77, 1669, 107, 'عبدالعزيز عبدالفتاح صابر', 'Male', 2, 3, 3, '2006', 'الفيزياء', 'Very_Good', '2000-01-05', '87727082888379', '2026-10-23', 'O\'Keefefort', 4, 'Muslim', 4, 'bhills@example.org', 4, 3, 7, '0230010484', '0222074391', '01171711639', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '82145648624085', 'No', NULL, NULL, '2022-07-16', 'Employee', 5, 8, 'No', 'Yes', 2, '9.00', '45425.45', '1514.18', 'Fixed', '1714.79', 'Yes', '839.32', '23802973544843', 'Yes', '683.37', '08282871033320', 'Cach', 'No', NULL, '962 Hermann Tunnel\nEast Verdamouth, ME 46590', 0, 'Widowed', NULL, '8184072211', 'Yes', NULL, 2, 'Sarai Conroy', '00510279935532', 'Schowalterview', '2029-10-27', NULL, NULL, NULL, NULL, NULL, 1396298757, 0, 0, 3, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(78, 7496, 1512, 'نادر زين ربيع', 'Male', 2, 4, 2, '2002', 'الرياضيات', 'Fair', '2014-07-24', '83620181570487', '2027-09-30', 'Port Dorcas', 1, 'Muslim', 1, 'oernser@example.com', 4, 9, 9, '0231527593', '0238297919', '01503921827', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '81355947893795', 'No', NULL, NULL, '2021-08-05', 'Employee', 2, 23, 'Yes', 'Yes', 4, '8.00', '34862.42', '1162.08', 'Fixed', '1629.27', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '816 Towne Meadows\nEast Norenehaven, LA 50205-9707', 0, 'Divorced', NULL, '530881012', 'Yes', NULL, 1, 'Mr. Guiseppe Franecki DDS', '43488598016135', 'Lake Nayeli', '2029-08-22', NULL, NULL, NULL, NULL, NULL, 1861537802, 0, 0, 3, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(79, 6169, 1008, 'هدى إبراهيم راغب', 'Female', 2, 3, 6, '1992', 'إدارة الأعمال', 'Very_Good', '2002-10-29', '14944251716854', '2029-05-14', 'Geovanniborough', 3, 'Muslim', 2, 'auer.cruz@example.org', 5, 22, 2, '0228981120', '0237421377', '01595138890', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '91289869772377', 'Yes', NULL, NULL, '2024-04-02', 'Employee', 7, 22, 'Yes', 'No', 3, '11.00', '32596.83', '1086.56', 'Changeable', NULL, 'Yes', '832.92', '52569506475440', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '20786 Connelly Harbor Apt. 456\nAdrianview, OK 24480-8880', 0, 'Divorced', NULL, '41204196299', 'Yes', NULL, 5, 'Earl Abshire', '99390674986185', 'Hansenberg', '2028-02-12', NULL, NULL, NULL, NULL, NULL, 1705598595, 0, 0, 3, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(80, 4824, 2866, 'أميرة مازن فارس', 'Female', 2, 1, 4, '1997', 'علوم الحاسوب', 'Excellent', '2004-08-22', '61461220104057', '2025-01-31', 'Lake Marcel', 3, 'Christian', 2, 'lucienne.flatley@example.org', 3, 3, 1, '0237544609', '0220465252', '01219509340', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '65272129400269', 'Yes', NULL, NULL, '2024-09-09', 'Employee', 1, 23, 'Yes', 'Yes', 1, '10.00', '28835.43', '961.18', 'Fixed', '1272.14', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '3264 Patricia Overpass Apt. 873\nNew Arlenetown, AZ 50792-6367', 0, 'Married', NULL, '3045079611', 'Yes', NULL, 6, 'Dr. Edwardo Friesen', '16121063649292', 'Brionnaland', '2029-10-04', NULL, NULL, NULL, NULL, NULL, 1084649778, 0, 0, 2, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(81, 4629, 161, 'رياض جمال إبراهيم', 'Male', 2, 4, 6, '1990', 'الرياضيات', 'Fair', '2001-12-01', '15129773658405', '2029-04-28', 'West Mariannebury', 1, 'Christian', 7, 'homenick.bridget@example.org', 5, 16, 15, '0235131137', '0225176197', '01289936230', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '09096233571986', 'Yes', NULL, NULL, '2020-01-30', 'Employee', 2, 1, 'Yes', 'Yes', 1, '8.00', '31117.00', '1037.23', 'Fixed', '1331.92', 'No', NULL, NULL, 'Yes', '555.72', '44945648139489', 'Visa', 'No', NULL, '87315 Xavier Junctions Suite 501\nSouth Audie, SC 01716', 0, 'Single', NULL, '11429377224', 'Yes', NULL, 6, 'Treva Kreiger', '49756804241370', 'New Josie', '2028-12-03', NULL, NULL, NULL, NULL, NULL, 2010804019, 0, 0, 4, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(82, 3945, 737, 'محمود رائد صهيب', 'Male', 2, 1, 1, '2010', 'إدارة الأعمال', 'Excellent', '2021-04-10', '36157194988621', '2027-01-26', 'Littlebury', 4, 'Christian', 2, 'ada91@example.org', 2, 9, 10, '0236267591', '0223397537', '01108935189', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '88042751554596', 'No', NULL, NULL, '2020-01-31', 'Employee', 6, 20, 'No', 'Yes', 2, '9.00', '34229.50', '1140.98', 'Fixed', '1928.00', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '18241 Laisha Center\nOberbrunnermouth, NY 26716', 0, 'Single', NULL, '27922595439320', 'Yes', NULL, 1, 'Fletcher Franecki', '87016763172453', 'Batzport', '2028-03-11', NULL, NULL, NULL, NULL, NULL, 1053928953, 0, 0, 2, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(83, 6738, 550, 'يحيى جمال عبداللطيف', 'Male', 3, 4, 6, '2007', 'إدارة الأعمال', 'Very_Good', '2014-12-30', '07466330256565', '2025-06-28', 'North Janieville', 4, 'Christian', 11, 'fausto.beier@example.com', 6, 12, 13, '0226185440', '0233953729', '01028375858', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '54301786303256', 'Yes', NULL, NULL, '2020-04-27', 'Employee', 9, 3, 'Yes', 'No', 1, '7.00', '39384.29', '1312.81', 'Fixed', '1146.43', 'No', NULL, NULL, 'Yes', '564.17', '51247838398761', 'Visa', 'No', NULL, '16902 Kathryne Row\nChesleyville, FL 47668', 0, 'Divorced', NULL, '246796382719', 'Yes', NULL, 1, 'Miss Freeda Stroman V', '62609159365092', 'North Carmine', '2027-03-28', NULL, NULL, NULL, NULL, NULL, 1446225883, 0, 0, 1, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(84, 8201, 1814, 'عبدالسلام عادل يوسف', 'Male', 3, 2, 4, '1983', 'الفيزياء', 'Fair', '2024-11-21', '75981179991885', '2027-08-14', 'East Mckayla', 7, 'Muslim', 3, 'eveline66@example.com', 4, 12, 4, '0235741657', '0223681991', '01261535042', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '84258541630585', 'Yes', NULL, NULL, '2022-02-22', 'Employee', 1, 23, 'Yes', 'No', 4, '8.00', '41044.63', '1368.15', 'Changeable', NULL, 'Yes', '564.60', '95128416035272', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '8208 Kristofer Land Apt. 394\nWest Kieranberg, WA 87237-7529', 0, 'Widowed', NULL, '922238296', 'Yes', NULL, 3, 'Bessie Rolfson', '19168170651973', 'North Angelicaberg', '2026-08-31', NULL, NULL, NULL, NULL, NULL, 930306765, 0, 0, 3, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(85, 9397, 2127, 'عبدالباسط سليمان طلال', 'Male', 4, 1, 3, '2007', 'الرياضيات', 'Excellent', '2000-05-29', '20516346312534', '2029-10-09', 'West Demetris', 3, 'Christian', 8, 'rosalind.hill@example.com', 3, 18, 6, '0227423638', '0235381967', '01185713438', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '85284111639462', 'No', NULL, NULL, '2022-08-02', 'Employee', 1, 21, 'No', 'No', 4, '8.00', '39183.92', '1306.13', 'Fixed', '1550.96', 'No', NULL, NULL, 'Yes', '706.60', '41064447110769', 'Visa', 'Yes', NULL, '38701 Hintz View\nPort Camille, ID 90905', 0, 'Married', NULL, '88680204068', 'Yes', NULL, 6, 'Christina Ledner', '88893991016458', 'Eldatown', '2029-10-12', NULL, NULL, NULL, NULL, NULL, 1531801147, 0, 0, 2, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(86, 3398, 910, 'حسين طارق وائل', 'Male', 2, 3, 6, '2008', 'إدارة الأعمال', 'Very_Good', '2024-06-07', '83308715851484', '2027-05-04', 'Feeneybury', 7, 'Christian', 12, 'reese43@example.net', 1, 11, 12, '0222315579', '0238970908', '01221411091', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '21681318591054', 'No', NULL, NULL, '2023-03-07', 'Employee', 2, 21, 'No', 'No', 1, '9.00', '46282.86', '1542.76', 'Fixed', '1239.49', 'No', NULL, NULL, 'Yes', '722.27', '04535578252590', 'Visa', 'No', NULL, '5452 Bradtke Road\nAkeemshire, PA 46904', 0, 'Widowed', NULL, '399137', 'Yes', NULL, 4, 'Ethelyn Pagac', '46047151706646', 'East Jedidiahberg', '2028-07-14', NULL, NULL, NULL, NULL, NULL, 1891279364, 0, 0, 2, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(87, 9885, 2258, 'هناء مهند يحيى', 'Female', 3, 2, 3, '2008', 'علوم الحاسوب', 'Fair', '2002-05-13', '91393608135036', '2026-12-02', 'Gaetanobury', 3, 'Christian', 12, 'reece.beier@example.net', 2, 23, 5, '0231880876', '0222096099', '01293394081', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '17262281635942', 'Yes', NULL, NULL, '2023-08-02', 'Employee', 7, 15, 'Yes', 'Yes', 1, '12.00', '18818.53', '627.28', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '836.47', '17302426031263', 'Cach', 'Yes', NULL, '933 Anika Cape\nLake Ellis, ME 94367-8975', 0, 'Married', NULL, '0012894582640', 'Yes', NULL, 3, 'Prof. Ole Bins I', '07586328830775', 'Wittingview', '2028-07-10', NULL, NULL, NULL, NULL, NULL, 1397012818, 0, 0, 2, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(88, 7121, 1717, 'أمجد نبيل ماهر', 'Male', 1, 4, 5, '2008', 'الرياضيات', 'Very_Good', '2024-06-15', '63047864603082', '2028-09-24', 'West Amir', 6, 'Muslim', 3, 'friesen.delfina@example.org', 6, 19, 5, '0228246404', '0228093492', '01141421239', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '35185617916418', 'Yes', NULL, NULL, '2024-06-08', 'Employee', 10, 26, 'No', 'No', 3, '12.00', '38966.78', '1298.89', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '601.92', '15895859044234', 'Cach', 'Yes', NULL, '88376 Parker Island Suite 276\nWelchborough, PA 47382', 0, 'Married', NULL, '31614837220495505', 'Yes', NULL, 1, 'Ms. Britney Watsica DDS', '42359403611275', 'Ismaeltown', '2028-04-16', NULL, NULL, NULL, NULL, NULL, 1695390834, 0, 0, 2, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(89, 4455, 2348, 'آلاء عبدالفتاح عبدالحميد', 'Female', 3, 3, 6, '1971', 'علم الأحياء', 'Excellent', '2014-12-12', '91004538583979', '2029-05-26', 'Meggieview', 7, 'Christian', 11, 'ystamm@example.net', 1, 24, 3, '0222052316', '0238306513', '01230787754', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '15040546168121', 'No', NULL, NULL, '2021-12-10', 'Employee', 3, 4, 'No', 'Yes', 2, '10.00', '30718.73', '1023.96', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '880.74', '95788894784929', 'Visa', 'Yes', NULL, '531 White Pine\nNorth Brannon, UT 42231-7270', 0, 'Single', NULL, '516389390', 'Yes', NULL, 6, 'Ryley Lynch', '96208879924190', 'Williamsonstad', '2027-09-30', NULL, NULL, NULL, NULL, NULL, 1666160831, 0, 0, 3, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(90, 7686, 1, 'صهيب طارق رياض', 'Male', 2, 2, 5, '1977', 'الهندسة', 'Fair', '2014-07-07', '64801429306189', '2025-06-13', 'West Everette', 1, 'Muslim', 9, 'destiny15@example.com', 6, 20, 10, '0230449571', '0236102206', '01287986077', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '40406355318784', 'Yes', NULL, NULL, '2021-02-10', 'Employee', 9, 26, 'No', 'Yes', 4, '9.00', '30094.32', '1003.14', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '721.59', '39327945201614', 'Cach', 'No', NULL, '22900 Shields Gateway\nMooreton, TN 98000', 0, 'Widowed', NULL, '67125163968', 'Yes', NULL, 4, 'Muriel Konopelski DDS', '33127208793973', 'Humbertoport', '2027-06-29', NULL, NULL, NULL, NULL, NULL, 1008066323, 0, 0, 2, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(91, 3397, 1024, 'ياسر عبدالباسط ثامر', 'Male', 4, 3, 6, '2004', 'إدارة الأعمال', 'Very_Good', '2015-02-27', '62141465445736', '2026-09-22', 'Bergnaummouth', 7, 'Christian', 2, 'stehr.darrick@example.net', 4, 2, 11, '0236647567', '0221352986', '01536163173', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '85189372391807', 'No', NULL, NULL, '2024-10-21', 'Employee', 4, 29, 'No', 'Yes', 4, '12.00', '46032.71', '1534.42', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '726.61', '54280445970331', 'Cach', 'Yes', NULL, '2016 Runte Knoll\nLake Erinview, NC 29192', 0, 'Widowed', NULL, '799446692193509', 'Yes', NULL, 1, 'Dax Borer Sr.', '91604394159259', 'Heathcotefort', '2029-02-01', NULL, NULL, NULL, NULL, NULL, 630590894, 0, 0, 3, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(92, 8760, 2412, 'نوران رامي نور', 'Female', 1, 2, 4, '1999', 'إدارة الأعمال', 'Excellent', '2024-09-30', '31985962636959', '2029-11-18', 'West Ryleebury', 5, 'Christian', 1, 'mcclure.amaya@example.org', 1, 5, 4, '0234477298', '0229960180', '01151282203', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '04757647316001', 'Yes', NULL, NULL, '2024-05-11', 'Employee', 8, 5, 'Yes', 'No', 2, '8.00', '49379.11', '1645.97', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '190 Raleigh Rest\nEast Madge, TX 78730-5021', 0, 'Widowed', NULL, '254228121910', 'Yes', NULL, 4, 'Halie Lemke', '12632587037523', 'Sauerfort', '2029-03-05', NULL, NULL, NULL, NULL, NULL, 649518031, 0, 0, 3, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(93, 4390, 1014, 'زين أحمد رياض', 'Male', 2, 3, 2, '1980', 'علم الأحياء', 'Very_Good', '2005-11-26', '24951452295493', '2028-03-14', 'Hayesmouth', 1, 'Muslim', 7, 'glover.mose@example.com', 6, 25, 7, '0227761429', '0222296682', '01568865097', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '37629198946249', 'No', NULL, NULL, '2021-05-20', 'Employee', 4, 25, 'Yes', 'Yes', 2, '9.00', '9740.66', '324.69', 'Fixed', '1734.52', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '92685 Anahi Parkway Apt. 171\nHillsstad, HI 64617', 0, 'Single', NULL, '4069929423', 'Yes', NULL, 6, 'Coy Fadel', '55898068851743', 'Bergnaumstad', '2025-07-23', NULL, NULL, NULL, NULL, NULL, 693838127, 0, 0, 4, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(94, 5391, 147, 'روز كريم أديب', 'Female', 4, 1, 4, '1992', 'إدارة الأعمال', 'Very_Good', '2011-04-07', '24237823217774', '2027-06-01', 'Adityaport', 7, 'Christian', 4, 'mziemann@example.com', 5, 6, 5, '0233026343', '0221659112', '01524379517', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '19779155336855', 'Yes', NULL, NULL, '2023-02-10', 'Employee', 1, 7, 'No', 'No', 3, '11.00', '36131.28', '1204.38', 'Changeable', NULL, 'Yes', '861.55', '83236993667194', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '34991 West Light\nEast Grayce, MD 98487-0110', 0, 'Widowed', NULL, '8114757004', 'Yes', NULL, 3, 'Shawn Schaefer', '81831610853353', 'Reynoldtown', '2025-12-28', NULL, NULL, NULL, NULL, NULL, 951915316, 0, 0, 3, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(95, 1047, 390, 'تالة وجيه آدم', 'Female', 1, 3, 5, '2014', 'الفيزياء', 'Excellent', '2019-09-23', '78856855662647', '2025-04-04', 'East Simeon', 3, 'Christian', 3, 'ocie36@example.net', 2, 3, 14, '0235770851', '0234033505', '01584889511', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '26169762538680', 'No', NULL, NULL, '2024-05-06', 'Employee', 7, 9, 'Yes', 'Yes', 1, '8.00', '41090.18', '1369.67', 'Fixed', '1566.26', 'Yes', '973.34', '23581993240669', 'No', NULL, NULL, 'Cach', 'No', NULL, '4683 Dayna Park Suite 077\nPort Danny, ID 12096-6485', 0, 'Married', NULL, '33468058719148', 'Yes', NULL, 5, 'Emanuel Muller V', '05282415182975', 'Rodriguezburgh', '2026-08-30', NULL, NULL, NULL, NULL, NULL, 2015064011, 0, 0, 1, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(96, 6176, 1955, 'نور معاذ عبدالفتاح', 'Male', 2, 1, 6, '2008', 'الرياضيات', 'Good', '2023-02-16', '53474866519100', '2029-10-04', 'New Vada', 3, 'Muslim', 5, 'constantin.terry@example.com', 4, 7, 4, '0235868597', '0234716585', '01047767357', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '26134385904460', 'Yes', NULL, NULL, '2021-03-21', 'Employee', 6, 15, 'Yes', 'No', 2, '8.00', '24596.68', '819.89', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '799 Smitham Drives\nLake Ettie, MD 16688-2906', 0, 'Divorced', NULL, '57434293987566', 'Yes', NULL, 3, 'Prof. Devonte Johnston', '85173300124224', 'East Guyburgh', '2026-03-19', NULL, NULL, NULL, NULL, NULL, 441984833, 0, 0, 4, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(97, 2443, 2671, 'عصام رياض حامد', 'Male', 1, 1, 4, '2011', 'علم الأحياء', 'Good', '2001-09-24', '30306257711713', '2028-04-22', 'Herminashire', 4, 'Christian', 9, 'auer.davion@example.com', 2, 12, 14, '0226172300', '0237047274', '01010714879', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '40523567279851', 'No', NULL, NULL, '2020-11-06', 'Employee', 9, 15, 'Yes', 'No', 2, '11.00', '9679.47', '322.65', 'Changeable', NULL, 'Yes', '691.92', '22644307660051', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '3269 Liana Shore Apt. 721\nLake Telly, NM 71823-8009', 0, 'Widowed', NULL, '083757513746415', 'Yes', NULL, 2, 'Alexis Klocko', '02788568610955', 'West Anya', '2025-05-21', NULL, NULL, NULL, NULL, NULL, 380208116, 0, 0, 4, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(98, 7505, 1580, 'فايزة هيثم طارق', 'Female', 3, 1, 4, '1992', 'الهندسة', 'Fair', '2003-07-18', '40846030925392', '2029-10-27', 'Schultztown', 4, 'Christian', 7, 'kiara09@example.net', 5, 10, 13, '0221836889', '0222863988', '01535550904', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '18326688387224', 'No', NULL, NULL, '2022-04-29', 'Employee', 2, 29, 'Yes', 'Yes', 4, '11.00', '30675.88', '1022.53', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '6898 Willie Street\nMyleneshire, MT 74596-6507', 0, 'Widowed', NULL, '25185535665935', 'Yes', NULL, 3, 'Saige Huels Jr.', '52887752261756', 'West Novamouth', '2025-03-25', NULL, NULL, NULL, NULL, NULL, 336494931, 0, 0, 1, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(99, 7805, 2416, 'وفاء تامر حاتم', 'Female', 1, 3, 4, '2004', 'علم الأحياء', 'Excellent', '2023-03-05', '87297194527567', '2027-12-02', 'Lizethborough', 2, 'Christian', 5, 'kiehn.lemuel@example.com', 5, 7, 4, '0225658880', '0220372407', '01189841823', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '54161769561445', 'Yes', NULL, NULL, '2020-09-22', 'Employee', 3, 25, 'No', 'No', 2, '7.00', '13205.56', '440.19', 'Fixed', '1301.51', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '74509 Keyon Underpass\nRobelburgh, NH 85401', 0, 'Single', NULL, '9601612476338', 'Yes', NULL, 1, 'Dr. Evalyn Nader', '52438226581974', 'Dewayneton', '2026-01-02', NULL, NULL, NULL, NULL, NULL, 800194661, 0, 0, 4, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(100, 7864, 1167, 'آلاء ناجي كريم', 'Female', 1, 1, 2, '1994', 'إدارة الأعمال', 'Good', '2011-04-11', '99398240905039', '2025-08-20', 'Konopelskiside', 3, 'Christian', 3, 'hegmann.destin@example.com', 2, 2, 10, '0238302244', '0229571988', '01518666132', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '79030074731215', 'No', NULL, NULL, '2023-04-15', 'Employee', 10, 9, 'Yes', 'Yes', 1, '10.00', '47110.45', '1570.35', 'Changeable', NULL, 'Yes', '838.81', '17531239912769', 'No', NULL, NULL, 'Visa', 'No', NULL, '996 Jewel Island\nO\'Keefeland, ND 19211', 0, 'Married', NULL, '194887348', 'Yes', NULL, 4, 'Katrine Sanford', '55633972411151', 'McKenzieberg', '2028-09-19', NULL, NULL, NULL, NULL, NULL, 2000623173, 0, 0, 1, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(101, 3445, 1242, 'أديب عادل زياد', 'Male', 2, 2, 6, '2007', 'علم الأحياء', 'Excellent', '2010-10-01', '70513033888213', '2026-07-24', 'Reingerberg', 7, 'Christian', 9, 'derek.gulgowski@example.net', 6, 14, 5, '0231677069', '0226197086', '01220515385', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '28564809973673', 'Yes', NULL, NULL, '2020-08-23', 'Employee', 3, 29, 'No', 'Yes', 3, '9.00', '17488.45', '582.95', 'Fixed', '1172.50', 'Yes', '997.12', '35544292581692', 'Yes', '606.61', '52604800946090', 'Cach', 'Yes', NULL, '9049 Wiza Valleys Suite 105\nLake Benniefurt, NJ 82356', 0, 'Divorced', NULL, '13358719691', 'Yes', NULL, 4, 'Bernice Lehner', '48185161212971', 'Jabarihaven', '2027-02-04', NULL, NULL, NULL, NULL, NULL, 1365501637, 0, 0, 1, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(102, 5435, 1444, 'زياد سيف نبيل', 'Male', 3, 1, 1, '2013', 'الفيزياء', 'Fair', '2009-02-25', '86882390600245', '2024-12-30', 'East David', 1, 'Muslim', 10, 'winston.armstrong@example.com', 6, 26, 9, '0226168758', '0232114339', '01131808270', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '06042622714030', 'No', NULL, NULL, '2021-08-04', 'Employee', 10, 28, 'Yes', 'No', 4, '7.00', '45260.96', '1508.70', 'Changeable', NULL, 'Yes', '641.60', '43469307510014', 'No', NULL, NULL, 'Visa', 'No', NULL, '61429 Jerod Shores Apt. 670\nPort Teagan, NV 13268', 0, 'Married', NULL, '5989341135946', 'Yes', NULL, 3, 'Naomie Mills', '32428595630385', 'Chaddborough', '2027-04-29', NULL, NULL, NULL, NULL, NULL, 895396686, 0, 0, 4, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(103, 2746, 325, 'مي عبدالسلام ثامر', 'Female', 4, 4, 3, '1984', 'علوم الحاسوب', 'Very_Good', '2017-07-09', '64792232112281', '2027-08-22', 'Lake Rosella', 3, 'Christian', 3, 'ritchie.elliot@example.org', 5, 6, 6, '0236588489', '0239942025', '01551136164', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '70573559485666', 'No', NULL, NULL, '2021-06-23', 'Employee', 5, 27, 'Yes', 'No', 3, '8.00', '6278.21', '209.27', 'Fixed', '1211.10', 'No', NULL, NULL, 'Yes', '819.89', '66008194754575', 'Cach', 'Yes', NULL, '89451 Metz Drives\nCiarafort, WA 13600-4682', 0, 'Single', NULL, '00315170', 'Yes', NULL, 6, 'Dr. Kurt O\'Connell I', '46938163489035', 'North Amiyamouth', '2027-03-27', NULL, NULL, NULL, NULL, NULL, 1673179345, 0, 0, 2, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(104, 6991, 173, 'عادل توفيق سعيد', 'Male', 1, 4, 3, '1991', 'إدارة الأعمال', 'Good', '2008-01-25', '29499359096100', '2029-06-16', 'Ravenfurt', 6, 'Christian', 12, 'stamm.adriana@example.net', 5, 1, 10, '0229083544', '0225119857', '01145962184', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '06788034652431', 'No', NULL, NULL, '2023-02-28', 'Employee', 8, 14, 'No', 'Yes', 1, '12.00', '16262.45', '542.08', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '715.94', '74103040351949', 'Cach', 'No', NULL, '76131 Houston Union Suite 077\nSouth Melody, WY 81737', 0, 'Divorced', NULL, '414211575356', 'Yes', NULL, 3, 'Viola Mayert', '49487555678911', 'West Arianna', '2025-12-09', NULL, NULL, NULL, NULL, NULL, 1499437597, 0, 0, 1, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(105, 7488, 447, 'هند عامر نور', 'Female', 4, 3, 5, '2007', 'إدارة الأعمال', 'Excellent', '2011-11-10', '49306881110549', '2025-05-08', 'Framishire', 5, 'Christian', 12, 'tromp.colby@example.net', 3, 21, 1, '0233925062', '0225734210', '01020451086', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '61375472192956', 'Yes', NULL, NULL, '2021-01-29', 'Employee', 4, 7, 'No', 'No', 1, '11.00', '40677.79', '1355.93', 'Fixed', '1121.51', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '639 Smitham Flat Suite 285\nSouth Dianna, WA 31355-0105', 0, 'Widowed', NULL, '7726080299', 'Yes', NULL, 3, 'Hope Schuppe', '11382212654882', 'Schmidtchester', '2025-07-03', NULL, NULL, NULL, NULL, NULL, 1815577692, 0, 0, 1, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(106, 5936, 1928, 'إبراهيم عمار عادل', 'Male', 2, 4, 2, '1973', 'علوم الحاسوب', 'Good', '2007-11-08', '75999367563512', '2028-03-26', 'East Elta', 3, 'Christian', 12, 'schroeder.elissa@example.net', 2, 26, 11, '0227432984', '0229369547', '01169092362', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '04898579440378', 'No', NULL, NULL, '2023-04-21', 'Employee', 3, 28, 'No', 'No', 1, '7.00', '41859.80', '1395.33', 'Changeable', NULL, 'Yes', '647.85', '00508383900410', 'Yes', '857.58', '43663091285628', 'Visa', 'No', NULL, '577 Legros Wall Apt. 180\nWest Ophelia, IL 72217-0335', 0, 'Single', NULL, '603912807894', 'Yes', NULL, 4, 'Elenora Goldner Jr.', '84694626722315', 'Jillianport', '2027-03-16', NULL, NULL, NULL, NULL, NULL, 2012579230, 0, 0, 1, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(107, 9955, 268, 'مارين عمار صابر', 'Female', 2, 2, 6, '1970', 'علوم الحاسوب', 'Very_Good', '2022-03-01', '45853479847382', '2029-05-30', 'Lake Jettieburgh', 3, 'Christian', 12, 'rkub@example.org', 6, 23, 4, '0228155656', '0229304685', '01512605031', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '21716520287548', 'No', NULL, NULL, '2023-09-27', 'Employee', 5, 23, 'No', 'Yes', 4, '11.00', '35408.45', '1180.28', 'Changeable', NULL, 'Yes', '879.91', '09500719049013', 'No', NULL, NULL, 'Cach', 'No', NULL, '76672 Donna Canyon Suite 756\nCassinfort, NH 83890', 0, 'Single', NULL, '8123580110986', 'Yes', NULL, 5, 'Oran Zemlak', '39106751706515', 'Lake Stephanie', '2027-12-13', NULL, NULL, NULL, NULL, NULL, 536752962, 0, 0, 1, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(108, 5470, 652, 'نادر رامي محمود', 'Male', 2, 1, 6, '1993', 'الفيزياء', 'Excellent', '2001-10-09', '05905629165643', '2025-12-10', 'New Icieton', 2, 'Christian', 5, 'sigrid03@example.com', 3, 7, 14, '0227279174', '0238236141', '01131267402', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '98492453828537', 'Yes', NULL, NULL, '2024-02-28', 'Employee', 2, 23, 'Yes', 'No', 3, '9.00', '34647.51', '1154.92', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '179 Toy Plains Suite 652\nBelleton, MI 90948', 0, 'Divorced', NULL, '56320107726583', 'Yes', NULL, 3, 'Delbert Will', '68186292589104', 'Donnellytown', '2027-01-05', NULL, NULL, NULL, NULL, NULL, 770723770, 0, 0, 3, NULL, 1, '2024-12-13 13:29:53', '2024-12-13 13:29:53'),
(109, 5060, 1699, 'عبدالرزاق عبدالسلام إسماعيل', 'Male', 2, 1, 3, '1982', 'الفيزياء', 'Fair', '2014-10-29', '02487153729059', '2027-06-13', 'Port Twila', 1, 'Christian', 5, 'kassandra.wolf@example.net', 5, 14, 8, '0235284403', '0224244396', '01125191895', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '93529835060812', 'Yes', NULL, NULL, '2024-03-06', 'Employee', 2, 13, 'Yes', 'No', 3, '7.00', '41745.97', '1391.53', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '271 Hector Turnpike Apt. 746\nBriaside, VT 91165', 0, 'Married', NULL, '712389795951403', 'Yes', NULL, 6, 'Leone DuBuque', '47841623057584', 'Lorenamouth', '2028-01-11', NULL, NULL, NULL, NULL, NULL, 1757120023, 0, 0, 2, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(110, 2799, 2251, 'سامي أمجد رياض', 'Male', 3, 1, 1, '2001', 'الرياضيات', 'Very_Good', '2013-08-20', '52095596646857', '2026-06-14', 'New Floytown', 5, 'Muslim', 5, 'corwin.walton@example.org', 5, 11, 12, '0239690570', '0220373855', '01077190683', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '51038391293079', 'No', NULL, NULL, '2024-05-24', 'Employee', 9, 10, 'No', 'Yes', 3, '11.00', '7380.56', '246.02', 'Changeable', NULL, 'Yes', '611.67', '19616929696353', 'Yes', '566.52', '66730955329347', 'Visa', 'No', NULL, '47833 Avery Green\nNorth Ilenefort, WY 29729', 0, 'Married', NULL, '3397020490', 'Yes', NULL, 2, 'Dr. Milan Johnson IV', '18794357445342', 'Bradleyshire', '2028-01-28', NULL, NULL, NULL, NULL, NULL, 1594188305, 0, 0, 2, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(111, 4559, 1346, 'أماني نور سيف', 'Female', 4, 4, 4, '2012', 'إدارة الأعمال', 'Very_Good', '2015-04-08', '66262372704129', '2026-08-03', 'Nitzschebury', 7, 'Muslim', 5, 'luisa78@example.org', 1, 17, 1, '0224985119', '0239726751', '01162622993', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '36340425424346', 'Yes', NULL, NULL, '2022-01-29', 'Employee', 2, 11, 'No', 'No', 4, '12.00', '11881.92', '396.06', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '978.61', '41875557733684', 'Cach', 'No', NULL, '752 Kilback Manor\nRogahnland, KY 52626-6153', 0, 'Single', NULL, '0546409573551', 'Yes', NULL, 2, 'Lacey Huel V', '90886067261377', 'West Adelinestad', '2025-08-23', NULL, NULL, NULL, NULL, NULL, 613831177, 0, 0, 1, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(112, 5191, 335, 'يحيى سهيل محمود', 'Male', 3, 2, 6, '1982', 'إدارة الأعمال', 'Good', '2016-03-24', '33441916704945', '2027-01-18', 'West Roseburgh', 6, 'Christian', 9, 'karlie.marquardt@example.com', 3, 27, 3, '0230295475', '0230062871', '01053572247', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '73396665456433', 'Yes', NULL, NULL, '2023-08-07', 'Employee', 4, 12, 'No', 'Yes', 2, '10.00', '15055.10', '501.84', 'Fixed', '1161.20', 'No', NULL, NULL, 'Yes', '682.41', '49882691129140', 'Visa', 'No', NULL, '14669 Dayton Points Suite 603\nLangbury, NC 24312', 0, 'Single', NULL, '2764834131', 'Yes', NULL, 4, 'Aileen Smitham DDS', '62206828850439', 'Larsonborough', '2028-03-22', NULL, NULL, NULL, NULL, NULL, 1871125606, 0, 0, 1, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(113, 8352, 1805, 'توفيق مازن عبدالعزيز', 'Male', 3, 2, 6, '1986', 'إدارة الأعمال', 'Very_Good', '2008-06-11', '77334439410347', '2028-11-25', 'Metzburgh', 2, 'Christian', 4, 'torphy.birdie@example.net', 5, 18, 11, '0237539908', '0235186689', '01001929352', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '36477998186079', 'Yes', NULL, NULL, '2023-11-29', 'Employee', 9, 10, 'Yes', 'Yes', 4, '10.00', '9415.77', '313.86', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '2761 Cormier Drive Suite 096\nLake Celestineberg, NM 51097-6510', 0, 'Widowed', NULL, '8821869006', 'Yes', NULL, 1, 'Edyth Mosciski', '20889609693045', 'Lake Rupertfort', '2029-01-15', NULL, NULL, NULL, NULL, NULL, 610018933, 0, 0, 3, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(114, 9366, 867, 'عبدالكريم أديب آدم', 'Male', 3, 2, 5, '1988', 'الفيزياء', 'Fair', '2000-01-27', '61057501373562', '2025-04-23', 'South Marjolaine', 2, 'Muslim', 1, 'vena91@example.net', 3, 4, 2, '0230574137', '0235603577', '01064219252', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '31416155913030', 'Yes', NULL, NULL, '2022-11-15', 'Employee', 9, 15, 'Yes', 'Yes', 2, '11.00', '43671.22', '1455.71', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '447 Freda Vista Apt. 712\nProhaskatown, AK 05962-7803', 0, 'Married', NULL, '6020074642924708', 'Yes', NULL, 1, 'Christophe Bartoletti', '58169674672754', 'Oliverside', '2028-05-03', NULL, NULL, NULL, NULL, NULL, 1124341983, 0, 0, 4, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(115, 3716, 629, 'نسرين عمار إبراهيم', 'Female', 4, 4, 1, '1971', 'علوم الحاسوب', 'Good', '2019-09-09', '76386877934256', '2026-06-28', 'South Marc', 5, 'Christian', 6, 'kerluke.ryan@example.net', 6, 9, 12, '0234277660', '0228852963', '01070171937', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '38161583563898', 'Yes', NULL, NULL, '2022-09-05', 'Employee', 2, 19, 'No', 'No', 1, '8.00', '13039.23', '434.64', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '3204 Victoria Field Apt. 183\nBauchburgh, IL 53945-5427', 0, 'Divorced', NULL, '722397602', 'Yes', NULL, 5, 'Mr. Orland Gulgowski', '57326432536949', 'Octaviatown', '2029-08-08', NULL, NULL, NULL, NULL, NULL, 1094566760, 0, 0, 1, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(116, 8709, 1055, 'حنان عماد عبدالحي', 'Female', 1, 1, 3, '1997', 'الهندسة', 'Fair', '2004-01-04', '76679698143582', '2028-02-19', 'North Ryannchester', 5, 'Christian', 3, 'hoppe.lesley@example.net', 6, 21, 11, '0225240581', '0228519063', '01165198750', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '78291742113755', 'Yes', NULL, NULL, '2023-01-05', 'Employee', 1, 15, 'Yes', 'No', 3, '10.00', '17436.17', '581.21', 'Fixed', '1833.69', 'No', NULL, NULL, 'Yes', '640.47', '37294380193039', 'Visa', 'Yes', NULL, '9903 Gene Curve Apt. 792\nCharlieville, MO 40156', 0, 'Divorced', NULL, '3745937473', 'Yes', NULL, 6, 'Prof. Marianna Boyer', '21599048198869', 'Port Erick', '2025-01-09', NULL, NULL, NULL, NULL, NULL, 953244047, 0, 0, 1, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(117, 8380, 2332, 'أنور حذيفة محمد', 'Male', 2, 3, 2, '1989', 'الرياضيات', 'Fair', '2013-02-05', '91938945768346', '2027-10-14', 'Murazikfurt', 1, 'Muslim', 6, 'qarmstrong@example.net', 5, 12, 4, '0222000253', '0227847385', '01527735809', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '88834454874267', 'No', NULL, NULL, '2023-08-13', 'Employee', 9, 16, 'Yes', 'No', 2, '12.00', '24394.94', '813.16', 'Changeable', NULL, 'Yes', '810.32', '46207453855535', 'Yes', '540.55', '11422435425784', 'Cach', 'No', NULL, '7633 Wiza Walk\nWest Hannah, AK 20986', 0, 'Married', NULL, '911085201456', 'Yes', NULL, 1, 'Mr. Stephen Green DDS', '76111913770162', 'North Gavinmouth', '2029-01-25', NULL, NULL, NULL, NULL, NULL, 1801024945, 0, 0, 1, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(118, 1429, 2888, 'ناهد وجيه حمزة', 'Female', 2, 1, 3, '1976', 'إدارة الأعمال', 'Fair', '2011-06-12', '97135174766446', '2028-10-16', 'South Abbigail', 1, 'Muslim', 12, 'donnell55@example.net', 5, 18, 6, '0230606634', '0221274110', '01015915148', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '98800784922996', 'Yes', NULL, NULL, '2024-07-23', 'Employee', 6, 29, 'No', 'Yes', 1, '7.00', '10702.55', '356.75', 'Fixed', '1613.04', 'Yes', '634.63', '13538033959603', 'No', NULL, NULL, 'Cach', 'No', NULL, '7732 Will Branch\nMarilieton, DC 02768', 0, 'Single', NULL, '09295805', 'Yes', NULL, 5, 'Mr. Cole Carter', '52024388149986', 'Arvidstad', '2029-06-20', NULL, NULL, NULL, NULL, NULL, 137008243, 0, 0, 4, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54');
INSERT INTO `employees` (`id`, `employee_code`, `fp_code`, `name`, `gender`, `branch_id`, `job_grade_id`, `qualification_id`, `qualification_year`, `major`, `graduation_estimate`, `brith_date`, `national_id`, `end_national_id`, `national_id_place`, `blood_types_id`, `religion`, `language_id`, `email`, `country_id`, `governorate_id`, `city_id`, `home_telephone`, `work_telephone`, `mobile`, `military`, `military_date_from`, `military_date_to`, `military_wepon`, `military_exemption_date`, `military_exemption_reason`, `military_postponement_reason`, `date_resignation`, `resignation_reason`, `driving_license`, `driving_license_type`, `driving_License_id`, `has_relatives`, `relatives_details`, `notes`, `work_start_date`, `functional_status`, `department_id`, `job_categories_id`, `has_attendance`, `has_fixed_shift`, `shift_types_id`, `daily_work_hour`, `salary`, `day_price`, `motivation_type`, `motivation`, `social_insurance`, `social_insurance_cut_monthely`, `social_insurance_number`, `medical_insurance`, `medical_insurance_cut_monthely`, `medical_insurance_number`, `Type_salary_receipt`, `active_vacation`, `urgent_person_details`, `staies_address`, `children_number`, `social_status`, `resignation_id`, `bank_number_account`, `disabilities`, `disabilities_type`, `nationality_id`, `name_sponsor`, `pasport_identity`, `pasport_from_place`, `pasport_exp_date`, `num_vacation_days`, `add_service`, `years_service`, `cv`, `basic_address_country`, `fixed_allowances`, `is_done_Vacation_formula`, `is_Sensitive_manager_data`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(119, 5707, 1941, 'دنيا تامر مالك', 'Female', 3, 2, 5, '1981', 'علم الأحياء', 'Good', '2004-09-02', '49966816072771', '2027-12-05', 'Thompsonview', 2, 'Christian', 7, 'jaydon.cormier@example.com', 6, 24, 4, '0224921822', '0225448935', '01519118908', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '88295035455892', 'No', NULL, NULL, '2022-02-05', 'Employee', 6, 6, 'Yes', 'Yes', 1, '9.00', '46426.00', '1547.53', 'Fixed', '1091.93', 'No', NULL, NULL, 'Yes', '899.75', '87537235421548', 'Cach', 'Yes', NULL, '3103 Rath Village Apt. 445\nNew Branson, SD 61533-7676', 0, 'Single', NULL, '943062491215', 'Yes', NULL, 5, 'Miss Elda Leannon', '54102418420321', 'New Ivyberg', '2028-08-31', NULL, NULL, NULL, NULL, NULL, 1421328237, 0, 0, 1, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(120, 1891, 2636, 'نور بكر ماهر', 'Male', 3, 4, 3, '1985', 'علوم الحاسوب', 'Fair', '2001-07-26', '17146614127943', '2026-07-29', 'Gerholdburgh', 3, 'Christian', 8, 'njohns@example.net', 4, 10, 7, '0235992281', '0230992576', '01247413132', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '75694125942514', 'Yes', NULL, NULL, '2022-04-20', 'Employee', 8, 25, 'Yes', 'Yes', 1, '12.00', '39800.97', '1326.70', 'Fixed', '1141.86', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '377 Angelo Mews Suite 664\nEast Lloydfort, NE 54177-4975', 0, 'Widowed', NULL, '495838404', 'Yes', NULL, 5, 'Barrett Ritchie', '92589334783801', 'Herbertchester', '2028-12-27', NULL, NULL, NULL, NULL, NULL, 103665354, 0, 0, 3, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(121, 4580, 2675, 'آلاء سعيد جمال', 'Female', 3, 2, 1, '1992', 'الرياضيات', 'Good', '2022-01-13', '68939697934358', '2027-05-10', 'West Derick', 2, 'Christian', 3, 'plubowitz@example.com', 1, 6, 10, '0226154385', '0224460562', '01222807005', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '49672323283553', 'No', NULL, NULL, '2023-06-30', 'Employee', 6, 13, 'Yes', 'Yes', 2, '12.00', '8253.54', '275.12', 'Changeable', NULL, 'Yes', '750.93', '41456884309012', 'No', NULL, NULL, 'Visa', 'No', NULL, '19934 Joelle Road Apt. 559\nMariestad, SD 03444', 0, 'Single', NULL, '49941634746225', 'Yes', NULL, 3, 'Federico O\'Keefe', '41692081431235', 'New Grover', '2028-01-21', NULL, NULL, NULL, NULL, NULL, 1107158535, 0, 0, 3, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(122, 6268, 1222, 'يوسف سامر لؤي', 'Male', 2, 3, 3, '1999', 'علوم الحاسوب', 'Fair', '2023-06-06', '49742083989147', '2026-09-06', 'Maggiofurt', 6, 'Muslim', 3, 'vblock@example.org', 2, 19, 8, '0221510629', '0236375053', '01191035146', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '84999138395178', 'Yes', NULL, NULL, '2023-09-28', 'Employee', 2, 9, 'Yes', 'Yes', 4, '10.00', '7636.29', '254.54', 'Changeable', NULL, 'Yes', '619.80', '73191949157058', 'Yes', '643.57', '24108425575147', 'Visa', 'Yes', NULL, '5114 Oberbrunner Expressway\nVicentafurt, IL 77156-1084', 0, 'Single', NULL, '04949389688889', 'Yes', NULL, 4, 'Kyler McGlynn', '68791511909858', 'Hesselbury', '2027-12-24', NULL, NULL, NULL, NULL, NULL, 1878658407, 0, 0, 1, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(123, 9518, 2387, 'معاذ عبدالباسط ناجي', 'Male', 2, 2, 4, '1972', 'علم الأحياء', 'Excellent', '2003-01-07', '72453170868305', '2028-11-12', 'Ninaburgh', 3, 'Christian', 1, 'sanford.garrick@example.net', 1, 19, 12, '0228354626', '0231064166', '01505120900', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '57755467269843', 'Yes', NULL, NULL, '2022-05-04', 'Employee', 3, 29, 'Yes', 'Yes', 3, '11.00', '28666.59', '955.55', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '993.77', '15955449553022', 'Visa', 'Yes', NULL, '849 Bruen Mews\nLake Nestorside, VT 07746', 0, 'Single', NULL, '4820745181726', 'Yes', NULL, 2, 'Dr. Federico Wiegand', '63860881701917', 'Giovannyfort', '2027-06-03', NULL, NULL, NULL, NULL, NULL, 1713007885, 0, 0, 4, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(124, 6426, 2497, 'بتول رامز مالك', 'Female', 2, 1, 5, '1988', 'الفيزياء', 'Very_Good', '2005-10-28', '67503309218953', '2025-07-31', 'Fisherfort', 4, 'Christian', 11, 'schoen.rowena@example.com', 4, 5, 8, '0238533328', '0239982259', '01125534813', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '98279223789065', 'No', NULL, NULL, '2020-07-31', 'Employee', 5, 19, 'Yes', 'Yes', 3, '11.00', '43909.81', '1463.66', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '909.02', '35893828575621', 'Cach', 'Yes', NULL, '104 Pfannerstill Plaza Suite 167\nWest Weston, LA 07466', 0, 'Widowed', NULL, '8116642757558', 'Yes', NULL, 2, 'Wendell Schmeler', '86408722746736', 'Abbottmouth', '2029-07-15', NULL, NULL, NULL, NULL, NULL, 310912157, 0, 0, 1, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(125, 3006, 2459, 'فرح سيف صابر', 'Female', 3, 3, 3, '1977', 'علوم الحاسوب', 'Excellent', '2017-04-28', '18487683203680', '2025-04-24', 'Davismouth', 1, 'Christian', 4, 'wferry@example.com', 5, 9, 6, '0234892769', '0229262383', '01191645856', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '55490556319481', 'Yes', NULL, NULL, '2022-11-04', 'Employee', 3, 23, 'No', 'Yes', 1, '8.00', '35460.80', '1182.03', 'Fixed', '1165.82', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '77087 Barrows Gardens\nGayside, OH 63126', 0, 'Single', NULL, '687217471321', 'Yes', NULL, 4, 'Prof. Ulices Goyette', '52375343360938', 'North Noreneborough', '2027-07-29', NULL, NULL, NULL, NULL, NULL, 896141614, 0, 0, 2, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(126, 6200, 2185, 'غادة سامر شاكر', 'Female', 1, 4, 3, '2004', 'علوم الحاسوب', 'Very_Good', '2005-07-01', '21341043267887', '2027-02-28', 'North Havenbury', 7, 'Christian', 10, 'zdoyle@example.net', 1, 18, 15, '0231689646', '0233358649', '01232789524', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '46191216997518', 'No', NULL, NULL, '2022-01-27', 'Employee', 8, 21, 'Yes', 'Yes', 3, '11.00', '14882.29', '496.08', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '844.73', '40955307072780', 'Visa', 'Yes', NULL, '668 Hertha Shoal Suite 159\nGeraldland, ID 49533', 0, 'Married', NULL, '4239978', 'Yes', NULL, 4, 'Fay Kiehn', '81843732389357', 'Homenickside', '2025-07-05', NULL, NULL, NULL, NULL, NULL, 812003639, 0, 0, 1, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(127, 4789, 2103, 'محمود جمال عبدالفتاح', 'Male', 2, 2, 2, '1986', 'إدارة الأعمال', 'Good', '2019-03-09', '13201272922493', '2026-04-23', 'Lake Wendy', 6, 'Muslim', 7, 'abagail39@example.com', 2, 25, 4, '0229807045', '0237124185', '01230028590', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '94670164598470', 'No', NULL, NULL, '2024-09-19', 'Employee', 1, 23, 'Yes', 'Yes', 3, '12.00', '20202.58', '673.42', 'Fixed', '1676.86', 'Yes', '662.53', '82127368257037', 'Yes', '828.13', '89594295969182', 'Visa', 'Yes', NULL, '71643 Jerrell Rapids\nOdabury, WY 15917', 0, 'Married', NULL, '146753206625', 'Yes', NULL, 5, 'Jessie Langosh', '89642274205998', 'North Shirley', '2028-11-23', NULL, NULL, NULL, NULL, NULL, 307229095, 0, 0, 3, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(128, 6222, 2186, 'زيد عبدالحميد عماد', 'Male', 2, 3, 2, '1981', 'الفيزياء', 'Fair', '2022-06-18', '02416157237867', '2028-05-08', 'East Elmorefurt', 5, 'Christian', 1, 'zstanton@example.com', 1, 7, 5, '0223428950', '0223203239', '01043964524', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '38938049736503', 'Yes', NULL, NULL, '2020-08-29', 'Employee', 2, 24, 'No', 'Yes', 4, '7.00', '17553.18', '585.11', 'Fixed', '1421.17', 'Yes', '618.59', '83322366198582', 'Yes', '998.68', '79260110660794', 'Cach', 'No', NULL, '2820 O\'Conner Path\nRueckerside, AR 34855', 0, 'Widowed', NULL, '0074456817', 'Yes', NULL, 3, 'Linda Ward', '90610432107623', 'Juliusfurt', '2029-11-25', NULL, NULL, NULL, NULL, NULL, 1383439823, 0, 0, 4, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(129, 2309, 614, 'روى ربيع أحمد', 'Female', 4, 1, 1, '1986', 'علوم الحاسوب', 'Good', '2016-12-26', '07396775983842', '2026-03-10', 'Port Reggie', 3, 'Christian', 2, 'steuber.hilton@example.org', 3, 26, 8, '0238397513', '0226192368', '01241172203', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '55120845615578', 'No', NULL, NULL, '2020-04-26', 'Employee', 6, 5, 'No', 'No', 4, '10.00', '28809.83', '960.33', 'Changeable', NULL, 'Yes', '615.48', '26823054350118', 'Yes', '974.96', '45509195933773', 'Cach', 'No', NULL, '140 Minerva Branch\nZulaufside, NV 34003-7525', 0, 'Single', NULL, '529516298323', 'Yes', NULL, 2, 'Everardo Christiansen', '29490061923991', 'Michelside', '2029-12-13', NULL, NULL, NULL, NULL, NULL, 1180720838, 0, 0, 3, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(130, 9379, 1152, 'روان لؤي ماهر', 'Female', 1, 4, 1, '1988', 'علم الأحياء', 'Very_Good', '2015-06-06', '01210463594942', '2025-02-05', 'Port Lillyborough', 1, 'Christian', 1, 'jovani.mayer@example.org', 5, 11, 6, '0225336801', '0232439720', '01024110743', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '81933726202076', 'Yes', NULL, NULL, '2020-02-06', 'Employee', 3, 26, 'Yes', 'No', 1, '10.00', '12927.07', '430.90', 'Changeable', NULL, 'Yes', '554.24', '52295821597205', 'Yes', '515.44', '48512607870223', 'Visa', 'No', NULL, '81152 Lind Springs Suite 646\nMonteshire, CA 59965', 0, 'Widowed', NULL, '1417685', 'Yes', NULL, 4, 'Michaela Jones DDS', '51488031703593', 'Donnyport', '2028-11-06', NULL, NULL, NULL, NULL, NULL, 1846515656, 0, 0, 4, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(131, 8247, 2601, 'هيثم عامر نبيل', 'Male', 2, 2, 2, '2002', 'علم الأحياء', 'Excellent', '2006-04-04', '15395856142206', '2028-11-09', 'Padbergton', 6, 'Christian', 8, 'spencer.wilson@example.com', 1, 21, 4, '0224608114', '0223176296', '01554227585', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '55203575385622', 'No', NULL, NULL, '2021-08-31', 'Employee', 2, 24, 'No', 'Yes', 2, '9.00', '18508.36', '616.95', 'Fixed', '1493.53', 'Yes', '914.56', '70359014011283', 'No', NULL, NULL, 'Cach', 'No', NULL, '9689 Hirthe Fields Apt. 426\nNew Noelland, ID 15124-3185', 0, 'Married', NULL, '78347385990', 'Yes', NULL, 6, 'Jacynthe Boyer II', '41384210119009', 'Lake Savannah', '2028-11-13', NULL, NULL, NULL, NULL, NULL, 937563541, 0, 0, 3, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(132, 8103, 1884, 'مايا طلال قاسم', 'Female', 2, 1, 4, '1990', 'الهندسة', 'Excellent', '2016-10-19', '14143274584715', '2027-07-24', 'North Hubert', 2, 'Muslim', 11, 'brittany08@example.org', 5, 16, 5, '0231558524', '0232763276', '01036141165', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '48085925409774', 'No', NULL, NULL, '2020-12-13', 'Employee', 6, 16, 'No', 'No', 4, '7.00', '46285.93', '1542.86', 'Fixed', '1067.65', 'Yes', '867.65', '15366649764167', 'Yes', '711.99', '92436449813467', 'Cach', 'No', NULL, '2419 Jeanette Meadows Apt. 187\nNolanhaven, GA 37758-5680', 0, 'Married', NULL, '20923692629061', 'Yes', NULL, 4, 'Sabrina Grady', '14962323878814', 'Kristopherchester', '2029-11-20', NULL, NULL, NULL, NULL, NULL, 1914257105, 0, 0, 3, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(133, 6308, 1240, 'هدى إلياس سامر', 'Female', 3, 2, 1, '1976', 'علم الأحياء', 'Excellent', '2009-09-07', '37878947595167', '2025-08-08', 'Ernserview', 6, 'Muslim', 7, 'champlin.maximillian@example.com', 5, 19, 7, '0232754241', '0232175356', '01257345639', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '52703146301958', 'No', NULL, NULL, '2024-09-07', 'Employee', 6, 27, 'No', 'Yes', 4, '12.00', '35194.37', '1173.15', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '628.77', '99012489495537', 'Visa', 'Yes', NULL, '17381 Bahringer Valley\nLilyport, NM 84005-3299', 0, 'Widowed', NULL, '9415296741', 'Yes', NULL, 3, 'Daija Turcotte', '19908834222525', 'Malloryberg', '2025-01-22', NULL, NULL, NULL, NULL, NULL, 1613017237, 0, 0, 3, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(134, 7608, 1017, 'سليمان وجيه توفيق', 'Male', 3, 3, 6, '2003', 'الهندسة', 'Good', '2006-08-15', '88631589289492', '2027-01-21', 'Lake Autumn', 1, 'Muslim', 1, 'abshire.aric@example.net', 6, 17, 7, '0228213716', '0230109401', '01106033937', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '39263991393105', 'No', NULL, NULL, '2020-09-11', 'Employee', 7, 4, 'Yes', 'No', 3, '10.00', '12728.56', '424.29', 'Fixed', '1843.48', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '39514 Schimmel Trafficway\nBomouth, NY 85824', 0, 'Widowed', NULL, '82038542804', 'Yes', NULL, 5, 'Reta Halvorson', '35814543892312', 'East Dustin', '2027-08-30', NULL, NULL, NULL, NULL, NULL, 7123332, 0, 0, 3, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(135, 5958, 1462, 'زينب نبيل منصور', 'Female', 2, 1, 2, '1973', 'الرياضيات', 'Good', '2009-04-01', '21821162073204', '2027-01-03', 'Schmidtborough', 1, 'Christian', 4, 'murphy.jake@example.org', 3, 7, 6, '0224030465', '0239544276', '01254770161', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '93177113825262', 'No', NULL, NULL, '2020-02-03', 'Employee', 6, 18, 'Yes', 'No', 1, '11.00', '46018.65', '1533.96', 'Fixed', '1213.01', 'No', NULL, NULL, 'Yes', '865.74', '87418787760560', 'Cach', 'No', NULL, '59919 Ullrich Station\nHowellfort, AK 36842', 0, 'Single', NULL, '7668509', 'Yes', NULL, 6, 'Candida Dickinson', '57784175224573', 'East Jeannetown', '2028-03-19', NULL, NULL, NULL, NULL, NULL, 147787976, 0, 0, 2, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(136, 9964, 2029, 'ليان توفيق عادل', 'Female', 3, 2, 1, '2008', 'الفيزياء', 'Very_Good', '2002-06-02', '23394222789278', '2028-05-24', 'East Brooklyn', 5, 'Christian', 7, 'mallory26@example.net', 2, 3, 3, '0235831569', '0228817224', '01022514485', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '71554390336515', 'No', NULL, NULL, '2022-11-22', 'Employee', 6, 24, 'Yes', 'Yes', 4, '9.00', '15326.64', '510.89', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '636.00', '83847796132551', 'Cach', 'Yes', NULL, '8107 Rogahn Divide\nNorth Natton, TN 25039', 0, 'Widowed', NULL, '76446901980', 'Yes', NULL, 2, 'Kiana Hettinger', '57384601859400', 'South Kalifurt', '2026-03-25', NULL, NULL, NULL, NULL, NULL, 644736375, 0, 0, 3, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(137, 5868, 2609, 'سليمان عبدالرحمن نور', 'Male', 3, 3, 4, '2011', 'علوم الحاسوب', 'Good', '2007-05-09', '26433056630612', '2026-01-07', 'Cruickshankville', 5, 'Christian', 7, 'nschuppe@example.org', 2, 22, 9, '0233526690', '0226287774', '01574525806', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '97919783406136', 'Yes', NULL, NULL, '2021-09-17', 'Employee', 2, 7, 'Yes', 'Yes', 1, '9.00', '27747.51', '924.92', 'Changeable', NULL, 'Yes', '588.17', '32352998849360', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '6740 Christiansen Square Suite 333\nPalmaside, ND 18872-2426', 0, 'Single', NULL, '251796374890', 'Yes', NULL, 5, 'Treva Nitzsche', '54755386026218', 'Cliftonville', '2025-03-16', NULL, NULL, NULL, NULL, NULL, 1171685043, 0, 0, 3, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(138, 6234, 1671, 'تالين سامر نبيل', 'Female', 1, 1, 5, '1998', 'علم الأحياء', 'Fair', '2009-08-25', '40098724074153', '2026-12-22', 'Cronintown', 3, 'Muslim', 5, 'wbartell@example.org', 5, 21, 1, '0227179407', '0231976253', '01017547380', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '26199121242085', 'Yes', NULL, NULL, '2022-04-05', 'Employee', 5, 7, 'No', 'Yes', 4, '7.00', '23728.18', '790.94', 'Fixed', '1627.21', 'Yes', '694.92', '33660970058838', 'Yes', '995.91', '89228911841436', 'Cach', 'No', NULL, '433 Anabelle Pines\nLake Ova, HI 85780', 0, 'Divorced', NULL, '581323', 'Yes', NULL, 4, 'Ansley Orn', '82712949203262', 'West Jordan', '2029-11-14', NULL, NULL, NULL, NULL, NULL, 1466577285, 0, 0, 4, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(139, 6322, 1870, 'جمال مازن رائد', 'Male', 2, 1, 5, '2008', 'علوم الحاسوب', 'Very_Good', '2013-08-22', '34804608142061', '2028-08-03', 'Shadfurt', 3, 'Christian', 3, 'pyundt@example.net', 2, 25, 13, '0220605248', '0221914093', '01152844476', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '55511300305220', 'Yes', NULL, NULL, '2022-01-03', 'Employee', 3, 4, 'Yes', 'Yes', 2, '8.00', '43879.44', '1462.65', 'Fixed', '1066.74', 'Yes', '824.33', '10315935062437', 'No', NULL, NULL, 'Visa', 'No', NULL, '1886 Missouri Terrace\nIsaiasburgh, WV 18032-9676', 0, 'Married', NULL, '788126751292', 'Yes', NULL, 5, 'Horace Jerde', '64747117501127', 'Hollieberg', '2029-02-14', NULL, NULL, NULL, NULL, NULL, 1618301147, 0, 0, 4, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(140, 2075, 1651, 'راغب رفيق مصطفى', 'Male', 1, 4, 5, '2010', 'الفيزياء', 'Good', '2017-01-09', '44152117034182', '2026-01-09', 'Reillyview', 7, 'Christian', 2, 'rath.bailey@example.com', 5, 5, 14, '0232557151', '0222874603', '01594772643', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '80791568988529', 'No', NULL, NULL, '2021-01-03', 'Employee', 9, 15, 'No', 'Yes', 3, '12.00', '48156.80', '1605.23', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '76260 Leonardo Skyway\nLouveniachester, SC 65499', 0, 'Divorced', NULL, '45480202199913', 'Yes', NULL, 3, 'Erna Pagac', '91483814023378', 'New Linwoodberg', '2029-05-04', NULL, NULL, NULL, NULL, NULL, 1100326012, 0, 0, 3, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(141, 1642, 1192, 'هاجر وائل توفيق', 'Female', 3, 1, 6, '2004', 'الرياضيات', 'Excellent', '2024-07-08', '34957831786701', '2027-08-24', 'East Walkerton', 4, 'Christian', 12, 'fhintz@example.net', 1, 27, 15, '0239411224', '0236669213', '01527018198', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '76304745433485', 'No', NULL, NULL, '2023-04-13', 'Employee', 6, 13, 'No', 'No', 4, '10.00', '45551.80', '1518.39', 'Fixed', '1384.85', 'Yes', '578.61', '70186976386404', 'Yes', '522.79', '97443573672243', 'Cach', 'Yes', NULL, '42176 Orpha Creek Suite 378\nZachariahshire, MT 60902-4466', 0, 'Divorced', NULL, '82456464059', 'Yes', NULL, 5, 'Araceli Langworth', '58417758653829', 'Port Davonteside', '2029-07-17', NULL, NULL, NULL, NULL, NULL, 2028685326, 0, 0, 1, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(142, 8973, 163, 'يوسف سعيد بدر', 'Male', 2, 1, 6, '1984', 'علم الأحياء', 'Fair', '2005-01-05', '83656934530840', '2025-06-19', 'Lindgrenport', 5, 'Christian', 3, 'mkertzmann@example.org', 6, 5, 1, '0233047232', '0221058499', '01152329660', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '84233407859111', 'Yes', NULL, NULL, '2021-04-16', 'Employee', 2, 28, 'No', 'No', 2, '10.00', '32650.95', '1088.37', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '752.78', '20631753522496', 'Cach', 'Yes', NULL, '9832 McLaughlin Avenue\nStokesside, NV 17104-7458', 0, 'Widowed', NULL, '6341507819', 'Yes', NULL, 3, 'Deron Hane', '67562593466673', 'Dorothyton', '2028-06-14', NULL, NULL, NULL, NULL, NULL, 1042219030, 0, 0, 4, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(143, 6597, 2568, 'وفاء طارق عبدالرزاق', 'Female', 4, 1, 1, '1993', 'علم الأحياء', 'Fair', '2021-03-12', '04851424328655', '2028-07-22', 'North Claudiahaven', 6, 'Muslim', 13, 'hermann.mallie@example.net', 4, 3, 8, '0230499876', '0235480965', '01213147329', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '88391514271073', 'No', NULL, NULL, '2022-06-05', 'Employee', 10, 23, 'No', 'Yes', 4, '12.00', '9959.47', '331.98', 'Fixed', '1125.24', 'Yes', '788.89', '04824546735096', 'Yes', '692.87', '72895446316453', 'Cach', 'No', NULL, '6260 Rutherford Shores\nLydiashire, NY 31420-3810', 0, 'Divorced', NULL, '6150682199651', 'Yes', NULL, 2, 'Emilio Fritsch', '72942891278580', 'East Dolly', '2025-06-29', NULL, NULL, NULL, NULL, NULL, 1184382374, 0, 0, 1, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(144, 6312, 263, 'أميرة طلال سامر', 'Female', 2, 1, 2, '2001', 'علوم الحاسوب', 'Very_Good', '2020-04-24', '30874508568366', '2025-11-01', 'Rooseveltfort', 6, 'Christian', 7, 'brekke.geraldine@example.com', 6, 3, 1, '0233669881', '0239567937', '01588634962', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '53488835942342', 'No', NULL, NULL, '2022-12-12', 'Employee', 3, 18, 'Yes', 'No', 3, '9.00', '26673.17', '889.11', 'Fixed', '1930.23', 'No', NULL, NULL, 'Yes', '878.38', '99038713693470', 'Visa', 'No', NULL, '439 Arlo Hollow\nLake Aurelio, AR 72882-9749', 0, 'Widowed', NULL, '9279035708', 'Yes', NULL, 5, 'Tyrique Gutmann', '07585675893952', 'New Gonzaloshire', '2028-01-09', NULL, NULL, NULL, NULL, NULL, 1148796700, 0, 0, 2, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(145, 2608, 1225, 'سامر فارس علي', 'Male', 2, 2, 5, '1985', 'علم الأحياء', 'Fair', '2006-08-11', '43398763389229', '2027-05-07', 'Reingerville', 4, 'Christian', 7, 'hegmann.mattie@example.com', 2, 26, 11, '0231596645', '0228045452', '01258834467', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '37566601742947', 'Yes', NULL, NULL, '2023-10-22', 'Employee', 2, 9, 'Yes', 'Yes', 1, '12.00', '10671.91', '355.73', 'Fixed', '1737.76', 'No', NULL, NULL, 'Yes', '778.25', '93409031421176', 'Visa', 'No', NULL, '479 Candida Way\nNorth Providencibury, WV 21781-4017', 0, 'Married', NULL, '4096211652', 'Yes', NULL, 4, 'Sadie Breitenberg', '65684225748614', 'Loyaltown', '2026-11-25', NULL, NULL, NULL, NULL, NULL, 112234902, 0, 0, 3, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(146, 8881, 888, 'هناء بكر سهيل', 'Female', 1, 4, 3, '2004', 'علوم الحاسوب', 'Very_Good', '2013-01-16', '53201424902691', '2025-05-15', 'Borerburgh', 2, 'Muslim', 12, 'kristian17@example.com', 6, 14, 6, '0221517894', '0231253708', '01170012467', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '48755365153742', 'Yes', NULL, NULL, '2021-02-11', 'Employee', 9, 28, 'Yes', 'No', 2, '12.00', '46203.28', '1540.11', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '643 Boyle Mount Suite 599\nLake Mariettaview, MT 31898', 0, 'Married', NULL, '40106415', 'Yes', NULL, 2, 'Austin Cruickshank', '66797172195083', 'East Garnett', '2025-06-10', NULL, NULL, NULL, NULL, NULL, 1581661141, 0, 0, 3, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(147, 7288, 2935, 'نسرين أنور عادل', 'Female', 4, 4, 2, '2014', 'علوم الحاسوب', 'Excellent', '2019-06-08', '16187160992155', '2027-09-01', 'Norafurt', 7, 'Muslim', 12, 'kautzer.angelica@example.net', 6, 11, 12, '0230932137', '0222221498', '01276189260', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '77197091975713', 'No', NULL, NULL, '2020-10-03', 'Employee', 1, 26, 'No', 'Yes', 4, '12.00', '22145.74', '738.19', 'Fixed', '1705.23', 'Yes', '759.98', '07000703178979', 'Yes', '829.26', '44780075928885', 'Cach', 'Yes', NULL, '7588 Doyle Underpass\nHerzogburgh, VA 57280', 0, 'Single', NULL, '798884441584', 'Yes', NULL, 2, 'Dr. Immanuel Turcotte', '27474113852865', 'Maurinetown', '2027-05-15', NULL, NULL, NULL, NULL, NULL, 208480947, 0, 0, 2, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(148, 6499, 2544, 'ثريا إسماعيل صهيب', 'Female', 2, 4, 5, '1970', 'علم الأحياء', 'Good', '2019-08-07', '45461008854889', '2026-09-29', 'West Rebeca', 6, 'Christian', 7, 'breitenberg.bartholome@example.net', 3, 2, 2, '0229847916', '0232118921', '01125398103', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '63789414377448', 'Yes', NULL, NULL, '2022-08-15', 'Employee', 4, 12, 'No', 'Yes', 3, '8.00', '25879.54', '862.65', 'Fixed', '1712.68', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '944 Cole Canyon\nSchneidertown, KS 84389-1103', 0, 'Divorced', NULL, '83377963996', 'Yes', NULL, 2, 'Priscilla Schmidt', '49038401713576', 'Pfefferhaven', '2028-12-21', NULL, NULL, NULL, NULL, NULL, 1450956199, 0, 0, 2, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(149, 6579, 1713, 'صفا حذيفة طارق', 'Female', 2, 1, 5, '1996', 'إدارة الأعمال', 'Excellent', '2003-12-16', '92313516846868', '2029-11-19', 'New Lester', 2, 'Muslim', 8, 'billie64@example.net', 3, 16, 7, '0222764087', '0231256046', '01054663731', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '74278484649720', 'Yes', NULL, NULL, '2022-06-05', 'Employee', 4, 13, 'No', 'Yes', 4, '9.00', '31976.64', '1065.89', 'Fixed', '1988.62', 'No', NULL, NULL, 'Yes', '745.14', '51545156440075', 'Visa', 'Yes', NULL, '322 Kali Wells\nJohannton, VA 91560-2081', 0, 'Single', NULL, '713989512', 'Yes', NULL, 2, 'Eula Leffler', '30608794760798', 'North Sabrynabury', '2026-09-10', NULL, NULL, NULL, NULL, NULL, 412048261, 0, 0, 2, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(150, 8681, 301, 'إسماعيل عامر عبدالحميد', 'Male', 4, 4, 5, '1977', 'الفيزياء', 'Excellent', '2007-02-27', '62491312382646', '2028-01-16', 'New Jaylentown', 1, 'Muslim', 1, 'mlesch@example.org', 6, 11, 5, '0226734533', '0233636453', '01068581384', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '36335907982696', 'Yes', NULL, NULL, '2024-01-25', 'Employee', 4, 2, 'No', 'Yes', 4, '8.00', '37681.44', '1256.05', 'Fixed', '1384.32', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '93021 Dach Mountains Apt. 518\nHerzogfurt, ID 48062-8820', 0, 'Divorced', NULL, '6027838627', 'Yes', NULL, 3, 'Savanah Harber', '31786574733158', 'O\'Connellport', '2027-05-31', NULL, NULL, NULL, NULL, NULL, 2059775047, 0, 0, 2, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(151, 4090, 2264, 'مارين جمال أيمن', 'Female', 1, 1, 1, '1980', 'الهندسة', 'Excellent', '2011-10-05', '96780764552104', '2025-09-20', 'Kunzemouth', 5, 'Christian', 2, 'bernadette.moore@example.net', 3, 18, 2, '0227038543', '0232842260', '01275176466', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '80842466682667', 'Yes', NULL, NULL, '2020-01-18', 'Employee', 9, 14, 'No', 'No', 4, '7.00', '35804.87', '1193.50', 'Fixed', '1014.83', 'Yes', '516.39', '56340787554003', 'Yes', '652.96', '81628181476166', 'Visa', 'No', NULL, '9081 Volkman Summit\nWest Valerieburgh, AK 00424-9374', 0, 'Single', NULL, '714191331905', 'Yes', NULL, 1, 'Jon Feest', '37491968327402', 'Akeemhaven', '2027-11-25', NULL, NULL, NULL, NULL, NULL, 490858077, 0, 0, 3, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(152, 9384, 2161, 'إلياس زياد إبراهيم', 'Male', 1, 4, 4, '2000', 'الرياضيات', 'Very_Good', '2008-06-04', '16999999136924', '2028-01-16', 'South Fridatown', 1, 'Christian', 5, 'gfeest@example.com', 3, 3, 8, '0233758032', '0238282705', '01166890162', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '32429399217964', 'No', NULL, NULL, '2023-02-16', 'Employee', 8, 10, 'Yes', 'No', 1, '11.00', '7139.84', '237.99', 'Changeable', NULL, 'Yes', '585.49', '97845444950109', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '13280 Tara Summit\nPort Chadrickville, MD 67526', 0, 'Single', NULL, '00690615', 'Yes', NULL, 1, 'Caitlyn Ondricka', '03862947596005', 'North Karen', '2027-06-16', NULL, NULL, NULL, NULL, NULL, 1331769398, 0, 0, 2, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(153, 8577, 1797, 'باسم ثامر نبيل', 'Male', 1, 3, 2, '1992', 'الفيزياء', 'Excellent', '2009-01-09', '40972451255803', '2025-04-05', 'West Zenaborough', 2, 'Muslim', 6, 'camden17@example.com', 3, 4, 7, '0225732826', '0220757034', '01154752927', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '46751067978543', 'Yes', NULL, NULL, '2023-02-27', 'Employee', 4, 24, 'Yes', 'No', 3, '9.00', '9882.53', '329.42', 'Fixed', '1706.39', 'No', NULL, NULL, 'Yes', '647.70', '42623809010577', 'Cach', 'Yes', NULL, '5870 Rohan Orchard\nSteuberton, ID 34488-7046', 0, 'Divorced', NULL, '9861048', 'Yes', NULL, 1, 'Maryjane Rau', '29016135761062', 'Whiteton', '2029-08-31', NULL, NULL, NULL, NULL, NULL, 646018397, 0, 0, 3, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(154, 5333, 1358, 'وفاء عمار منصور', 'Female', 3, 1, 6, '2011', 'الفيزياء', 'Fair', '2001-03-04', '79057758990222', '2026-09-04', 'Stiedemannmouth', 3, 'Muslim', 6, 'abigayle92@example.com', 6, 24, 3, '0238551877', '0238294097', '01283794004', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '19831604432542', 'No', NULL, NULL, '2021-03-18', 'Employee', 2, 23, 'No', 'Yes', 2, '10.00', '41471.58', '1382.39', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '703 Edythe Run\nEleanoremouth, MD 72159', 0, 'Single', NULL, '7020366319', 'Yes', NULL, 3, 'Doyle Reilly', '72185388658165', 'Maribelland', '2028-07-10', NULL, NULL, NULL, NULL, NULL, 192859071, 0, 0, 2, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(155, 6210, 1736, 'قاسم سهيل عامر', 'Male', 2, 2, 4, '1990', 'الهندسة', 'Good', '2003-09-20', '99826066113070', '2027-08-07', 'Hirtheview', 1, 'Muslim', 8, 'elda92@example.net', 3, 13, 9, '0228000908', '0233833789', '01142957091', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '52495210046254', 'Yes', NULL, NULL, '2023-04-13', 'Employee', 7, 4, 'Yes', 'Yes', 2, '10.00', '8065.09', '268.84', 'Fixed', '1686.48', 'Yes', '738.03', '01349813924335', 'No', NULL, NULL, 'Visa', 'No', NULL, '8518 Goyette Street Apt. 187\nLebsackside, ID 40210', 0, 'Single', NULL, '45352472051', 'Yes', NULL, 6, 'Prof. Keith O\'Connell DVM', '36805688807712', 'Kaseyview', '2028-11-22', NULL, NULL, NULL, NULL, NULL, 176604373, 0, 0, 4, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(156, 5066, 2795, 'غادة عدنان كريم', 'Female', 3, 3, 6, '1987', 'علوم الحاسوب', 'Very_Good', '2007-10-02', '17337428719026', '2029-05-21', 'Bartolettifort', 5, 'Muslim', 2, 'mose.auer@example.org', 2, 3, 14, '0237446267', '0230820863', '01203586345', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '26540755194633', 'No', NULL, NULL, '2021-07-08', 'Employee', 10, 12, 'No', 'Yes', 2, '11.00', '36512.05', '1217.07', 'Fixed', '1016.22', 'Yes', '610.63', '75943911124645', 'Yes', '975.90', '07442517003132', 'Cach', 'Yes', NULL, '101 Blanche Walks\nSouth Kelliemouth, GA 56758', 0, 'Single', NULL, '70025235060', 'Yes', NULL, 1, 'Miss Filomena Grimes', '54019038662426', 'Freedashire', '2028-12-20', NULL, NULL, NULL, NULL, NULL, 630086233, 0, 0, 2, NULL, 1, '2024-12-13 13:29:54', '2024-12-13 13:29:54'),
(157, 5589, 2232, 'قاسم نور زيد', 'Male', 1, 2, 1, '2000', 'إدارة الأعمال', 'Very_Good', '2015-08-24', '86335579626055', '2028-06-11', 'Port Rexmouth', 3, 'Muslim', 6, 'huel.ansel@example.net', 2, 13, 3, '0230491087', '0234212591', '01180052310', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '30240587757105', 'Yes', NULL, NULL, '2021-04-28', 'Employee', 10, 25, 'Yes', 'Yes', 3, '12.00', '41620.99', '1387.37', 'Fixed', '1995.46', 'No', NULL, NULL, 'Yes', '591.97', '60885811993742', 'Cach', 'No', NULL, '96497 Marlee Corners Suite 360\nJairoburgh, NE 83841-2991', 0, 'Divorced', NULL, '4248979335', 'Yes', NULL, 4, 'Dr. Adelia Howe', '70086256192083', 'Verniestad', '2026-03-20', NULL, NULL, NULL, NULL, NULL, 1957108963, 0, 0, 2, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(158, 9648, 1271, 'إبراهيم عبدالسلام عبداللطيف', 'Male', 3, 2, 3, '1989', 'إدارة الأعمال', 'Excellent', '2002-01-10', '60080538708042', '2026-09-29', 'South Leilafort', 3, 'Christian', 13, 'iquitzon@example.net', 6, 7, 8, '0234597426', '0227343285', '01567429122', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '80115278215263', 'Yes', NULL, NULL, '2023-05-18', 'Employee', 8, 20, 'Yes', 'No', 3, '9.00', '41277.73', '1375.92', 'Changeable', NULL, 'Yes', '786.67', '03123088190910', 'Yes', '992.18', '93056410406443', 'Visa', 'No', NULL, '109 Devante Village Apt. 812\nLake Reymundochester, NH 64898-8247', 0, 'Widowed', NULL, '56843211524', 'Yes', NULL, 5, 'Vilma Walsh', '34800790817288', 'North Dewaynechester', '2029-07-31', NULL, NULL, NULL, NULL, NULL, 2058586544, 0, 0, 2, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(159, 6213, 503, 'رغد عبدالفتاح منصور', 'Female', 3, 3, 2, '1973', 'علوم الحاسوب', 'Fair', '2019-01-15', '89066727584942', '2029-02-04', 'New Marquesport', 1, 'Christian', 9, 'eschaden@example.com', 4, 16, 2, '0222809864', '0227288994', '01078797756', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '47451567226862', 'Yes', NULL, NULL, '2020-06-08', 'Employee', 2, 21, 'No', 'Yes', 4, '12.00', '41256.80', '1375.23', 'Fixed', '1827.57', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '1668 Asia Vista\nPort Ressie, MN 30048-6220', 0, 'Widowed', NULL, '51091665829', 'Yes', NULL, 6, 'Scottie Hirthe', '33530086353621', 'Harleyton', '2025-12-15', NULL, NULL, NULL, NULL, NULL, 1918225512, 0, 0, 3, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(160, 2384, 2874, 'آنا قاسم صابر', 'Female', 1, 2, 2, '2012', 'علوم الحاسوب', 'Fair', '2018-02-11', '82865927917008', '2027-09-09', 'Lake Glennie', 7, 'Christian', 6, 'abernathy.nona@example.org', 3, 3, 11, '0235639576', '0235996392', '01239400781', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '46897137057135', 'Yes', NULL, NULL, '2021-11-30', 'Employee', 1, 15, 'No', 'No', 4, '9.00', '24490.51', '816.35', 'Fixed', '1450.93', 'Yes', '719.98', '50145102762837', 'Yes', '849.58', '81716720987815', 'Visa', 'Yes', NULL, '76357 Mitchell Ranch Apt. 393\nEvalynland, OR 29390-2249', 0, 'Divorced', NULL, '9797189261', 'Yes', NULL, 2, 'Lea Schiller', '95838653556594', 'Legrosport', '2028-10-15', NULL, NULL, NULL, NULL, NULL, 1632499685, 0, 0, 3, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(161, 8668, 568, 'باسل نور محمد', 'Male', 1, 3, 2, '1987', 'الرياضيات', 'Very_Good', '2020-08-22', '56384303205543', '2027-01-19', 'Murraychester', 7, 'Muslim', 3, 'barton.rosenbaum@example.com', 2, 19, 1, '0236309294', '0221261990', '01076985707', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '74543308627515', 'Yes', NULL, NULL, '2020-12-09', 'Employee', 2, 17, 'Yes', 'Yes', 4, '8.00', '42955.98', '1431.87', 'Changeable', NULL, 'Yes', '558.78', '27932110148905', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '355 Melody Prairie Apt. 695\nHyattfort, GA 84208', 0, 'Widowed', NULL, '296022286515', 'Yes', NULL, 2, 'Enola Koelpin', '75686606735975', 'Wittingville', '2026-04-22', NULL, NULL, NULL, NULL, NULL, 1648365839, 0, 0, 4, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(162, 6483, 2808, 'أسماء أحمد يحيى', 'Female', 1, 1, 3, '1996', 'الفيزياء', 'Fair', '2009-09-21', '83766535400195', '2028-10-31', 'Willburgh', 7, 'Muslim', 10, 'pdickens@example.com', 2, 26, 7, '0229272798', '0236837184', '01043437124', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '17879611518219', 'No', NULL, NULL, '2023-06-09', 'Employee', 7, 11, 'Yes', 'No', 1, '11.00', '9640.29', '321.34', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '701.66', '51138603972549', 'Cach', 'Yes', NULL, '577 Philip Summit Apt. 782\nDoyleport, NE 16345-8599', 0, 'Widowed', NULL, '22554367782', 'Yes', NULL, 1, 'Eino Kling', '07611215519202', 'West Ewaldstad', '2025-12-01', NULL, NULL, NULL, NULL, NULL, 258891735, 0, 0, 2, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(163, 1781, 2016, 'أكرم راغب علاء', 'Male', 4, 2, 1, '1975', 'الرياضيات', 'Very_Good', '2017-03-03', '74225673683035', '2026-05-05', 'Port Yvette', 2, 'Muslim', 3, 'salvador22@example.org', 5, 2, 1, '0230753429', '0236702347', '01156827036', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '34825797161732', 'No', NULL, NULL, '2023-11-20', 'Employee', 10, 23, 'Yes', 'Yes', 2, '9.00', '44913.24', '1497.11', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '986.16', '25536772385361', 'Visa', 'Yes', NULL, '523 Strosin Place\nWest Bethel, MI 86730', 0, 'Single', NULL, '9810450946', 'Yes', NULL, 4, 'Jewell Keebler', '00290177281544', 'North Kobyport', '2025-10-10', NULL, NULL, NULL, NULL, NULL, 639734471, 0, 0, 1, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(164, 7878, 2573, 'معاذ جواد عمار', 'Male', 2, 1, 2, '1998', 'إدارة الأعمال', 'Good', '2001-08-28', '55352684300366', '2028-07-29', 'Labadieside', 7, 'Muslim', 13, 'rwuckert@example.org', 2, 5, 2, '0220450120', '0227305162', '01540154945', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '02121949054506', 'No', NULL, NULL, '2022-09-20', 'Employee', 2, 4, 'No', 'Yes', 1, '12.00', '43172.98', '1439.10', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '505.32', '81013293905008', 'Visa', 'Yes', NULL, '971 Kevin Island\nKoeppberg, UT 40287-5362', 0, 'Single', NULL, '42939502823', 'Yes', NULL, 3, 'Dr. Houston Friesen DVM', '36585172690740', 'Marilietown', '2025-03-19', NULL, NULL, NULL, NULL, NULL, 1126529696, 0, 0, 4, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(165, 7739, 787, 'أيمن عمر مصطفى', 'Male', 2, 3, 5, '1982', 'علم الأحياء', 'Very_Good', '2020-01-11', '77015927179519', '2029-09-08', 'North Marilynetown', 1, 'Christian', 9, 'maybell50@example.com', 3, 11, 7, '0224940525', '0228903480', '01164127094', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '13709212400764', 'Yes', NULL, NULL, '2020-04-20', 'Employee', 6, 3, 'No', 'No', 4, '8.00', '24154.99', '805.17', 'Fixed', '1191.80', 'No', NULL, NULL, 'Yes', '660.16', '05500130337506', 'Cach', 'Yes', NULL, '6756 Doyle Squares Apt. 139\nEast Demario, CO 08607', 0, 'Divorced', NULL, '420204699', 'Yes', NULL, 5, 'Prof. Julio Bauch', '13412222742683', 'Port Sofia', '2028-04-14', NULL, NULL, NULL, NULL, NULL, 1492596421, 0, 0, 2, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(166, 7926, 1782, 'آلاء باسل سامر', 'Female', 2, 1, 6, '2003', 'الفيزياء', 'Very_Good', '2003-01-24', '32324937591358', '2028-11-30', 'West Blancafurt', 7, 'Muslim', 7, 'milton.frami@example.net', 1, 13, 7, '0223174947', '0238875192', '01516189319', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '48536147799738', 'No', NULL, NULL, '2023-10-01', 'Employee', 1, 20, 'Yes', 'Yes', 1, '11.00', '47735.05', '1591.17', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '902.80', '00922016493592', 'Visa', 'No', NULL, '1104 Goyette Overpass Apt. 147\nSouth Luisa, AR 35532', 0, 'Divorced', NULL, '68997486821', 'Yes', NULL, 2, 'Catherine Baumbach', '50585032487351', 'East Soledadfurt', '2026-01-01', NULL, NULL, NULL, NULL, NULL, 1749581490, 0, 0, 1, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(167, 6824, 1631, 'ماريا فارس عبدالباسط', 'Female', 4, 4, 1, '1978', 'الرياضيات', 'Fair', '2023-09-08', '26307664645677', '2029-06-25', 'West Mellie', 1, 'Muslim', 2, 'prosacco.forrest@example.net', 2, 23, 8, '0235006555', '0227287118', '01249578616', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '21010792218208', 'Yes', NULL, NULL, '2023-06-26', 'Employee', 9, 12, 'Yes', 'No', 4, '12.00', '35770.48', '1192.35', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '778.73', '38623096102220', 'Visa', 'Yes', NULL, '725 Mosciski Isle\nLake Alannaside, OR 18614', 0, 'Married', NULL, '58589470', 'Yes', NULL, 5, 'Greta Considine', '17900144697415', 'Abbieside', '2027-01-11', NULL, NULL, NULL, NULL, NULL, 1868891626, 0, 0, 2, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(168, 3153, 2815, 'إيمان وائل عبدالحي', 'Female', 3, 1, 4, '2002', 'الهندسة', 'Excellent', '2021-03-18', '32501864078770', '2026-05-29', 'Fernbury', 4, 'Muslim', 11, 'maudie28@example.net', 5, 15, 11, '0233270024', '0237270325', '01163035760', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '95059895536315', 'No', NULL, NULL, '2022-10-03', 'Employee', 4, 1, 'No', 'No', 3, '9.00', '34597.99', '1153.27', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '7946 Lilliana Union\nDuBuqueland, SC 07502-3971', 0, 'Single', NULL, '44407772823', 'Yes', NULL, 1, 'Elnora Wuckert', '68724023243349', 'South Sagehaven', '2027-01-08', NULL, NULL, NULL, NULL, NULL, 831246123, 0, 0, 1, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(169, 6230, 1021, 'عمر وائل جواد', 'Male', 3, 3, 5, '1993', 'الرياضيات', 'Excellent', '2001-08-11', '77806137270626', '2026-05-21', 'O\'Konberg', 2, 'Muslim', 12, 'marilou.schiller@example.com', 3, 11, 7, '0225688561', '0239247859', '01056113617', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '77335556657342', 'No', NULL, NULL, '2022-12-30', 'Employee', 8, 6, 'No', 'No', 3, '10.00', '44677.33', '1489.24', 'Fixed', '1324.01', 'Yes', '856.23', '72542291313721', 'No', NULL, NULL, 'Visa', 'No', NULL, '905 Candida Burgs\nBraunfort, NJ 42107-9872', 0, 'Single', NULL, '85941932122527', 'Yes', NULL, 1, 'Prof. Henderson Grady V', '87893819494615', 'Weldonton', '2025-05-06', NULL, NULL, NULL, NULL, NULL, 1209915510, 0, 0, 3, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(170, 8239, 299, 'نبيل عبدالفتاح عصام', 'Male', 2, 1, 1, '2001', 'الهندسة', 'Very_Good', '2021-08-20', '81369329058248', '2028-03-28', 'Hudsonport', 4, 'Christian', 3, 'anissa.jakubowski@example.net', 1, 3, 15, '0221214062', '0233204496', '01284941660', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '13346693112895', 'Yes', NULL, NULL, '2023-01-18', 'Employee', 8, 19, 'No', 'Yes', 4, '11.00', '18496.21', '616.54', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '407 Jacobi Plains\nNorth Stefan, DC 10817', 0, 'Widowed', NULL, '33257771', 'Yes', NULL, 3, 'Alf Rau', '14766055294524', 'Gibsonton', '2027-11-03', NULL, NULL, NULL, NULL, NULL, 1336426082, 0, 0, 2, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(171, 7336, 730, 'عبدالحميد شادي أمجد', 'Male', 4, 2, 3, '1970', 'الرياضيات', 'Very_Good', '2006-03-30', '09676131575933', '2025-11-19', 'Yundtville', 5, 'Christian', 3, 'delfina.kohler@example.org', 5, 14, 12, '0232960897', '0224130710', '01007219909', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '33840743986554', 'Yes', NULL, NULL, '2021-05-30', 'Employee', 6, 15, 'Yes', 'Yes', 4, '10.00', '39441.61', '1314.72', 'Fixed', '1048.47', 'Yes', '768.26', '29283356224958', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '494 Boehm Parkways\nJacobsonshire, TX 87611-5339', 0, 'Divorced', NULL, '346547208', 'Yes', NULL, 3, 'Orpha McClure', '81330245501491', 'Schaeferville', '2025-11-25', NULL, NULL, NULL, NULL, NULL, 1482805096, 0, 0, 4, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(172, 6313, 1732, 'ماريا ناجي إسماعيل', 'Female', 4, 1, 2, '1975', 'الهندسة', 'Good', '2024-07-23', '07713793815391', '2027-12-03', 'Fisherburgh', 5, 'Christian', 2, 'leannon.ofelia@example.com', 3, 9, 12, '0229262653', '0236800132', '01548380889', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '46424819090316', 'Yes', NULL, NULL, '2019-12-18', 'Employee', 1, 16, 'Yes', 'Yes', 4, '7.00', '47632.56', '1587.75', 'Fixed', '1001.86', 'Yes', '933.42', '45328463965984', 'Yes', '705.17', '25573292253507', 'Cach', 'Yes', NULL, '229 Annamae Ways\nLake Mitchel, CA 94481', 0, 'Divorced', NULL, '7076216281', 'Yes', NULL, 1, 'Rosetta Pollich', '64446252211344', 'New Jaylon', '2029-10-14', NULL, NULL, NULL, NULL, NULL, 1482382681, 0, 0, 1, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(173, 7371, 1483, 'هالة مازن آدم', 'Female', 2, 2, 3, '1983', 'إدارة الأعمال', 'Excellent', '2014-03-05', '51834014684994', '2028-06-16', 'Port Glenda', 5, 'Muslim', 9, 'keebler.nestor@example.net', 6, 20, 2, '0224657468', '0225203037', '01280015696', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '79809244256066', 'Yes', NULL, NULL, '2022-07-23', 'Employee', 2, 27, 'No', 'Yes', 4, '8.00', '30182.69', '1006.09', 'Fixed', '1988.17', 'No', NULL, NULL, 'Yes', '662.24', '12283921948949', 'Visa', 'No', NULL, '78015 Grady Island Apt. 331\nWilkinsonmouth, RI 70758-4675', 0, 'Single', NULL, '128057315343', 'Yes', NULL, 2, 'Pierre Parker', '71683265574914', 'North Ephraimtown', '2026-06-27', NULL, NULL, NULL, NULL, NULL, 1425399580, 0, 0, 1, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(174, 4125, 2465, 'مها رائد يوسف', 'Female', 2, 2, 2, '1973', 'الهندسة', 'Good', '2024-07-26', '76095371780461', '2027-08-03', 'Emmerichtown', 3, 'Muslim', 10, 'trevor.flatley@example.com', 1, 11, 13, '0223701860', '0235886576', '01071372409', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '93219679764728', 'Yes', NULL, NULL, '2020-08-31', 'Employee', 2, 25, 'Yes', 'Yes', 3, '11.00', '5501.97', '183.40', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '577.98', '44022498186192', 'Cach', 'Yes', NULL, '3124 Salma Burg Apt. 035\nWest Hunterstad, AK 94567-7540', 0, 'Divorced', NULL, '997259276', 'Yes', NULL, 4, 'Cleo Cronin II', '99226367197244', 'Anguschester', '2029-01-15', NULL, NULL, NULL, NULL, NULL, 1274365579, 0, 0, 3, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(175, 9184, 1538, 'نور منصور أنور', 'Female', 1, 4, 2, '1978', 'الفيزياء', 'Very_Good', '2016-09-25', '22264347837366', '2028-05-30', 'Kunzehaven', 4, 'Christian', 5, 'triston55@example.com', 3, 25, 8, '0227448409', '0237697173', '01011231235', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '31714811185339', 'Yes', NULL, NULL, '2024-05-24', 'Employee', 8, 26, 'Yes', 'No', 3, '11.00', '48697.37', '1623.25', 'Fixed', '1354.81', 'No', NULL, NULL, 'Yes', '871.63', '87969094347547', 'Visa', 'No', NULL, '8407 Hanna Camp\nLake Carlomouth, GA 39024-1757', 0, 'Divorced', NULL, '277614155523', 'Yes', NULL, 2, 'Reanna Murphy II', '52099868532265', 'Lindgrenberg', '2028-04-20', NULL, NULL, NULL, NULL, NULL, 974672305, 0, 0, 1, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(176, 1385, 2044, 'نادر أنور لؤي', 'Male', 1, 3, 1, '1973', 'علم الأحياء', 'Excellent', '2004-11-02', '61788373670803', '2028-06-27', 'Krisfort', 7, 'Christian', 6, 'gislason.katarina@example.net', 4, 2, 2, '0228569720', '0238697351', '01098306071', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '05064458171294', 'Yes', NULL, NULL, '2020-07-31', 'Employee', 1, 2, 'No', 'Yes', 2, '9.00', '15975.09', '532.50', 'Fixed', '1917.89', 'Yes', '549.87', '37925174053613', 'No', NULL, NULL, 'Visa', 'No', NULL, '69679 Trenton Mall Suite 105\nLake Valentin, SC 56292', 0, 'Widowed', NULL, '9423623379', 'Yes', NULL, 6, 'Mr. Zachary Reinger Jr.', '76821185036697', 'Lake Shanny', '2029-06-28', NULL, NULL, NULL, NULL, NULL, 671679851, 0, 0, 3, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(177, 7893, 539, 'أريج عبدالحكيم عبدالباسط', 'Female', 3, 1, 6, '2012', 'إدارة الأعمال', 'Very_Good', '2001-11-05', '01112691833572', '2025-07-15', 'Reillyside', 3, 'Muslim', 1, 'jconnelly@example.com', 4, 20, 8, '0238861562', '0235642718', '01566375468', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '23034098873987', 'Yes', NULL, NULL, '2019-12-28', 'Employee', 10, 25, 'Yes', 'No', 4, '8.00', '35938.52', '1197.95', 'Fixed', '1745.71', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '84412 Vince Stravenue Apt. 412\nPeytonmouth, KY 68091', 0, 'Single', NULL, '9428598079', 'Yes', NULL, 2, 'Braeden Labadie', '24066469181841', 'Lake Geovany', '2026-02-20', NULL, NULL, NULL, NULL, NULL, 539799226, 0, 0, 1, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55');
INSERT INTO `employees` (`id`, `employee_code`, `fp_code`, `name`, `gender`, `branch_id`, `job_grade_id`, `qualification_id`, `qualification_year`, `major`, `graduation_estimate`, `brith_date`, `national_id`, `end_national_id`, `national_id_place`, `blood_types_id`, `religion`, `language_id`, `email`, `country_id`, `governorate_id`, `city_id`, `home_telephone`, `work_telephone`, `mobile`, `military`, `military_date_from`, `military_date_to`, `military_wepon`, `military_exemption_date`, `military_exemption_reason`, `military_postponement_reason`, `date_resignation`, `resignation_reason`, `driving_license`, `driving_license_type`, `driving_License_id`, `has_relatives`, `relatives_details`, `notes`, `work_start_date`, `functional_status`, `department_id`, `job_categories_id`, `has_attendance`, `has_fixed_shift`, `shift_types_id`, `daily_work_hour`, `salary`, `day_price`, `motivation_type`, `motivation`, `social_insurance`, `social_insurance_cut_monthely`, `social_insurance_number`, `medical_insurance`, `medical_insurance_cut_monthely`, `medical_insurance_number`, `Type_salary_receipt`, `active_vacation`, `urgent_person_details`, `staies_address`, `children_number`, `social_status`, `resignation_id`, `bank_number_account`, `disabilities`, `disabilities_type`, `nationality_id`, `name_sponsor`, `pasport_identity`, `pasport_from_place`, `pasport_exp_date`, `num_vacation_days`, `add_service`, `years_service`, `cv`, `basic_address_country`, `fixed_allowances`, `is_done_Vacation_formula`, `is_Sensitive_manager_data`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(178, 9923, 2193, 'ناهد رامي حامد', 'Female', 4, 3, 1, '1993', 'علوم الحاسوب', 'Fair', '2003-08-04', '91551938085483', '2027-12-21', 'North Jalon', 7, 'Christian', 9, 'vince68@example.com', 3, 27, 15, '0229061684', '0230513824', '01135957476', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '63365258939235', 'No', NULL, NULL, '2024-11-23', 'Employee', 4, 2, 'No', 'Yes', 4, '7.00', '28477.70', '949.26', 'Changeable', NULL, 'Yes', '701.59', '02001640110021', 'Yes', '828.49', '63686652540432', 'Cach', 'Yes', NULL, '17910 Nella Cliff\nPort Prince, MN 85865', 0, 'Married', NULL, '500769850', 'Yes', NULL, 1, 'Annabel Braun', '48284734401080', 'New Soledadbury', '2026-04-29', NULL, NULL, NULL, NULL, NULL, 1308186543, 0, 0, 1, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(179, 8266, 2078, 'ديمة أيوب عصام', 'Female', 4, 3, 6, '1976', 'إدارة الأعمال', 'Very_Good', '2022-07-14', '91777085524902', '2025-01-05', 'Reingerland', 3, 'Christian', 9, 'kozey.johnson@example.net', 5, 23, 11, '0236928290', '0235284238', '01044018210', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '70764981330781', 'No', NULL, NULL, '2021-01-04', 'Employee', 10, 9, 'No', 'No', 1, '10.00', '23048.12', '768.27', 'Changeable', NULL, 'Yes', '840.74', '84220999652657', 'Yes', '641.34', '17536827137164', 'Visa', 'No', NULL, '71514 Kshlerin Parks Suite 235\nEast Julian, WA 34471', 0, 'Divorced', NULL, '191756989', 'Yes', NULL, 3, 'Prof. Stan Homenick', '84886743554340', 'Tillmanside', '2028-12-18', NULL, NULL, NULL, NULL, NULL, 841363501, 0, 0, 4, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(180, 5114, 2334, 'علي وائل ربيع', 'Male', 3, 3, 2, '1988', 'الهندسة', 'Good', '2019-01-20', '92562409352300', '2025-04-08', 'South Carmine', 3, 'Christian', 11, 'rbaumbach@example.com', 2, 24, 2, '0226424668', '0221805360', '01042513047', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '31088137506116', 'No', NULL, NULL, '2023-10-16', 'Employee', 3, 28, 'Yes', 'Yes', 3, '12.00', '47697.33', '1589.91', 'Fixed', '1132.42', 'Yes', '786.14', '18120513319531', 'Yes', '680.85', '61402274559190', 'Visa', 'No', NULL, '4492 Jed Haven Apt. 175\nNorth Agustina, GA 13262-3949', 0, 'Single', NULL, '542254611322', 'Yes', NULL, 2, 'Theresa Marvin', '03652496479912', 'Kaleyland', '2029-02-15', NULL, NULL, NULL, NULL, NULL, 1337058259, 0, 0, 3, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(181, 1304, 812, 'زينب مصطفى سالم', 'Female', 2, 1, 1, '1974', 'الهندسة', 'Very_Good', '2013-05-11', '16201062602581', '2025-09-03', 'Kirlinburgh', 2, 'Muslim', 12, 'ralph.swift@example.org', 5, 15, 4, '0231646584', '0232228439', '01020023107', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '89684034936338', 'Yes', NULL, NULL, '2020-12-21', 'Employee', 1, 25, 'Yes', 'No', 4, '7.00', '23409.03', '780.30', 'Fixed', '1496.85', 'Yes', '607.47', '84480001463976', 'Yes', '619.39', '47800365248308', 'Cach', 'No', NULL, '17357 Rogahn Walks\nEast Finn, NH 22830-1464', 0, 'Divorced', NULL, '045007788198753', 'Yes', NULL, 6, 'Prof. Dominique Jacobi Sr.', '67559098403800', 'Edythmouth', '2029-03-29', NULL, NULL, NULL, NULL, NULL, 1844237769, 0, 0, 2, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(182, 4196, 1925, 'جوري باسل طارق', 'Female', 1, 4, 1, '1998', 'علوم الحاسوب', 'Excellent', '2009-04-30', '82389040101406', '2027-09-29', 'West Edyth', 4, 'Muslim', 5, 'hassie79@example.com', 2, 20, 2, '0227284247', '0220734046', '01025644708', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '40946166835855', 'No', NULL, NULL, '2021-10-21', 'Employee', 9, 27, 'No', 'No', 2, '7.00', '23076.93', '769.23', 'Fixed', '1572.24', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '745 Carroll Heights Suite 541\nEmoryville, LA 28825-7946', 0, 'Divorced', NULL, '20244746265039', 'Yes', NULL, 3, 'Dr. Lelah Schimmel Sr.', '21404233514810', 'Grahambury', '2027-04-17', NULL, NULL, NULL, NULL, NULL, 699789081, 0, 0, 2, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(183, 9770, 2775, 'حذيفة مصطفى توفيق', 'Male', 1, 3, 4, '2011', 'علوم الحاسوب', 'Very_Good', '2010-03-18', '79112910517127', '2027-08-21', 'Port Caitlynton', 2, 'Muslim', 8, 'mariela39@example.com', 2, 26, 5, '0237069715', '0226142642', '01212816577', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '80101574856409', 'Yes', NULL, NULL, '2021-10-29', 'Employee', 3, 2, 'No', 'Yes', 3, '9.00', '14072.21', '469.07', 'Fixed', '1999.66', 'Yes', '823.10', '73120686677531', 'Yes', '667.31', '92496978438286', 'Cach', 'Yes', NULL, '35888 Hoeger Corners Suite 416\nSouth Margarettaburgh, AR 01080', 0, 'Widowed', NULL, '37624787986', 'Yes', NULL, 6, 'Dr. Marina Schowalter', '83898237691130', 'Russelshire', '2029-10-04', NULL, NULL, NULL, NULL, NULL, 1505262974, 0, 0, 1, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(184, 4518, 2912, 'دعاء رامز عبدالحميد', 'Female', 1, 2, 5, '2000', 'الفيزياء', 'Fair', '2008-07-06', '47751095090619', '2026-07-24', 'Kerluketon', 6, 'Christian', 8, 'alberta.barrows@example.net', 2, 6, 8, '0236302856', '0236366371', '01109721849', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '27433842356034', 'No', NULL, NULL, '2020-02-02', 'Employee', 5, 16, 'Yes', 'No', 4, '8.00', '10749.37', '358.31', 'Fixed', '1467.05', 'Yes', '604.33', '55403184553570', 'No', NULL, NULL, 'Visa', 'No', NULL, '40037 Lockman Causeway\nLake Laila, NC 74309-8186', 0, 'Single', NULL, '375573589', 'Yes', NULL, 5, 'Dr. Moriah Bode', '12284248431625', 'New Danaview', '2027-03-16', NULL, NULL, NULL, NULL, NULL, 1193842313, 0, 0, 3, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(185, 1875, 1115, 'جمانة عبدالسلام عبدالحكيم', 'Female', 2, 4, 1, '1972', 'الفيزياء', 'Excellent', '2018-09-24', '84335466366762', '2028-11-04', 'Brakusborough', 6, 'Muslim', 9, 'kessler.green@example.com', 2, 19, 10, '0226198872', '0228589290', '01210034549', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '18861399856336', 'No', NULL, NULL, '2024-10-19', 'Employee', 9, 1, 'No', 'Yes', 1, '9.00', '37340.97', '1244.70', 'Changeable', NULL, 'Yes', '541.15', '99280703025737', 'Yes', '660.87', '62492382046993', 'Visa', 'No', NULL, '86644 Kohler Canyon\nCalebchester, DC 16469', 0, 'Divorced', NULL, '1593855256895', 'Yes', NULL, 1, 'Miss Shanna Blanda MD', '19404571332325', 'Libbyfort', '2029-11-23', NULL, NULL, NULL, NULL, NULL, 1750632496, 0, 0, 2, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(186, 8759, 2992, 'فرح عبدالعزيز زيد', 'Female', 4, 3, 1, '1986', 'علوم الحاسوب', 'Good', '2000-05-17', '13942953528175', '2026-10-24', 'New Francesport', 6, 'Muslim', 1, 'tia65@example.com', 6, 23, 4, '0236242434', '0233683830', '01218917221', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '69208926964927', 'Yes', NULL, NULL, '2024-09-17', 'Employee', 2, 14, 'No', 'Yes', 2, '8.00', '8148.52', '271.62', 'Fixed', '1564.82', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '8717 Kihn Plains\nMyrafurt, KY 59374', 0, 'Married', NULL, '37666731211339', 'Yes', NULL, 6, 'Curt Blick', '09144182473783', 'Abrahamside', '2025-07-23', NULL, NULL, NULL, NULL, NULL, 1335499447, 0, 0, 1, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(187, 9852, 2837, 'جمانة حامد حاتم', 'Female', 4, 2, 2, '1995', 'إدارة الأعمال', 'Good', '2023-10-29', '59291368740962', '2025-08-13', 'Donnellyview', 2, 'Muslim', 12, 'eeffertz@example.net', 3, 5, 9, '0222754106', '0236616676', '01091257496', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '84303716551765', 'No', NULL, NULL, '2024-09-07', 'Employee', 9, 3, 'No', 'No', 4, '11.00', '13287.64', '442.92', 'Fixed', '1572.37', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '4322 Lehner Common Apt. 868\nNorth Darbychester, NM 76216-9219', 0, 'Widowed', NULL, '869335045', 'Yes', NULL, 6, 'Catalina Torphy', '80684805619135', 'New Camilahaven', '2029-05-22', NULL, NULL, NULL, NULL, NULL, 45525060, 0, 0, 3, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(188, 7553, 1728, 'لميس باسل باسم', 'Female', 2, 3, 5, '1986', 'الهندسة', 'Fair', '2018-11-01', '78321318113173', '2028-02-24', 'Lefflerhaven', 4, 'Muslim', 7, 'sporer.jacinto@example.org', 2, 9, 15, '0227720368', '0239297090', '01587184150', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '99000535204046', 'Yes', NULL, NULL, '2024-04-11', 'Employee', 3, 23, 'No', 'Yes', 2, '8.00', '27429.99', '914.33', 'Changeable', NULL, 'Yes', '853.01', '56511633633591', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '71319 Tess Mall\nSouth Daniela, AZ 01289-8958', 0, 'Married', NULL, '099519050825', 'Yes', NULL, 5, 'Kaden Keebler', '31703468719693', 'Port Arvilla', '2025-04-07', NULL, NULL, NULL, NULL, NULL, 134684517, 0, 0, 4, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(189, 9508, 2149, 'ثامر عبدالرحمن عبدالرزاق', 'Male', 4, 2, 4, '1998', 'الرياضيات', 'Good', '2024-05-23', '88971002544314', '2025-05-18', 'North Ana', 3, 'Christian', 6, 'margret.gulgowski@example.com', 6, 10, 8, '0220033034', '0235869529', '01151629865', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '02030851547431', 'No', NULL, NULL, '2021-07-28', 'Employee', 10, 3, 'Yes', 'Yes', 1, '12.00', '7793.29', '259.78', 'Fixed', '1205.63', 'Yes', '643.21', '80970122615305', 'Yes', '591.17', '00439784822282', 'Cach', 'No', NULL, '9055 Trenton Village Apt. 106\nNorth Lourdes, NM 88227', 0, 'Divorced', NULL, '521318877190', 'Yes', NULL, 5, 'Elyse Kuhn', '73084627988462', 'Runolfssonmouth', '2025-11-15', NULL, NULL, NULL, NULL, NULL, 1806114979, 0, 0, 3, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(190, 4091, 177, 'لميس ناجي حمزة', 'Female', 1, 2, 3, '1982', 'الفيزياء', 'Good', '2002-04-01', '55857801688854', '2025-04-20', 'Isadorefurt', 7, 'Muslim', 7, 'lawrence.marks@example.net', 1, 24, 14, '0230056448', '0233297969', '01009510155', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '45229029291866', 'No', NULL, NULL, '2021-09-15', 'Employee', 6, 3, 'Yes', 'No', 4, '7.00', '5433.04', '181.10', 'Fixed', '1690.88', 'Yes', '636.69', '87463661373617', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '22106 Corkery Harbor Suite 520\nLake Chelsea, NH 02529', 0, 'Married', NULL, '646894340425', 'Yes', NULL, 5, 'Marguerite Hegmann', '45698801725322', 'North Darwinchester', '2027-06-13', NULL, NULL, NULL, NULL, NULL, 770682510, 0, 0, 1, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(191, 5022, 1608, 'ياسر جواد حاتم', 'Male', 4, 4, 4, '1993', 'الرياضيات', 'Fair', '2012-06-11', '21562751018330', '2027-12-03', 'New Jennyfer', 1, 'Christian', 5, 'ylebsack@example.com', 5, 14, 10, '0225518882', '0234786506', '01105657496', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '76928508287535', 'Yes', NULL, NULL, '2021-11-30', 'Employee', 3, 15, 'No', 'Yes', 1, '8.00', '6992.03', '233.07', 'Fixed', '1865.50', 'Yes', '827.54', '02759242738357', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '48784 Braun Island Suite 110\nDanefurt, NH 95299', 0, 'Single', NULL, '160265688330', 'Yes', NULL, 3, 'Miss Mireille Moen', '94825852175721', 'New Halport', '2026-05-10', NULL, NULL, NULL, NULL, NULL, 716881749, 0, 0, 3, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(192, 7731, 1356, 'هيا عمر وائل', 'Female', 3, 2, 2, '2001', 'الهندسة', 'Very_Good', '2016-02-21', '25609539017225', '2026-01-24', 'Kubmouth', 7, 'Muslim', 11, 'jose.schaden@example.org', 1, 1, 9, '0233077976', '0233585599', '01228697006', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '36506330464476', 'Yes', NULL, NULL, '2020-06-09', 'Employee', 2, 23, 'Yes', 'No', 3, '8.00', '45989.20', '1532.97', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '40775 Crist Ridges\nEast Breanne, CT 97372', 0, 'Single', NULL, '10278652345683', 'Yes', NULL, 2, 'Dr. Mackenzie Balistreri', '18563826999139', 'East Earline', '2026-11-11', NULL, NULL, NULL, NULL, NULL, 781220200, 0, 0, 2, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(193, 7377, 1521, 'معاذ عبدالكريم زياد', 'Male', 2, 4, 2, '2002', 'علم الأحياء', 'Very_Good', '2000-03-03', '16378132700480', '2025-02-28', 'Schambergerborough', 4, 'Christian', 2, 'morissette.athena@example.net', 2, 16, 12, '0223419499', '0224042474', '01016932006', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '38522794067427', 'No', NULL, NULL, '2024-05-19', 'Employee', 7, 27, 'Yes', 'Yes', 2, '11.00', '33595.54', '1119.85', 'Fixed', '1198.33', 'No', NULL, NULL, 'Yes', '714.87', '50741663589345', 'Cach', 'Yes', NULL, '16538 Abigale Harbors\nGloverland, MI 06552', 0, 'Widowed', NULL, '75036247381', 'Yes', NULL, 6, 'Sadie Grady', '06364496798636', 'Cruickshankhaven', '2025-08-26', NULL, NULL, NULL, NULL, NULL, 1838452980, 0, 0, 4, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(194, 6943, 771, 'هيثم حذيفة لؤي', 'Male', 2, 2, 6, '1972', 'علوم الحاسوب', 'Good', '2002-05-01', '05115839629994', '2029-01-07', 'Troyton', 1, 'Christian', 13, 'boehm.cyril@example.org', 3, 13, 6, '0230766685', '0224445510', '01129548723', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '54841868048937', 'Yes', NULL, NULL, '2020-03-01', 'Employee', 4, 7, 'Yes', 'Yes', 1, '9.00', '42030.37', '1401.01', 'Fixed', '1923.08', 'No', NULL, NULL, 'Yes', '809.30', '38862737345522', 'Visa', 'No', NULL, '4321 Jacobs Pass Apt. 821\nReillyport, SC 52493', 0, 'Single', NULL, '29887189', 'Yes', NULL, 1, 'Sonny Haley', '99006549478307', 'South Luisa', '2025-03-03', NULL, NULL, NULL, NULL, NULL, 847989734, 0, 0, 4, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(195, 4548, 2173, 'لارا مازن محمد', 'Female', 2, 2, 5, '2007', 'الهندسة', 'Excellent', '2022-01-12', '86710226086685', '2029-02-20', 'South Helga', 1, 'Christian', 9, 'rozella38@example.org', 1, 10, 14, '0234570996', '0238589605', '01549065594', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '30989112619800', 'No', NULL, NULL, '2020-03-03', 'Employee', 5, 13, 'No', 'Yes', 3, '11.00', '21105.27', '703.51', 'Fixed', '1433.54', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '75065 Littel Mountains Apt. 536\nTeaganberg, CO 18313', 0, 'Divorced', NULL, '653806289146671', 'Yes', NULL, 1, 'Darrin Rath', '51583358586448', 'Sylvanmouth', '2026-05-29', NULL, NULL, NULL, NULL, NULL, 894700993, 0, 0, 2, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(196, 6556, 2277, 'سعاد أنور إلياس', 'Female', 3, 1, 5, '2009', 'الفيزياء', 'Fair', '2024-10-13', '24421688393764', '2027-02-11', 'New Peggieside', 4, 'Christian', 1, 'yklocko@example.org', 5, 12, 7, '0228848370', '0234628998', '01509993227', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '51484913139116', 'Yes', NULL, NULL, '2022-03-04', 'Employee', 2, 3, 'No', 'No', 1, '9.00', '36815.87', '1227.20', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '10344 Morar Light Suite 611\nPriceburgh, NH 22765-6415', 0, 'Married', NULL, '6141176368', 'Yes', NULL, 3, 'Mrs. Constance Zulauf II', '22720737179140', 'Lake Jarrod', '2029-08-05', NULL, NULL, NULL, NULL, NULL, 58093759, 0, 0, 1, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(197, 2761, 589, 'هالة عبدالكريم علي', 'Female', 3, 1, 5, '1973', 'الفيزياء', 'Very_Good', '2019-12-18', '87367460359557', '2026-03-09', 'Millsport', 5, 'Christian', 2, 'hermann74@example.com', 2, 4, 5, '0237626397', '0235429547', '01053396115', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '21990246437462', 'Yes', NULL, NULL, '2023-10-29', 'Employee', 8, 10, 'No', 'No', 2, '7.00', '34058.41', '1135.28', 'Fixed', '1909.14', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '993 Christ Loaf Apt. 520\nBotsfordstad, ND 08779', 0, 'Married', NULL, '694228616', 'Yes', NULL, 3, 'Jennifer Hayes', '24978797646778', 'Alainastad', '2028-01-31', NULL, NULL, NULL, NULL, NULL, 1980211163, 0, 0, 2, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(198, 1820, 316, 'هدى هيثم راغب', 'Female', 2, 1, 5, '2011', 'علم الأحياء', 'Good', '2016-10-01', '96782651132630', '2028-01-28', 'Barrowsshire', 4, 'Christian', 8, 'roderick55@example.com', 2, 25, 9, '0224977899', '0235476610', '01099771722', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '24684960461357', 'No', NULL, NULL, '2021-07-17', 'Employee', 4, 3, 'No', 'Yes', 4, '8.00', '34173.34', '1139.11', 'Fixed', '1728.39', 'No', NULL, NULL, 'Yes', '881.83', '02381989282723', 'Visa', 'Yes', NULL, '9252 Gaylord Islands Apt. 619\nClemensmouth, WA 17718', 0, 'Divorced', NULL, '0773340494', 'Yes', NULL, 2, 'Ryder Purdy I', '77873586817726', 'West Jewell', '2027-05-11', NULL, NULL, NULL, NULL, NULL, 982354980, 0, 0, 3, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(199, 8579, 2820, 'شريف عمار قاسم', 'Male', 2, 2, 1, '1991', 'الفيزياء', 'Good', '2023-10-12', '55983558532776', '2027-11-30', 'Sengerborough', 3, 'Christian', 11, 'qrodriguez@example.net', 4, 14, 4, '0223135652', '0222380891', '01573102397', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '39892514612773', 'Yes', NULL, NULL, '2023-02-26', 'Employee', 10, 19, 'Yes', 'Yes', 2, '7.00', '44072.89', '1469.10', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '6173 Ankunding Fields\nNew Braxton, IL 92000-7116', 0, 'Single', NULL, '4347185015', 'Yes', NULL, 1, 'Mr. Jules Larson Jr.', '63238126391848', 'Reingerborough', '2028-10-19', NULL, NULL, NULL, NULL, NULL, 361983119, 0, 0, 3, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(200, 3729, 2254, 'هيفاء عبدالسلام حسن', 'Female', 4, 4, 2, '1993', 'إدارة الأعمال', 'Very_Good', '2009-11-20', '90257976895518', '2029-09-10', 'North Gregoryshire', 1, 'Muslim', 10, 'nmarks@example.com', 2, 13, 8, '0233540089', '0234432194', '01152898637', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '91715472158298', 'No', NULL, NULL, '2021-07-21', 'Employee', 6, 8, 'Yes', 'Yes', 2, '9.00', '7695.13', '256.50', 'Changeable', NULL, 'Yes', '792.95', '06509490033047', 'Yes', '742.78', '88688098725364', 'Cach', 'Yes', NULL, '936 Corwin Trace\nPort Kaiaville, CT 26337', 0, 'Widowed', NULL, '7629733547153', 'Yes', NULL, 3, 'Leonora Hirthe DDS', '91795268805089', 'North Zane', '2025-01-25', NULL, NULL, NULL, NULL, NULL, 938086713, 0, 0, 1, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(201, 5671, 2475, 'نسرين عصام أديب', 'Female', 2, 4, 5, '2007', 'علوم الحاسوب', 'Excellent', '2023-05-12', '50478618948936', '2029-05-04', 'North Marcelle', 3, 'Muslim', 3, 'heber.schamberger@example.org', 6, 12, 11, '0222860975', '0238338262', '01264068536', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '80227882345797', 'Yes', NULL, NULL, '2020-11-03', 'Employee', 4, 16, 'No', 'Yes', 4, '11.00', '28737.04', '957.90', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '949.67', '01078255943772', 'Visa', 'Yes', NULL, '395 Kassandra Tunnel\nLake Dudley, LA 49001-5525', 0, 'Married', NULL, '59319689813', 'Yes', NULL, 1, 'Nona Lindgren', '72743569175528', 'West Antonetta', '2029-02-19', NULL, NULL, NULL, NULL, NULL, 2077691095, 0, 0, 3, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(202, 4081, 2246, 'عامر أيمن شاكر', 'Male', 2, 2, 5, '1971', 'الرياضيات', 'Fair', '2011-10-05', '48542171347729', '2029-04-30', 'Baileyland', 6, 'Muslim', 10, 'cremin.jasmin@example.com', 1, 16, 1, '0239705045', '0237388444', '01275487225', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '63986493971551', 'No', NULL, NULL, '2024-05-09', 'Employee', 1, 25, 'Yes', 'No', 2, '9.00', '35244.58', '1174.82', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '4494 Ullrich Prairie Apt. 867\nMauricioville, OR 56684-3173', 0, 'Divorced', NULL, '022662582670', 'Yes', NULL, 2, 'Ethel Volkman', '53495456232584', 'Dashawnland', '2028-10-01', NULL, NULL, NULL, NULL, NULL, 854010609, 0, 0, 2, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(203, 5160, 1204, 'قاسم رفيق حذيفة', 'Male', 3, 1, 5, '1983', 'الفيزياء', 'Excellent', '2019-04-08', '46024922895381', '2026-05-12', 'Mallieville', 3, 'Christian', 9, 'chelsie27@example.com', 3, 7, 8, '0222151839', '0227661272', '01569509037', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '62370592835513', 'Yes', NULL, NULL, '2023-09-07', 'Employee', 10, 26, 'No', 'Yes', 1, '7.00', '16753.38', '558.45', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '636.61', '30505600143518', 'Visa', 'No', NULL, '7448 Lois Circle Suite 886\nPort Alexandrinefurt, MT 45196-1826', 0, 'Married', NULL, '4935152140', 'Yes', NULL, 1, 'Cheyanne O\'Keefe', '48546194031960', 'North Jairoton', '2029-10-04', NULL, NULL, NULL, NULL, NULL, 1076160153, 0, 0, 4, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(204, 5576, 1694, 'منصور مهند شريف', 'Male', 3, 4, 6, '1975', 'إدارة الأعمال', 'Excellent', '2003-04-22', '70013497805523', '2025-01-03', 'Lake Jaysonmouth', 3, 'Christian', 3, 'eveline.gleichner@example.net', 1, 25, 2, '0231475606', '0220365280', '01281550989', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '21824718670735', 'Yes', NULL, NULL, '2022-12-22', 'Employee', 6, 28, 'No', 'No', 2, '7.00', '34539.57', '1151.32', 'Changeable', NULL, 'Yes', '782.05', '79593816743326', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '7082 Jakubowski Avenue\nLake Bridgetstad, VA 05666-7988', 0, 'Single', NULL, '6690710143', 'Yes', NULL, 6, 'Dr. Gloria Ritchie', '22750785151759', 'Port Shanebury', '2025-11-11', NULL, NULL, NULL, NULL, NULL, 679215111, 0, 0, 2, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(205, 1283, 2314, 'علا حاتم إبراهيم', 'Female', 3, 4, 4, '2002', 'علوم الحاسوب', 'Good', '1999-12-15', '53104995065917', '2027-11-09', 'Erinview', 1, 'Christian', 7, 'hondricka@example.net', 4, 23, 1, '0221473839', '0221537256', '01218642146', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '66351340792681', 'No', NULL, NULL, '2020-05-07', 'Employee', 2, 4, 'Yes', 'No', 2, '7.00', '20761.06', '692.04', 'Changeable', NULL, 'Yes', '987.28', '01608507042806', 'No', NULL, NULL, 'Visa', 'No', NULL, '902 Peter Plaza Apt. 862\nHeatherfurt, MA 45392', 0, 'Married', NULL, '08445454861', 'Yes', NULL, 3, 'Germaine Collier', '11216766748218', 'New Wymanbury', '2026-09-24', NULL, NULL, NULL, NULL, NULL, 176995404, 0, 0, 3, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(206, 7638, 2312, 'عبدالرحمن زياد رامي', 'Male', 3, 3, 3, '2004', 'إدارة الأعمال', 'Very_Good', '2012-06-29', '62577038610983', '2025-03-20', 'Jevonmouth', 4, 'Christian', 1, 'aubrey.bauch@example.org', 5, 6, 14, '0237083380', '0230333924', '01160373849', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '54645012139067', 'Yes', NULL, NULL, '2021-07-24', 'Employee', 1, 5, 'Yes', 'Yes', 4, '10.00', '12816.73', '427.22', 'Fixed', '1217.31', 'No', NULL, NULL, 'Yes', '667.27', '80725046839783', 'Cach', 'Yes', NULL, '14509 Elody Knoll\nStarkchester, ND 99819-4281', 0, 'Married', NULL, '9690057848984', 'Yes', NULL, 4, 'Chadrick Pacocha', '13299620894481', 'Aldenfurt', '2028-03-03', NULL, NULL, NULL, NULL, NULL, 933610758, 0, 0, 2, NULL, 1, '2024-12-13 13:29:55', '2024-12-13 13:29:55'),
(207, 2967, 2629, 'نور عصام ربيع', 'Female', 1, 4, 5, '1980', 'إدارة الأعمال', 'Good', '2010-09-29', '16353720584508', '2029-09-06', 'Port Vivianeport', 6, 'Muslim', 10, 'halvorson.karelle@example.org', 1, 19, 3, '0228684977', '0231141663', '01090768497', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '24762505416366', 'No', NULL, NULL, '2020-05-20', 'Employee', 2, 3, 'Yes', 'No', 4, '7.00', '36117.61', '1203.92', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '568.81', '86778453287059', 'Cach', 'Yes', NULL, '7559 Kautzer Land Suite 838\nSouth Clark, NJ 41645', 0, 'Single', NULL, '35473596138', 'Yes', NULL, 4, 'Vena Swaniawski', '16534318891220', 'East Jamelfurt', '2025-05-13', NULL, NULL, NULL, NULL, NULL, 1546813617, 0, 0, 2, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(208, 8419, 2529, 'ندى عبداللطيف أحمد', 'Female', 4, 1, 2, '1999', 'الفيزياء', 'Very_Good', '2017-06-07', '35449338158946', '2029-04-14', 'New Aleen', 4, 'Muslim', 6, 'bridie.baumbach@example.org', 6, 9, 8, '0233718165', '0228172816', '01035338403', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '11799531205933', 'No', NULL, NULL, '2023-03-10', 'Employee', 3, 6, 'Yes', 'No', 4, '12.00', '14859.66', '495.32', 'Fixed', '1187.86', 'Yes', '594.13', '62256125750856', 'Yes', '918.18', '01039653350383', 'Visa', 'No', NULL, '6505 Jacobs Isle Suite 472\nPort Stefanie, MO 68648-7475', 0, 'Single', NULL, '01442618', 'Yes', NULL, 6, 'Ms. Letitia Hermann', '69610585302817', 'Emmerichberg', '2027-11-22', NULL, NULL, NULL, NULL, NULL, 678867649, 0, 0, 4, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(209, 3798, 1595, 'نادية عبدالحكيم أنس', 'Female', 4, 4, 3, '1976', 'علم الأحياء', 'Excellent', '2004-07-07', '09503819909110', '2027-09-06', 'Lake Mayetown', 6, 'Christian', 7, 'antwan.barrows@example.com', 2, 16, 1, '0234082102', '0231208133', '01207150894', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '96916409612967', 'Yes', NULL, NULL, '2024-06-20', 'Employee', 9, 6, 'Yes', 'No', 3, '10.00', '32432.37', '1081.08', 'Fixed', '1793.14', 'Yes', '720.70', '11642162266347', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '8916 Francesco Groves\nLake Tatum, RI 55759', 0, 'Married', NULL, '860984252216', 'Yes', NULL, 4, 'Dr. Geovany Jerde', '70991465994124', 'Ezraview', '2027-05-08', NULL, NULL, NULL, NULL, NULL, 1156425572, 0, 0, 2, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(210, 7605, 145, 'أنور محمد رائد', 'Male', 3, 3, 2, '1986', 'الرياضيات', 'Fair', '2020-05-12', '33707108408922', '2028-09-07', 'Lake Abdiel', 3, 'Muslim', 2, 'vmann@example.org', 4, 16, 12, '0231869167', '0237667279', '01232682369', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '75547303288421', 'No', NULL, NULL, '2022-08-18', 'Employee', 3, 2, 'Yes', 'Yes', 4, '9.00', '21291.84', '709.73', 'Changeable', NULL, 'Yes', '571.00', '73792195592227', 'Yes', '729.41', '51457791191996', 'Visa', 'No', NULL, '48708 Kihn Shoals\nOberbrunnerville, KS 86769-1351', 0, 'Divorced', NULL, '0985230396737', 'Yes', NULL, 1, 'Talia Langworth', '93474098666586', 'Shainastad', '2024-12-29', NULL, NULL, NULL, NULL, NULL, 1358403796, 0, 0, 2, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(211, 5894, 1470, 'شهد أمجد إبراهيم', 'Female', 1, 3, 5, '1975', 'إدارة الأعمال', 'Good', '2016-08-16', '99960951672194', '2028-07-26', 'South Rockytown', 1, 'Muslim', 12, 'lsmitham@example.net', 6, 14, 13, '0225830279', '0221868674', '01175988671', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '13473610793479', 'No', NULL, NULL, '2023-03-23', 'Employee', 8, 8, 'No', 'No', 3, '11.00', '31549.07', '1051.64', 'Changeable', NULL, 'Yes', '822.58', '54540831259199', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '118 Rebekah Shores Apt. 427\nLesliechester, NJ 27647', 0, 'Single', NULL, '4142101632', 'Yes', NULL, 5, 'Elliott Padberg', '95785459885184', 'New Ressiechester', '2027-09-20', NULL, NULL, NULL, NULL, NULL, 766627923, 0, 0, 4, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(212, 4978, 2321, 'ليلى رامز شادي', 'Female', 4, 2, 5, '1974', 'الفيزياء', 'Good', '2017-01-17', '31520958803294', '2025-01-06', 'Kathrynhaven', 7, 'Muslim', 9, 'raymundo.wyman@example.net', 5, 6, 15, '0226380699', '0223742919', '01171994737', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '64158147021577', 'No', NULL, NULL, '2024-12-10', 'Employee', 7, 22, 'No', 'No', 1, '7.00', '49103.33', '1636.78', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '718.67', '36791904574508', 'Visa', 'No', NULL, '63622 Eduardo Vista Suite 021\nNew Parkerburgh, OR 22413-9661', 0, 'Divorced', NULL, '1034789221060', 'Yes', NULL, 4, 'Virgie McGlynn', '24540818352294', 'Lake Robertberg', '2026-04-01', NULL, NULL, NULL, NULL, NULL, 526447852, 0, 0, 1, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(213, 8919, 2206, 'نادية رامي ثامر', 'Female', 4, 3, 6, '1986', 'الرياضيات', 'Very_Good', '2004-07-26', '34148660594239', '2027-05-24', 'North Maeve', 2, 'Christian', 9, 'aleen.rohan@example.org', 5, 1, 2, '0226379460', '0227164041', '01259415728', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '04997550822233', 'No', NULL, NULL, '2020-09-26', 'Employee', 2, 18, 'Yes', 'Yes', 2, '12.00', '22608.43', '753.61', 'Fixed', '1052.16', 'No', NULL, NULL, 'Yes', '870.49', '46020708272333', 'Cach', 'Yes', NULL, '3802 Abbott Cliffs Apt. 634\nPort Minervachester, HI 28200', 0, 'Single', NULL, '332173', 'Yes', NULL, 1, 'Libbie Cronin', '47640443650558', 'New Jamarcusview', '2027-03-18', NULL, NULL, NULL, NULL, NULL, 271640557, 0, 0, 2, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(214, 9783, 1466, 'عصام شادي شريف', 'Male', 3, 4, 3, '1990', 'علوم الحاسوب', 'Very_Good', '2007-10-05', '72801658248935', '2027-08-18', 'Zanderchester', 1, 'Christian', 10, 'zhayes@example.org', 4, 22, 15, '0236731857', '0237394464', '01063973654', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '39587198065553', 'No', NULL, NULL, '2021-01-18', 'Employee', 4, 9, 'No', 'Yes', 3, '11.00', '11285.81', '376.19', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '677.25', '58915930728002', 'Visa', 'Yes', NULL, '30779 Hamill Light Apt. 072\nNorth Ashlee, NV 65141-2553', 0, 'Widowed', NULL, '342888045472', 'Yes', NULL, 5, 'Jazlyn Jacobi', '64306515084506', 'Gulgowskimouth', '2027-11-26', NULL, NULL, NULL, NULL, NULL, 507248549, 0, 0, 1, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(215, 2714, 179, 'أنس كريم عبدالفتاح', 'Male', 4, 3, 6, '1991', 'علوم الحاسوب', 'Good', '2004-08-06', '99970279947472', '2026-06-29', 'East Keatontown', 7, 'Christian', 10, 'isadore.pouros@example.com', 5, 18, 13, '0239094234', '0220346635', '01187704975', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '35184413343602', 'Yes', NULL, NULL, '2020-12-02', 'Employee', 6, 21, 'Yes', 'No', 4, '7.00', '23902.84', '796.76', 'Fixed', '1869.02', 'Yes', '732.00', '33885417412598', 'No', NULL, NULL, 'Cach', 'No', NULL, '314 Hilpert Village Apt. 869\nMorissettestad, NE 70176-2556', 0, 'Widowed', NULL, '8747037109709', 'Yes', NULL, 4, 'Abdullah Sipes', '86209452672615', 'North Katarinaberg', '2026-06-19', NULL, NULL, NULL, NULL, NULL, 1397798475, 0, 0, 1, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(216, 3056, 1494, 'نجوى عبدالحميد سعيد', 'Female', 2, 3, 5, '1975', 'علوم الحاسوب', 'Fair', '2002-12-27', '72545061155021', '2026-11-12', 'Justynfurt', 7, 'Christian', 6, 'wava.rohan@example.com', 4, 9, 7, '0232541674', '0235143564', '01010177748', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '24491966390102', 'No', NULL, NULL, '2020-03-15', 'Employee', 4, 11, 'Yes', 'Yes', 2, '10.00', '22007.30', '733.58', 'Fixed', '1011.80', 'No', NULL, NULL, 'Yes', '944.41', '94272311354697', 'Cach', 'Yes', NULL, '2616 Windler Plains\nLakinbury, FL 69151', 0, 'Single', NULL, '206185054477', 'Yes', NULL, 3, 'Karli Kozey', '43669879428729', 'West Roxanne', '2026-06-16', NULL, NULL, NULL, NULL, NULL, 1782047483, 0, 0, 4, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(217, 8539, 1598, 'رباب سامي وائل', 'Female', 4, 1, 3, '1978', 'الفيزياء', 'Good', '2020-04-22', '69829615809565', '2025-07-11', 'Pascaleville', 1, 'Christian', 4, 'lonie.deckow@example.com', 4, 18, 2, '0234737413', '0226869104', '01118603641', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '02079833288569', 'No', NULL, NULL, '2021-01-25', 'Employee', 7, 15, 'No', 'No', 3, '10.00', '27642.38', '921.41', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '872.76', '31063870178362', 'Visa', 'Yes', NULL, '751 Roberts Ranch Apt. 429\nNew Carson, TN 55614', 0, 'Single', NULL, '00950466963', 'Yes', NULL, 4, 'Dr. Samir Lindgren', '07846234285528', 'Hollistown', '2029-04-18', NULL, NULL, NULL, NULL, NULL, 1789385088, 0, 0, 3, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(218, 1905, 2872, 'أنس كريم نور', 'Male', 1, 2, 2, '2011', 'الهندسة', 'Good', '2000-02-04', '17190172449969', '2026-07-15', 'East Sylvanton', 4, 'Christian', 3, 'olson.allison@example.com', 6, 10, 5, '0236402749', '0224782542', '01061935945', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '73658870691872', 'Yes', NULL, NULL, '2023-11-20', 'Employee', 2, 12, 'Yes', 'Yes', 4, '12.00', '48207.92', '1606.93', 'Changeable', NULL, 'Yes', '816.74', '61145411314807', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '575 Lila Alley\nDickibury, HI 63841-3917', 0, 'Divorced', NULL, '42499417354', 'Yes', NULL, 6, 'Juvenal Reinger', '56544516800081', 'Port Damonbury', '2026-12-09', NULL, NULL, NULL, NULL, NULL, 949274045, 0, 0, 1, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(219, 2750, 1489, 'ندى عبدالعزيز عبداللطيف', 'Female', 3, 2, 2, '1978', 'الهندسة', 'Fair', '2000-11-08', '30184584275821', '2026-11-19', 'Zboncakborough', 7, 'Muslim', 2, 'jewell90@example.net', 3, 14, 14, '0230220633', '0235449907', '01190116937', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '41306007645955', 'No', NULL, NULL, '2024-02-16', 'Employee', 3, 16, 'No', 'No', 2, '9.00', '47904.68', '1596.82', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '67266 Diamond Inlet\nJakubowskifort, MI 43337-2047', 0, 'Married', NULL, '340605354', 'Yes', NULL, 5, 'Kennedi Labadie I', '77637497620322', 'North Tamiaport', '2025-12-01', NULL, NULL, NULL, NULL, NULL, 156686739, 0, 0, 3, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(220, 9772, 1332, 'سمر سليمان سامر', 'Female', 2, 1, 1, '1970', 'علم الأحياء', 'Very_Good', '2016-01-19', '45462055911603', '2026-03-01', 'Port Kelsishire', 7, 'Christian', 10, 'willard.tillman@example.org', 6, 5, 3, '0227457758', '0228335225', '01163678574', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '43586086342136', 'No', NULL, NULL, '2022-11-01', 'Employee', 6, 22, 'Yes', 'Yes', 4, '8.00', '15182.95', '506.10', 'Changeable', NULL, 'Yes', '609.22', '68955829561859', 'Yes', '948.45', '64200692455702', 'Visa', 'No', NULL, '96805 Abbott Road Suite 642\nLake Minervaview, AL 63439', 0, 'Married', NULL, '22363563505543', 'Yes', NULL, 5, 'Mabelle Johns', '05984789416885', 'Colemanborough', '2025-10-28', NULL, NULL, NULL, NULL, NULL, 1198605781, 0, 0, 1, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(221, 7607, 2325, 'بتول حمزة يحيى', 'Female', 2, 3, 6, '1973', 'الفيزياء', 'Good', '2019-07-08', '60512426990412', '2026-03-11', 'North Kailyn', 1, 'Muslim', 4, 'cole.montana@example.net', 5, 1, 15, '0233864777', '0239859651', '01534662828', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '52120775395102', 'Yes', NULL, NULL, '2022-07-24', 'Employee', 10, 6, 'Yes', 'No', 1, '7.00', '6683.77', '222.79', 'Fixed', '1410.96', 'Yes', '694.55', '19684995327712', 'Yes', '537.32', '24325458796369', 'Visa', 'No', NULL, '57221 Collier Field Suite 463\nWest Elishaview, AZ 83797', 0, 'Widowed', NULL, '0393639934772', 'Yes', NULL, 3, 'Prof. Christy Mosciski', '03679747980159', 'Maximillianchester', '2026-04-11', NULL, NULL, NULL, NULL, NULL, 165890206, 0, 0, 1, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(222, 1424, 2642, 'رحمة عبدالكريم نبيل', 'Female', 3, 2, 4, '2004', 'إدارة الأعمال', 'Excellent', '2015-05-05', '17814713126739', '2025-07-27', 'New Pathaven', 7, 'Christian', 12, 'kuhn.carlotta@example.org', 4, 6, 14, '0222547971', '0222850663', '01034808968', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '87123833481870', 'No', NULL, NULL, '2023-12-11', 'Employee', 10, 10, 'No', 'Yes', 3, '12.00', '43005.54', '1433.52', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '539.07', '94942305391872', 'Visa', 'No', NULL, '26727 Harris Terrace\nNew Vella, MN 30152-7006', 0, 'Divorced', NULL, '991114156195', 'Yes', NULL, 1, 'Mr. Mathias Heathcote III', '17544393580413', 'Port Schuyler', '2026-01-11', NULL, NULL, NULL, NULL, NULL, 1629625527, 0, 0, 1, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(223, 3304, 931, 'شهد عادل سليمان', 'Female', 4, 1, 2, '1994', 'الرياضيات', 'Good', '2010-06-04', '23042435723056', '2029-12-01', 'Americabury', 3, 'Christian', 7, 'mann.bernie@example.org', 6, 22, 15, '0226111526', '0235906147', '01147054253', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '04127988406964', 'Yes', NULL, NULL, '2021-04-20', 'Employee', 7, 6, 'Yes', 'No', 2, '12.00', '42334.30', '1411.14', 'Fixed', '1949.15', 'No', NULL, NULL, 'Yes', '835.00', '12116401084748', 'Cach', 'Yes', NULL, '797 Hill Trail\nMacejkovicstad, FL 40990', 0, 'Married', NULL, '12679165639407', 'Yes', NULL, 5, 'Kendall Lebsack', '99748090238258', 'North Alexysfort', '2025-10-22', NULL, NULL, NULL, NULL, NULL, 868614649, 0, 0, 2, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(224, 4256, 1045, 'عمر شادي توفيق', 'Male', 3, 2, 4, '2000', 'علم الأحياء', 'Very_Good', '2023-01-04', '33726484671709', '2027-11-30', 'Leeburgh', 4, 'Muslim', 12, 'maximo.dare@example.com', 2, 7, 7, '0237065691', '0232691892', '01583322109', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '93322624498267', 'Yes', NULL, NULL, '2021-09-11', 'Employee', 9, 29, 'Yes', 'Yes', 3, '8.00', '15760.41', '525.35', 'Fixed', '1457.36', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '1849 Kyleigh Creek\nNorth Adrienne, LA 19801', 0, 'Single', NULL, '5651760140', 'Yes', NULL, 6, 'Prof. Milan Harris', '73832334338789', 'Lake Gordon', '2028-06-05', NULL, NULL, NULL, NULL, NULL, 1145415752, 0, 0, 3, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(225, 5127, 1382, 'أكرم نادر حذيفة', 'Male', 4, 2, 5, '1997', 'إدارة الأعمال', 'Fair', '2003-01-30', '34019351079461', '2028-12-08', 'Vergieview', 3, 'Christian', 3, 'osteuber@example.org', 5, 15, 12, '0223344942', '0230021198', '01083380437', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '49347875702821', 'No', NULL, NULL, '2020-07-08', 'Employee', 3, 25, 'Yes', 'No', 3, '11.00', '30691.66', '1023.06', 'Fixed', '1270.83', 'Yes', '880.59', '13725566393575', 'Yes', '744.48', '69506133438873', 'Visa', 'Yes', NULL, '478 Ivory Branch Apt. 601\nBotsfordfurt, UT 02998', 0, 'Married', NULL, '66244228599', 'Yes', NULL, 3, 'Libbie Nikolaus DDS', '92421351335028', 'Mafaldafurt', '2025-06-04', NULL, NULL, NULL, NULL, NULL, 1571049557, 0, 0, 2, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(226, 3882, 304, 'مريم أحمد عامر', 'Female', 2, 3, 3, '2000', 'علوم الحاسوب', 'Very_Good', '2013-07-08', '18925034094912', '2027-03-25', 'East Andreanneland', 5, 'Muslim', 9, 'leatha.bogisich@example.org', 2, 11, 3, '0236170753', '0229101561', '01075120517', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '29623219163674', 'Yes', NULL, NULL, '2023-12-18', 'Employee', 9, 14, 'Yes', 'Yes', 4, '11.00', '32020.48', '1067.35', 'Fixed', '1749.26', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '4409 Rice Path Apt. 338\nStracketown, NJ 86678', 0, 'Married', NULL, '75081339622', 'Yes', NULL, 4, 'Cheyanne Bechtelar', '26665456429579', 'East Westonview', '2026-01-09', NULL, NULL, NULL, NULL, NULL, 498239536, 0, 0, 4, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(227, 7145, 820, 'هيفاء بدر فارس', 'Female', 1, 2, 1, '1984', 'الهندسة', 'Fair', '2019-10-06', '14621187265031', '2027-04-09', 'Lake Hildegard', 2, 'Muslim', 1, 'gbernhard@example.com', 3, 24, 7, '0221832113', '0232550386', '01253202020', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '48096599175696', 'Yes', NULL, NULL, '2020-04-20', 'Employee', 8, 11, 'Yes', 'Yes', 3, '10.00', '26380.83', '879.36', 'Fixed', '1348.04', 'Yes', '982.44', '61828383480825', 'No', NULL, NULL, 'Cach', 'No', NULL, '7840 Nathanial Oval Apt. 827\nLake Melody, GA 52696-6700', 0, 'Divorced', NULL, '12268356', 'Yes', NULL, 1, 'Maxime Pollich', '05672567054205', 'O\'Konchester', '2028-05-30', NULL, NULL, NULL, NULL, NULL, 1107603034, 0, 0, 4, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(228, 2179, 113, 'فاطمة عصام آدم', 'Female', 2, 3, 3, '2013', 'الفيزياء', 'Good', '2020-06-14', '61684693878770', '2027-10-12', 'Gerholdborough', 6, 'Muslim', 10, 'ulices.cole@example.com', 4, 7, 5, '0233653815', '0226917358', '01281541512', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '54963569803541', 'Yes', NULL, NULL, '2023-10-21', 'Employee', 10, 22, 'No', 'Yes', 3, '12.00', '47275.62', '1575.85', 'Fixed', '1619.65', 'Yes', '990.49', '55052484811654', 'No', NULL, NULL, 'Cach', 'No', NULL, '520 Ellen Cliff Suite 515\nNew Myah, AK 05676-3363', 0, 'Divorced', NULL, '934925671051', 'Yes', NULL, 5, 'Aubrey Vandervort', '97091685904266', 'New Cristobalmouth', '2028-04-12', NULL, NULL, NULL, NULL, NULL, 2110008533, 0, 0, 4, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(229, 9463, 1618, 'رفيق عامر صابر', 'Male', 3, 3, 1, '1999', 'الفيزياء', 'Very_Good', '2012-04-15', '33966576514904', '2025-04-02', 'Starkton', 2, 'Muslim', 10, 'ystracke@example.net', 3, 14, 6, '0232189285', '0224277441', '01222013197', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '89519285490276', 'Yes', NULL, NULL, '2023-08-16', 'Employee', 9, 18, 'Yes', 'Yes', 4, '7.00', '14881.04', '496.03', 'Fixed', '1692.44', 'Yes', '630.86', '29738523610964', 'Yes', '693.65', '71537259955339', 'Visa', 'Yes', NULL, '427 Bailey Pine\nDickinsonview, AZ 29994-6302', 0, 'Widowed', NULL, '005426691170', 'Yes', NULL, 1, 'Mayra Keeling', '39466185299038', 'Walshside', '2027-02-05', NULL, NULL, NULL, NULL, NULL, 2011639300, 0, 0, 1, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(230, 6843, 1142, 'حنان قاسم رياض', 'Female', 1, 4, 1, '1971', 'الهندسة', 'Very_Good', '2024-09-13', '41762244404949', '2027-04-13', 'Cleveport', 6, 'Christian', 3, 'ibrakus@example.com', 4, 13, 10, '0236227552', '0239612425', '01519568645', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '11358426687479', 'Yes', NULL, NULL, '2024-02-03', 'Employee', 3, 28, 'Yes', 'Yes', 2, '7.00', '14751.27', '491.71', 'Fixed', '1595.71', 'Yes', '644.16', '72889294607307', 'No', NULL, NULL, 'Visa', 'No', NULL, '862 Araceli Stravenue Suite 685\nDietrichborough, MT 97090-6431', 0, 'Divorced', NULL, '932847', 'Yes', NULL, 6, 'Mr. Kevin Luettgen V', '31921377557971', 'Juddbury', '2026-02-01', NULL, NULL, NULL, NULL, NULL, 915405128, 0, 0, 2, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(231, 7976, 1394, 'ماهر عبدالسلام كريم', 'Male', 4, 3, 3, '1990', 'إدارة الأعمال', 'Good', '2013-03-03', '96988560792295', '2029-03-26', 'New Antwonland', 3, 'Muslim', 10, 'murl02@example.net', 2, 3, 3, '0238678779', '0235302149', '01060192400', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '05073901504362', 'Yes', NULL, NULL, '2024-09-05', 'Employee', 2, 7, 'Yes', 'No', 3, '12.00', '41279.43', '1375.98', 'Fixed', '1143.26', 'Yes', '558.24', '37077164957377', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '70292 Darrin Gardens\nWalterberg, SD 50090', 0, 'Single', NULL, '58856383067499', 'Yes', NULL, 3, 'Antonia Wisoky I', '76074241897139', 'New Wardhaven', '2026-07-27', NULL, NULL, NULL, NULL, NULL, 692263268, 0, 0, 2, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(232, 5275, 213, 'ثريا عادل حمزة', 'Female', 2, 3, 4, '2008', 'علم الأحياء', 'Fair', '2006-01-04', '27636261331307', '2027-12-07', 'Jodieville', 5, 'Christian', 5, 'flarkin@example.net', 4, 11, 11, '0223404417', '0220063701', '01118570218', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '65333144567041', 'No', NULL, NULL, '2020-06-16', 'Employee', 8, 22, 'No', 'Yes', 3, '8.00', '10659.53', '355.32', 'Fixed', '1030.37', 'Yes', '553.59', '03518651400580', 'Yes', '529.91', '78673662819543', 'Visa', 'No', NULL, '696 Schroeder Causeway\nSedrickbury, VA 89438', 0, 'Divorced', NULL, '6015570993', 'Yes', NULL, 6, 'Major Schowalter', '56058817943815', 'North Daisyhaven', '2029-10-04', NULL, NULL, NULL, NULL, NULL, 1188235507, 0, 0, 3, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(233, 3766, 2082, 'ماهر وائل حاتم', 'Male', 2, 1, 3, '1992', 'الهندسة', 'Good', '2024-02-24', '37031962543358', '2027-03-13', 'Eastonfurt', 7, 'Christian', 1, 'runolfsson.judge@example.com', 4, 18, 13, '0232707059', '0226969647', '01273406597', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '94608479774174', 'No', NULL, NULL, '2021-09-18', 'Employee', 4, 29, 'No', 'Yes', 1, '7.00', '35518.66', '1183.96', 'Fixed', '1280.56', 'Yes', '596.07', '27749115968984', 'Yes', '750.56', '50165406312365', 'Visa', 'Yes', NULL, '289 Walker Mews\nSmithfort, RI 77192', 0, 'Divorced', NULL, '67697383258', 'Yes', NULL, 3, 'Mariela Harvey', '80267230725803', 'Trompview', '2025-11-20', NULL, NULL, NULL, NULL, NULL, 1590984794, 0, 0, 2, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(234, 4289, 2398, 'رينا صهيب حمزة', 'Female', 2, 1, 2, '2004', 'علوم الحاسوب', 'Very_Good', '2023-06-17', '02889687841496', '2026-09-21', 'Port Evan', 3, 'Muslim', 11, 'eulalia.mayert@example.org', 1, 3, 12, '0226834165', '0237081029', '01048253553', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '78961173982284', 'No', NULL, NULL, '2021-02-10', 'Employee', 9, 25, 'No', 'No', 4, '7.00', '30168.30', '1005.61', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '34420 Stark Junction Apt. 859\nHermannside, NJ 25329', 0, 'Divorced', NULL, '10537916156936', 'Yes', NULL, 6, 'Miss Rebekah Bechtelar', '95205652479898', 'South Eleazar', '2025-06-11', NULL, NULL, NULL, NULL, NULL, 1016352625, 0, 0, 3, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(235, 1779, 2137, 'عبدالرزاق جمال عدنان', 'Male', 1, 3, 4, '1978', 'الفيزياء', 'Fair', '2020-05-29', '85844326167089', '2029-07-19', 'Baileystad', 5, 'Muslim', 4, 'sunny13@example.com', 1, 11, 7, '0231794836', '0238837431', '01193445880', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '50727782962348', 'Yes', NULL, NULL, '2020-04-24', 'Employee', 1, 3, 'No', 'No', 1, '9.00', '14128.02', '470.93', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '56391 Sven Squares\nEast Cathyville, CO 01065-4011', 0, 'Widowed', NULL, '437167343', 'Yes', NULL, 1, 'Dr. Robyn Nikolaus', '92778847422216', 'Smithland', '2027-02-23', NULL, NULL, NULL, NULL, NULL, 472710110, 0, 0, 2, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(236, 7726, 2054, 'نجوى علاء قاسم', 'Female', 2, 4, 2, '1983', 'الرياضيات', 'Good', '2023-11-05', '99419871845643', '2027-11-23', 'East Lexi', 7, 'Christian', 11, 'rafaela87@example.net', 2, 19, 13, '0235862577', '0232124575', '01297121041', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '70006937539293', 'Yes', NULL, NULL, '2021-12-08', 'Employee', 8, 7, 'Yes', 'No', 4, '7.00', '45849.33', '1528.31', 'Changeable', NULL, 'Yes', '963.72', '12319110861513', 'Yes', '836.23', '02917256478600', 'Cach', 'No', NULL, '9793 Kris Camp Suite 424\nFeilview, MA 23900', 0, 'Single', NULL, '339214202869', 'Yes', NULL, 6, 'Barton Waelchi', '27302281604410', 'North Ramona', '2029-06-14', NULL, NULL, NULL, NULL, NULL, 1812883781, 0, 0, 4, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56');
INSERT INTO `employees` (`id`, `employee_code`, `fp_code`, `name`, `gender`, `branch_id`, `job_grade_id`, `qualification_id`, `qualification_year`, `major`, `graduation_estimate`, `brith_date`, `national_id`, `end_national_id`, `national_id_place`, `blood_types_id`, `religion`, `language_id`, `email`, `country_id`, `governorate_id`, `city_id`, `home_telephone`, `work_telephone`, `mobile`, `military`, `military_date_from`, `military_date_to`, `military_wepon`, `military_exemption_date`, `military_exemption_reason`, `military_postponement_reason`, `date_resignation`, `resignation_reason`, `driving_license`, `driving_license_type`, `driving_License_id`, `has_relatives`, `relatives_details`, `notes`, `work_start_date`, `functional_status`, `department_id`, `job_categories_id`, `has_attendance`, `has_fixed_shift`, `shift_types_id`, `daily_work_hour`, `salary`, `day_price`, `motivation_type`, `motivation`, `social_insurance`, `social_insurance_cut_monthely`, `social_insurance_number`, `medical_insurance`, `medical_insurance_cut_monthely`, `medical_insurance_number`, `Type_salary_receipt`, `active_vacation`, `urgent_person_details`, `staies_address`, `children_number`, `social_status`, `resignation_id`, `bank_number_account`, `disabilities`, `disabilities_type`, `nationality_id`, `name_sponsor`, `pasport_identity`, `pasport_from_place`, `pasport_exp_date`, `num_vacation_days`, `add_service`, `years_service`, `cv`, `basic_address_country`, `fixed_allowances`, `is_done_Vacation_formula`, `is_Sensitive_manager_data`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(237, 7008, 1274, 'منصور حامد كريم', 'Male', 2, 3, 3, '1999', 'علوم الحاسوب', 'Excellent', '2006-10-25', '78737307245326', '2029-07-31', 'Altenwerthville', 7, 'Christian', 6, 'dbogisich@example.org', 5, 6, 3, '0235893428', '0239993793', '01118907070', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '94517477064418', 'Yes', NULL, NULL, '2022-05-09', 'Employee', 4, 10, 'Yes', 'Yes', 2, '8.00', '25621.96', '854.07', 'Changeable', NULL, 'Yes', '704.90', '91419156136778', 'Yes', '559.96', '34205640366767', 'Cach', 'Yes', NULL, '60211 Kihn Lake Suite 519\nElyssabury, PA 03320-6600', 0, 'Single', NULL, '098957939614192', 'Yes', NULL, 4, 'Marion Hagenes III', '88020978455360', 'Evangelineton', '2026-08-03', NULL, NULL, NULL, NULL, NULL, 718724065, 0, 0, 2, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(238, 7784, 2677, 'رنا سالم عامر', 'Female', 2, 3, 2, '2006', 'الفيزياء', 'Excellent', '2016-09-23', '03059989221479', '2029-05-01', 'New Coty', 2, 'Muslim', 7, 'abogan@example.com', 4, 11, 5, '0224733697', '0231502142', '01039618777', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '28183020841515', 'Yes', NULL, NULL, '2024-06-24', 'Employee', 10, 18, 'No', 'Yes', 2, '10.00', '6823.56', '227.45', 'Fixed', '1173.21', 'No', NULL, NULL, 'Yes', '993.67', '38153498617704', 'Visa', 'Yes', NULL, '615 Ledner Expressway Suite 064\nPort Yessenia, MS 99529-4248', 0, 'Married', NULL, '043966132061', 'Yes', NULL, 6, 'Dr. Alan Johnson PhD', '79482086717428', 'Port Sylvesterborough', '2026-10-26', NULL, NULL, NULL, NULL, NULL, 1162300236, 0, 0, 1, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(239, 1789, 1835, 'سمر جواد عبداللطيف', 'Female', 3, 1, 5, '2010', 'الفيزياء', 'Excellent', '2022-01-02', '91241516352117', '2029-01-30', 'Domenicofort', 4, 'Muslim', 3, 'clement79@example.net', 2, 26, 7, '0220236135', '0239463989', '01177753442', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '47622703341288', 'No', NULL, NULL, '2022-08-09', 'Employee', 2, 22, 'Yes', 'No', 4, '7.00', '20005.38', '666.85', 'Changeable', NULL, 'Yes', '712.73', '98329550138790', 'Yes', '546.60', '59927418231408', 'Cach', 'Yes', NULL, '8747 Kallie Trail\nSipesville, NY 22362-8307', 0, 'Divorced', NULL, '2452226479404', 'Yes', NULL, 5, 'Viola Baumbach', '46542257514873', 'Wavaland', '2028-08-14', NULL, NULL, NULL, NULL, NULL, 714560398, 0, 0, 3, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(240, 7214, 1474, 'إسماعيل يحيى عبدالفتاح', 'Male', 2, 2, 4, '1989', 'إدارة الأعمال', 'Excellent', '2003-12-28', '09130437660110', '2029-10-16', 'Darechester', 1, 'Christian', 9, 'cruz17@example.net', 6, 6, 9, '0229288669', '0224786916', '01527504733', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '87039497047166', 'No', NULL, NULL, '2024-01-26', 'Employee', 7, 15, 'Yes', 'No', 2, '10.00', '16124.55', '537.49', 'Changeable', NULL, 'Yes', '680.85', '78331223846808', 'Yes', '876.85', '12567976818116', 'Visa', 'No', NULL, '61644 Zieme Via\nKorbinhaven, ME 21779', 0, 'Single', NULL, '294009404887', 'Yes', NULL, 5, 'Ms. Carmen Steuber', '86453027011127', 'Dickiborough', '2025-12-16', NULL, NULL, NULL, NULL, NULL, 2027873960, 0, 0, 4, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(241, 5735, 779, 'عبدالحي طلال عبدالله', 'Male', 2, 3, 5, '1998', 'الرياضيات', 'Fair', '2015-08-17', '77081901859913', '2026-03-16', 'Estebantown', 4, 'Muslim', 7, 'gbarrows@example.net', 3, 16, 3, '0222754870', '0231595920', '01295006400', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '81762637062102', 'No', NULL, NULL, '2023-04-06', 'Employee', 10, 30, 'Yes', 'Yes', 4, '12.00', '21254.82', '708.49', 'Fixed', '1212.07', 'Yes', '532.19', '69346672405728', 'No', NULL, NULL, 'Cach', 'No', NULL, '7166 Botsford Village\nSouth Samir, TX 90907', 0, 'Married', NULL, '412500', 'Yes', NULL, 6, 'Sarina Schamberger MD', '66315074559281', 'North Erichland', '2028-03-09', NULL, NULL, NULL, NULL, NULL, 997983502, 0, 0, 1, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(242, 9368, 1458, 'لمى شاكر وجيه', 'Female', 1, 3, 1, '1978', 'الرياضيات', 'Excellent', '2006-06-17', '30008289617225', '2029-06-06', 'North Quinnport', 1, 'Muslim', 11, 'burdette46@example.org', 3, 18, 2, '0230653390', '0234101079', '01259417246', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '85526168942893', 'Yes', NULL, NULL, '2023-08-01', 'Employee', 8, 4, 'Yes', 'No', 1, '10.00', '41395.00', '1379.83', 'Fixed', '1673.47', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '30034 Clarissa Underpass Suite 863\nRempelborough, AZ 13982-2774', 0, 'Married', NULL, '862380745528', 'Yes', NULL, 2, 'Sabryna Thompson', '68473089667098', 'Howellstad', '2025-04-04', NULL, NULL, NULL, NULL, NULL, 1568568764, 0, 0, 2, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(243, 3984, 419, 'سهى أيمن يوسف', 'Female', 1, 1, 3, '2008', 'علم الأحياء', 'Excellent', '2022-08-28', '14548673044761', '2025-06-02', 'East Dorotheaburgh', 1, 'Muslim', 5, 'clark.goyette@example.com', 6, 5, 15, '0226037772', '0223244884', '01009418419', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '12260649889933', 'No', NULL, NULL, '2022-10-18', 'Employee', 6, 1, 'Yes', 'Yes', 2, '12.00', '28559.80', '951.99', 'Fixed', '1718.03', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '2698 Jenkins Islands Suite 705\nLake Sofiamouth, AR 96037-2654', 0, 'Single', NULL, '94764615677', 'Yes', NULL, 4, 'Floy Lakin Jr.', '70246167689399', 'Kohlerstad', '2026-10-03', NULL, NULL, NULL, NULL, NULL, 810495768, 0, 0, 1, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(244, 8272, 388, 'بسمة تامر سعيد', 'Female', 2, 4, 1, '1970', 'الرياضيات', 'Excellent', '2005-03-17', '54728016253781', '2029-09-11', 'Schinnerton', 1, 'Muslim', 9, 'ullrich.walker@example.net', 4, 2, 9, '0222024387', '0233704859', '01546591400', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '41348200208484', 'Yes', NULL, NULL, '2021-10-17', 'Employee', 8, 8, 'No', 'No', 2, '11.00', '30103.21', '1003.44', 'Fixed', '1619.30', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '17841 Rowe Skyway\nGrimesfurt, TN 48971', 0, 'Married', NULL, '0597750491564', 'Yes', NULL, 1, 'Prof. Estella Abbott', '28055386279629', 'South Earlenefort', '2026-04-18', NULL, NULL, NULL, NULL, NULL, 281677566, 0, 0, 2, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(245, 3917, 1473, 'فاطمة تامر رياض', 'Female', 4, 1, 3, '2002', 'الفيزياء', 'Fair', '2014-06-21', '00433343509622', '2029-10-23', 'New Valentinmouth', 3, 'Muslim', 3, 'lenny61@example.com', 5, 1, 15, '0227515594', '0238178548', '01256881237', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '79095495930833', 'Yes', NULL, NULL, '2020-12-06', 'Employee', 8, 24, 'Yes', 'No', 1, '8.00', '14414.84', '480.49', 'Fixed', '1095.83', 'Yes', '940.77', '86104997179740', 'Yes', '779.73', '54814034976289', 'Cach', 'No', NULL, '28557 Rath Inlet Suite 674\nLake Mayraside, DC 70265-2795', 0, 'Single', NULL, '11216928632', 'Yes', NULL, 4, 'Leo Quigley', '78357083691875', 'Willmsshire', '2028-08-26', NULL, NULL, NULL, NULL, NULL, 432040843, 0, 0, 3, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(246, 8179, 733, 'مارين مهند صابر', 'Female', 1, 4, 2, '1999', 'الرياضيات', 'Good', '2012-04-29', '13325904739059', '2027-05-08', 'Kemmerside', 4, 'Christian', 4, 'ydaniel@example.net', 6, 16, 1, '0223315603', '0230536573', '01094970327', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '62771128018895', 'No', NULL, NULL, '2020-04-14', 'Employee', 4, 16, 'No', 'No', 1, '10.00', '33758.45', '1125.28', 'Changeable', NULL, 'Yes', '700.64', '57172781725996', 'Yes', '725.84', '31004507958469', 'Cach', 'No', NULL, '858 Bahringer Brooks Suite 945\nWest Gilesfurt, TX 75476', 0, 'Widowed', NULL, '486454114', 'Yes', NULL, 3, 'Trycia Effertz', '41613686944297', 'Tillmanton', '2025-08-03', NULL, NULL, NULL, NULL, NULL, 545360559, 0, 0, 4, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(247, 8121, 436, 'ديمة جمال رائد', 'Female', 3, 3, 1, '1984', 'علم الأحياء', 'Good', '2015-12-16', '26273939255992', '2027-12-12', 'Welchton', 1, 'Christian', 2, 'camryn17@example.com', 3, 17, 4, '0220089230', '0224327802', '01039620699', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '45761294445151', 'Yes', NULL, NULL, '2023-10-05', 'Employee', 7, 29, 'Yes', 'No', 4, '12.00', '7969.94', '265.66', 'Fixed', '1356.83', 'Yes', '886.01', '43661257079032', 'No', NULL, NULL, 'Cach', 'No', NULL, '89004 Annette Stravenue Suite 986\nMcKenzieview, WY 25866-4711', 0, 'Divorced', NULL, '14668318634373', 'Yes', NULL, 6, 'Miss Celestine Zboncak II', '02359672851035', 'Zoieland', '2026-10-01', NULL, NULL, NULL, NULL, NULL, 393082471, 0, 0, 4, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(248, 1968, 862, 'زينب صابر يحيى', 'Female', 1, 1, 5, '1971', 'الهندسة', 'Good', '2009-07-19', '13775416874152', '2027-10-24', 'Swaniawskiborough', 1, 'Muslim', 8, 'eddie04@example.org', 1, 22, 1, '0234034323', '0235095003', '01287225746', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '24357054002369', 'Yes', NULL, NULL, '2023-08-27', 'Employee', 6, 6, 'Yes', 'No', 4, '12.00', '10728.60', '357.62', 'Fixed', '1792.21', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '45120 Eldon Inlet Suite 973\nEast Chaimview, ID 75436', 0, 'Married', NULL, '093827986', 'Yes', NULL, 3, 'Austyn Gutmann MD', '31122387915475', 'Yostside', '2029-05-31', NULL, NULL, NULL, NULL, NULL, 683992466, 0, 0, 2, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(249, 8522, 2015, 'تامر صابر سليمان', 'Male', 3, 2, 5, '1992', 'علم الأحياء', 'Excellent', '2010-01-05', '04472557352724', '2029-07-14', 'South Francescashire', 3, 'Christian', 13, 'fritsch.rylan@example.net', 5, 14, 1, '0222376865', '0222492319', '01072281876', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '19583613465418', 'No', NULL, NULL, '2021-11-08', 'Employee', 1, 24, 'No', 'No', 2, '10.00', '5410.00', '180.33', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '582.77', '68027045516471', 'Visa', 'No', NULL, '4828 Chanel Light\nLake Lucie, WI 04920-1964', 0, 'Divorced', NULL, '2561104910', 'Yes', NULL, 1, 'Shyann Hessel', '03410476342552', 'East Carolanne', '2026-12-02', NULL, NULL, NULL, NULL, NULL, 575020621, 0, 0, 3, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(250, 9751, 1974, 'سامي عبدالحكيم عبدالحي', 'Male', 2, 3, 1, '2003', 'الهندسة', 'Fair', '2019-04-23', '25921592058651', '2027-11-29', 'North Alexandreborough', 1, 'Muslim', 11, 'vicente76@example.net', 2, 19, 12, '0229892804', '0225174483', '01529151829', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '08070304086410', 'Yes', NULL, NULL, '2021-06-14', 'Employee', 4, 1, 'No', 'No', 3, '9.00', '37983.51', '1266.12', 'Fixed', '1104.59', 'No', NULL, NULL, 'Yes', '577.28', '32072319786752', 'Cach', 'No', NULL, '299 Delphia Branch\nPort Sandra, PA 33906-3092', 0, 'Divorced', NULL, '1156389004', 'Yes', NULL, 2, 'Samanta Kris', '26385686798380', 'Smithton', '2025-10-07', NULL, NULL, NULL, NULL, NULL, 1840875347, 0, 0, 3, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(251, 4215, 272, 'فرح عبدالعزيز نبيل', 'Female', 4, 1, 5, '2007', 'علم الأحياء', 'Good', '2020-04-29', '61255512751832', '2027-06-05', 'Jakefort', 6, 'Christian', 12, 'wava67@example.org', 3, 14, 5, '0233132832', '0229958658', '01527289058', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '47409906701278', 'No', NULL, NULL, '2021-02-18', 'Employee', 5, 9, 'Yes', 'Yes', 2, '8.00', '19906.86', '663.56', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '718 Kautzer Rapids Suite 959\nRutherfordport, GA 76430-9032', 0, 'Divorced', NULL, '6699326376', 'Yes', NULL, 4, 'Prof. Erwin Reinger', '73085766704593', 'Bradenside', '2026-08-05', NULL, NULL, NULL, NULL, NULL, 1380287825, 0, 0, 4, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(252, 9613, 1543, 'أيوب ربيع عمار', 'Male', 4, 4, 6, '2005', 'علم الأحياء', 'Excellent', '2021-05-19', '93304954457271', '2028-06-29', 'Greenton', 6, 'Christian', 8, 'timothy.marquardt@example.org', 2, 20, 7, '0237945833', '0239037669', '01035186585', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '91372015272208', 'No', NULL, NULL, '2020-03-24', 'Employee', 1, 3, 'Yes', 'Yes', 2, '10.00', '23393.32', '779.78', 'Changeable', NULL, 'Yes', '640.11', '03213080884900', 'Yes', '979.18', '70111615805758', 'Cach', 'No', NULL, '73992 Hector Walk\nSchowalterland, AR 80458-5497', 0, 'Single', NULL, '749679374081256', 'Yes', NULL, 5, 'Prof. Napoleon Welch', '93550983618036', 'Boscomouth', '2029-03-14', NULL, NULL, NULL, NULL, NULL, 1006957042, 0, 0, 3, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(253, 3682, 2758, 'سليمان حسين رامي', 'Male', 1, 1, 1, '1976', 'علم الأحياء', 'Very_Good', '2022-09-17', '83068752841928', '2027-10-30', 'Lake Rossie', 5, 'Christian', 10, 'addison95@example.net', 2, 16, 6, '0232583202', '0232409778', '01213949762', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '96355377306952', 'Yes', NULL, NULL, '2022-10-14', 'Employee', 4, 6, 'No', 'No', 2, '7.00', '33538.27', '1117.94', 'Fixed', '1573.48', 'No', NULL, NULL, 'Yes', '536.81', '92246289908855', 'Visa', 'Yes', NULL, '7414 Dooley Mills\nPort Buford, DE 70438-5356', 0, 'Married', NULL, '63660538437', 'Yes', NULL, 5, 'Hilario Howell', '09196112343149', 'Brandynside', '2028-04-03', NULL, NULL, NULL, NULL, NULL, 1883817919, 0, 0, 3, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(254, 8177, 1085, 'عماد حاتم جواد', 'Male', 3, 4, 6, '2007', 'الهندسة', 'Very_Good', '2007-03-28', '39882372918007', '2026-05-13', 'Port Eldridgeborough', 3, 'Muslim', 5, 'wgleason@example.org', 4, 20, 15, '0235328574', '0223803713', '01519773201', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '46739601057756', 'Yes', NULL, NULL, '2024-02-20', 'Employee', 5, 2, 'Yes', 'Yes', 3, '7.00', '47214.41', '1573.81', 'Fixed', '1865.01', 'Yes', '789.89', '63318769672014', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '68382 Zackary Divide\nWest Kaylee, WV 25543', 0, 'Widowed', NULL, '93005140380', 'Yes', NULL, 6, 'Dr. Torrey Rosenbaum DVM', '88374753212289', 'New Merlstad', '2025-05-08', NULL, NULL, NULL, NULL, NULL, 1197042492, 0, 0, 1, NULL, 1, '2024-12-13 13:29:56', '2024-12-13 13:29:56'),
(255, 1074, 2046, 'شهد شريف زين', 'Female', 2, 1, 6, '1975', 'إدارة الأعمال', 'Good', '2016-03-19', '19689994346446', '2028-06-23', 'West Emilianobury', 5, 'Christian', 11, 'joana92@example.com', 1, 15, 10, '0220802670', '0236547916', '01260426308', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '46709750482465', 'Yes', NULL, NULL, '2021-01-14', 'Employee', 3, 9, 'No', 'No', 4, '11.00', '8007.77', '266.93', 'Fixed', '1143.76', 'No', NULL, NULL, 'Yes', '840.01', '06491850851858', 'Cach', 'No', NULL, '297 Considine Trace Apt. 609\nJacobsontown, ID 15863', 0, 'Single', NULL, '04266116104', 'Yes', NULL, 5, 'Prof. Misael Emard IV', '24509550858596', 'Adamsmouth', '2025-03-12', NULL, NULL, NULL, NULL, NULL, 602024195, 0, 0, 1, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(256, 4710, 1558, 'عبدالسلام يحيى قاسم', 'Male', 1, 2, 1, '1975', 'الهندسة', 'Very_Good', '2016-03-23', '33861129492326', '2027-08-09', 'Rutherfordchester', 1, 'Christian', 5, 'pboyer@example.org', 2, 6, 4, '0234966540', '0234753952', '01267464525', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '50868592294074', 'No', NULL, NULL, '2024-09-22', 'Employee', 6, 16, 'No', 'Yes', 3, '8.00', '15063.28', '502.11', 'Fixed', '1807.14', 'Yes', '749.33', '39503879648685', 'Yes', '523.93', '13117376779912', 'Visa', 'Yes', NULL, '59370 Iva Mission Apt. 424\nWehnerbury, CO 87657', 0, 'Single', NULL, '31690017362', 'Yes', NULL, 1, 'Lenny Schultz IV', '01029108766825', 'North Sammie', '2026-03-19', NULL, NULL, NULL, NULL, NULL, 965199407, 0, 0, 1, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(257, 8036, 2192, 'رحمة فارس أكرم', 'Female', 4, 1, 5, '1988', 'الفيزياء', 'Very_Good', '2004-08-03', '63910768831383', '2027-10-09', 'East Walter', 6, 'Christian', 1, 'gretchen.tillman@example.net', 1, 15, 4, '0227069557', '0231284573', '01233233428', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '66716814626515', 'No', NULL, NULL, '2024-05-10', 'Employee', 6, 24, 'Yes', 'Yes', 2, '7.00', '24918.02', '830.60', 'Fixed', '1974.77', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '28230 O\'Kon Rue Apt. 562\nLake Howard, TN 51955-6173', 0, 'Divorced', NULL, '298651', 'Yes', NULL, 4, 'Erna Gaylord', '70328385733432', 'Friedrichbury', '2027-08-05', NULL, NULL, NULL, NULL, NULL, 846287952, 0, 0, 3, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(258, 8802, 7, 'عبدالسلام أيمن عبدالعزيز', 'Male', 1, 4, 1, '2005', 'الرياضيات', 'Very_Good', '2011-06-24', '36627590125636', '2027-07-08', 'Sandrinestad', 4, 'Muslim', 1, 'herman39@example.net', 2, 17, 5, '0222356196', '0221434631', '01069077238', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '58257918180313', 'No', NULL, NULL, '2024-12-03', 'Employee', 1, 9, 'No', 'No', 2, '9.00', '33653.02', '1121.77', 'Fixed', '1137.54', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '42444 Hintz Junction Apt. 208\nO\'Konfort, KS 75895-0136', 0, 'Married', NULL, '590749694', 'Yes', NULL, 4, 'Miss Alfreda Braun III', '18088930187295', 'Opheliaburgh', '2028-01-28', NULL, NULL, NULL, NULL, NULL, 1491367538, 0, 0, 1, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(259, 7781, 541, 'عمر عامر أمجد', 'Male', 4, 3, 6, '1971', 'الفيزياء', 'Very_Good', '2012-02-17', '90949272176980', '2025-03-22', 'New Enola', 2, 'Muslim', 11, 'kamron17@example.net', 5, 4, 1, '0228466279', '0229454248', '01031598430', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '84181574324204', 'Yes', NULL, NULL, '2022-09-21', 'Employee', 8, 22, 'No', 'No', 4, '12.00', '12242.72', '408.09', 'Fixed', '1854.35', 'Yes', '976.15', '04921184245398', 'Yes', '570.15', '68380937495443', 'Visa', 'Yes', NULL, '615 Murazik Extension Apt. 152\nPort Mariamtown, MD 57394-2646', 0, 'Divorced', NULL, '11878307292', 'Yes', NULL, 6, 'Dr. Jakob Pacocha', '98903896953617', 'Eveberg', '2028-08-30', NULL, NULL, NULL, NULL, NULL, 1750571282, 0, 0, 1, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(260, 2432, 1665, 'كنزي رامي عامر', 'Female', 1, 2, 4, '1980', 'إدارة الأعمال', 'Excellent', '2002-09-26', '51817718151495', '2026-09-25', 'Thielton', 5, 'Christian', 5, 'jeff.skiles@example.com', 6, 23, 10, '0238607957', '0227904992', '01293937321', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '86766785256036', 'Yes', NULL, NULL, '2020-02-22', 'Employee', 2, 28, 'Yes', 'No', 1, '10.00', '17352.67', '578.42', 'Changeable', NULL, 'Yes', '842.82', '13206669596607', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '96295 Ethyl Pine Suite 710\nTerryhaven, WV 53277', 0, 'Married', NULL, '844809559482', 'Yes', NULL, 4, 'Kirsten Herzog', '38823952718478', 'Gerholdfort', '2029-06-11', NULL, NULL, NULL, NULL, NULL, 424489666, 0, 0, 2, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(261, 1467, 2243, 'عبدالرزاق علاء سيف', 'Male', 4, 4, 1, '1987', 'إدارة الأعمال', 'Fair', '2010-06-07', '19717101224496', '2027-12-22', 'Abernathyport', 7, 'Muslim', 8, 'isom68@example.net', 3, 22, 3, '0226162861', '0239016099', '01210024228', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '31025548495343', 'Yes', NULL, NULL, '2023-06-28', 'Employee', 1, 23, 'No', 'Yes', 3, '7.00', '8974.33', '299.14', 'Fixed', '1422.11', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '745 Roberts Crossing Apt. 571\nNorth Clementine, WA 41634-6750', 0, 'Widowed', NULL, '5984850327054', 'Yes', NULL, 1, 'Dr. Herminio Carroll IV', '71640073693686', 'Jalynmouth', '2025-05-13', NULL, NULL, NULL, NULL, NULL, 1170147232, 0, 0, 2, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(262, 4031, 376, 'سارة ثامر أديب', 'Female', 2, 3, 6, '1995', 'الهندسة', 'Fair', '2015-05-12', '13606663058348', '2028-06-29', 'Deronstad', 7, 'Muslim', 3, 'marcos36@example.net', 6, 16, 13, '0220980051', '0227338258', '01096640888', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '78874033522348', 'Yes', NULL, NULL, '2022-10-02', 'Employee', 8, 24, 'Yes', 'Yes', 4, '7.00', '8283.66', '276.12', 'Changeable', NULL, 'Yes', '661.82', '84521031598801', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '967 Madie Well Apt. 849\nKariannemouth, CA 29102-6461', 0, 'Single', NULL, '3826635556207', 'Yes', NULL, 2, 'Lauryn Rodriguez', '08625871171700', 'Walshfurt', '2027-05-11', NULL, NULL, NULL, NULL, NULL, 1588361540, 0, 0, 1, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(263, 3243, 2425, 'لؤي رامز إلياس', 'Male', 2, 1, 3, '1974', 'علم الأحياء', 'Good', '2014-01-29', '50179652600328', '2026-05-26', 'Fredrickport', 7, 'Muslim', 5, 'stephen20@example.com', 4, 4, 7, '0228674573', '0232779973', '01511089215', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '91937156953781', 'Yes', NULL, NULL, '2023-11-28', 'Employee', 10, 14, 'No', 'Yes', 3, '12.00', '6012.94', '200.43', 'Fixed', '1965.15', 'Yes', '739.17', '56687157277325', 'Yes', '945.08', '00495837127574', 'Cach', 'Yes', NULL, '3860 Ardith Dam\nCarliton, UT 34426', 0, 'Widowed', NULL, '541968604', 'Yes', NULL, 3, 'Sherwood Green', '74463322777536', 'Lake Coystad', '2029-01-21', NULL, NULL, NULL, NULL, NULL, 1528731878, 0, 0, 4, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(264, 9593, 1020, 'وفاء زياد علي', 'Female', 1, 1, 5, '1971', 'إدارة الأعمال', 'Very_Good', '2010-08-20', '07402828109287', '2027-08-16', 'East Marlinhaven', 6, 'Christian', 5, 'zbruen@example.net', 2, 3, 7, '0237623715', '0224508063', '01249165210', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '15229310991955', 'Yes', NULL, NULL, '2024-04-18', 'Employee', 7, 19, 'No', 'No', 3, '7.00', '34887.87', '1162.93', 'Changeable', NULL, 'Yes', '901.12', '83092821740311', 'Yes', '986.29', '66824138859900', 'Visa', 'Yes', NULL, '3585 Elmo Skyway Apt. 119\nPort Mauricioville, MI 53323', 0, 'Widowed', NULL, '7359170946', 'Yes', NULL, 2, 'Maude Ferry IV', '29798885443176', 'Lake May', '2028-02-17', NULL, NULL, NULL, NULL, NULL, 2139351607, 0, 0, 1, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(265, 7818, 775, 'حلا أيمن أكرم', 'Female', 2, 1, 6, '1988', 'إدارة الأعمال', 'Fair', '2021-01-08', '60830024411102', '2026-10-09', 'Markusbury', 4, 'Muslim', 5, 'nhamill@example.com', 3, 1, 14, '0227036939', '0237531122', '01031255055', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '36001072570007', 'No', NULL, NULL, '2020-10-02', 'Employee', 2, 14, 'Yes', 'Yes', 4, '12.00', '7559.62', '251.99', 'Changeable', NULL, 'Yes', '915.12', '35533514753344', 'No', NULL, NULL, 'Visa', 'No', NULL, '8408 Farrell Trail\nLake Kimborough, GA 55989-4338', 0, 'Divorced', NULL, '0853322334734', 'Yes', NULL, 1, 'Kathryne Tromp', '81948239568394', 'South Bobbie', '2029-01-10', NULL, NULL, NULL, NULL, NULL, 393447579, 0, 0, 1, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(266, 7959, 695, 'دعاء مالك عدنان', 'Female', 1, 2, 2, '1982', 'علوم الحاسوب', 'Good', '2014-10-23', '89084481811893', '2025-05-30', 'Bradtkeport', 1, 'Muslim', 8, 'trantow.nelle@example.org', 3, 12, 4, '0235427796', '0221745091', '01548857116', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '36741383434638', 'Yes', NULL, NULL, '2023-11-12', 'Employee', 1, 21, 'No', 'No', 1, '12.00', '22899.30', '763.31', 'Fixed', '1330.26', 'No', NULL, NULL, 'Yes', '986.36', '18736957241225', 'Cach', 'No', NULL, '9952 Edwina Plaza Suite 320\nWendyport, ME 37957-5821', 0, 'Single', NULL, '25973325736314', 'Yes', NULL, 1, 'Jolie Sipes', '48816446074043', 'East Stan', '2027-03-15', NULL, NULL, NULL, NULL, NULL, 1491276458, 0, 0, 4, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(267, 8491, 788, 'شهد وائل عامر', 'Female', 4, 4, 6, '1993', 'علم الأحياء', 'Very_Good', '2022-09-29', '32077455948796', '2028-06-01', 'Spinkamouth', 7, 'Muslim', 11, 'botsford.rubie@example.net', 5, 9, 14, '0224209825', '0229629540', '01575400493', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '86392310163279', 'Yes', NULL, NULL, '2023-04-30', 'Employee', 1, 6, 'No', 'Yes', 3, '11.00', '39131.84', '1304.39', 'Fixed', '1580.45', 'Yes', '633.47', '26731825220861', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '5970 Daniella Crest Apt. 245\nNew Marisaland, MN 86589', 0, 'Widowed', NULL, '145207527848', 'Yes', NULL, 1, 'Betty Pouros', '98071202867519', 'Hyattchester', '2027-04-27', NULL, NULL, NULL, NULL, NULL, 1914742554, 0, 0, 2, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(268, 6569, 938, 'بسمة آدم كريم', 'Female', 2, 1, 2, '1991', 'الهندسة', 'Good', '2000-04-30', '13867946560121', '2029-04-22', 'Jonesmouth', 1, 'Christian', 2, 'godfrey.hessel@example.net', 6, 20, 2, '0229320130', '0229294654', '01288798161', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '45273936877402', 'Yes', NULL, NULL, '2021-02-13', 'Employee', 2, 16, 'No', 'Yes', 3, '9.00', '48389.01', '1612.97', 'Fixed', '1268.40', 'Yes', '924.70', '97737174825281', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '30328 Camren Union\nNorth Jaquelinmouth, MS 98276', 0, 'Married', NULL, '2923160580', 'Yes', NULL, 6, 'Junior Schuppe', '31618006618081', 'Port Moses', '2028-08-09', NULL, NULL, NULL, NULL, NULL, 15237516, 0, 0, 1, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(269, 9460, 1799, 'سعاد وجيه توفيق', 'Female', 2, 3, 4, '2014', 'علم الأحياء', 'Fair', '2011-06-13', '92841312722140', '2025-08-20', 'South Hardychester', 4, 'Christian', 12, 'efritsch@example.net', 5, 4, 3, '0226136337', '0232776311', '01298679826', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '87565198067075', 'No', NULL, NULL, '2024-11-02', 'Employee', 3, 16, 'Yes', 'No', 2, '8.00', '47260.22', '1575.34', 'Fixed', '1626.08', 'Yes', '632.05', '62317440238570', 'Yes', '755.77', '35589524712191', 'Cach', 'No', NULL, '647 Monserrat Viaduct Apt. 183\nWest Bennyville, OK 04704', 0, 'Widowed', NULL, '212412562914824', 'Yes', NULL, 6, 'Miss Dessie Pfeffer', '17831614064412', 'Bradtkeburgh', '2028-03-29', NULL, NULL, NULL, NULL, NULL, 1031940941, 0, 0, 2, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(270, 1110, 1154, 'نبيل جواد سيف', 'Male', 2, 2, 2, '1994', 'علم الأحياء', 'Excellent', '2005-03-30', '13405462876207', '2026-08-27', 'West Kirashire', 5, 'Christian', 5, 'aruecker@example.org', 1, 19, 1, '0237531626', '0230509426', '01122829407', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '11316063930793', 'Yes', NULL, NULL, '2023-06-14', 'Employee', 3, 1, 'No', 'No', 2, '11.00', '23702.24', '790.07', 'Fixed', '1790.20', 'Yes', '895.82', '18851551461901', 'Yes', '596.60', '51842514979854', 'Visa', 'No', NULL, '506 Mina Ford Apt. 095\nNew Ahmad, SC 72659-0203', 0, 'Single', NULL, '4107277223419', 'Yes', NULL, 2, 'Cletus Walker', '18307032738666', 'West Alektown', '2027-09-10', NULL, NULL, NULL, NULL, NULL, 1378842082, 0, 0, 3, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(271, 8712, 2377, 'تالة راغب جمال', 'Female', 4, 1, 3, '1976', 'علم الأحياء', 'Excellent', '2019-11-18', '44517690700818', '2026-06-10', 'Gislasonberg', 7, 'Muslim', 7, 'lera12@example.org', 5, 4, 2, '0225163255', '0229464696', '01276416838', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '80396337286376', 'Yes', NULL, NULL, '2022-12-01', 'Employee', 5, 6, 'No', 'Yes', 2, '9.00', '42493.12', '1416.44', 'Changeable', NULL, 'Yes', '528.45', '57140032815244', 'No', NULL, NULL, 'Cach', 'No', NULL, '4561 Johnston Tunnel\nBerniermouth, CA 08267', 0, 'Married', NULL, '5239492374909', 'Yes', NULL, 2, 'Prof. Domenico Stark', '24981709467049', 'New Cielo', '2026-06-15', NULL, NULL, NULL, NULL, NULL, 355356741, 0, 0, 2, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(272, 9166, 1755, 'أحمد حذيفة عامر', 'Male', 3, 4, 2, '1984', 'الرياضيات', 'Fair', '2005-09-28', '15119766139692', '2028-09-01', 'Port Teaganshire', 1, 'Christian', 9, 'jacobs.hyman@example.org', 4, 19, 12, '0236930511', '0226078232', '01529320530', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '24106864256776', 'Yes', NULL, NULL, '2021-06-21', 'Employee', 5, 30, 'No', 'No', 3, '7.00', '36554.49', '1218.48', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '687.41', '96760776391930', 'Cach', 'Yes', NULL, '4980 Grimes Locks\nPort Doramouth, TX 21548-6200', 0, 'Divorced', NULL, '134859564303', 'Yes', NULL, 4, 'Danial Gottlieb', '21346768116081', 'North Osborneshire', '2026-09-28', NULL, NULL, NULL, NULL, NULL, 1245257816, 0, 0, 2, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(273, 6981, 871, 'رامز أمجد عبداللطيف', 'Male', 1, 4, 1, '2005', 'علوم الحاسوب', 'Excellent', '2000-12-15', '24626210839694', '2026-11-16', 'Hermannside', 4, 'Muslim', 2, 'bette54@example.net', 1, 20, 6, '0220453489', '0221788588', '01146816638', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '76441196106793', 'Yes', NULL, NULL, '2024-08-29', 'Employee', 9, 28, 'No', 'No', 3, '9.00', '7441.15', '248.04', 'Fixed', '1697.76', 'Yes', '947.42', '84770876462249', 'Yes', '742.34', '27952720550196', 'Visa', 'No', NULL, '160 Roberto Hills Apt. 687\nPort Vincenza, SD 33790-2393', 0, 'Single', NULL, '070688308378', 'Yes', NULL, 5, 'Emie Witting', '97181670770251', 'Elainabury', '2026-10-09', NULL, NULL, NULL, NULL, NULL, 1300528384, 0, 0, 3, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(274, 9894, 51, 'طارق رامز بكر', 'Male', 3, 4, 5, '1985', 'علم الأحياء', 'Good', '2000-05-22', '17009272092116', '2028-06-22', 'North Hailie', 4, 'Christian', 6, 'osborne68@example.net', 5, 13, 14, '0226842164', '0225876180', '01504463404', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '53875037954234', 'Yes', NULL, NULL, '2021-03-04', 'Employee', 4, 4, 'Yes', 'Yes', 1, '8.00', '42116.35', '1403.88', 'Fixed', '1713.90', 'Yes', '708.64', '75188220426330', 'Yes', '672.85', '94136252871508', 'Visa', 'Yes', NULL, '6240 Jast Branch\nO\'Reillychester, ME 72220-6260', 0, 'Married', NULL, '896399072', 'Yes', NULL, 4, 'Giovanni Feeney DVM', '47999514840393', 'Lake Johnpaul', '2028-11-23', NULL, NULL, NULL, NULL, NULL, 559309439, 0, 0, 1, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(275, 8079, 1312, 'إبراهيم منصور سالم', 'Male', 3, 1, 2, '2001', 'الهندسة', 'Very_Good', '2021-01-19', '32197276773060', '2025-07-31', 'New Gabriellaview', 2, 'Christian', 3, 'anastacio95@example.com', 6, 18, 1, '0227975368', '0231179237', '01291353943', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '38542906740920', 'Yes', NULL, NULL, '2023-01-26', 'Employee', 8, 28, 'Yes', 'Yes', 1, '7.00', '17212.80', '573.76', 'Fixed', '1903.78', 'Yes', '974.57', '82428906406454', 'Yes', '875.86', '38970378660650', 'Visa', 'No', NULL, '5069 Krystel Radial\nEast Deonteville, HI 11872-0336', 0, 'Widowed', NULL, '070089954', 'Yes', NULL, 4, 'Henriette Bashirian', '13511411168452', 'Josueville', '2026-06-27', NULL, NULL, NULL, NULL, NULL, 1609448021, 0, 0, 3, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(276, 7307, 1985, 'مهند عامر طارق', 'Male', 2, 3, 1, '2013', 'الفيزياء', 'Excellent', '2006-08-27', '30175609731931', '2026-10-11', 'Lake Lorna', 2, 'Muslim', 8, 'hailie10@example.com', 1, 18, 5, '0225078045', '0238900914', '01197862699', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '81906767573755', 'Yes', NULL, NULL, '2021-10-30', 'Employee', 3, 13, 'Yes', 'No', 1, '7.00', '13450.27', '448.34', 'Fixed', '1505.52', 'Yes', '963.17', '19197217773925', 'Yes', '974.34', '16195007767701', 'Visa', 'No', NULL, '349 Tremblay Circle\nNew Isaac, ME 07923', 0, 'Single', NULL, '502294367822', 'Yes', NULL, 6, 'Rico Schowalter', '23034907374798', 'Lueilwitzside', '2029-11-28', NULL, NULL, NULL, NULL, NULL, 1300697616, 0, 0, 4, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(277, 2413, 880, 'عبدالسلام شاكر رامز', 'Male', 3, 2, 1, '1999', 'الهندسة', 'Excellent', '2017-08-08', '85157244131316', '2029-01-26', 'Crystelview', 4, 'Christian', 13, 'mcglynn.cortez@example.com', 6, 22, 4, '0222103841', '0232228618', '01108610817', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '38431515549727', 'Yes', NULL, NULL, '2021-02-14', 'Employee', 9, 19, 'No', 'No', 2, '9.00', '45153.14', '1505.10', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '5479 Toby Ferry\nPowlowskihaven, MS 71182-6058', 0, 'Married', NULL, '358344246780', 'Yes', NULL, 6, 'Elwyn Stehr', '69681696652002', 'New Will', '2027-08-16', NULL, NULL, NULL, NULL, NULL, 1143952178, 0, 0, 1, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(278, 6005, 999, 'شريف عدنان آدم', 'Male', 4, 3, 4, '1976', 'إدارة الأعمال', 'Good', '2015-01-17', '98155158617494', '2028-12-15', 'Hermistonmouth', 6, 'Christian', 4, 'atrantow@example.com', 6, 26, 1, '0229449541', '0229690478', '01538659803', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '66429539790841', 'No', NULL, NULL, '2020-02-06', 'Employee', 9, 4, 'Yes', 'No', 1, '9.00', '33949.60', '1131.65', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '6328 Lemuel Flat\nVonRuedenland, SD 07292', 0, 'Widowed', NULL, '2819042990227', 'Yes', NULL, 4, 'Mr. Alessandro Quigley', '89020717817380', 'Kileyhaven', '2029-09-17', NULL, NULL, NULL, NULL, NULL, 705104853, 0, 0, 1, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(279, 1747, 764, 'عبدالعزيز ثامر فارس', 'Male', 3, 1, 6, '2007', 'الفيزياء', 'Excellent', '2018-12-10', '57753259280890', '2026-03-20', 'Jacobimouth', 1, 'Christian', 3, 'mckenzie.vincenzo@example.com', 2, 16, 10, '0228569571', '0235134571', '01523177168', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '37534217239247', 'No', NULL, NULL, '2020-05-18', 'Employee', 2, 26, 'No', 'No', 3, '10.00', '17556.43', '585.21', 'Fixed', '1304.25', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '2955 Dickens View\nIvachester, FL 28588', 0, 'Single', NULL, '375478675830196', 'Yes', NULL, 3, 'Kaley Stokes', '98566188535955', 'South Abe', '2028-09-08', NULL, NULL, NULL, NULL, NULL, 1310206328, 0, 0, 3, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(280, 3155, 246, 'ماريا عبدالرزاق إسماعيل', 'Female', 3, 3, 6, '1988', 'علوم الحاسوب', 'Excellent', '2015-10-19', '80231893857571', '2028-10-23', 'Armstrongfurt', 4, 'Muslim', 1, 'mavis48@example.net', 5, 3, 12, '0228912990', '0231704382', '01592123737', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '82732654234724', 'Yes', NULL, NULL, '2020-01-15', 'Employee', 5, 24, 'Yes', 'No', 2, '12.00', '18073.25', '602.44', 'Changeable', NULL, 'Yes', '875.21', '32792069384420', 'Yes', '664.19', '49786203618067', 'Visa', 'No', NULL, '62261 Jones Stream\nAdityamouth, CT 73294-6972', 0, 'Married', NULL, '80249787', 'Yes', NULL, 6, 'Rosemarie Tremblay', '01214762341690', 'Westhaven', '2027-02-20', NULL, NULL, NULL, NULL, NULL, 1455866800, 0, 0, 3, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(281, 1479, 1945, 'روان طارق رياض', 'Female', 4, 1, 5, '2008', 'علم الأحياء', 'Fair', '2002-02-17', '43771539613895', '2027-02-05', 'Elveraburgh', 5, 'Muslim', 9, 'qmosciski@example.org', 1, 5, 14, '0220365799', '0232838638', '01102881987', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '49932819505212', 'Yes', NULL, NULL, '2022-04-18', 'Employee', 6, 25, 'Yes', 'Yes', 3, '8.00', '7015.37', '233.85', 'Fixed', '1775.20', 'Yes', '531.52', '14418403090700', 'Yes', '855.59', '31109335114028', 'Visa', 'No', NULL, '6562 Annabel Locks\nKuhnfort, KY 89737-4932', 0, 'Married', NULL, '99486615168', 'Yes', NULL, 6, 'Enos Kreiger', '02090887410280', 'Catalinamouth', '2026-07-08', NULL, NULL, NULL, NULL, NULL, 503354101, 0, 0, 4, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(282, 5718, 2024, 'نبيل آدم شريف', 'Male', 1, 4, 3, '1970', 'علم الأحياء', 'Excellent', '2018-10-16', '52516530091806', '2027-09-08', 'North Jazmin', 1, 'Christian', 1, 'emanuel47@example.com', 2, 2, 1, '0225304783', '0227073750', '01234304435', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '08674645516601', 'No', NULL, NULL, '2023-11-03', 'Employee', 3, 17, 'No', 'No', 2, '9.00', '39169.06', '1305.64', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '8256 Rodriguez Course\nLittelbury, LA 84436', 0, 'Married', NULL, '395223551232', 'Yes', NULL, 2, 'Mckenzie Erdman II', '61193655509828', 'Thorabury', '2026-02-28', NULL, NULL, NULL, NULL, NULL, 332401780, 0, 0, 2, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(283, 6127, 2966, 'رشا رشيد لؤي', 'Female', 2, 2, 6, '1992', 'علم الأحياء', 'Good', '2023-05-08', '01752768932150', '2027-01-12', 'Randitown', 1, 'Christian', 2, 'keira.bednar@example.com', 1, 10, 4, '0232543471', '0234672714', '01083267231', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '15021479326696', 'Yes', NULL, NULL, '2024-08-16', 'Employee', 7, 1, 'No', 'Yes', 4, '10.00', '38291.24', '1276.37', 'Fixed', '1404.77', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '5414 Schuster Port Apt. 029\nSouth Jessika, TX 74292', 0, 'Single', NULL, '451072575', 'Yes', NULL, 2, 'Una Willms Jr.', '40374215121087', 'East Savannahmouth', '2026-04-15', NULL, NULL, NULL, NULL, NULL, 337351513, 0, 0, 4, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(284, 3467, 1398, 'نوران يوسف آدم', 'Female', 3, 3, 3, '2009', 'الرياضيات', 'Fair', '2015-01-05', '61636951613480', '2026-02-14', 'Lake Stephanchester', 4, 'Christian', 5, 'ftremblay@example.net', 4, 23, 4, '0233618312', '0232147172', '01203180996', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '89420695600872', 'Yes', NULL, NULL, '2020-11-05', 'Employee', 8, 15, 'No', 'No', 2, '10.00', '31177.85', '1039.26', 'Fixed', '1106.37', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '3649 Lesch Radial Suite 271\nRossiebury, NH 50741', 0, 'Married', NULL, '13096638', 'Yes', NULL, 6, 'Noemy Bechtelar I', '08123512170625', 'East Neal', '2027-04-28', NULL, NULL, NULL, NULL, NULL, 32309185, 0, 0, 2, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(285, 8816, 1939, 'نادية مصطفى صابر', 'Female', 1, 2, 5, '1986', 'علوم الحاسوب', 'Fair', '2008-03-10', '93143950204135', '2029-12-01', 'North Nichole', 7, 'Muslim', 5, 'rutherford.meredith@example.org', 6, 5, 6, '0226689340', '0237144587', '01593172245', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '90404604333631', 'Yes', NULL, NULL, '2024-07-23', 'Employee', 9, 10, 'No', 'No', 2, '11.00', '19341.99', '644.73', 'Fixed', '1177.50', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '3887 Lueilwitz Prairie Apt. 165\nCummeratafurt, LA 55407', 0, 'Divorced', NULL, '27241447279', 'Yes', NULL, 6, 'Luther Cassin', '57024240903687', 'North Aurore', '2028-04-16', NULL, NULL, NULL, NULL, NULL, 1440776212, 0, 0, 4, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(286, 8233, 1888, 'عبدالحكيم حامد يوسف', 'Male', 1, 4, 2, '1976', 'علم الأحياء', 'Excellent', '2006-12-17', '27139562248782', '2025-01-30', 'Rennerfurt', 5, 'Muslim', 10, 'hackett.tess@example.org', 4, 6, 5, '0224037814', '0232430383', '01535924350', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '77716293639055', 'Yes', NULL, NULL, '2020-11-02', 'Employee', 1, 29, 'No', 'Yes', 2, '12.00', '8700.66', '290.02', 'Fixed', '1242.06', 'No', NULL, NULL, 'Yes', '647.66', '78062081179333', 'Visa', 'No', NULL, '312 Keshaun Road\nNorth Travon, OH 98174', 0, 'Widowed', NULL, '2086076', 'Yes', NULL, 6, 'Miss Hettie Mann', '50219009765587', 'Coltville', '2026-01-21', NULL, NULL, NULL, NULL, NULL, 9291061, 0, 0, 1, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(287, 2932, 2841, 'ناجي أكرم إبراهيم', 'Male', 2, 2, 2, '1999', 'الفيزياء', 'Fair', '2000-01-23', '82248838580840', '2028-07-27', 'Verlaburgh', 6, 'Christian', 3, 'stefan53@example.net', 6, 11, 11, '0233788451', '0221119594', '01049674975', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '60467692681442', 'No', NULL, NULL, '2022-01-11', 'Employee', 3, 21, 'Yes', 'No', 4, '12.00', '22332.48', '744.42', 'Changeable', NULL, 'Yes', '572.53', '59303328452999', 'No', NULL, NULL, 'Visa', 'No', NULL, '6847 Susanna Square Suite 473\nSchmelerview, IL 19073-2560', 0, 'Married', NULL, '6754477368', 'Yes', NULL, 4, 'Evan D\'Amore', '72139114971270', 'Port Rosariomouth', '2028-11-08', NULL, NULL, NULL, NULL, NULL, 1267748056, 0, 0, 1, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(288, 1450, 1533, 'هيفاء محمود وجيه', 'Female', 1, 2, 6, '2003', 'علم الأحياء', 'Very_Good', '2019-02-25', '97186211328692', '2029-03-07', 'Port Anabelleburgh', 7, 'Christian', 1, 'evans.hamill@example.com', 6, 5, 11, '0234906060', '0235827377', '01107453881', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '86987916399489', 'No', NULL, NULL, '2023-04-05', 'Employee', 7, 30, 'No', 'No', 3, '9.00', '47827.76', '1594.26', 'Changeable', NULL, 'Yes', '802.66', '19068117972475', 'No', NULL, NULL, 'Visa', 'No', NULL, '468 Kilback Views Apt. 674\nSouth Veldaton, HI 52672', 0, 'Widowed', NULL, '892148', 'Yes', NULL, 6, 'Hubert Bogan', '44579122524353', 'Emeraldstad', '2026-12-22', NULL, NULL, NULL, NULL, NULL, 1634536135, 0, 0, 2, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(289, 4176, 1455, 'كريم جواد أيوب', 'Male', 3, 3, 5, '1984', 'الفيزياء', 'Fair', '2007-10-31', '32596344530490', '2027-04-24', 'Scarlettport', 4, 'Muslim', 1, 'montana52@example.org', 5, 27, 4, '0238532957', '0233451167', '01520856339', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '94546612347226', 'Yes', NULL, NULL, '2024-11-17', 'Employee', 1, 9, 'No', 'Yes', 4, '12.00', '42583.16', '1419.44', 'Fixed', '1029.29', 'Yes', '728.51', '18916534071214', 'Yes', '551.58', '75679277604765', 'Cach', 'Yes', NULL, '4789 Dovie Ford\nO\'Keefetown, FL 27284', 0, 'Widowed', NULL, '27619726', 'Yes', NULL, 1, 'Ms. Dayna Franecki MD', '03979138389471', 'Eloiseland', '2028-05-07', NULL, NULL, NULL, NULL, NULL, 1549744334, 0, 0, 3, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(290, 9344, 2713, 'إيمان إبراهيم سالم', 'Female', 4, 3, 4, '2008', 'علوم الحاسوب', 'Good', '2013-01-22', '19563008135268', '2028-12-03', 'New Shaunfurt', 2, 'Christian', 2, 'seth32@example.net', 2, 15, 8, '0238435073', '0230259455', '01159012032', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '19273397222038', 'No', NULL, NULL, '2020-08-15', 'Employee', 3, 1, 'Yes', 'Yes', 3, '7.00', '9019.35', '300.65', 'Changeable', NULL, 'Yes', '581.31', '91124691239747', 'No', NULL, NULL, 'Visa', 'No', NULL, '134 Maxwell Square\nDurganbury, VA 39822', 0, 'Widowed', NULL, '0750518391876', 'Yes', NULL, 5, 'Amira Weber', '82395052618786', 'West Margareteborough', '2027-01-29', NULL, NULL, NULL, NULL, NULL, 25224920, 0, 0, 1, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(291, 4664, 283, 'عبدالكريم جواد منصور', 'Male', 2, 1, 6, '2002', 'الفيزياء', 'Good', '2019-11-12', '63701832024579', '2029-03-04', 'South Rolandoside', 1, 'Muslim', 13, 'kling.clifton@example.org', 3, 7, 15, '0228200199', '0239840773', '01531267296', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '91623464546844', 'No', NULL, NULL, '2024-02-07', 'Employee', 5, 13, 'No', 'No', 4, '9.00', '27513.17', '917.11', 'Fixed', '1382.65', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '590 Shannon Coves\nEast Niko, NY 99408-7124', 0, 'Divorced', NULL, '9476374270', 'Yes', NULL, 5, 'Dr. Destin Grimes V', '87677223193606', 'New Marvin', '2027-11-08', NULL, NULL, NULL, NULL, NULL, 646551430, 0, 0, 2, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(292, 2023, 1516, 'حنان ناجي زيد', 'Female', 4, 3, 3, '1982', 'علم الأحياء', 'Good', '2015-05-10', '94777983909241', '2027-11-09', 'Rosaleeville', 4, 'Christian', 8, 'wintheiser.evangeline@example.com', 4, 20, 15, '0234130715', '0237909815', '01252380074', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '73292084025690', 'Yes', NULL, NULL, '2019-12-24', 'Employee', 7, 12, 'Yes', 'Yes', 3, '7.00', '49301.36', '1643.38', 'Fixed', '1683.31', 'Yes', '864.83', '41091995671733', 'No', NULL, NULL, 'Cach', 'No', NULL, '90275 McLaughlin Shoal Suite 686\nFeilfurt, NH 21728-2707', 0, 'Divorced', NULL, '21908783544', 'Yes', NULL, 5, 'Kavon Cruickshank', '04955273569416', 'Heidenreichmouth', '2028-05-22', NULL, NULL, NULL, NULL, NULL, 1624015465, 0, 0, 3, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(293, 4611, 1171, 'لبنى مصطفى وائل', 'Female', 2, 1, 5, '1990', 'الهندسة', 'Very_Good', '2024-08-03', '36209043009495', '2029-10-23', 'Lake Everettfurt', 1, 'Muslim', 5, 'jast.kristopher@example.org', 2, 13, 6, '0236733844', '0233698213', '01134154046', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '70372441101181', 'No', NULL, NULL, '2021-07-09', 'Employee', 6, 28, 'Yes', 'Yes', 3, '10.00', '29818.75', '993.96', 'Fixed', '1145.10', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '40010 Laura Place\nLindfurt, CA 68268-1053', 0, 'Divorced', NULL, '66428725880', 'Yes', NULL, 5, 'Mr. Prince Parker I', '77244012922569', 'New Maxime', '2025-11-25', NULL, NULL, NULL, NULL, NULL, 279887829, 0, 0, 3, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(294, 3900, 664, 'أيمن مصطفى حسن', 'Male', 2, 3, 5, '1997', 'الرياضيات', 'Good', '2021-09-09', '33092206735430', '2026-01-04', 'North Augustine', 7, 'Muslim', 1, 'nicolas.vince@example.net', 1, 13, 4, '0223866111', '0226140685', '01177291624', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '35259049822195', 'No', NULL, NULL, '2024-01-21', 'Employee', 5, 28, 'No', 'No', 4, '12.00', '49702.65', '1656.76', 'Changeable', NULL, 'Yes', '798.22', '08318416813232', 'Yes', '601.78', '10126139754777', 'Visa', 'No', NULL, '615 Arnaldo Coves\nSouth Otilia, ND 07527', 0, 'Widowed', NULL, '9433347064374', 'Yes', NULL, 2, 'Hubert Glover DVM', '17116064870870', 'North Paige', '2028-11-07', NULL, NULL, NULL, NULL, NULL, 1185885502, 0, 0, 2, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(295, 3278, 672, 'سعيد عصام حامد', 'Male', 4, 4, 6, '2002', 'الفيزياء', 'Good', '2017-04-22', '35092295913603', '2025-10-15', 'Ernestineburgh', 5, 'Christian', 7, 'adelia56@example.com', 2, 10, 14, '0234052411', '0227509179', '01228800518', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '42262788972085', 'No', NULL, NULL, '2024-07-06', 'Employee', 5, 6, 'No', 'No', 4, '7.00', '30503.84', '1016.79', 'Changeable', NULL, 'Yes', '970.87', '77239999977797', 'Yes', '746.30', '43462011640135', 'Cach', 'No', NULL, '7356 Johns Ridge Suite 773\nEast Pasqualeborough, NJ 22636', 0, 'Widowed', NULL, '5928254661', 'Yes', NULL, 5, 'Prof. Marcelino Treutel', '30450044708898', 'Loweburgh', '2026-04-27', NULL, NULL, NULL, NULL, NULL, 697170696, 0, 0, 3, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57');
INSERT INTO `employees` (`id`, `employee_code`, `fp_code`, `name`, `gender`, `branch_id`, `job_grade_id`, `qualification_id`, `qualification_year`, `major`, `graduation_estimate`, `brith_date`, `national_id`, `end_national_id`, `national_id_place`, `blood_types_id`, `religion`, `language_id`, `email`, `country_id`, `governorate_id`, `city_id`, `home_telephone`, `work_telephone`, `mobile`, `military`, `military_date_from`, `military_date_to`, `military_wepon`, `military_exemption_date`, `military_exemption_reason`, `military_postponement_reason`, `date_resignation`, `resignation_reason`, `driving_license`, `driving_license_type`, `driving_License_id`, `has_relatives`, `relatives_details`, `notes`, `work_start_date`, `functional_status`, `department_id`, `job_categories_id`, `has_attendance`, `has_fixed_shift`, `shift_types_id`, `daily_work_hour`, `salary`, `day_price`, `motivation_type`, `motivation`, `social_insurance`, `social_insurance_cut_monthely`, `social_insurance_number`, `medical_insurance`, `medical_insurance_cut_monthely`, `medical_insurance_number`, `Type_salary_receipt`, `active_vacation`, `urgent_person_details`, `staies_address`, `children_number`, `social_status`, `resignation_id`, `bank_number_account`, `disabilities`, `disabilities_type`, `nationality_id`, `name_sponsor`, `pasport_identity`, `pasport_from_place`, `pasport_exp_date`, `num_vacation_days`, `add_service`, `years_service`, `cv`, `basic_address_country`, `fixed_allowances`, `is_done_Vacation_formula`, `is_Sensitive_manager_data`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(296, 1726, 2556, 'رائد زياد طارق', 'Male', 3, 1, 3, '2012', 'إدارة الأعمال', 'Excellent', '2017-06-18', '48102036496589', '2028-10-20', 'West Constanceshire', 7, 'Muslim', 9, 'dereck.green@example.net', 3, 18, 6, '0225818930', '0232722261', '01131335159', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '80778827468805', 'No', NULL, NULL, '2020-10-01', 'Employee', 10, 29, 'No', 'No', 1, '12.00', '13401.86', '446.73', 'Fixed', '1732.72', 'Yes', '721.67', '21849682387212', 'Yes', '512.46', '69017061409194', 'Visa', 'Yes', NULL, '28462 Hahn Tunnel\nUptonbury, ID 58594', 0, 'Single', NULL, '69600704', 'Yes', NULL, 6, 'Trevor Hermann MD', '50484387331088', 'Lulufurt', '2026-04-12', NULL, NULL, NULL, NULL, NULL, 1122493893, 0, 0, 2, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(297, 6478, 1301, 'لمى نبيل عبدالفتاح', 'Female', 3, 4, 5, '1995', 'الفيزياء', 'Very_Good', '2005-07-26', '69117356148908', '2029-09-29', 'Andersonton', 5, 'Muslim', 7, 'stephan38@example.net', 6, 20, 5, '0238965917', '0233477446', '01240218140', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '12018056147965', 'No', NULL, NULL, '2024-02-28', 'Employee', 7, 5, 'No', 'No', 4, '8.00', '26937.92', '897.93', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '3969 Dooley Mountains Suite 407\nAllychester, AK 15673-0173', 0, 'Married', NULL, '54209424845950', 'Yes', NULL, 1, 'Jake Huel', '54552924149968', 'Heidenreichhaven', '2026-01-27', NULL, NULL, NULL, NULL, NULL, 1967752733, 0, 0, 3, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(298, 4205, 697, 'وفاء يوسف شاكر', 'Female', 3, 2, 4, '2012', 'علم الأحياء', 'Excellent', '2009-04-24', '12024352753650', '2027-02-03', 'South Rosendoton', 4, 'Christian', 6, 'aeichmann@example.net', 5, 5, 1, '0229392347', '0231982176', '01153869225', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '13730693557848', 'Yes', NULL, NULL, '2024-01-05', 'Employee', 9, 3, 'Yes', 'Yes', 3, '9.00', '34515.88', '1150.53', 'Changeable', NULL, 'Yes', '699.56', '07880255062973', 'No', NULL, NULL, 'Visa', 'No', NULL, '39525 Bart Fork Apt. 730\nAbernathyshire, PA 22274', 0, 'Widowed', NULL, '845195208267', 'Yes', NULL, 3, 'Kris Block', '86464394029686', 'Bethelborough', '2025-03-10', NULL, NULL, NULL, NULL, NULL, 377093155, 0, 0, 2, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(299, 5131, 2765, 'تالين باسل ناجي', 'Female', 1, 1, 3, '1983', 'الهندسة', 'Excellent', '2014-10-15', '03706279182511', '2027-10-31', 'Haneburgh', 3, 'Christian', 4, 'cyrus78@example.net', 2, 12, 10, '0231667209', '0226499725', '01577853057', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '37279792566204', 'No', NULL, NULL, '2023-11-04', 'Employee', 2, 13, 'Yes', 'Yes', 3, '9.00', '35596.79', '1186.56', 'Changeable', NULL, 'Yes', '514.33', '04081347247684', 'Yes', '805.48', '13578537468066', 'Visa', 'No', NULL, '9925 Kayla Terrace\nKerlukeport, MA 72625', 0, 'Widowed', NULL, '096542752761', 'Yes', NULL, 2, 'Aglae Kunze V', '63521816807219', 'North Laury', '2026-04-24', NULL, NULL, NULL, NULL, NULL, 695658970, 0, 0, 4, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57'),
(300, 5569, 1681, 'صابر عبدالفتاح ثامر', 'Male', 4, 4, 3, '1992', 'الهندسة', 'Excellent', '2010-02-19', '21107335131534', '2025-01-23', 'South Gino', 5, 'Christian', 8, 'gnienow@example.org', 6, 5, 2, '0232362886', '0230627548', '01148587716', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '94351923470790', 'No', NULL, NULL, '2022-11-04', 'Employee', 4, 17, 'No', 'Yes', 4, '12.00', '36460.63', '1215.35', 'Changeable', NULL, 'Yes', '679.15', '89015586838634', 'Yes', '750.07', '88959493296486', 'Cach', 'Yes', NULL, '834 Mosciski Keys\nColleenfort, NV 47371-9484', 0, 'Divorced', NULL, '456279304924', 'Yes', NULL, 6, 'Prof. Rosendo Pacocha MD', '73735887651646', 'Schadenland', '2026-06-02', NULL, NULL, NULL, NULL, NULL, 285161303, 0, 0, 2, NULL, 1, '2024-12-13 13:29:57', '2024-12-13 13:29:57');

-- --------------------------------------------------------

--
-- Table structure for table `employee_files`
--

CREATE TABLE `employee_files` (
  `id` bigint UNSIGNED NOT NULL,
  `desc_file` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_path` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `employee_id` bigint UNSIGNED DEFAULT NULL,
  `com_code` int NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_fixed_allowances`
--

CREATE TABLE `employee_fixed_allowances` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED DEFAULT NULL,
  `allowance_id` bigint UNSIGNED DEFAULT NULL,
  `value` decimal(10,2) DEFAULT NULL COMMENT 'قيمة البدل الثابت',
  `notes` varchar(600) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ملاحظات',
  `com_code` int NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_salary_absence_days`
--

CREATE TABLE `employee_salary_absence_days` (
  `id` bigint UNSIGNED NOT NULL,
  `main_salary_employees_id` bigint UNSIGNED NOT NULL,
  `finance_cln_periods_id` bigint UNSIGNED NOT NULL,
  `is_auto` int DEFAULT '0' COMMENT 'هل تلقائى من النظام أم بشكل يدوى',
  `employee_code` bigint NOT NULL COMMENT 'كود الموظف',
  `day_price` decimal(10,2) NOT NULL COMMENT 'أجر يوم الموظف',
  `value` decimal(10,2) NOT NULL COMMENT 'كام يوم غياب',
  `total` decimal(10,2) NOT NULL COMMENT 'أجمالى الغيابات',
  `is_archived` int DEFAULT '0' COMMENT 'حالة الأرشفه',
  `archived_by` bigint UNSIGNED DEFAULT NULL,
  `archived_at` datetime DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint NOT NULL DEFAULT '1',
  `com_code` int NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_salary_additionals`
--

CREATE TABLE `employee_salary_additionals` (
  `id` bigint UNSIGNED NOT NULL,
  `main_salary_employees_id` bigint UNSIGNED NOT NULL,
  `finance_cln_periods_id` bigint UNSIGNED NOT NULL,
  `is_auto` int DEFAULT '0' COMMENT 'هل تلقائى من النظام أم بشكل يدوى',
  `employee_code` bigint NOT NULL COMMENT 'كود الموظف',
  `day_price` decimal(10,2) NOT NULL COMMENT 'أجر يوم الموظف',
  `value` decimal(10,2) NOT NULL COMMENT 'كام يوم أضافى',
  `total` decimal(10,2) NOT NULL COMMENT 'أجمالى الأضافى',
  `is_archived` int DEFAULT '0' COMMENT 'حالة الأرشفه',
  `archived_by` bigint UNSIGNED DEFAULT NULL,
  `archived_at` datetime DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint NOT NULL DEFAULT '1',
  `com_code` int NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_salary_allowances`
--

CREATE TABLE `employee_salary_allowances` (
  `id` bigint UNSIGNED NOT NULL,
  `main_salary_employees_id` bigint UNSIGNED NOT NULL,
  `finance_cln_periods_id` bigint UNSIGNED NOT NULL,
  `is_auto` int DEFAULT '0' COMMENT 'هل تلقائى من النظام أم بشكل يدوى',
  `employee_code` bigint NOT NULL COMMENT 'كود الموظف',
  `day_price` decimal(10,2) NOT NULL COMMENT 'أجر يوم الموظف',
  `allowance_id` bigint UNSIGNED NOT NULL COMMENT ' نوع البدلات ',
  `total` decimal(10,2) NOT NULL COMMENT 'أجمالى البدلات',
  `is_archived` int DEFAULT '0' COMMENT 'حالة الأرشفه',
  `archived_by` bigint UNSIGNED DEFAULT NULL,
  `archived_at` datetime DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint NOT NULL DEFAULT '1',
  `com_code` int NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_salary_discounts`
--

CREATE TABLE `employee_salary_discounts` (
  `id` bigint UNSIGNED NOT NULL,
  `main_salary_employees_id` bigint UNSIGNED NOT NULL,
  `finance_cln_periods_id` bigint UNSIGNED NOT NULL,
  `is_auto` int DEFAULT '0' COMMENT 'هل تلقائى من النظام أم بشكل يدوى',
  `employee_code` bigint NOT NULL COMMENT 'كود الموظف',
  `day_price` decimal(10,2) NOT NULL COMMENT 'أجر يوم الموظف',
  `discount_types_id` bigint UNSIGNED NOT NULL COMMENT ' نوع الخصومات ',
  `total` decimal(10,2) NOT NULL COMMENT 'أجمالى الخصومات',
  `is_archived` int DEFAULT '0' COMMENT 'حالة الأرشفه',
  `archived_by` bigint UNSIGNED DEFAULT NULL,
  `archived_at` datetime DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint NOT NULL DEFAULT '1',
  `com_code` int NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_salary_loans`
--

CREATE TABLE `employee_salary_loans` (
  `id` bigint UNSIGNED NOT NULL,
  `main_salary_employees_id` bigint UNSIGNED NOT NULL,
  `finance_cln_periods_id` bigint UNSIGNED NOT NULL,
  `employee_code` bigint NOT NULL COMMENT 'كود الموظف',
  `day_price` decimal(10,2) NOT NULL COMMENT 'أجر يوم الموظف',
  `total` decimal(10,2) NOT NULL COMMENT 'أجمالى السلف',
  `is_archived` int DEFAULT '0' COMMENT 'حالة الأرشفه',
  `archived_by` bigint UNSIGNED DEFAULT NULL,
  `archived_at` datetime DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint NOT NULL DEFAULT '1',
  `com_code` int NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_salary_permanent_loans`
--

CREATE TABLE `employee_salary_permanent_loans` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_code` bigint NOT NULL COMMENT 'كود الموظف',
  `employee_salary` decimal(10,2) NOT NULL COMMENT 'مرتب الموظف',
  `total` decimal(10,2) NOT NULL COMMENT 'أجمالى القرض أو السلفه',
  `month_number_installment` int DEFAULT NULL COMMENT 'عدد الشهور للأقساط',
  `month_installment_value` decimal(10,2) DEFAULT NULL COMMENT 'قيمة القسط الشهرى',
  `year_month_start` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'يبدأ السداد من الشهر المالى',
  `year_month_start_date` date DEFAULT NULL COMMENT 'يبدأ سداد أول قسط بتاريخ ',
  `installment_paid` decimal(10,2) DEFAULT '0.00' COMMENT 'قيمة القسط المدفوع',
  `installment_remain` decimal(10,2) DEFAULT '0.00' COMMENT 'قيمة القسط المتبقى',
  `has_disbursed_done` int DEFAULT '0' COMMENT 'حالة الصرف',
  `disbursed_by` bigint UNSIGNED DEFAULT NULL,
  `disbursed_at` date DEFAULT NULL COMMENT 'متى صرف',
  `is_archived` int DEFAULT '0' COMMENT 'حالة الأرشفه',
  `archived_by` bigint UNSIGNED DEFAULT NULL,
  `archived_at` datetime DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint NOT NULL DEFAULT '1',
  `com_code` int NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_salary_rewards`
--

CREATE TABLE `employee_salary_rewards` (
  `id` bigint UNSIGNED NOT NULL,
  `main_salary_employees_id` bigint UNSIGNED NOT NULL,
  `finance_cln_periods_id` bigint UNSIGNED NOT NULL,
  `is_auto` int DEFAULT '0' COMMENT 'هل تلقائى من النظام أم بشكل يدوى',
  `employee_code` bigint NOT NULL COMMENT 'كود الموظف',
  `day_price` decimal(10,2) NOT NULL COMMENT 'أجر يوم الموظف',
  `additional_types_id` bigint UNSIGNED NOT NULL COMMENT ' نوع إضافى المكافئة ',
  `total` decimal(10,2) NOT NULL COMMENT 'أجمالى المكافئة',
  `is_archived` int DEFAULT '0' COMMENT 'حالة الأرشفه',
  `archived_by` bigint UNSIGNED DEFAULT NULL,
  `archived_at` datetime DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint NOT NULL DEFAULT '1',
  `com_code` int NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_salary_sanctions`
--

CREATE TABLE `employee_salary_sanctions` (
  `id` bigint UNSIGNED NOT NULL,
  `main_salary_employees_id` bigint UNSIGNED NOT NULL,
  `finance_cln_periods_id` bigint UNSIGNED NOT NULL,
  `is_auto` int DEFAULT '0' COMMENT 'هل تلقائى من النظام أم بشكل يدوى',
  `employee_code` bigint NOT NULL COMMENT 'كود الموظف',
  `day_price` decimal(10,2) NOT NULL COMMENT 'أجر يوم الموظف',
  `sanctions_type` int NOT NULL COMMENT ' واحد جزاء أيام - أثنين جزاء بصمة - ثلاثه جزاء تحقيق',
  `value` decimal(10,2) NOT NULL COMMENT 'كام يوم جزاء',
  `total` decimal(10,2) NOT NULL COMMENT 'أجمالى الجزاءات',
  `is_archived` int DEFAULT '0' COMMENT 'حالة الأرشفه',
  `archived_by` bigint UNSIGNED DEFAULT NULL,
  `archived_at` datetime DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint NOT NULL DEFAULT '1',
  `com_code` int NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `finance_calendars`
--

CREATE TABLE `finance_calendars` (
  `id` bigint UNSIGNED NOT NULL,
  `finance_yr` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `finance_yr_desc` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `is_open` tinyint NOT NULL DEFAULT '0' COMMENT 'صفر = معلق | واحد = مفتوح | اثنين = مؤرشف',
  `com_code` int DEFAULT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `finance_calendars`
--

INSERT INTO `finance_calendars` (`id`, `finance_yr`, `finance_yr_desc`, `start_date`, `end_date`, `is_open`, `com_code`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, '2024', 'السنه المالية لسنه 2024', '2024-01-01', '2024-12-31', 0, 1, 1, 1, '2024-12-13 13:29:35', '2024-12-13 13:29:35');

-- --------------------------------------------------------

--
-- Table structure for table `finance_cln_periods`
--

CREATE TABLE `finance_cln_periods` (
  `id` bigint UNSIGNED NOT NULL,
  `finance_calendars_id` bigint UNSIGNED NOT NULL,
  `finance_yr` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'السنة المالية',
  `month_id` bigint UNSIGNED NOT NULL,
  `year_and_month` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'محتاج ان اقوم بالتسجيل بالشهر و السنه و ليس باليوم',
  `start_date_m` date NOT NULL,
  `end_date_m` date NOT NULL,
  `number_of_days` int NOT NULL COMMENT 'عدد الايام فى الشهر',
  `start_date_fp` date NOT NULL COMMENT 'بداية تاريخ البصمة',
  `end_date_fp` date NOT NULL COMMENT 'نهاية تاريخ البصمة',
  `is_open` int NOT NULL DEFAULT '0' COMMENT 'صفر = معلق | واحد = مفتوح | اثنين = مؤرشف',
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `finance_cln_periods`
--

INSERT INTO `finance_cln_periods` (`id`, `finance_calendars_id`, `finance_yr`, `month_id`, `year_and_month`, `start_date_m`, `end_date_m`, `number_of_days`, `start_date_fp`, `end_date_fp`, `is_open`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(1, 1, '2024', 1, '2024-01', '2024-01-01', '2024-01-31', 31, '2024-01-01', '2024-01-31', 0, 1, 1, 1, '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(2, 1, '2024', 2, '2024-02', '2024-02-01', '2024-02-28', 28, '2024-02-01', '2024-02-28', 0, 1, 1, 1, '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(3, 1, '2024', 3, '2024-03', '2024-03-01', '2024-03-31', 31, '2024-03-01', '2024-03-31', 0, 1, 1, 1, '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(4, 1, '2024', 4, '2024-04', '2024-04-01', '2024-04-30', 30, '2024-04-01', '2024-04-30', 0, 1, 1, 1, '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(5, 1, '2024', 5, '2024-05', '2024-05-01', '2024-05-31', 31, '2024-05-01', '2024-05-31', 0, 1, 1, 1, '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(6, 1, '2024', 6, '2024-06', '2024-06-01', '2024-06-30', 30, '2024-06-01', '2024-06-30', 0, 1, 1, 1, '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(7, 1, '2024', 7, '2024-07', '2024-07-01', '2024-07-31', 31, '2024-07-01', '2024-07-31', 0, 1, 1, 1, '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(8, 1, '2024', 8, '2024-08', '2024-08-01', '2024-08-31', 31, '2024-08-01', '2024-08-31', 0, 1, 1, 1, '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(9, 1, '2024', 9, '2024-09', '2024-09-01', '2024-09-30', 30, '2024-09-01', '2024-09-30', 0, 1, 1, 1, '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(10, 1, '2024', 10, '2024-10', '2024-10-01', '2024-10-31', 31, '2024-10-01', '2024-10-31', 0, 1, 1, 1, '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(11, 1, '2024', 11, '2024-11', '2024-11-01', '2024-11-30', 30, '2024-11-01', '2024-11-30', 0, 1, 1, 1, '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(12, 1, '2024', 12, '2024-02', '2024-12-01', '2024-12-31', 31, '2024-12-01', '2024-12-30', 0, 1, 1, 1, '2024-12-13 13:29:35', '2024-12-13 13:29:35');

-- --------------------------------------------------------

--
-- Table structure for table `governorates`
--

CREATE TABLE `governorates` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `governorates`
--

INSERT INTO `governorates` (`id`, `name`, `country_id`, `created_at`, `updated_at`) VALUES
(1, 'القاهرة', 1, NULL, NULL),
(2, 'الجيزه', 1, NULL, NULL),
(3, 'الاسكندرية', 1, NULL, NULL),
(4, 'الإسماعيلية', 1, NULL, NULL),
(5, 'الدقهلية', 1, NULL, NULL),
(6, 'أسيوط', 1, NULL, NULL),
(7, 'السويس', 1, NULL, NULL),
(8, 'القليوبية', 1, NULL, NULL),
(9, 'البحيرة', 1, NULL, NULL),
(10, 'الغربية', 1, NULL, NULL),
(11, 'دمياط', 1, NULL, NULL),
(12, 'كفرالشيخ', 1, NULL, NULL),
(13, 'سوهاج', 1, NULL, NULL),
(14, 'الأقصر', 1, NULL, NULL),
(15, 'أسوان', 1, NULL, NULL),
(16, 'الواحات', 1, NULL, NULL),
(17, 'الوادي الجديد', 1, NULL, NULL),
(18, 'البحر الأحمر', 1, NULL, NULL),
(19, 'قنا', 1, NULL, NULL),
(20, 'المنيا', 1, NULL, NULL),
(21, 'جنوب سيناء', 1, NULL, NULL),
(22, 'شمال سيناء', 1, NULL, NULL),
(23, 'مطروح', 1, NULL, NULL),
(24, 'بنها', 1, NULL, NULL),
(25, 'الفيوم', 1, NULL, NULL),
(26, 'بنى سويف', 1, NULL, NULL),
(27, 'الشرقيه', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `days_counter` int NOT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `holidays`
--

INSERT INTO `holidays` (`id`, `name`, `from_date`, `to_date`, `days_counter`, `active`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(1, 'عيد الميلاد المجيد', '2024-01-07', '2024-01-07', 1, 1, 1, 1, 1, NULL, NULL),
(2, 'عيد الشرطة', '2024-01-25', '2024-01-25', 1, 1, 1, 1, 1, NULL, NULL),
(3, 'عيد الفطر المبارك', '2024-04-09', '2024-04-14', 1, 1, 1, 1, 1, NULL, NULL),
(4, 'عيد تحرير سيناء', '2024-04-25', '2024-04-25', 1, 1, 1, 1, 1, NULL, NULL),
(5, 'عيد العمال', '2024-05-01', '2024-05-01', 1, 1, 1, 1, 1, NULL, NULL),
(6, 'عيد شم النسيم', '2024-05-06', '2024-05-06', 1, 1, 1, 1, 1, NULL, NULL),
(7, 'وقفة عيد الأضحى', '2024-06-15', '2024-06-15', 1, 1, 1, 1, 1, NULL, NULL),
(8, 'عيد الأضحى المبارك', '2024-06-16', '2024-06-19', 1, 1, 1, 1, 1, NULL, NULL),
(9, 'ثورة ٣٠ يونيو', '2024-06-30', '2024-06-30', 1, 1, 1, 1, 1, NULL, NULL),
(10, 'رأس السنة الهجرية', '2024-07-08', '2024-07-08', 1, 1, 1, 1, 1, NULL, NULL),
(11, 'ثورة ٢٣ يوليو ١٩٥٢', '2024-07-23', '2024-07-23', 1, 1, 1, 1, 1, NULL, NULL),
(12, 'المولد النبوي الشريف', '2024-09-16', '2024-09-16', 1, 1, 1, 1, 1, NULL, NULL),
(13, '٦ أكتوبر', '2024-10-06', '2024-10-06', 1, 1, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id` bigint UNSIGNED NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `imageable_id` int NOT NULL,
  `imageable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs_categories`
--

CREATE TABLE `jobs_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jobs_categories`
--

INSERT INTO `jobs_categories` (`id`, `name`, `active`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(1, 'محاسب', 1, 1, 1, 1, NULL, NULL),
(2, 'محامى', 1, 1, 1, 1, NULL, NULL),
(3, 'IT', 1, 1, 1, 1, NULL, NULL),
(4, 'HR', 1, 1, 1, 1, NULL, NULL),
(5, 'المبيعات', 1, 1, 1, 1, NULL, NULL),
(6, 'المشتريات', 1, 1, 1, 1, NULL, NULL),
(7, 'مدير مالى', 1, 1, 1, 1, NULL, NULL),
(8, 'مهندس شبكات', 1, 1, 1, 1, NULL, NULL),
(9, 'مهندس تطوير الويب', 1, 1, 1, 1, NULL, NULL),
(10, 'مصمم جرافيك', 1, 1, 1, 1, NULL, NULL),
(11, 'فني ميكانيكا سيارات', 1, 1, 1, 1, NULL, NULL),
(12, 'فني تكييف وتبريد', 1, 1, 1, 1, NULL, NULL),
(13, 'سائق شاحنة', 1, 1, 1, 1, NULL, NULL),
(14, 'مسؤول لوجستي', 1, 1, 1, 1, NULL, NULL),
(15, 'كاتب محتوى', 1, 1, 1, 1, NULL, NULL),
(16, 'مترجم', 1, 1, 1, 1, NULL, NULL),
(17, 'مندوب مبيعات', 1, 1, 1, 1, NULL, NULL),
(18, 'عامل نظافة', 1, 1, 1, 1, NULL, NULL),
(19, 'حارس أمن', 1, 1, 1, 1, NULL, NULL),
(20, 'كهربائي', 1, 1, 1, 1, NULL, NULL),
(21, 'مستشار اقتصادي', 1, 1, 1, 1, NULL, NULL),
(22, 'أمين صندوق', 1, 1, 1, 1, NULL, NULL),
(23, 'مدير مالي', 1, 1, 1, 1, NULL, NULL),
(24, 'مستشار ضرائب', 1, 1, 1, 1, NULL, NULL),
(25, 'مدير مشاريع', 1, 1, 1, 1, NULL, NULL),
(26, 'مساعد إداري', 1, 1, 1, 1, NULL, NULL),
(27, 'مدير مكتب', 1, 1, 1, 1, NULL, NULL),
(28, 'مطور تطبيقات موبايل', 1, 1, 1, 1, NULL, NULL),
(29, 'مصمم واجهات وتجربة المستخدم (UI/UX)', 1, 1, 1, 1, NULL, NULL),
(30, 'خبير أمن سيبراني', 1, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `job_grades`
--

CREATE TABLE `job_grades` (
  `id` bigint UNSIGNED NOT NULL,
  `job_grades_code` int NOT NULL COMMENT 'كود الدرجه الوظيفية',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `min_salary` decimal(10,2) NOT NULL COMMENT 'الحد الادنى للمرتب',
  `max_salary` decimal(10,2) NOT NULL COMMENT 'الحد الأقصى للمرتب',
  `notes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `job_grades`
--

INSERT INTO `job_grades` (`id`, `job_grades_code`, `name`, `min_salary`, `max_salary`, `notes`, `active`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(1, 4, 'الدرجه الرابعه', '5000.00', '6000.00', NULL, 1, 1, NULL, 1, NULL, NULL),
(2, 3, 'الدرجه الثالثه', '6000.00', '7000.00', NULL, 1, 1, NULL, 1, NULL, NULL),
(3, 2, 'الدرجه الثانية', '7000.00', '8000.00', NULL, 1, 1, NULL, 1, NULL, NULL),
(4, 1, 'الدرجه الأولى', '8000.00', '10000.00', NULL, 1, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `active`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(1, 'العربية', 1, 1, 1, 1, NULL, NULL),
(2, 'الأنجليزية', 1, 1, 1, 1, NULL, NULL),
(3, 'الفرنسية', 1, 1, 1, 1, NULL, NULL),
(4, 'الألمانية', 1, 1, 1, 1, NULL, NULL),
(5, 'الأسبانية', 1, 1, 1, 1, NULL, NULL),
(6, 'الأيطالية', 1, 1, 1, 1, NULL, NULL),
(7, 'العبرية', 1, 1, 1, 1, NULL, NULL),
(8, 'الصينية', 1, 1, 1, 1, NULL, NULL),
(9, 'الهندية', 1, 1, 1, 1, NULL, NULL),
(10, 'البرتغالية', 1, 1, 1, 1, NULL, NULL),
(11, 'الروسية', 1, 1, 1, 1, NULL, NULL),
(12, 'اليابانية', 1, 1, 1, 1, NULL, NULL),
(13, 'التركية', 1, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `main_employees_vacation_balances`
--

CREATE TABLE `main_employees_vacation_balances` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_code` int NOT NULL COMMENT 'كود الموظف',
  `year_month` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'الشهر المالى المرتب',
  `financial_year` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'السنه المالية ',
  `carryover_from_previous_month` decimal(10,2) DEFAULT '0.00' COMMENT 'الرصيد المرحل من الشهر السابق',
  `current_month_balance` decimal(10,2) DEFAULT '0.00' COMMENT 'رصيد الشهر الحالى',
  `total_available_balance` decimal(10,2) DEFAULT '0.00' COMMENT 'اجمالى الرصيد المتاح',
  `spent_balance` decimal(10,2) DEFAULT '0.00' COMMENT 'الرصيد المستهلك',
  `net_balance` decimal(10,2) DEFAULT '0.00' COMMENT 'صافى الرصيد',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `main_salary_employees`
--

CREATE TABLE `main_salary_employees` (
  `id` bigint UNSIGNED NOT NULL,
  `finance_cln_periods_id` bigint UNSIGNED NOT NULL,
  `financial_year` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'السنه المالية ',
  `year_month` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'الشهر المالى المرتب',
  `employee_code` int NOT NULL COMMENT 'كود الموظف',
  `employee_name` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'أسم الموظف لحظة فتح الراتب',
  `salary_employee` decimal(10,2) NOT NULL COMMENT 'قيمة مرتب الموظف',
  `day_price` decimal(10,2) NOT NULL COMMENT 'قيمة يوم الموظفمن الراتب',
  `branch_id` bigint UNSIGNED NOT NULL COMMENT 'كود الفرع لحظة الراتب ',
  `employee_status` enum('Employee','Unemployed') COLLATE utf8mb4_unicode_ci DEFAULT 'Employee' COMMENT 'حالة الموظف لحظة الراتب',
  `employee_department_code` int NOT NULL COMMENT 'إدارة الموظف لحظة الراتب',
  `employee_jobs_id` int NOT NULL COMMENT 'وظيفة الموظف لحظة الراتب',
  `total_rewards_salary` decimal(10,2) DEFAULT '0.00' COMMENT 'إجمالى الاضافى مكافأت للمرتب',
  `motivation` decimal(10,2) DEFAULT '0.00' COMMENT 'إجمالى الحافز مع العلم ممكن ان يكون ثابت او متغير',
  `additional_days_counter` decimal(10,2) DEFAULT '0.00' COMMENT 'إجمالى أيام الاضافى للمرتب',
  `additional_days_total` decimal(10,2) DEFAULT '0.00' COMMENT 'إجمالى قيمة أيام الاضافى للمرتب',
  `fixed_allowances` decimal(10,2) DEFAULT '0.00' COMMENT 'قيمة البدلات الثابته للمرتب',
  `changeable_allowance` decimal(10,2) DEFAULT '0.00' COMMENT 'قيمة البدلات المتغيره للمرتب',
  `total_benefits` decimal(10,2) DEFAULT '0.00' COMMENT 'إجمالى الأستحقاقات للموظف',
  `sanctions_days_counter` decimal(10,2) DEFAULT '0.00' COMMENT 'عدد جزاءات الأيام',
  `sanctions_days_total` decimal(10,2) DEFAULT '0.00' COMMENT 'إجمالى قيمة ايام الجزاءات',
  `absence_days_counter` decimal(10,2) DEFAULT '0.00' COMMENT 'عدد أيام الغياب للبصمة',
  `absence_days_total` decimal(10,2) DEFAULT '0.00' COMMENT 'إجمالى قيمة أيام الغياب للمرتب',
  `monthly_loan` decimal(10,2) DEFAULT '0.00' COMMENT 'إجمالى قيمة المستقطع سلف شهرية للمرتب',
  `permanent_loan` decimal(10,2) DEFAULT '0.00' COMMENT 'إجمالى قيمة المستقطع سلف مستديمة للمرتب',
  `discount` decimal(10,2) DEFAULT '0.00' COMMENT 'إجمالى قيمة الخصومات للمرتب',
  `phones_bill` decimal(10,2) DEFAULT '0.00' COMMENT 'إجمالى قيمة خصومات الهاتف للمرتب',
  `medical_insurance_monthly` decimal(10,2) DEFAULT '0.00' COMMENT 'إجمالى قيمة خصم التأمين الطبى للمرتب',
  `medical_social_monthly` decimal(10,2) DEFAULT '0.00' COMMENT 'إجمالى قيمة خصم التأمين الأجتماعى للمرتب',
  `total_deductions` decimal(10,2) DEFAULT '0.00' COMMENT 'إجمالى المستقطع للموظف',
  `net_salary` decimal(10,2) DEFAULT NULL COMMENT 'صافى قيمة المرتب',
  `net_salary_after_close_for_deportation` decimal(10,2) DEFAULT '0.00' COMMENT 'صافى قيمة المرتب بعد أخذ إجراء ويعتبر الرصيد المرحل للشهر الجديد فقط',
  `archive_by` bigint UNSIGNED DEFAULT NULL,
  `is_archived` int DEFAULT '0' COMMENT 'حالة الموظف لحظة الراتب',
  `archived_date` datetime DEFAULT NULL COMMENT 'تاريخ ارشفه الراتب',
  `last_salary_remain_balance` decimal(10,2) DEFAULT NULL COMMENT 'قيمة الراتب المرحل من الشهر السابق',
  `last_main_salary_record_id` decimal(10,2) DEFAULT NULL COMMENT 'رقم الراتب للشهر السابق',
  `is_take_action_disbursed_collect` int DEFAULT '0' COMMENT 'هل تم أخذ إجرا لصرف أو تحصيل المرتب خلال الشهر',
  `cash_visa` enum('Cach','Visa') COLLATE utf8mb4_unicode_ci DEFAULT 'Cach' COMMENT 'قبض المرتب كاش ام فيزا',
  `is_sensitive_manager_data` enum('yes','no') COLLATE utf8mb4_unicode_ci DEFAULT 'yes' COMMENT 'هل الموظف بإدارة عليا بها بيانات حساسة',
  `is_stopped` enum('stopped','unstopped') COLLATE utf8mb4_unicode_ci DEFAULT 'unstopped' COMMENT 'المرتب موقوف ام سارى',
  `com_code` int NOT NULL COMMENT 'كود الشركة التابع لها الموظف',
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2022_04_12_000000_create_admins_table', 1),
(6, '2024_03_14_213857_create_week_days_table', 1),
(7, '2024_06_19_102639_create_permission_tables', 1),
(8, '2024_06_26_144602_create_months_table', 1),
(9, '2024_06_27_194935_create_admin_panel_settings_table', 1),
(10, '2024_06_27_214107_create_finance_calendars_table', 1),
(11, '2024_06_27_214837_create_finance_cln_periods_table', 1),
(12, '2024_06_30_200143_create_branches_table', 1),
(13, '2024_07_01_092820_create_shifts_types_table', 1),
(14, '2024_07_03_112738_create_images_table', 1),
(15, '2024_07_03_143403_create_countries_table', 1),
(16, '2024_07_03_165023_create_languages_table', 1),
(17, '2024_07_04_104830_create_departments_table', 1),
(18, '2024_07_04_114301_create_jobs_categories_table', 1),
(19, '2024_07_04_120940_create_qualifications_table', 1),
(20, '2024_07_04_121417_create_blood_types_table', 1),
(21, '2024_07_04_122729_create_holidays_table', 1),
(22, '2024_07_04_124622_create_resignations_table', 1),
(23, '2024_07_04_130237_create_nationalities_table', 1),
(24, '2024_07_04_151007_create_governorates_table', 1),
(25, '2024_07_04_151014_create_cities_table', 1),
(26, '2024_07_04_181007_create_job_grades_table', 1),
(27, '2024_07_04_220445_create_employees_table', 1),
(28, '2024_07_11_175711_create_employee_files_table', 1),
(29, '2024_07_12_170313_create_additional_types_table', 1),
(30, '2024_07_12_190111_create_discount_types_table', 1),
(31, '2024_07_12_191115_create_allowances_table', 1),
(32, '2024_07_22_103814_create_main_salary_employees_table', 1),
(33, '2024_07_25_124057_create_employee_salary_sanctions_table', 1),
(34, '2024_08_08_192313_create_employee_salary_absence_days_table', 1),
(35, '2024_08_10_114207_create_employee_salary_additionals_table', 1),
(36, '2024_08_12_104634_create_employee_salary_discounts_table', 1),
(37, '2024_08_12_114025_create_employee_salary_rewards_table', 1),
(38, '2024_08_12_132008_create_employee_salary_allowances_table', 1),
(39, '2024_08_12_143519_create_employee_salary_loans_table', 1),
(40, '2024_08_12_194858_create_employee_salary_permanent_loans_table', 1),
(41, '2024_08_12_214509_create_permanent_loans_installments_table', 1),
(42, '2024_08_22_220547_create_employee_fixed_allowances_table', 1),
(43, '2024_09_02_142045_create_salary_archives_table', 1),
(44, '2024_09_10_123625_create_attendance_departure_action_excels_table', 1),
(45, '2024_09_10_134224_create_attendance_departures_table', 1),
(46, '2024_09_10_142757_create_attendance_departure_actions_table', 1),
(47, '2024_09_26_095531_create_vacation_types_table', 1),
(48, '2024_10_05_151008_create_main_employees_vacation_balances_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\Admin', 1),
(1, 'App\\Models\\Admin', 2),
(2, 'App\\Models\\Admin', 3),
(3, 'App\\Models\\Admin', 4);

-- --------------------------------------------------------

--
-- Table structure for table `months`
--

CREATE TABLE `months` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_en` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `months`
--

INSERT INTO `months` (`id`, `name`, `name_en`, `created_at`, `updated_at`) VALUES
(1, 'يناير', 'January', NULL, NULL),
(2, 'فبراير', 'February', NULL, NULL),
(3, 'مارس', 'March', NULL, NULL),
(4, 'أبريل', 'April', NULL, NULL),
(5, 'مايو', 'May', NULL, NULL),
(6, 'يونيو', 'June', NULL, NULL),
(7, 'يوليو', 'July', NULL, NULL),
(8, 'أغسطس', 'August', NULL, NULL),
(9, 'سبتمبر', 'September', NULL, NULL),
(10, 'اكتوبر', 'October', NULL, NULL),
(11, 'نوفمبر', 'November', NULL, NULL),
(12, 'ديسمبر', 'December', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `nationalities`
--

CREATE TABLE `nationalities` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nationalities`
--

INSERT INTO `nationalities` (`id`, `name`, `active`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(1, 'مصرى', 1, 1, 1, 1, NULL, NULL),
(2, 'سورى', 1, 1, 1, 1, NULL, NULL),
(3, 'لبنانى', 1, 1, 1, 1, NULL, NULL),
(4, 'يمنى', 1, 1, 1, 1, NULL, NULL),
(5, 'هندى', 1, 1, 1, 1, NULL, NULL),
(6, 'إنجليزى', 1, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permanent_loans_installments`
--

CREATE TABLE `permanent_loans_installments` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_code` bigint NOT NULL COMMENT 'كود الموظف',
  `employee_permanent_loans_id` bigint UNSIGNED DEFAULT NULL,
  `main_salary_employees_id` bigint UNSIGNED DEFAULT NULL,
  `month_installment_value` decimal(10,2) DEFAULT NULL COMMENT 'قيمة القسط',
  `year_month` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'تاريخ الاستحقاق',
  `status` int DEFAULT '0' COMMENT 'حالة الدفع: صفر معلق - واحد تم الدفع على المرتب - أثنين تم الدفع كاش ',
  `has_parent_disbursed_done` int DEFAULT '0' COMMENT 'حالة الصرف',
  `is_archived` int DEFAULT '0' COMMENT 'حالة الأرشفه',
  `archived_by` bigint UNSIGNED DEFAULT NULL,
  `archived_at` datetime DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `category`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'view role', 'Roles', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(2, 'create role', 'Roles', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(3, 'update role', 'Roles', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(4, 'delete role', 'Roles', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(5, 'view permission', 'Permissions', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(6, 'create permission', 'Permissions', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(7, 'update permission', 'Permissions', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(8, 'delete permission', 'Permissions', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(9, 'view user', 'Users', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(10, 'create user', 'Users', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(11, 'update user', 'Users', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(12, 'delete user', 'Users', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(13, 'قائمة الأعدادات', 'Settings', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(14, 'الضبط العام', 'generalSettings', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(15, 'تعديل الضبط العام', 'generalSettings', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(16, 'السنوات المالية', 'financeCalendars', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(17, 'اضافة السنوات المالية', 'financeCalendars', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(18, 'تعديل السنوات المالية', 'financeCalendars', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(19, 'حذف السنوات المالية', 'financeCalendars', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(20, 'عرض شهور السنه السنوات مالية', 'financeCalendars', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(21, 'فتح السنوات المالية', 'financeCalendars', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(22, 'غلق السنوات المالية', 'financeCalendars', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(23, 'الفروع', 'branches', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(24, 'اضافة الفروع', 'branches', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(25, 'تعديل الفروع', 'branches', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(26, 'حذف الفروع', 'branches', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(27, 'الشفتات', 'shiftsTypes', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(28, 'اضافة الشفتات', 'shiftsTypes', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(29, 'تعديل الشفتات', 'shiftsTypes', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(30, 'حذف الشفتات', 'shiftsTypes', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(31, 'الأدارات', 'departments', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(32, 'اضافة الأدارات', 'departments', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(33, 'تعديل الأدارات', 'departments', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(34, 'حذف الأدارات', 'departments', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(35, 'الوظائف', 'jobsCategories', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(36, 'اضافة الوظائف', 'jobsCategories', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(37, 'تعديل الوظائف', 'jobsCategories', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(38, 'حذف الوظائف', 'jobsCategories', 'admin', '2024-12-13 13:29:35', '2024-12-13 13:29:35'),
(39, 'الدرجات الوظيفية', 'jobsGrades', 'admin', '2024-12-13 13:29:36', '2024-12-13 13:29:36'),
(40, 'اضافة الدرجات الوظيفية', 'jobsGrades', 'admin', '2024-12-13 13:29:36', '2024-12-13 13:29:36'),
(41, 'تعديل الدرجات الوظيفية', 'jobsGrades', 'admin', '2024-12-13 13:29:36', '2024-12-13 13:29:36'),
(42, 'حذف الدرجات الوظيفية', 'jobsGrades', 'admin', '2024-12-13 13:29:36', '2024-12-13 13:29:36'),
(43, 'المؤهل', 'qualifications', 'admin', '2024-12-13 13:29:36', '2024-12-13 13:29:36'),
(44, 'اضافة المؤهل', 'qualifications', 'admin', '2024-12-13 13:29:36', '2024-12-13 13:29:36'),
(45, 'تعديل المؤهل', 'qualifications', 'admin', '2024-12-13 13:29:36', '2024-12-13 13:29:36'),
(46, 'حذف المؤهل', 'qualifications', 'admin', '2024-12-13 13:29:36', '2024-12-13 13:29:36'),
(47, 'العطلات الرسمية', 'holidays', 'admin', '2024-12-13 13:29:36', '2024-12-13 13:29:36'),
(48, 'اضافة العطلات الرسمية', 'holidays', 'admin', '2024-12-13 13:29:36', '2024-12-13 13:29:36'),
(49, 'تعديل العطلات الرسمية', 'holidays', 'admin', '2024-12-13 13:29:36', '2024-12-13 13:29:36'),
(50, 'حذف العطلات الرسمية', 'holidays', 'admin', '2024-12-13 13:29:36', '2024-12-13 13:29:36'),
(51, 'الأستقالة', 'resignations', 'admin', '2024-12-13 13:29:36', '2024-12-13 13:29:36'),
(52, 'اضافة الأستقالة', 'resignations', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(53, 'تعديل الأستقالة', 'resignations', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(54, 'حذف الأستقالة', 'resignations', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(55, 'الأجازات', 'vacations', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(56, 'اضافة الأجازات', 'vacations', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(57, 'تعديل الأجازات', 'vacations', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(58, 'حذف الأجازات', 'vacations', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(59, 'البلاد', 'countries', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(60, 'اضافة البلاد', 'countries', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(61, 'تعديل البلاد', 'countries', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(62, 'حذف البلاد', 'countries', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(63, 'المنطقه', 'cities', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(64, 'اضافة المنطقه', 'cities', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(65, 'تعديل المنطقه', 'cities', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(66, 'حذف المنطقه', 'cities', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(67, 'الجنسيات', 'nationalities', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(68, 'اضافة الجنسيات', 'nationalities', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(69, 'تعديل الجنسيات', 'nationalities', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(70, 'حذف الجنسيات', 'nationalities', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(71, 'فصيلة الدم', 'bloodTypes', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(72, 'اضافة فصيلة الدم', 'bloodTypes', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(73, 'تعديل فصيلة الدم', 'bloodTypes', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(74, 'حذف فصيلة الدم', 'bloodTypes', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(75, 'قائمة بيانات شئون الموظفين', 'affairsEmployees', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(76, 'بيانات الموظفين', 'Employees', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(77, 'جدول الموظفين', 'Employees', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(78, 'أضافة موظف', 'Employees', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(79, 'تعديل الموظف', 'Employees', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(80, 'حذف الموظف', 'Employees', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(81, 'عرض حساب الأجازات', 'Employees', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(82, 'بحث الموظفين', 'Employees', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(83, 'اضافة بدل ثابت', 'Employees', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(84, 'الراتب المؤرشف', 'Employees', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(85, 'جدول الملفات الشخصية', 'Employees', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(86, 'اضافة ملفات شخصية', 'Employees', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(87, 'تحميل من جدول ملفات شخصية', 'Employees', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(88, 'حذف من جدول ملفات شخصية', 'Employees', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(89, 'الأضافى للراتب', 'additional_types', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(90, 'اضافة الأضافى للراتب', 'additional_types', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(91, 'تعديل الأضافى للراتب', 'additional_types', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(92, 'حذف الأضافى للراتب', 'additional_types', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(93, 'الخصم', 'discount_types', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(94, 'اضافة الخصم', 'discount_types', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(95, 'تعديل الخصم', 'discount_types', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(96, 'حذف الخصم', 'discount_types', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(97, 'البدلات', 'allowances', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(98, 'اضافة البدلات', 'allowances', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(99, 'تعديل البدلات', 'allowances', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(100, 'حذف البدلات', 'allowances', 'admin', '2024-12-13 13:29:37', '2024-12-13 13:29:37'),
(101, 'قائمة الأجور', 'salaries', 'admin', '2024-12-13 13:29:38', '2024-12-13 13:29:38'),
(102, 'السجلات الرئيسية للرواتب', 'salaryRecords', 'admin', '2024-12-13 13:29:38', '2024-12-13 13:29:38'),
(103, 'ارشفة الشهر المالى', 'salaryRecords', 'admin', '2024-12-13 13:29:38', '2024-12-13 13:29:38'),
(104, 'فتح الشهر المالى', 'salaryRecords', 'admin', '2024-12-13 13:29:38', '2024-12-13 13:29:38'),
(105, 'الجزاءات', 'sanctions', 'admin', '2024-12-13 13:29:38', '2024-12-13 13:29:38'),
(106, 'عرض الجزاءات', 'sanctions', 'admin', '2024-12-13 13:29:38', '2024-12-13 13:29:38'),
(107, 'بحث الجزاءات', 'sanctions', 'admin', '2024-12-13 13:29:38', '2024-12-13 13:29:38'),
(108, 'اضافة الجزاءات', 'sanctions', 'admin', '2024-12-13 13:29:38', '2024-12-13 13:29:38'),
(109, 'تعديل الجزاءات', 'sanctions', 'admin', '2024-12-13 13:29:38', '2024-12-13 13:29:38'),
(110, 'حذف الجزاءات', 'sanctions', 'admin', '2024-12-13 13:29:38', '2024-12-13 13:29:38'),
(111, 'طباعه الجزاءات', 'sanctions', 'admin', '2024-12-13 13:29:38', '2024-12-13 13:29:38'),
(112, 'الغيابات', 'absences', 'admin', '2024-12-13 13:29:38', '2024-12-13 13:29:38'),
(113, 'عرض الغيابات', 'absences', 'admin', '2024-12-13 13:29:38', '2024-12-13 13:29:38'),
(114, 'بحث الغيابات', 'absences', 'admin', '2024-12-13 13:29:38', '2024-12-13 13:29:38'),
(115, 'اضافة الغيابات', 'absences', 'admin', '2024-12-13 13:29:38', '2024-12-13 13:29:38'),
(116, 'تعديل الغيابات', 'absences', 'admin', '2024-12-13 13:29:38', '2024-12-13 13:29:38'),
(117, 'حذف الغيابات', 'absences', 'admin', '2024-12-13 13:29:38', '2024-12-13 13:29:38'),
(118, 'طباعه الغيابات', 'absences', 'admin', '2024-12-13 13:29:38', '2024-12-13 13:29:38'),
(119, 'الأضافى', 'additionals', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(120, 'عرض الأضافى', 'additionals', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(121, 'بحث الأضافى', 'additionals', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(122, 'اضافة الأضافى', 'additionals', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(123, 'تعديل الأضافى', 'additionals', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(124, 'حذف الأضافى', 'additionals', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(125, 'طباعه الأضافى', 'additionals', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(126, 'الخصومات', 'discounts', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(127, 'عرض الخصومات', 'discounts', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(128, 'بحث الخصومات', 'discounts', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(129, 'اضافة الخصومات', 'discounts', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(130, 'تعديل الخصومات', 'discounts', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(131, 'حذف الخصومات', 'discounts', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(132, 'طباعه الخصومات', 'discounts', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(133, 'المكافئات', 'rewards', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(134, 'عرض المكافئات', 'rewards', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(135, 'بحث المكافئات', 'rewards', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(136, 'اضافة المكافئات', 'rewards', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(137, 'تعديل المكافئات', 'rewards', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(138, 'حذف المكافئات', 'rewards', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(139, 'طباعه المكافئات', 'rewards', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(140, 'البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(141, 'عرض البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(142, 'بحث البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(143, 'اضافة البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(144, 'تعديل البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(145, 'حذف البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-12-13 13:29:39', '2024-12-13 13:29:39'),
(146, 'طباعه البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(147, 'السلف الشهرية', 'loans', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(148, 'عرض السلف الشهرية', 'loans', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(149, 'بحث السلف الشهرية', 'loans', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(150, 'اضافة السلف الشهرية', 'loans', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(151, 'تعديل السلف الشهرية', 'loans', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(152, 'حذف السلف الشهرية', 'loans', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(153, 'طباعه السلف الشهرية', 'loans', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(154, 'السلف المستديمة', 'permanentLoan', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(155, 'بحث السلف المستديمة', 'permanentLoan', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(156, 'صرف السلف المستديمة', 'permanentLoan', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(157, 'الدفع كاش السلف المستديمة', 'permanentLoan', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(158, 'تفاصيل السلف المستديمة', 'permanentLoan', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(159, 'اضافة السلف المستديمة', 'permanentLoan', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(160, 'تعديل السلف المستديمة', 'permanentLoan', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(161, 'حذف السلف المستديمة', 'permanentLoan', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(162, 'طباعه السلف المستديمة', 'permanentLoan', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(163, 'رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(164, 'عرض رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(165, 'بحث رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(166, 'اضافة مرتب يدوى', 'mainSalaryEmployees', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(167, 'اضافة رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(168, 'تعديل رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(169, 'حذف رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(170, 'بيانات الموظفين للرواتب', 'mainSalaryEmployees', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(171, 'طباعه رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(172, 'طباعه بحث تفصيلى للرواتب', 'mainSalaryEmployees', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(173, 'طباعه بحث اجمالى للرواتب', 'mainSalaryEmployees', 'admin', '2024-12-13 13:29:40', '2024-12-13 13:29:40'),
(174, 'طباعه مفردات المرتب', 'mainSalaryEmployees', 'admin', '2024-12-13 13:29:41', '2024-12-13 13:29:41'),
(175, 'ايقاف المرتب', 'mainSalaryEmployees', 'admin', '2024-12-13 13:29:41', '2024-12-13 13:29:41'),
(176, 'ارشفه المرتب يدوى', 'mainSalaryEmployees', 'admin', '2024-12-13 13:29:41', '2024-12-13 13:29:41'),
(177, 'حذف المرتب', 'mainSalaryEmployees', 'admin', '2024-12-13 13:29:41', '2024-12-13 13:29:41'),
(178, 'قائمة سجلات بصمة الموظفين', 'attendanceDeparturesFP', 'admin', '2024-12-13 13:29:41', '2024-12-13 13:29:41'),
(179, 'سجلات بصمة الموظفين', 'attendanceDepartures', 'admin', '2024-12-13 13:29:41', '2024-12-13 13:29:41'),
(180, 'عرض بصمة الموظفين', 'attendanceDepartures', 'admin', '2024-12-13 13:29:41', '2024-12-13 13:29:41'),
(181, 'بحث بصمة الموظفين', 'attendanceDepartures', 'admin', '2024-12-13 13:29:41', '2024-12-13 13:29:41'),
(182, 'إرفاق ملف البصمة مرتب يدوى', 'attendanceDepartures', 'admin', '2024-12-13 13:29:41', '2024-12-13 13:29:41'),
(183, 'عرض بصمات الموظفين', 'attendanceDepartures', 'admin', '2024-12-13 13:29:41', '2024-12-13 13:29:41'),
(184, 'تحميل بصمات الموظفين', 'attendanceDepartures', 'admin', '2024-12-13 13:29:41', '2024-12-13 13:29:41'),
(185, 'عرض سجل أرشيف بصمات الموظفين', 'attendanceDepartures', 'admin', '2024-12-13 13:29:41', '2024-12-13 13:29:41'),
(186, 'عرض حركات بصمات الموظفين', 'attendanceDepartures', 'admin', '2024-12-13 13:29:41', '2024-12-13 13:29:41'),
(187, 'تفاصيل أجازه الموظفين الموظفين', 'attendanceDepartures', 'admin', '2024-12-13 13:29:41', '2024-12-13 13:29:41'),
(188, 'طباعه بصمات الموظفين', 'attendanceDepartures', 'admin', '2024-12-13 13:29:41', '2024-12-13 13:29:41'),
(189, 'إعادة ضبط بصمات الموظفين', 'attendanceDepartures', 'admin', '2024-12-13 13:29:41', '2024-12-13 13:29:41'),
(190, 'قائمة المستخدمين', 'UserList', 'admin', '2024-12-13 13:29:41', '2024-12-13 13:29:41'),
(191, 'المستخدمين', 'users', 'admin', '2024-12-13 13:29:41', '2024-12-13 13:29:41'),
(192, 'اضافة المستخدمين', 'users', 'admin', '2024-12-13 13:29:42', '2024-12-13 13:29:42'),
(193, 'تعديل المستخدمين', 'users', 'admin', '2024-12-13 13:29:42', '2024-12-13 13:29:42'),
(194, 'حذف المستخدمين', 'users', 'admin', '2024-12-13 13:29:42', '2024-12-13 13:29:42'),
(195, 'الصلاحيات', 'roles', 'admin', '2024-12-13 13:29:42', '2024-12-13 13:29:42'),
(196, 'اضافة الصلاحيات', 'roles', 'admin', '2024-12-13 13:29:42', '2024-12-13 13:29:42'),
(197, 'تعديل الصلاحيات', 'roles', 'admin', '2024-12-13 13:29:42', '2024-12-13 13:29:42'),
(198, 'حذف الصلاحيات', 'roles', 'admin', '2024-12-13 13:29:42', '2024-12-13 13:29:42'),
(199, 'إضافة وتعديل أذونات الصلاحية', 'roles', 'admin', '2024-12-13 13:29:42', '2024-12-13 13:29:42'),
(200, 'الأذونات', 'permissions', 'admin', '2024-12-13 13:29:42', '2024-12-13 13:29:42'),
(201, 'اضافة الأذونات', 'permissions', 'admin', '2024-12-13 13:29:42', '2024-12-13 13:29:42'),
(202, 'تعديل الأذونات', 'permissions', 'admin', '2024-12-13 13:29:42', '2024-12-13 13:29:42'),
(203, 'حذف الأذونات', 'permissions', 'admin', '2024-12-13 13:29:42', '2024-12-13 13:29:42');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `qualifications`
--

CREATE TABLE `qualifications` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  `com_code` int NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `qualifications`
--

INSERT INTO `qualifications` (`id`, `name`, `active`, `com_code`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'ليسانس حقوق', 1, 1, 1, 1, NULL, NULL),
(2, 'بكالوريوس نظم و معلومات إدارية', 1, 1, 1, 1, NULL, NULL),
(3, 'بكالوريوس تجارة', 1, 1, 1, 1, NULL, NULL),
(4, 'بكالوريوس تجارة خارجية', 1, 1, 1, 1, NULL, NULL),
(5, 'بكالوريوس إدارة أعمال', 1, 1, 1, 1, NULL, NULL),
(6, 'بكالوريوس علوم حاسب', 1, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `resignations`
--

CREATE TABLE `resignations` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resignations`
--

INSERT INTO `resignations` (`id`, `name`, `created_by`, `updated_by`, `active`, `com_code`, `created_at`, `updated_at`) VALUES
(1, 'إنقطاع عن العمل', 1, 1, 1, 1, NULL, NULL),
(2, 'إستقاله بدون سبب', 1, 1, 1, 1, NULL, NULL),
(3, 'كثرة الغياب', 1, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'super-admin', 'admin', '2024-12-13 13:29:42', '2024-12-13 13:29:42'),
(2, 'admin', 'admin', '2024-12-13 13:29:42', '2024-12-13 13:29:42'),
(3, 'staff', 'admin', '2024-12-13 13:29:42', '2024-12-13 13:29:42'),
(4, 'user', 'admin', '2024-12-13 13:29:42', '2024-12-13 13:29:42');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1),
(71, 1),
(72, 1),
(73, 1),
(74, 1),
(75, 1),
(76, 1),
(77, 1),
(78, 1),
(79, 1),
(80, 1),
(81, 1),
(82, 1),
(83, 1),
(84, 1),
(85, 1),
(86, 1),
(87, 1),
(88, 1),
(89, 1),
(90, 1),
(91, 1),
(92, 1),
(93, 1),
(94, 1),
(95, 1),
(96, 1),
(97, 1),
(98, 1),
(99, 1),
(100, 1),
(101, 1),
(102, 1),
(103, 1),
(104, 1),
(105, 1),
(106, 1),
(107, 1),
(108, 1),
(109, 1),
(110, 1),
(111, 1),
(112, 1),
(113, 1),
(114, 1),
(115, 1),
(116, 1),
(117, 1),
(118, 1),
(119, 1),
(120, 1),
(121, 1),
(122, 1),
(123, 1),
(124, 1),
(125, 1),
(126, 1),
(127, 1),
(128, 1),
(129, 1),
(130, 1),
(131, 1),
(132, 1),
(133, 1),
(134, 1),
(135, 1),
(136, 1),
(137, 1),
(138, 1),
(139, 1),
(140, 1),
(141, 1),
(142, 1),
(143, 1),
(144, 1),
(145, 1),
(146, 1),
(147, 1),
(148, 1),
(149, 1),
(150, 1),
(151, 1),
(152, 1),
(153, 1),
(154, 1),
(155, 1),
(156, 1),
(157, 1),
(158, 1),
(159, 1),
(160, 1),
(161, 1),
(162, 1),
(163, 1),
(164, 1),
(165, 1),
(166, 1),
(167, 1),
(168, 1),
(169, 1),
(170, 1),
(171, 1),
(172, 1),
(173, 1),
(174, 1),
(175, 1),
(176, 1),
(177, 1),
(178, 1),
(179, 1),
(180, 1),
(181, 1),
(182, 1),
(183, 1),
(184, 1),
(185, 1),
(186, 1),
(187, 1),
(188, 1),
(189, 1),
(190, 1),
(191, 1),
(192, 1),
(193, 1),
(194, 1),
(195, 1),
(196, 1),
(197, 1),
(198, 1),
(199, 1),
(200, 1),
(201, 1),
(202, 1),
(203, 1),
(1, 2),
(2, 2),
(3, 2),
(5, 2),
(6, 2),
(9, 2),
(10, 2),
(11, 2);

-- --------------------------------------------------------

--
-- Table structure for table `salary_archives`
--

CREATE TABLE `salary_archives` (
  `id` bigint UNSIGNED NOT NULL,
  `employee_id` bigint UNSIGNED DEFAULT NULL,
  `value` decimal(10,2) DEFAULT NULL COMMENT 'قيمة الراتب قبل التغيير',
  `com_code` int NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shifts_types`
--

CREATE TABLE `shifts_types` (
  `id` bigint UNSIGNED NOT NULL,
  `type` tinyint NOT NULL COMMENT 'نوع الشيفت: واحد صباحى و أثنين مسائى',
  `from_time` time NOT NULL,
  `to_time` time NOT NULL,
  `total_hours` decimal(10,2) NOT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shifts_types`
--

INSERT INTO `shifts_types` (`id`, `type`, `from_time`, `to_time`, `total_hours`, `active`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(1, 3, '00:00:00', '12:00:00', '8.00', 1, 1, 1, 1, NULL, '2024-09-07 05:47:47'),
(2, 1, '11:00:00', '19:00:00', '8.00', 1, 1, NULL, 1, '2024-09-07 05:41:50', '2024-09-07 05:45:00'),
(3, 1, '08:30:00', '15:00:00', '8.00', 1, 1, 1, 1, '2024-09-07 05:42:23', '2024-09-07 05:47:14'),
(4, 2, '13:00:00', '21:00:00', '8.00', 1, 1, NULL, 1, '2024-09-07 05:48:16', '2024-09-07 05:48:16');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `license_expiry_date` date DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `status`, `license_expiry_date`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'رشا موسى', 'rasha@dt.com', NULL, '$2y$10$6yuMWjufnJ06iYKNCDhQDeT86r5QFLf7fGkG4s3Rdk9K8Vpd/UVWG', 'active', '2024-07-02', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vacation_types`
--

CREATE TABLE `vacation_types` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  `com_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vacation_types`
--

INSERT INTO `vacation_types` (`id`, `name`, `created_by`, `updated_by`, `active`, `com_code`, `created_at`, `updated_at`) VALUES
(1, 'راحة أسبوعية', 1, 1, 1, 1, NULL, NULL),
(2, 'سنوى', 1, 1, 1, 1, NULL, NULL),
(3, 'بدل راحة', 1, 1, 1, 1, NULL, NULL),
(4, 'اجازه رسمية', 1, 1, 1, 1, NULL, NULL),
(5, 'غياب بدون إذن', 1, 1, 1, 1, NULL, NULL),
(6, 'غياب بدون آجر', 1, 1, 1, 1, NULL, NULL),
(7, 'وضع', 1, 1, 1, 1, NULL, NULL),
(8, 'ميلاد', 1, 1, 1, 1, NULL, NULL),
(9, 'وفاة', 1, 1, 1, 1, NULL, NULL),
(10, 'مرضى', 1, 1, 1, 1, NULL, NULL),
(11, 'زواج', 1, 1, 1, 1, NULL, NULL),
(12, 'آخرى', 1, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `week_days`
--

CREATE TABLE `week_days` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_en` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `week_days`
--

INSERT INTO `week_days` (`id`, `name`, `name_en`, `created_at`, `updated_at`) VALUES
(1, 'السبت', 'Saturday', NULL, NULL),
(2, 'الأحد', 'Sunday', NULL, NULL),
(3, 'الإثنين', 'Monday', NULL, NULL),
(4, 'الثلاثاء', 'Tuesday', NULL, NULL),
(5, 'الأربعاء', 'Wednesday', NULL, NULL),
(6, 'الخميس', 'Thursday', NULL, NULL),
(7, 'الجمعة', 'Friday', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `additional_types`
--
ALTER TABLE `additional_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `additional_types_created_by_foreign` (`created_by`),
  ADD KEY `additional_types_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_username_unique` (`username`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indexes for table `admin_panel_settings`
--
ALTER TABLE `admin_panel_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `allowances`
--
ALTER TABLE `allowances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `allowances_created_by_foreign` (`created_by`),
  ADD KEY `allowances_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `attendance_departures`
--
ALTER TABLE `attendance_departures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attendance_departures_archived_by_foreign` (`archived_by`),
  ADD KEY `attendance_departures_is_updated_active_action_by_foreign` (`is_updated_active_action_by`),
  ADD KEY `attendance_departures_branch_id_foreign` (`branch_id`),
  ADD KEY `attendance_departures_created_by_foreign` (`created_by`),
  ADD KEY `attendance_departures_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `attendance_departure_actions`
--
ALTER TABLE `attendance_departure_actions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attendance_departure_actions_attendance_departure_id_foreign` (`attendance_departure_id`),
  ADD KEY `attendance_departure_actions_created_by_foreign` (`created_by`),
  ADD KEY `attendance_departure_actions_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `attendance_departure_action_excels`
--
ALTER TABLE `attendance_departure_action_excels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attendance_departure_action_excels_created_by_foreign` (`created_by`);

--
-- Indexes for table `blood_types`
--
ALTER TABLE `blood_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blood_types_created_by_foreign` (`created_by`),
  ADD KEY `blood_types_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `branches_created_by_foreign` (`created_by`),
  ADD KEY `branches_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cities_governorate_id_foreign` (`governorate_id`),
  ADD KEY `cities_created_by_foreign` (`created_by`),
  ADD KEY `cities_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `countries_created_by_foreign` (`created_by`),
  ADD KEY `countries_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `departments_created_by_foreign` (`created_by`),
  ADD KEY `departments_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `discount_types`
--
ALTER TABLE `discount_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `discount_types_created_by_foreign` (`created_by`),
  ADD KEY `discount_types_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employees_name_unique` (`name`),
  ADD UNIQUE KEY `employees_fp_code_unique` (`fp_code`),
  ADD UNIQUE KEY `employees_national_id_unique` (`national_id`),
  ADD UNIQUE KEY `employees_email_unique` (`email`),
  ADD KEY `employees_branch_id_foreign` (`branch_id`),
  ADD KEY `employees_job_grade_id_foreign` (`job_grade_id`),
  ADD KEY `employees_qualification_id_foreign` (`qualification_id`),
  ADD KEY `employees_blood_types_id_foreign` (`blood_types_id`),
  ADD KEY `employees_language_id_foreign` (`language_id`),
  ADD KEY `employees_country_id_foreign` (`country_id`),
  ADD KEY `employees_governorate_id_foreign` (`governorate_id`),
  ADD KEY `employees_city_id_foreign` (`city_id`),
  ADD KEY `employees_department_id_foreign` (`department_id`),
  ADD KEY `employees_job_categories_id_foreign` (`job_categories_id`),
  ADD KEY `employees_shift_types_id_foreign` (`shift_types_id`),
  ADD KEY `employees_resignation_id_foreign` (`resignation_id`),
  ADD KEY `employees_nationality_id_foreign` (`nationality_id`),
  ADD KEY `employees_created_by_foreign` (`created_by`),
  ADD KEY `employees_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `employee_files`
--
ALTER TABLE `employee_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_files_employee_id_foreign` (`employee_id`),
  ADD KEY `employee_files_created_by_foreign` (`created_by`),
  ADD KEY `employee_files_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `employee_fixed_allowances`
--
ALTER TABLE `employee_fixed_allowances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_fixed_allowances_employee_id_foreign` (`employee_id`),
  ADD KEY `employee_fixed_allowances_allowance_id_foreign` (`allowance_id`),
  ADD KEY `employee_fixed_allowances_created_by_foreign` (`created_by`),
  ADD KEY `employee_fixed_allowances_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `employee_salary_absence_days`
--
ALTER TABLE `employee_salary_absence_days`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_salary_absence_days_main_salary_employees_id_foreign` (`main_salary_employees_id`),
  ADD KEY `employee_salary_absence_days_finance_cln_periods_id_foreign` (`finance_cln_periods_id`),
  ADD KEY `employee_salary_absence_days_archived_by_foreign` (`archived_by`),
  ADD KEY `employee_salary_absence_days_created_by_foreign` (`created_by`),
  ADD KEY `employee_salary_absence_days_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `employee_salary_additionals`
--
ALTER TABLE `employee_salary_additionals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_salary_additionals_main_salary_employees_id_foreign` (`main_salary_employees_id`),
  ADD KEY `employee_salary_additionals_finance_cln_periods_id_foreign` (`finance_cln_periods_id`),
  ADD KEY `employee_salary_additionals_archived_by_foreign` (`archived_by`),
  ADD KEY `employee_salary_additionals_created_by_foreign` (`created_by`),
  ADD KEY `employee_salary_additionals_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `employee_salary_allowances`
--
ALTER TABLE `employee_salary_allowances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_salary_allowances_main_salary_employees_id_foreign` (`main_salary_employees_id`),
  ADD KEY `employee_salary_allowances_finance_cln_periods_id_foreign` (`finance_cln_periods_id`),
  ADD KEY `employee_salary_allowances_allowance_id_foreign` (`allowance_id`),
  ADD KEY `employee_salary_allowances_archived_by_foreign` (`archived_by`),
  ADD KEY `employee_salary_allowances_created_by_foreign` (`created_by`),
  ADD KEY `employee_salary_allowances_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `employee_salary_discounts`
--
ALTER TABLE `employee_salary_discounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_salary_discounts_main_salary_employees_id_foreign` (`main_salary_employees_id`),
  ADD KEY `employee_salary_discounts_finance_cln_periods_id_foreign` (`finance_cln_periods_id`),
  ADD KEY `employee_salary_discounts_discount_types_id_foreign` (`discount_types_id`),
  ADD KEY `employee_salary_discounts_archived_by_foreign` (`archived_by`),
  ADD KEY `employee_salary_discounts_created_by_foreign` (`created_by`),
  ADD KEY `employee_salary_discounts_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `employee_salary_loans`
--
ALTER TABLE `employee_salary_loans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_salary_loans_main_salary_employees_id_foreign` (`main_salary_employees_id`),
  ADD KEY `employee_salary_loans_finance_cln_periods_id_foreign` (`finance_cln_periods_id`),
  ADD KEY `employee_salary_loans_archived_by_foreign` (`archived_by`),
  ADD KEY `employee_salary_loans_created_by_foreign` (`created_by`),
  ADD KEY `employee_salary_loans_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `employee_salary_permanent_loans`
--
ALTER TABLE `employee_salary_permanent_loans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_salary_permanent_loans_disbursed_by_foreign` (`disbursed_by`),
  ADD KEY `employee_salary_permanent_loans_archived_by_foreign` (`archived_by`),
  ADD KEY `employee_salary_permanent_loans_created_by_foreign` (`created_by`),
  ADD KEY `employee_salary_permanent_loans_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `employee_salary_rewards`
--
ALTER TABLE `employee_salary_rewards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_salary_rewards_main_salary_employees_id_foreign` (`main_salary_employees_id`),
  ADD KEY `employee_salary_rewards_finance_cln_periods_id_foreign` (`finance_cln_periods_id`),
  ADD KEY `employee_salary_rewards_additional_types_id_foreign` (`additional_types_id`),
  ADD KEY `employee_salary_rewards_archived_by_foreign` (`archived_by`),
  ADD KEY `employee_salary_rewards_created_by_foreign` (`created_by`),
  ADD KEY `employee_salary_rewards_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `employee_salary_sanctions`
--
ALTER TABLE `employee_salary_sanctions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_salary_sanctions_main_salary_employees_id_foreign` (`main_salary_employees_id`),
  ADD KEY `employee_salary_sanctions_finance_cln_periods_id_foreign` (`finance_cln_periods_id`),
  ADD KEY `employee_salary_sanctions_archived_by_foreign` (`archived_by`),
  ADD KEY `employee_salary_sanctions_created_by_foreign` (`created_by`),
  ADD KEY `employee_salary_sanctions_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `finance_calendars`
--
ALTER TABLE `finance_calendars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `finance_calendars_created_by_foreign` (`created_by`),
  ADD KEY `finance_calendars_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `finance_cln_periods`
--
ALTER TABLE `finance_cln_periods`
  ADD PRIMARY KEY (`id`),
  ADD KEY `finance_cln_periods_finance_calendars_id_foreign` (`finance_calendars_id`),
  ADD KEY `finance_cln_periods_month_id_foreign` (`month_id`),
  ADD KEY `finance_cln_periods_created_by_foreign` (`created_by`),
  ADD KEY `finance_cln_periods_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `governorates`
--
ALTER TABLE `governorates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `governorates_country_id_foreign` (`country_id`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`id`),
  ADD KEY `holidays_created_by_foreign` (`created_by`),
  ADD KEY `holidays_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs_categories`
--
ALTER TABLE `jobs_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_categories_created_by_foreign` (`created_by`),
  ADD KEY `jobs_categories_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `job_grades`
--
ALTER TABLE `job_grades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_grades_created_by_foreign` (`created_by`),
  ADD KEY `job_grades_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `languages_created_by_foreign` (`created_by`),
  ADD KEY `languages_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `main_employees_vacation_balances`
--
ALTER TABLE `main_employees_vacation_balances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_employees_vacation_balances_created_by_foreign` (`created_by`),
  ADD KEY `main_employees_vacation_balances_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `main_salary_employees`
--
ALTER TABLE `main_salary_employees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_salary_employees_finance_cln_periods_id_foreign` (`finance_cln_periods_id`),
  ADD KEY `main_salary_employees_branch_id_foreign` (`branch_id`),
  ADD KEY `main_salary_employees_archive_by_foreign` (`archive_by`),
  ADD KEY `main_salary_employees_created_by_foreign` (`created_by`),
  ADD KEY `main_salary_employees_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `months`
--
ALTER TABLE `months`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `nationalities`
--
ALTER TABLE `nationalities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nationalities_created_by_foreign` (`created_by`),
  ADD KEY `nationalities_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permanent_loans_installments`
--
ALTER TABLE `permanent_loans_installments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permanent_loans_installments_employee_permanent_loans_id_foreign` (`employee_permanent_loans_id`),
  ADD KEY `permanent_loans_installments_main_salary_employees_id_foreign` (`main_salary_employees_id`),
  ADD KEY `permanent_loans_installments_archived_by_foreign` (`archived_by`),
  ADD KEY `permanent_loans_installments_created_by_foreign` (`created_by`),
  ADD KEY `permanent_loans_installments_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `qualifications`
--
ALTER TABLE `qualifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `qualifications_created_by_foreign` (`created_by`),
  ADD KEY `qualifications_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `resignations`
--
ALTER TABLE `resignations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `resignations_created_by_foreign` (`created_by`),
  ADD KEY `resignations_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `salary_archives`
--
ALTER TABLE `salary_archives`
  ADD PRIMARY KEY (`id`),
  ADD KEY `salary_archives_employee_id_foreign` (`employee_id`),
  ADD KEY `salary_archives_created_by_foreign` (`created_by`),
  ADD KEY `salary_archives_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `shifts_types`
--
ALTER TABLE `shifts_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shifts_types_created_by_foreign` (`created_by`),
  ADD KEY `shifts_types_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `vacation_types`
--
ALTER TABLE `vacation_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vacation_types_created_by_foreign` (`created_by`),
  ADD KEY `vacation_types_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `week_days`
--
ALTER TABLE `week_days`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `additional_types`
--
ALTER TABLE `additional_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `admin_panel_settings`
--
ALTER TABLE `admin_panel_settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `allowances`
--
ALTER TABLE `allowances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `attendance_departures`
--
ALTER TABLE `attendance_departures`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendance_departure_actions`
--
ALTER TABLE `attendance_departure_actions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendance_departure_action_excels`
--
ALTER TABLE `attendance_departure_action_excels`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blood_types`
--
ALTER TABLE `blood_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `discount_types`
--
ALTER TABLE `discount_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=301;

--
-- AUTO_INCREMENT for table `employee_files`
--
ALTER TABLE `employee_files`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_fixed_allowances`
--
ALTER TABLE `employee_fixed_allowances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_salary_absence_days`
--
ALTER TABLE `employee_salary_absence_days`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_salary_additionals`
--
ALTER TABLE `employee_salary_additionals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_salary_allowances`
--
ALTER TABLE `employee_salary_allowances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_salary_discounts`
--
ALTER TABLE `employee_salary_discounts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_salary_loans`
--
ALTER TABLE `employee_salary_loans`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_salary_permanent_loans`
--
ALTER TABLE `employee_salary_permanent_loans`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_salary_rewards`
--
ALTER TABLE `employee_salary_rewards`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_salary_sanctions`
--
ALTER TABLE `employee_salary_sanctions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `finance_calendars`
--
ALTER TABLE `finance_calendars`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `finance_cln_periods`
--
ALTER TABLE `finance_cln_periods`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `governorates`
--
ALTER TABLE `governorates`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs_categories`
--
ALTER TABLE `jobs_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `job_grades`
--
ALTER TABLE `job_grades`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `main_employees_vacation_balances`
--
ALTER TABLE `main_employees_vacation_balances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `main_salary_employees`
--
ALTER TABLE `main_salary_employees`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `months`
--
ALTER TABLE `months`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `nationalities`
--
ALTER TABLE `nationalities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `permanent_loans_installments`
--
ALTER TABLE `permanent_loans_installments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=204;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qualifications`
--
ALTER TABLE `qualifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `resignations`
--
ALTER TABLE `resignations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `salary_archives`
--
ALTER TABLE `salary_archives`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shifts_types`
--
ALTER TABLE `shifts_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `vacation_types`
--
ALTER TABLE `vacation_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `week_days`
--
ALTER TABLE `week_days`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `additional_types`
--
ALTER TABLE `additional_types`
  ADD CONSTRAINT `additional_types_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `additional_types_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `allowances`
--
ALTER TABLE `allowances`
  ADD CONSTRAINT `allowances_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `allowances_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `attendance_departures`
--
ALTER TABLE `attendance_departures`
  ADD CONSTRAINT `attendance_departures_archived_by_foreign` FOREIGN KEY (`archived_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `attendance_departures_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `attendance_departures_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `attendance_departures_is_updated_active_action_by_foreign` FOREIGN KEY (`is_updated_active_action_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `attendance_departures_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `attendance_departure_actions`
--
ALTER TABLE `attendance_departure_actions`
  ADD CONSTRAINT `attendance_departure_actions_attendance_departure_id_foreign` FOREIGN KEY (`attendance_departure_id`) REFERENCES `attendance_departures` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `attendance_departure_actions_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `attendance_departure_actions_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `attendance_departure_action_excels`
--
ALTER TABLE `attendance_departure_action_excels`
  ADD CONSTRAINT `attendance_departure_action_excels_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `blood_types`
--
ALTER TABLE `blood_types`
  ADD CONSTRAINT `blood_types_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `blood_types_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `branches`
--
ALTER TABLE `branches`
  ADD CONSTRAINT `branches_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `branches_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `cities_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cities_governorate_id_foreign` FOREIGN KEY (`governorate_id`) REFERENCES `governorates` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cities_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `countries`
--
ALTER TABLE `countries`
  ADD CONSTRAINT `countries_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `countries_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `departments_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `departments_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `discount_types`
--
ALTER TABLE `discount_types`
  ADD CONSTRAINT `discount_types_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `discount_types_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_blood_types_id_foreign` FOREIGN KEY (`blood_types_id`) REFERENCES `blood_types` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_city_id_foreign` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_governorate_id_foreign` FOREIGN KEY (`governorate_id`) REFERENCES `governorates` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_job_categories_id_foreign` FOREIGN KEY (`job_categories_id`) REFERENCES `jobs_categories` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_job_grade_id_foreign` FOREIGN KEY (`job_grade_id`) REFERENCES `job_grades` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_nationality_id_foreign` FOREIGN KEY (`nationality_id`) REFERENCES `nationalities` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_qualification_id_foreign` FOREIGN KEY (`qualification_id`) REFERENCES `qualifications` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_resignation_id_foreign` FOREIGN KEY (`resignation_id`) REFERENCES `resignations` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_shift_types_id_foreign` FOREIGN KEY (`shift_types_id`) REFERENCES `shifts_types` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employees_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `employee_files`
--
ALTER TABLE `employee_files`
  ADD CONSTRAINT `employee_files_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_files_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_files_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `employee_fixed_allowances`
--
ALTER TABLE `employee_fixed_allowances`
  ADD CONSTRAINT `employee_fixed_allowances_allowance_id_foreign` FOREIGN KEY (`allowance_id`) REFERENCES `allowances` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_fixed_allowances_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_fixed_allowances_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_fixed_allowances_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `employee_salary_absence_days`
--
ALTER TABLE `employee_salary_absence_days`
  ADD CONSTRAINT `employee_salary_absence_days_archived_by_foreign` FOREIGN KEY (`archived_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_absence_days_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_absence_days_finance_cln_periods_id_foreign` FOREIGN KEY (`finance_cln_periods_id`) REFERENCES `finance_cln_periods` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_absence_days_main_salary_employees_id_foreign` FOREIGN KEY (`main_salary_employees_id`) REFERENCES `main_salary_employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_absence_days_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `employee_salary_additionals`
--
ALTER TABLE `employee_salary_additionals`
  ADD CONSTRAINT `employee_salary_additionals_archived_by_foreign` FOREIGN KEY (`archived_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_additionals_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_additionals_finance_cln_periods_id_foreign` FOREIGN KEY (`finance_cln_periods_id`) REFERENCES `finance_cln_periods` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_additionals_main_salary_employees_id_foreign` FOREIGN KEY (`main_salary_employees_id`) REFERENCES `main_salary_employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_additionals_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `employee_salary_allowances`
--
ALTER TABLE `employee_salary_allowances`
  ADD CONSTRAINT `employee_salary_allowances_allowance_id_foreign` FOREIGN KEY (`allowance_id`) REFERENCES `allowances` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_allowances_archived_by_foreign` FOREIGN KEY (`archived_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_allowances_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_allowances_finance_cln_periods_id_foreign` FOREIGN KEY (`finance_cln_periods_id`) REFERENCES `finance_cln_periods` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_allowances_main_salary_employees_id_foreign` FOREIGN KEY (`main_salary_employees_id`) REFERENCES `main_salary_employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_allowances_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `employee_salary_discounts`
--
ALTER TABLE `employee_salary_discounts`
  ADD CONSTRAINT `employee_salary_discounts_archived_by_foreign` FOREIGN KEY (`archived_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_discounts_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_discounts_discount_types_id_foreign` FOREIGN KEY (`discount_types_id`) REFERENCES `discount_types` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_discounts_finance_cln_periods_id_foreign` FOREIGN KEY (`finance_cln_periods_id`) REFERENCES `finance_cln_periods` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_discounts_main_salary_employees_id_foreign` FOREIGN KEY (`main_salary_employees_id`) REFERENCES `main_salary_employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_discounts_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `employee_salary_loans`
--
ALTER TABLE `employee_salary_loans`
  ADD CONSTRAINT `employee_salary_loans_archived_by_foreign` FOREIGN KEY (`archived_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_loans_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_loans_finance_cln_periods_id_foreign` FOREIGN KEY (`finance_cln_periods_id`) REFERENCES `finance_cln_periods` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_loans_main_salary_employees_id_foreign` FOREIGN KEY (`main_salary_employees_id`) REFERENCES `main_salary_employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_loans_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `employee_salary_permanent_loans`
--
ALTER TABLE `employee_salary_permanent_loans`
  ADD CONSTRAINT `employee_salary_permanent_loans_archived_by_foreign` FOREIGN KEY (`archived_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_permanent_loans_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_permanent_loans_disbursed_by_foreign` FOREIGN KEY (`disbursed_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_permanent_loans_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `employee_salary_rewards`
--
ALTER TABLE `employee_salary_rewards`
  ADD CONSTRAINT `employee_salary_rewards_additional_types_id_foreign` FOREIGN KEY (`additional_types_id`) REFERENCES `additional_types` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_rewards_archived_by_foreign` FOREIGN KEY (`archived_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_rewards_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_rewards_finance_cln_periods_id_foreign` FOREIGN KEY (`finance_cln_periods_id`) REFERENCES `finance_cln_periods` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_rewards_main_salary_employees_id_foreign` FOREIGN KEY (`main_salary_employees_id`) REFERENCES `main_salary_employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_rewards_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `employee_salary_sanctions`
--
ALTER TABLE `employee_salary_sanctions`
  ADD CONSTRAINT `employee_salary_sanctions_archived_by_foreign` FOREIGN KEY (`archived_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_sanctions_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_sanctions_finance_cln_periods_id_foreign` FOREIGN KEY (`finance_cln_periods_id`) REFERENCES `finance_cln_periods` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_sanctions_main_salary_employees_id_foreign` FOREIGN KEY (`main_salary_employees_id`) REFERENCES `main_salary_employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_salary_sanctions_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `finance_calendars`
--
ALTER TABLE `finance_calendars`
  ADD CONSTRAINT `finance_calendars_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `finance_calendars_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `finance_cln_periods`
--
ALTER TABLE `finance_cln_periods`
  ADD CONSTRAINT `finance_cln_periods_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `finance_cln_periods_finance_calendars_id_foreign` FOREIGN KEY (`finance_calendars_id`) REFERENCES `finance_calendars` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `finance_cln_periods_month_id_foreign` FOREIGN KEY (`month_id`) REFERENCES `months` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `finance_cln_periods_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `governorates`
--
ALTER TABLE `governorates`
  ADD CONSTRAINT `governorates_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `holidays`
--
ALTER TABLE `holidays`
  ADD CONSTRAINT `holidays_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `holidays_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `jobs_categories`
--
ALTER TABLE `jobs_categories`
  ADD CONSTRAINT `jobs_categories_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `jobs_categories_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `job_grades`
--
ALTER TABLE `job_grades`
  ADD CONSTRAINT `job_grades_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `job_grades_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `languages`
--
ALTER TABLE `languages`
  ADD CONSTRAINT `languages_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `languages_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `main_employees_vacation_balances`
--
ALTER TABLE `main_employees_vacation_balances`
  ADD CONSTRAINT `main_employees_vacation_balances_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `main_employees_vacation_balances_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `main_salary_employees`
--
ALTER TABLE `main_salary_employees`
  ADD CONSTRAINT `main_salary_employees_archive_by_foreign` FOREIGN KEY (`archive_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `main_salary_employees_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `main_salary_employees_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `main_salary_employees_finance_cln_periods_id_foreign` FOREIGN KEY (`finance_cln_periods_id`) REFERENCES `finance_cln_periods` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `main_salary_employees_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `nationalities`
--
ALTER TABLE `nationalities`
  ADD CONSTRAINT `nationalities_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `nationalities_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `permanent_loans_installments`
--
ALTER TABLE `permanent_loans_installments`
  ADD CONSTRAINT `permanent_loans_installments_archived_by_foreign` FOREIGN KEY (`archived_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `permanent_loans_installments_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `permanent_loans_installments_employee_permanent_loans_id_foreign` FOREIGN KEY (`employee_permanent_loans_id`) REFERENCES `employee_salary_permanent_loans` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permanent_loans_installments_main_salary_employees_id_foreign` FOREIGN KEY (`main_salary_employees_id`) REFERENCES `main_salary_employees` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `permanent_loans_installments_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `qualifications`
--
ALTER TABLE `qualifications`
  ADD CONSTRAINT `qualifications_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `qualifications_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `resignations`
--
ALTER TABLE `resignations`
  ADD CONSTRAINT `resignations_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `resignations_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `salary_archives`
--
ALTER TABLE `salary_archives`
  ADD CONSTRAINT `salary_archives_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `salary_archives_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `salary_archives_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `shifts_types`
--
ALTER TABLE `shifts_types`
  ADD CONSTRAINT `shifts_types_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `shifts_types_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `vacation_types`
--
ALTER TABLE `vacation_types`
  ADD CONSTRAINT `vacation_types_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `vacation_types_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `admins` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
