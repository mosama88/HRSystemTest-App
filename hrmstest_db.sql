-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 12, 2024 at 04:13 PM
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
(1, 'محمد أسامه', 'mosama', 'mosama@dt.com', NULL, '$2y$10$LfT0clEdgZTjbdR5BZNz7eya04k2LqxVgigzI1qvmvUT/6oxF0ITG', 1, 1, 'active', '2024-12-12', 1, NULL, NULL, NULL),
(2, 'Super Admin', 'superadmin', 'superadmin@dt.com', NULL, '$2y$10$PXJSW1FNl6M9u95rDWf9juMmG7HCX71h2CktLymIdAJpAGLQ2gaby', 1, NULL, 'active', NULL, NULL, NULL, '2024-12-12 15:30:38', '2024-12-12 15:30:38'),
(3, 'Admin', 'admin', 'admin@dt.com', NULL, '$2y$10$L/mZc5kvDSsmddi1QkxSsO0qI0iDnbIxJ1lainTlc3WsX.rwGQB0W', 1, NULL, 'active', NULL, 1, NULL, '2024-12-12 15:30:38', '2024-12-12 15:30:38'),
(4, 'Staff', 'staff', 'staff@dt.com', NULL, '$2y$10$VDxo1MH/OYahmFt2mpTC9uJRZOLFSi/DIGEZPRH79PpaKvg0weWE.', 1, NULL, 'active', NULL, 1, NULL, '2024-12-12 15:30:38', '2024-12-12 15:30:38');

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
(1, 'مستشفى المروة', 1, NULL, NULL, '01228759920', '45 شارع جامعه الدول ناصيه شهاب', 'info@almarwa.com', '4.00', 3, '15.00', '15.00', '30.00', '2.00', '4.00', '6.00', '180.00', '8.00', '8.00', '9.00', '10.00', '11.00', 1, 1, 1, '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
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
(1, 2236, 280, 'عادل بدر سهيل', 'Male', 4, 2, 3, '1998', 'الفيزياء', 'Excellent', '2020-09-10', '11843343888742', '2029-04-25', 'New Aubreefurt', 7, 'Muslim', 3, 'tkessler@example.com', 6, 24, 6, '0224953280', '0222744796', '01046074091', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '37651791002879', 'Yes', NULL, NULL, '2023-03-16', 'Employee', 2, 6, 'Yes', 'No', 3, '10.00', '44795.40', '1493.18', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '942 Simonis Circle\nNew Myrtisfort, ND 58825-6986', 0, 'Married', NULL, '0925116385', 'Yes', NULL, 6, 'Dr. Rasheed Bogisich III', '87598084551745', 'East Anita', '2027-09-14', NULL, NULL, NULL, NULL, NULL, 240282081, 0, 0, 1, NULL, 1, '2024-12-12 15:30:44', '2024-12-12 15:30:44'),
(2, 4585, 2710, 'رفيق مهند زياد', 'Male', 1, 1, 4, '2010', 'علم الأحياء', 'Excellent', '2001-11-29', '12148525333778', '2025-04-25', 'Port Freddy', 1, 'Muslim', 11, 'lonie.kozey@example.com', 3, 19, 5, '0231084529', '0228262630', '01251839743', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '13354054849948', 'Yes', NULL, NULL, '2023-03-28', 'Employee', 8, 6, 'No', 'Yes', 2, '8.00', '29546.63', '984.89', 'Changeable', NULL, 'Yes', '696.75', '83449511359316', 'No', NULL, NULL, 'Visa', 'No', NULL, '3386 Rahsaan Camp\nTorpland, CT 73593-1458', 0, 'Single', NULL, '4921437872', 'Yes', NULL, 4, 'Emmy Fisher III', '50615516248166', 'South Annamariefurt', '2026-01-03', NULL, NULL, NULL, NULL, NULL, 66730547, 0, 0, 3, NULL, 1, '2024-12-12 15:30:45', '2024-12-12 15:30:45'),
(3, 6784, 2602, 'محمود صهيب أمجد', 'Male', 2, 1, 4, '1993', 'علم الأحياء', 'Excellent', '2022-04-07', '34987106403090', '2028-01-06', 'East June', 4, 'Muslim', 3, 'aaron.bauch@example.net', 3, 25, 1, '0237361387', '0239236654', '01046484453', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '63798533136255', 'No', NULL, NULL, '2021-09-15', 'Employee', 2, 10, 'Yes', 'No', 3, '11.00', '34149.53', '1138.32', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '3078 Greenholt Loaf Apt. 248\nSchoenfurt, AR 79907', 0, 'Widowed', NULL, '111093679937', 'Yes', NULL, 4, 'Favian Cruickshank', '36259925191785', 'New Terry', '2026-07-20', NULL, NULL, NULL, NULL, NULL, 2015390618, 0, 0, 3, NULL, 1, '2024-12-12 15:30:45', '2024-12-12 15:30:45'),
(4, 1464, 268, 'حسين رشيد سعيد', 'Male', 1, 2, 2, '2011', 'علم الأحياء', 'Very_Good', '2003-02-14', '20008550623807', '2028-07-03', 'West Dorothy', 7, 'Christian', 8, 'freda.harvey@example.net', 3, 19, 5, '0224262577', '0237525192', '01036705507', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '56789267698437', 'Yes', NULL, NULL, '2019-12-12', 'Employee', 7, 8, 'No', 'Yes', 4, '11.00', '35601.54', '1186.72', 'Changeable', NULL, 'Yes', '654.98', '87203926468045', 'No', NULL, NULL, 'Visa', 'No', NULL, '702 Torphy Rue Apt. 382\nLake Paige, SD 30976-0578', 0, 'Widowed', NULL, '4570185220655', 'Yes', NULL, 3, 'Ruby Oberbrunner', '61374156837128', 'New Trudieside', '2027-08-09', NULL, NULL, NULL, NULL, NULL, 521775026, 0, 0, 3, NULL, 1, '2024-12-12 15:30:45', '2024-12-12 15:30:45'),
(5, 5279, 1393, 'نوران مصطفى عادل', 'Female', 3, 4, 4, '2004', 'الفيزياء', 'Fair', '2013-09-11', '84772473842412', '2028-09-28', 'Schoenburgh', 5, 'Muslim', 13, 'zkonopelski@example.com', 4, 16, 14, '0220060797', '0230959631', '01271226902', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '55873321088186', 'Yes', NULL, NULL, '2020-08-17', 'Employee', 10, 9, 'No', 'No', 1, '7.00', '11406.92', '380.23', 'Changeable', NULL, 'Yes', '610.55', '54903310999343', 'Yes', '799.73', '26032505252780', 'Cach', 'Yes', NULL, '103 Aufderhar Trace Apt. 575\nHageneshaven, CA 87907-1506', 0, 'Divorced', NULL, '923659942', 'Yes', NULL, 4, 'Ellie Daugherty III', '16940306570261', 'Port Jarrod', '2026-02-17', NULL, NULL, NULL, NULL, NULL, 1455638023, 0, 0, 1, NULL, 1, '2024-12-12 15:30:45', '2024-12-12 15:30:45'),
(6, 8051, 1359, 'عبدالكريم عبدالسلام آدم', 'Male', 3, 3, 4, '1989', 'إدارة الأعمال', 'Good', '2011-12-27', '71570279479013', '2026-05-05', 'East Elias', 5, 'Muslim', 5, 'obeier@example.net', 3, 11, 1, '0233387887', '0228389428', '01224250480', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '68602225351213', 'No', NULL, NULL, '2020-06-13', 'Employee', 9, 4, 'No', 'Yes', 4, '10.00', '48731.77', '1624.39', 'Fixed', '1413.98', 'Yes', '642.53', '69531416253053', 'Yes', '747.22', '75572823484776', 'Visa', 'No', NULL, '742 West Stream Apt. 142\nLake Wilfrid, SD 04981', 0, 'Divorced', NULL, '181969748', 'Yes', NULL, 1, 'Mrs. Ena Keeling II', '34470785981187', 'West Mertieview', '2025-10-28', NULL, NULL, NULL, NULL, NULL, 522453004, 0, 0, 4, NULL, 1, '2024-12-12 15:30:45', '2024-12-12 15:30:45'),
(7, 9596, 403, 'عبدالحميد مازن مهند', 'Male', 1, 3, 3, '2000', 'الفيزياء', 'Good', '2018-03-16', '32581770834355', '2025-11-10', 'Port Zanemouth', 5, 'Muslim', 13, 'koch.kyle@example.com', 6, 19, 11, '0238642510', '0233188734', '01042665701', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '29908644047616', 'Yes', NULL, NULL, '2024-01-20', 'Employee', 1, 2, 'No', 'Yes', 3, '11.00', '36538.62', '1217.95', 'Changeable', NULL, 'Yes', '652.77', '61518050869178', 'Yes', '669.89', '25447014549008', 'Visa', 'Yes', NULL, '182 Rosa Hills\nNorth Leonel, AL 52888', 0, 'Single', NULL, '32968701632', 'Yes', NULL, 1, 'Rory Klocko', '21189721100882', 'Melbamouth', '2029-01-22', NULL, NULL, NULL, NULL, NULL, 2021265836, 0, 0, 1, NULL, 1, '2024-12-12 15:30:45', '2024-12-12 15:30:45'),
(8, 7610, 2676, 'دنيا أنور نادر', 'Female', 4, 1, 6, '2007', 'الفيزياء', 'Very_Good', '2017-08-02', '94962297370274', '2026-03-25', 'Cedrickborough', 4, 'Muslim', 8, 'elta26@example.net', 5, 25, 8, '0232497472', '0230956714', '01113521876', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '09120270194384', 'No', NULL, NULL, '2022-06-12', 'Employee', 6, 10, 'No', 'Yes', 4, '11.00', '10336.10', '344.54', 'Changeable', NULL, 'Yes', '915.01', '76452213876881', 'No', NULL, NULL, 'Visa', 'No', NULL, '3006 Marjory Fort Apt. 505\nHiltonchester, IA 80742-9402', 0, 'Married', NULL, '1348104176964', 'Yes', NULL, 4, 'Marcus Toy DVM', '94296946167352', 'New Evanstown', '2027-02-20', NULL, NULL, NULL, NULL, NULL, 1772432772, 0, 0, 3, NULL, 1, '2024-12-12 15:30:45', '2024-12-12 15:30:45'),
(9, 6026, 1086, 'زياد إلياس أنور', 'Male', 1, 3, 3, '1998', 'علم الأحياء', 'Very_Good', '2001-07-14', '27720547893759', '2029-08-21', 'North Dereckland', 6, 'Muslim', 10, 'khalid46@example.net', 1, 7, 12, '0233375119', '0237024177', '01123656215', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '56890240606079', 'No', NULL, NULL, '2023-06-26', 'Employee', 3, 7, 'Yes', 'No', 2, '12.00', '24267.45', '808.92', 'Fixed', '1268.72', 'Yes', '604.30', '51027148840274', 'No', NULL, NULL, 'Visa', 'No', NULL, '4141 Kuvalis Islands\nPort Darenland, IA 19916', 0, 'Married', NULL, '7196513073317', 'Yes', NULL, 6, 'Sid Medhurst II', '87965576428162', 'West Wellingtonland', '2026-05-03', NULL, NULL, NULL, NULL, NULL, 232422838, 0, 0, 4, NULL, 1, '2024-12-12 15:30:45', '2024-12-12 15:30:45'),
(10, 3099, 2813, 'روان عبدالرحمن أكرم', 'Female', 1, 3, 6, '1977', 'إدارة الأعمال', 'Fair', '2004-07-12', '18068158691759', '2027-06-18', 'Bahringermouth', 7, 'Muslim', 12, 'howe.edna@example.com', 2, 23, 1, '0224618610', '0223424611', '01096388873', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '82192185196367', 'No', NULL, NULL, '2024-02-18', 'Employee', 2, 10, 'No', 'No', 1, '8.00', '44176.74', '1472.56', 'Fixed', '1829.83', 'Yes', '646.06', '77361571590513', 'Yes', '598.83', '12948507972281', 'Cach', 'No', NULL, '46624 Bessie Roads\nLake Fermin, WI 47893-9684', 0, 'Married', NULL, '61265287888702', 'Yes', NULL, 4, 'Henriette Gottlieb', '79209473783940', 'Lindgrenchester', '2025-11-07', NULL, NULL, NULL, NULL, NULL, 63030393, 0, 0, 2, NULL, 1, '2024-12-12 15:30:45', '2024-12-12 15:30:45'),
(11, 3440, 534, 'سالم مازن قاسم', 'Male', 1, 2, 2, '1979', 'الرياضيات', 'Fair', '2007-08-11', '98138702918911', '2027-09-29', 'South Jazmyne', 6, 'Christian', 4, 'rschmidt@example.com', 2, 1, 14, '0234498472', '0227584776', '01003866571', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '47930014113832', 'No', NULL, NULL, '2022-08-22', 'Employee', 4, 9, 'Yes', 'Yes', 4, '9.00', '22883.08', '762.77', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '8714 Cruickshank Courts Suite 436\nNorth Madyson, KS 17168', 0, 'Divorced', NULL, '3445185221196', 'Yes', NULL, 4, 'Camilla Grimes', '77284507455798', 'Dietrichside', '2027-10-16', NULL, NULL, NULL, NULL, NULL, 1396498022, 0, 0, 1, NULL, 1, '2024-12-12 15:30:45', '2024-12-12 15:30:45'),
(12, 1386, 2060, 'طارق سعيد ياسر', 'Male', 1, 4, 3, '1979', 'إدارة الأعمال', 'Good', '2009-11-16', '16241525177584', '2027-12-21', 'West Bernhard', 1, 'Muslim', 2, 'brown94@example.com', 2, 18, 12, '0233968167', '0224242363', '01516928905', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '11137016536810', 'No', NULL, NULL, '2021-03-03', 'Employee', 10, 6, 'Yes', 'Yes', 1, '7.00', '18199.85', '606.66', 'Fixed', '1631.43', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '401 Swift Roads\nWillmsview, OK 18306-8015', 0, 'Single', NULL, '8512796', 'Yes', NULL, 1, 'Verona Cummings', '58948315627950', 'Javierchester', '2025-02-14', NULL, NULL, NULL, NULL, NULL, 1056702233, 0, 0, 4, NULL, 1, '2024-12-12 15:30:46', '2024-12-12 15:30:46'),
(13, 2005, 1591, 'فاطمة عمر طارق', 'Female', 3, 4, 1, '2009', 'إدارة الأعمال', 'Good', '2016-07-25', '91769499303395', '2029-11-04', 'Port Annetteside', 2, 'Christian', 1, 'walton04@example.net', 2, 10, 14, '0230171075', '0220183913', '01096290464', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '25738411092657', 'Yes', NULL, NULL, '2020-07-09', 'Employee', 8, 1, 'Yes', 'Yes', 4, '8.00', '31630.32', '1054.34', 'Changeable', NULL, 'Yes', '832.56', '51839793067509', 'Yes', '712.20', '30792062514095', 'Visa', 'Yes', NULL, '94590 Bashirian Route\nPort Willardburgh, FL 86697', 0, 'Married', NULL, '545665', 'Yes', NULL, 3, 'Francesca Auer', '24645499526362', 'Rosalindton', '2028-08-16', NULL, NULL, NULL, NULL, NULL, 702235568, 0, 0, 1, NULL, 1, '2024-12-12 15:30:46', '2024-12-12 15:30:46'),
(14, 8085, 1441, 'لؤي أنس منصور', 'Male', 2, 2, 4, '2000', 'الرياضيات', 'Fair', '2012-10-16', '34327910939857', '2028-03-23', 'Maribelstad', 2, 'Christian', 4, 'pfannerstill.emie@example.org', 2, 10, 15, '0236468464', '0231815051', '01549060372', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '18377141547816', 'Yes', NULL, NULL, '2023-09-01', 'Employee', 5, 5, 'No', 'No', 3, '9.00', '29301.68', '976.72', 'Fixed', '1081.76', 'Yes', '700.55', '08583388059590', 'No', NULL, NULL, 'Visa', 'No', NULL, '279 Harvey Heights Suite 275\nSouth Amira, PA 39155', 0, 'Married', NULL, '38742675893888', 'Yes', NULL, 2, 'Ubaldo Johnson', '31316150936393', 'Gracielachester', '2025-08-16', NULL, NULL, NULL, NULL, NULL, 414438769, 0, 0, 1, NULL, 1, '2024-12-12 15:30:46', '2024-12-12 15:30:46'),
(15, 1205, 2359, 'عادل عصام معاذ', 'Male', 4, 3, 6, '1973', 'الفيزياء', 'Excellent', '2012-08-17', '76092138901306', '2025-11-26', 'Cielofurt', 5, 'Christian', 1, 'eichmann.alf@example.net', 4, 20, 4, '0238784112', '0227825162', '01519198490', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '01897176527104', 'No', NULL, NULL, '2023-08-04', 'Employee', 4, 8, 'No', 'Yes', 2, '8.00', '15898.03', '529.93', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '91503 McLaughlin Glen Apt. 465\nRempelfurt, CA 82931-8309', 0, 'Widowed', NULL, '106281769723', 'Yes', NULL, 5, 'Freda Graham', '77171385282809', 'Hermistonborough', '2027-10-22', NULL, NULL, NULL, NULL, NULL, 1128148159, 0, 0, 1, NULL, 1, '2024-12-12 15:30:46', '2024-12-12 15:30:46'),
(16, 9608, 77, 'روز صهيب يوسف', 'Female', 4, 1, 1, '1974', 'الهندسة', 'Good', '2003-09-13', '53545546479023', '2028-06-19', 'Lake Andrew', 4, 'Christian', 3, 'cummerata.niko@example.net', 6, 2, 8, '0229949559', '0232618149', '01032126597', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '67079849282216', 'No', NULL, NULL, '2024-02-03', 'Employee', 5, 8, 'No', 'No', 3, '9.00', '48159.43', '1605.31', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '544.75', '86837228390043', 'Visa', 'Yes', NULL, '22283 Elvis Mill Suite 466\nKuphalmouth, WI 48727', 0, 'Married', NULL, '555324907', 'Yes', NULL, 4, 'Prof. Malachi Welch MD', '91201164812255', 'New Joanne', '2025-02-24', NULL, NULL, NULL, NULL, NULL, 56199133, 0, 0, 4, NULL, 1, '2024-12-12 15:30:46', '2024-12-12 15:30:46'),
(17, 5683, 1419, 'نور صهيب سيف', 'Female', 3, 4, 5, '1992', 'الرياضيات', 'Fair', '2005-09-25', '88548355258616', '2025-11-01', 'Chelsiemouth', 3, 'Muslim', 1, 'bell.hills@example.org', 2, 20, 7, '0235241148', '0221361940', '01500865711', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '00617330326527', 'Yes', NULL, NULL, '2022-05-08', 'Employee', 6, 4, 'Yes', 'Yes', 2, '7.00', '21116.61', '703.89', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '711 Muller Walk Apt. 764\nSouth Felipatown, FL 56801', 0, 'Married', NULL, '56342953426', 'Yes', NULL, 4, 'Oren Bartell', '50141502741737', 'West Antoniettatown', '2029-10-07', NULL, NULL, NULL, NULL, NULL, 1604994458, 0, 0, 3, NULL, 1, '2024-12-12 15:30:46', '2024-12-12 15:30:46'),
(18, 1964, 2937, 'منى يحيى ياسر', 'Female', 1, 1, 6, '1970', 'علم الأحياء', 'Excellent', '2007-02-22', '96875387154887', '2029-07-17', 'Lake Syble', 5, 'Muslim', 5, 'labadie.richie@example.net', 6, 13, 10, '0223475384', '0226499065', '01524981172', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '56062936914800', 'No', NULL, NULL, '2024-11-23', 'Employee', 2, 5, 'Yes', 'No', 3, '8.00', '37549.66', '1251.66', 'Fixed', '1178.73', 'No', NULL, NULL, 'Yes', '711.83', '80801081046095', 'Cach', 'Yes', NULL, '790 Kirk Summit Suite 436\nEast Wilhelm, RI 01741', 0, 'Widowed', NULL, '721079196964856', 'Yes', NULL, 6, 'Jaquelin Kshlerin IV', '18444158107966', 'East Maurice', '2029-05-07', NULL, NULL, NULL, NULL, NULL, 822552004, 0, 0, 3, NULL, 1, '2024-12-12 15:30:46', '2024-12-12 15:30:46'),
(19, 4962, 2090, 'نادية سهيل وجيه', 'Female', 2, 2, 6, '2011', 'علوم الحاسوب', 'Very_Good', '2004-06-12', '35762573489574', '2026-03-16', 'Ettieport', 3, 'Christian', 12, 'schroeder.hershel@example.org', 3, 10, 7, '0235957212', '0237500469', '01218322444', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '35551616370031', 'Yes', NULL, NULL, '2022-12-24', 'Employee', 4, 4, 'No', 'No', 3, '11.00', '30922.40', '1030.75', 'Fixed', '1467.90', 'Yes', '517.58', '84939038149773', 'Yes', '812.01', '49562995550507', 'Cach', 'No', NULL, '9296 Lisette Mount Apt. 178\nSouth Alyce, VA 49709', 0, 'Widowed', NULL, '7697147322', 'Yes', NULL, 5, 'Kolby Cremin', '43310344106661', 'Jastville', '2027-05-08', NULL, NULL, NULL, NULL, NULL, 1836366390, 0, 0, 1, NULL, 1, '2024-12-12 15:30:46', '2024-12-12 15:30:46'),
(20, 2056, 1085, 'رنا معاذ رياض', 'Female', 1, 4, 2, '1971', 'الهندسة', 'Fair', '2010-06-28', '62509737555162', '2028-02-10', 'Lake Carriestad', 1, 'Christian', 3, 'mohr.casandra@example.com', 3, 19, 13, '0234496911', '0226328868', '01551523692', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '22205848701688', 'No', NULL, NULL, '2022-11-24', 'Employee', 7, 2, 'Yes', 'Yes', 3, '9.00', '10946.61', '364.89', 'Changeable', NULL, 'Yes', '928.66', '64560108837414', 'Yes', '812.78', '58192955723788', 'Visa', 'No', NULL, '273 Bechtelar Knoll Apt. 639\nWest Doloresshire, KY 92693-1784', 0, 'Married', NULL, '527700727', 'Yes', NULL, 1, 'Rylee Quigley', '59589805831065', 'Lake Estelfort', '2028-08-08', NULL, NULL, NULL, NULL, NULL, 1780461414, 0, 0, 3, NULL, 1, '2024-12-12 15:30:46', '2024-12-12 15:30:46'),
(21, 2578, 1391, 'ياسمين صهيب علاء', 'Female', 3, 2, 4, '2006', 'علم الأحياء', 'Good', '2022-03-04', '64416709945135', '2025-06-10', 'South Dianaton', 5, 'Muslim', 11, 'frunolfsson@example.com', 2, 13, 15, '0236219514', '0226818758', '01170171286', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '23478895626690', 'No', NULL, NULL, '2020-08-06', 'Employee', 4, 7, 'No', 'Yes', 1, '11.00', '14619.81', '487.33', 'Fixed', '1053.81', 'No', NULL, NULL, 'Yes', '916.35', '80400780301111', 'Visa', 'No', NULL, '912 Schaefer Loaf\nWest Landen, LA 78731', 0, 'Single', NULL, '297654797498', 'Yes', NULL, 5, 'Prof. Preston Reilly', '92945853397882', 'Donnyfort', '2028-05-01', NULL, NULL, NULL, NULL, NULL, 231943552, 0, 0, 1, NULL, 1, '2024-12-12 15:30:46', '2024-12-12 15:30:46'),
(22, 3103, 2700, 'عامر سامر عصام', 'Male', 1, 3, 6, '1985', 'علم الأحياء', 'Good', '2011-05-20', '20933529318585', '2026-09-27', 'Gottliebhaven', 7, 'Christian', 13, 'ntromp@example.org', 2, 21, 4, '0228864228', '0239942502', '01180603758', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '25593118702493', 'Yes', NULL, NULL, '2020-06-22', 'Employee', 9, 2, 'No', 'No', 4, '9.00', '34576.92', '1152.56', 'Changeable', NULL, 'Yes', '958.77', '00540905920623', 'Yes', '660.92', '53053620022959', 'Visa', 'No', NULL, '4213 Yasmeen Trace Apt. 057\nHettiefort, IN 18905', 0, 'Married', NULL, '2518555813', 'Yes', NULL, 2, 'Keira Cremin', '93414144287739', 'Cruzmouth', '2028-04-24', NULL, NULL, NULL, NULL, NULL, 454832729, 0, 0, 3, NULL, 1, '2024-12-12 15:30:46', '2024-12-12 15:30:46'),
(23, 5722, 2660, 'مريم عامر كريم', 'Female', 1, 3, 1, '2003', 'علوم الحاسوب', 'Fair', '2020-03-29', '03098194178070', '2029-05-05', 'Harleyberg', 2, 'Christian', 3, 'jordi.bashirian@example.net', 5, 3, 8, '0236821197', '0238545075', '01185570992', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '62285488766090', 'Yes', NULL, NULL, '2024-01-15', 'Employee', 1, 2, 'Yes', 'Yes', 1, '9.00', '22018.53', '733.95', 'Changeable', NULL, 'Yes', '846.32', '59033943579639', 'No', NULL, NULL, 'Cach', 'No', NULL, '5645 Libby Extension\nNorth Sedrickberg, NM 76442-9526', 0, 'Divorced', NULL, '207598032816', 'Yes', NULL, 5, 'Prof. Eulalia Gibson I', '67459299619799', 'South Elizabethport', '2025-05-09', NULL, NULL, NULL, NULL, NULL, 1780638908, 0, 0, 2, NULL, 1, '2024-12-12 15:30:46', '2024-12-12 15:30:46'),
(24, 6556, 1751, 'جوري عبدالله حمزة', 'Female', 3, 2, 2, '2004', 'إدارة الأعمال', 'Very_Good', '2018-07-19', '84181541570042', '2029-04-03', 'South Shania', 3, 'Muslim', 8, 'grimes.eugenia@example.com', 6, 10, 8, '0239407852', '0225148430', '01051361346', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '58944805607063', 'Yes', NULL, NULL, '2022-10-06', 'Employee', 5, 3, 'Yes', 'No', 1, '10.00', '22976.13', '765.87', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '1788 Presley Via Apt. 141\nMrazmouth, DC 09967-8591', 0, 'Widowed', NULL, '7350704205911', 'Yes', NULL, 5, 'Jerry O\'Connell', '52039362823230', 'Glennamouth', '2027-09-25', NULL, NULL, NULL, NULL, NULL, 494144099, 0, 0, 1, NULL, 1, '2024-12-12 15:30:47', '2024-12-12 15:30:47'),
(25, 3752, 1354, 'عصام عمر عامر', 'Male', 4, 4, 6, '1981', 'الرياضيات', 'Fair', '2024-08-09', '88672250670390', '2025-06-09', 'Joshuafort', 3, 'Christian', 7, 'telly75@example.com', 1, 20, 5, '0239257764', '0237433005', '01511039062', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '21201902934962', 'Yes', NULL, NULL, '2024-07-13', 'Employee', 3, 7, 'No', 'No', 2, '8.00', '43039.72', '1434.66', 'Changeable', NULL, 'Yes', '888.75', '15603121913176', 'Yes', '794.00', '71168586498961', 'Visa', 'No', NULL, '74615 Huels Points Suite 019\nJoanmouth, GA 52977-3158', 0, 'Widowed', NULL, '97922406610310', 'Yes', NULL, 4, 'Chet Hansen', '24140344522492', 'Melissahaven', '2027-10-10', NULL, NULL, NULL, NULL, NULL, 1058152481, 0, 0, 2, NULL, 1, '2024-12-12 15:30:47', '2024-12-12 15:30:47'),
(26, 5815, 2861, 'رامز لؤي أديب', 'Male', 1, 4, 5, '1975', 'الرياضيات', 'Fair', '2008-12-17', '55791179716648', '2028-08-15', 'South Sidmouth', 3, 'Muslim', 12, 'vcrooks@example.net', 6, 20, 5, '0224218122', '0221412714', '01201672495', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '50510240987714', 'No', NULL, NULL, '2021-12-26', 'Employee', 9, 7, 'No', 'No', 3, '9.00', '21935.02', '731.17', 'Fixed', '1874.40', 'No', NULL, NULL, 'Yes', '986.67', '25031898055583', 'Cach', 'Yes', NULL, '76926 Sanford Garden Suite 108\nLake Cora, NE 58187-9073', 0, 'Single', NULL, '5724049028', 'Yes', NULL, 5, 'Salma Gulgowski', '47059333417944', 'North Doris', '2025-05-10', NULL, NULL, NULL, NULL, NULL, 1748684731, 0, 0, 1, NULL, 1, '2024-12-12 15:30:47', '2024-12-12 15:30:47'),
(27, 6638, 2153, 'إلياس حذيفة هيثم', 'Male', 2, 2, 3, '1993', 'الرياضيات', 'Very_Good', '2020-09-20', '06322816534961', '2027-05-29', 'North Kylermouth', 7, 'Muslim', 12, 'corkery.amie@example.org', 2, 21, 12, '0223891205', '0232149199', '01124741486', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '32427916737800', 'Yes', NULL, NULL, '2022-12-22', 'Employee', 7, 3, 'Yes', 'Yes', 4, '7.00', '46494.44', '1549.81', 'Fixed', '1771.98', 'Yes', '866.03', '80109210275467', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '6220 Dakota Island Suite 591\nGaylordton, CA 84286', 0, 'Divorced', NULL, '73945178114490', 'Yes', NULL, 1, 'Prof. Jaylen Lemke', '28355592980445', 'West Lorahaven', '2029-02-19', NULL, NULL, NULL, NULL, NULL, 1625636870, 0, 0, 2, NULL, 1, '2024-12-12 15:30:47', '2024-12-12 15:30:47'),
(28, 3564, 602, 'صابر حمزة قاسم', 'Male', 3, 3, 5, '2012', 'الهندسة', 'Very_Good', '2021-03-04', '78726688962985', '2027-08-25', 'Elvisport', 3, 'Muslim', 7, 'paul55@example.com', 3, 9, 11, '0237230836', '0229325361', '01141415357', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '24636980921987', 'Yes', NULL, NULL, '2023-06-22', 'Employee', 8, 5, 'No', 'Yes', 2, '12.00', '12092.69', '403.09', 'Changeable', NULL, 'Yes', '938.38', '67723089280329', 'Yes', '571.11', '56270675809533', 'Visa', 'No', NULL, '13969 Jonas Circles Apt. 664\nNorth Jena, MA 05475-9047', 0, 'Divorced', NULL, '4100866307', 'Yes', NULL, 3, 'Isidro Durgan', '17507079763378', 'Kulasview', '2026-04-15', NULL, NULL, NULL, NULL, NULL, 586518324, 0, 0, 4, NULL, 1, '2024-12-12 15:30:47', '2024-12-12 15:30:47'),
(29, 6086, 966, 'عامر مالك جواد', 'Male', 4, 4, 4, '1984', 'الرياضيات', 'Fair', '2002-07-26', '14177235497192', '2026-01-28', 'Gildaberg', 4, 'Muslim', 2, 'roob.wyatt@example.net', 5, 2, 3, '0220944895', '0239092610', '01106000957', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '62503605380944', 'Yes', NULL, NULL, '2023-01-13', 'Employee', 10, 8, 'No', 'No', 1, '7.00', '14442.23', '481.41', 'Changeable', NULL, 'Yes', '767.56', '73330167525347', 'Yes', '767.01', '14653134787057', 'Visa', 'No', NULL, '6388 Satterfield Manor Suite 746\nNew Casimer, TN 59925', 0, 'Divorced', NULL, '86187713363046', 'Yes', NULL, 1, 'Briana Abernathy', '32233445491952', 'Royhaven', '2027-11-19', NULL, NULL, NULL, NULL, NULL, 566463528, 0, 0, 3, NULL, 1, '2024-12-12 15:30:47', '2024-12-12 15:30:47'),
(30, 9829, 1375, 'عبدالعزيز عامر عدنان', 'Male', 3, 2, 1, '1993', 'الهندسة', 'Good', '2018-01-21', '58245935833250', '2026-01-08', 'New Johnathon', 1, 'Muslim', 12, 'wiza.werner@example.net', 5, 11, 15, '0239837565', '0227141211', '01584796190', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '69340106534354', 'Yes', NULL, NULL, '2021-11-24', 'Employee', 4, 6, 'Yes', 'Yes', 4, '9.00', '26733.93', '891.13', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '596.96', '02637107162679', 'Cach', 'Yes', NULL, '22228 Benton Extension Apt. 937\nFaystad, UT 57303-4962', 0, 'Married', NULL, '59731412656', 'Yes', NULL, 2, 'Miss Claudie Nolan', '05526198208564', 'Weissnatport', '2025-01-03', NULL, NULL, NULL, NULL, NULL, 232952624, 0, 0, 2, NULL, 1, '2024-12-12 15:30:47', '2024-12-12 15:30:47'),
(31, 6922, 278, 'ثامر شاكر عبدالله', 'Male', 2, 4, 5, '2000', 'الرياضيات', 'Very_Good', '2003-08-04', '92047173066912', '2026-08-24', 'East Lowell', 7, 'Muslim', 13, 'layla42@example.com', 5, 13, 8, '0227307668', '0223569287', '01145300633', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '89371282187202', 'No', NULL, NULL, '2020-05-21', 'Employee', 7, 1, 'Yes', 'No', 3, '10.00', '21407.06', '713.57', 'Changeable', NULL, 'Yes', '669.68', '16295376551639', 'Yes', '949.07', '38833110819802', 'Cach', 'Yes', NULL, '710 Buddy Port\nHillsmouth, UT 02723', 0, 'Widowed', NULL, '252473278200', 'Yes', NULL, 3, 'Miss America Goyette', '64741340152593', 'Schmelerburgh', '2027-04-10', NULL, NULL, NULL, NULL, NULL, 944797022, 0, 0, 4, NULL, 1, '2024-12-12 15:30:47', '2024-12-12 15:30:47'),
(32, 1764, 1851, 'حمزة أكرم ثامر', 'Male', 3, 3, 2, '1997', 'علوم الحاسوب', 'Fair', '2010-12-05', '64110260632849', '2027-09-30', 'New Germaine', 5, 'Muslim', 5, 'terrill41@example.org', 1, 26, 10, '0229449462', '0222736200', '01009094197', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '17842669957690', 'No', NULL, NULL, '2021-09-19', 'Employee', 4, 2, 'Yes', 'Yes', 4, '8.00', '44877.51', '1495.92', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '578.63', '55778389306273', 'Cach', 'Yes', NULL, '387 Greenholt Branch\nWatersmouth, MO 04810-6137', 0, 'Married', NULL, '31477248', 'Yes', NULL, 5, 'Stan Wiegand', '11565275675736', 'Mellieland', '2028-06-23', NULL, NULL, NULL, NULL, NULL, 1428927650, 0, 0, 2, NULL, 1, '2024-12-12 15:30:48', '2024-12-12 15:30:48'),
(33, 5807, 635, 'مها مهند حامد', 'Female', 2, 1, 1, '2001', 'علوم الحاسوب', 'Very_Good', '2016-12-28', '03019223232748', '2028-10-17', 'Port Carlo', 5, 'Muslim', 5, 'quentin69@example.org', 6, 5, 9, '0220196073', '0239706363', '01154129995', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '42703222907663', 'No', NULL, NULL, '2022-12-07', 'Employee', 10, 5, 'No', 'No', 3, '8.00', '7888.05', '262.94', 'Changeable', NULL, 'Yes', '703.93', '62339387612184', 'Yes', '592.83', '17030477768638', 'Cach', 'No', NULL, '485 Toy Branch Suite 395\nNorth Jarenfort, PA 71758-9761', 0, 'Single', NULL, '694120402056', 'Yes', NULL, 2, 'Dr. Ashleigh Heathcote MD', '75328843169153', 'Lubowitztown', '2025-11-27', NULL, NULL, NULL, NULL, NULL, 720644273, 0, 0, 1, NULL, 1, '2024-12-12 15:30:48', '2024-12-12 15:30:48'),
(34, 4870, 23, 'نور عبدالكريم سعيد', 'Male', 1, 4, 6, '1977', 'إدارة الأعمال', 'Good', '2000-12-18', '73051817637887', '2029-04-14', 'Port Mallory', 3, 'Christian', 1, 'robel.selena@example.net', 6, 4, 5, '0224358903', '0236867027', '01278263230', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '61084510082876', 'Yes', NULL, NULL, '2022-07-06', 'Employee', 9, 10, 'No', 'No', 4, '7.00', '14894.46', '496.48', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '4288 Jerry Mountain\nKlockoview, IN 72996', 0, 'Married', NULL, '9630645581', 'Yes', NULL, 1, 'Bart Pacocha', '70343518392728', 'Taureanfort', '2025-06-09', NULL, NULL, NULL, NULL, NULL, 1940824059, 0, 0, 2, NULL, 1, '2024-12-12 15:30:48', '2024-12-12 15:30:48'),
(35, 2067, 1570, 'ميرال مصطفى يوسف', 'Female', 2, 3, 2, '2011', 'علوم الحاسوب', 'Excellent', '2016-12-30', '65243305642024', '2026-10-27', 'Schultzview', 4, 'Christian', 2, 'hyatt.maureen@example.com', 1, 23, 7, '0221284338', '0224332724', '01500364797', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '22427617151255', 'No', NULL, NULL, '2022-08-12', 'Employee', 1, 2, 'No', 'No', 2, '12.00', '24559.03', '818.63', 'Fixed', '1846.91', 'No', NULL, NULL, 'Yes', '739.98', '05072091140144', 'Cach', 'No', NULL, '93371 Shanahan Rue\nSouth Emilie, GA 98960', 0, 'Single', NULL, '7108671257', 'Yes', NULL, 4, 'Gloria McGlynn', '38694833190216', 'Larkintown', '2025-03-23', NULL, NULL, NULL, NULL, NULL, 519531039, 0, 0, 1, NULL, 1, '2024-12-12 15:30:48', '2024-12-12 15:30:48'),
(36, 6284, 116, 'عصام جمال عمار', 'Male', 1, 3, 5, '2007', 'الفيزياء', 'Very_Good', '2006-03-24', '95831372076417', '2029-07-10', 'Bashirianshire', 4, 'Christian', 6, 'kailee.kshlerin@example.org', 2, 10, 1, '0229060113', '0235188600', '01543357651', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '77435597452355', 'No', NULL, NULL, '2024-10-19', 'Employee', 1, 8, 'No', 'Yes', 3, '9.00', '15706.45', '523.55', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '763.46', '81262352435075', 'Cach', 'Yes', NULL, '8062 Aglae Port Suite 406\nLake Tess, CT 27570', 0, 'Widowed', NULL, '297265340705252', 'Yes', NULL, 3, 'Shawna Davis', '78213332156274', 'Rickchester', '2025-05-08', NULL, NULL, NULL, NULL, NULL, 1344645551, 0, 0, 4, NULL, 1, '2024-12-12 15:30:48', '2024-12-12 15:30:48'),
(37, 3869, 1251, 'أسماء رامي مهند', 'Female', 4, 3, 4, '1990', 'إدارة الأعمال', 'Good', '2002-03-08', '48814208508814', '2026-07-15', 'Darefort', 5, 'Muslim', 6, 'baylee.senger@example.org', 2, 15, 10, '0225398686', '0231084191', '01224224313', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '48919245670047', 'No', NULL, NULL, '2023-12-22', 'Employee', 8, 10, 'Yes', 'No', 3, '7.00', '21206.72', '706.89', 'Fixed', '1290.83', 'Yes', '564.68', '15739743285268', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '799 Hammes Fall Suite 111\nNorth Rashawnberg, MS 63961', 0, 'Married', NULL, '71679650', 'Yes', NULL, 6, 'Ryleigh Kautzer', '27902120218341', 'East Marcus', '2026-01-14', NULL, NULL, NULL, NULL, NULL, 1185677381, 0, 0, 2, NULL, 1, '2024-12-12 15:30:48', '2024-12-12 15:30:48'),
(38, 7067, 1019, 'علي هيثم بكر', 'Male', 2, 2, 5, '1993', 'الرياضيات', 'Excellent', '2002-09-25', '72716352503744', '2025-07-27', 'Feliciamouth', 6, 'Muslim', 4, 'violette99@example.net', 1, 4, 4, '0220615564', '0226494575', '01154896791', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '69041999133815', 'Yes', NULL, NULL, '2023-11-03', 'Employee', 4, 6, 'No', 'Yes', 3, '7.00', '18761.44', '625.38', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '58729 Hoeger Creek Apt. 142\nJoanneborough, OH 70232', 0, 'Divorced', NULL, '367803834', 'Yes', NULL, 2, 'Cora Muller', '00787782558058', 'Lake Hesterfurt', '2026-12-25', NULL, NULL, NULL, NULL, NULL, 1930833324, 0, 0, 2, NULL, 1, '2024-12-12 15:30:48', '2024-12-12 15:30:48'),
(39, 5820, 1750, 'رنا يوسف منصور', 'Female', 4, 3, 5, '2011', 'الفيزياء', 'Excellent', '2019-08-20', '45814858892872', '2028-05-06', 'Mitchelberg', 4, 'Muslim', 10, 'vladimir.emard@example.com', 6, 6, 7, '0227494724', '0221118846', '01197823003', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '38650575510144', 'Yes', NULL, NULL, '2020-06-12', 'Employee', 4, 3, 'Yes', 'No', 3, '10.00', '20465.30', '682.18', 'Fixed', '1914.65', 'Yes', '666.78', '53377531124138', 'No', NULL, NULL, 'Visa', 'No', NULL, '8049 Karl Via Suite 873\nJoellehaven, KY 95926-2228', 0, 'Widowed', NULL, '616286229512', 'Yes', NULL, 5, 'Kade Wisoky', '28082690227360', 'South Jarrett', '2026-10-11', NULL, NULL, NULL, NULL, NULL, 416069542, 0, 0, 4, NULL, 1, '2024-12-12 15:30:48', '2024-12-12 15:30:48'),
(40, 5039, 2663, 'معاذ مازن مهند', 'Male', 2, 1, 1, '1992', 'إدارة الأعمال', 'Excellent', '2018-11-26', '55270913384994', '2028-11-20', 'Kovacekmouth', 5, 'Muslim', 1, 'aleannon@example.com', 4, 22, 6, '0221452040', '0231255651', '01557449924', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '24039892937810', 'Yes', NULL, NULL, '2024-07-02', 'Employee', 7, 6, 'No', 'No', 3, '7.00', '39056.47', '1301.88', 'Fixed', '1635.83', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '286 Witting Burg\nKaylifort, MS 95051', 0, 'Single', NULL, '612484822930', 'Yes', NULL, 6, 'Prof. Jessie Hane', '46662389371340', 'Lake Keegan', '2028-05-08', NULL, NULL, NULL, NULL, NULL, 1823198316, 0, 0, 1, NULL, 1, '2024-12-12 15:30:48', '2024-12-12 15:30:48'),
(41, 4898, 2049, 'كنزي شاكر يوسف', 'Female', 3, 1, 1, '1991', 'إدارة الأعمال', 'Very_Good', '2013-10-18', '24893379490638', '2025-08-20', 'Stefanberg', 1, 'Christian', 9, 'boris.gusikowski@example.org', 3, 21, 8, '0225928226', '0226365285', '01278135795', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '39998370555729', 'Yes', NULL, NULL, '2020-05-26', 'Employee', 6, 8, 'No', 'Yes', 4, '11.00', '9512.90', '317.10', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '432 Herman Corner\nWest Mohammedburgh, MT 69101', 0, 'Married', NULL, '6290732', 'Yes', NULL, 2, 'Nickolas Moore', '66215255827298', 'Cormierburgh', '2028-10-23', NULL, NULL, NULL, NULL, NULL, 2018853793, 0, 0, 3, NULL, 1, '2024-12-12 15:30:48', '2024-12-12 15:30:48'),
(42, 4828, 566, 'معاذ زيد محمود', 'Male', 2, 2, 1, '1990', 'علوم الحاسوب', 'Excellent', '2018-05-22', '91263613689233', '2029-11-22', 'Mabellefurt', 7, 'Muslim', 6, 'qthompson@example.net', 3, 19, 2, '0220506401', '0234055146', '01594690356', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '81549312251676', 'No', NULL, NULL, '2020-04-07', 'Employee', 4, 5, 'Yes', 'Yes', 4, '12.00', '45663.08', '1522.10', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '19217 Clinton Street\nWest Dimitri, FL 81149', 0, 'Divorced', NULL, '930154434', 'Yes', NULL, 4, 'Kaycee Sawayn', '35893043765930', 'New Margeside', '2029-02-12', NULL, NULL, NULL, NULL, NULL, 509949098, 0, 0, 4, NULL, 1, '2024-12-12 15:30:48', '2024-12-12 15:30:48'),
(43, 2817, 2331, 'ليان فارس وائل', 'Female', 4, 3, 5, '1984', 'الفيزياء', 'Fair', '2001-12-25', '45061281527691', '2026-07-15', 'Trantowland', 4, 'Muslim', 5, 'sage.zboncak@example.com', 1, 18, 13, '0222977798', '0220522488', '01081369929', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '57888679483176', 'No', NULL, NULL, '2023-12-29', 'Employee', 1, 4, 'Yes', 'No', 2, '9.00', '22840.97', '761.37', 'Fixed', '1787.72', 'Yes', '801.97', '33092605308848', 'No', NULL, NULL, 'Visa', 'No', NULL, '6070 Jason Dam\nNew Vella, LA 58644', 0, 'Married', NULL, '9493826', 'Yes', NULL, 1, 'Ms. Elisabeth Treutel', '28221864796742', 'West Raeshire', '2029-06-26', NULL, NULL, NULL, NULL, NULL, 1715072538, 0, 0, 3, NULL, 1, '2024-12-12 15:30:48', '2024-12-12 15:30:48'),
(44, 3243, 1870, 'ساجدة رفيق إبراهيم', 'Female', 4, 2, 6, '1988', 'الهندسة', 'Good', '2012-11-01', '91158263656387', '2027-06-20', 'Lacychester', 1, 'Muslim', 7, 'george28@example.org', 3, 10, 5, '0229547484', '0233991457', '01135342696', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '07586910421301', 'No', NULL, NULL, '2024-08-16', 'Employee', 9, 5, 'Yes', 'Yes', 4, '12.00', '48183.88', '1606.13', 'Changeable', NULL, 'Yes', '727.44', '48201728838265', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '422 Rosalind Isle\nEast Vincent, AL 92761-3580', 0, 'Widowed', NULL, '1827425006', 'Yes', NULL, 3, 'Dr. Harmon Braun', '82431817168930', 'North Lucienne', '2025-07-06', NULL, NULL, NULL, NULL, NULL, 594631704, 0, 0, 2, NULL, 1, '2024-12-12 15:30:48', '2024-12-12 15:30:48'),
(45, 4576, 2152, 'عامر عبداللطيف حسن', 'Male', 4, 2, 5, '1990', 'الرياضيات', 'Good', '2003-08-12', '49496896133890', '2026-03-08', 'Rhodaville', 2, 'Muslim', 8, 'daugherty.lloyd@example.org', 4, 2, 12, '0226326087', '0231207514', '01088636542', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '13773755415197', 'No', NULL, NULL, '2023-05-09', 'Employee', 4, 1, 'No', 'No', 3, '9.00', '46981.91', '1566.06', 'Fixed', '1754.88', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '8860 Mateo Mountains\nNorth Kayden, ME 57348', 0, 'Widowed', NULL, '9586292154', 'Yes', NULL, 4, 'Isabell Bartoletti', '16663725960446', 'Rosalindburgh', '2029-11-03', NULL, NULL, NULL, NULL, NULL, 332234954, 0, 0, 3, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(46, 9996, 329, 'نور حسين نبيل', 'Male', 1, 4, 5, '2005', 'علم الأحياء', 'Excellent', '2000-09-19', '43646158054649', '2026-01-23', 'Schaeferport', 4, 'Christian', 4, 'waters.kaitlin@example.net', 1, 10, 7, '0231554656', '0229346800', '01515827552', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '56673168885254', 'No', NULL, NULL, '2020-04-25', 'Employee', 1, 7, 'No', 'No', 3, '7.00', '47441.66', '1581.39', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '185 Cronin Park\nNorth Janettown, NV 19125', 0, 'Single', NULL, '801827340605', 'Yes', NULL, 3, 'Miss Ashley Hagenes MD', '39581271549747', 'Port Nanniechester', '2025-11-27', NULL, NULL, NULL, NULL, NULL, 1381193296, 0, 0, 3, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(47, 7806, 201, 'ريم إلياس رفيق', 'Female', 2, 3, 1, '1978', 'الرياضيات', 'Good', '2024-12-06', '59439931658371', '2025-04-05', 'Carrollside', 5, 'Christian', 5, 'orlo.connelly@example.net', 2, 15, 10, '0226932601', '0239792971', '01536047511', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '18682431302362', 'No', NULL, NULL, '2024-01-10', 'Employee', 7, 5, 'No', 'No', 1, '12.00', '7079.06', '235.97', 'Changeable', NULL, 'Yes', '568.88', '60111016859661', 'Yes', '908.56', '15642760834014', 'Cach', 'Yes', NULL, '9830 Lueilwitz Corners Suite 110\nHansenmouth, DC 24275', 0, 'Divorced', NULL, '42845040427', 'Yes', NULL, 2, 'Mr. Hilton Hauck', '87815997859131', 'Jaimefurt', '2029-02-16', NULL, NULL, NULL, NULL, NULL, 1674084937, 0, 0, 3, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(48, 8135, 1478, 'وسام محمد وجيه', 'Female', 3, 2, 3, '2010', 'الفيزياء', 'Good', '2013-04-18', '09286342122364', '2026-04-10', 'Stephanyburgh', 1, 'Muslim', 10, 'crooks.irma@example.com', 1, 12, 4, '0236990866', '0227718597', '01251336241', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '55082640267525', 'No', NULL, NULL, '2020-01-04', 'Employee', 2, 7, 'Yes', 'No', 2, '12.00', '42624.99', '1420.83', 'Changeable', NULL, 'Yes', '848.97', '19112163218247', 'Yes', '960.93', '35075856284219', 'Cach', 'No', NULL, '712 Dare Mountains Suite 196\nPort Leanne, OK 82639-3927', 0, 'Divorced', NULL, '7966947315730', 'Yes', NULL, 6, 'Carmel Carroll', '31649049080591', 'Eribertochester', '2027-06-03', NULL, NULL, NULL, NULL, NULL, 1984033003, 0, 0, 1, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(49, 4236, 1012, 'سهيل رائد عبدالسلام', 'Male', 1, 4, 5, '1981', 'علوم الحاسوب', 'Good', '2001-10-22', '83497571946139', '2026-04-14', 'Lake Oceane', 4, 'Muslim', 10, 'ayla66@example.net', 2, 19, 3, '0228154030', '0235992337', '01121131777', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '45582699193308', 'Yes', NULL, NULL, '2020-01-15', 'Employee', 6, 9, 'No', 'Yes', 1, '9.00', '49667.24', '1655.57', 'Fixed', '1942.00', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '8333 Diana Stravenue Apt. 523\nConnellybury, HI 57559-0261', 0, 'Divorced', NULL, '45051476600075', 'Yes', NULL, 6, 'Hillard Rowe Sr.', '53462257430858', 'Lake Maryamhaven', '2029-01-30', NULL, NULL, NULL, NULL, NULL, 620360432, 0, 0, 4, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(50, 3823, 2000, 'تامر صهيب علاء', 'Male', 2, 2, 1, '2014', 'الفيزياء', 'Good', '2023-12-02', '60807520538658', '2028-04-09', 'Francohaven', 4, 'Christian', 8, 'nmayer@example.net', 6, 9, 3, '0235703724', '0222997107', '01044298948', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '62858610680168', 'Yes', NULL, NULL, '2020-04-03', 'Employee', 1, 6, 'No', 'Yes', 3, '10.00', '49308.01', '1643.60', 'Changeable', NULL, 'Yes', '637.36', '77313491235511', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '50379 Meggie Road\nNew Jonathon, OH 16578', 0, 'Divorced', NULL, '271657147670', 'Yes', NULL, 5, 'Floy Watsica PhD', '65337846537442', 'West Halborough', '2027-01-18', NULL, NULL, NULL, NULL, NULL, 1431461021, 0, 0, 3, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(51, 8276, 885, 'هالة محمود صهيب', 'Female', 2, 1, 2, '2002', 'إدارة الأعمال', 'Fair', '2024-12-08', '11736521094751', '2028-01-31', 'West Samson', 1, 'Christian', 8, 'green.cordia@example.org', 5, 12, 7, '0230499444', '0221553297', '01196935122', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '66212685158936', 'No', NULL, NULL, '2022-11-18', 'Employee', 5, 5, 'No', 'Yes', 1, '8.00', '43829.49', '1460.98', 'Fixed', '1764.35', 'Yes', '968.09', '74594262043707', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '9913 Nikolaus Mill\nDahliafort, ID 47355', 0, 'Divorced', NULL, '532426302517', 'Yes', NULL, 2, 'Josefina Koepp II', '06556405247839', 'Grahamside', '2027-09-05', NULL, NULL, NULL, NULL, NULL, 1956733207, 0, 0, 1, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(52, 9370, 2706, 'عبير حامد أحمد', 'Female', 3, 1, 3, '1983', 'علم الأحياء', 'Very_Good', '2016-06-14', '73937978651014', '2025-10-29', 'Daytonhaven', 1, 'Muslim', 1, 'otilia53@example.net', 5, 4, 11, '0227666690', '0224262909', '01125078259', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '77501648146322', 'No', NULL, NULL, '2022-01-05', 'Employee', 9, 9, 'Yes', 'Yes', 4, '11.00', '46520.81', '1550.69', 'Fixed', '1024.52', 'No', NULL, NULL, 'Yes', '507.72', '32673909494365', 'Cach', 'Yes', NULL, '10188 Yundt Road Suite 509\nNorth Karineport, MS 93543-3316', 0, 'Single', NULL, '294375702', 'Yes', NULL, 2, 'Mrs. Mona Murazik V', '76027657918379', 'Hamillborough', '2026-08-03', NULL, NULL, NULL, NULL, NULL, 698860843, 0, 0, 3, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(53, 4749, 2838, 'أميرة ناجي أكرم', 'Female', 3, 4, 5, '2009', 'الرياضيات', 'Fair', '2008-03-26', '77400802858946', '2029-10-05', 'Hudsonchester', 6, 'Christian', 1, 'linwood13@example.net', 5, 1, 5, '0234749307', '0224549559', '01544988800', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '92245748551356', 'No', NULL, NULL, '2020-02-25', 'Employee', 6, 4, 'No', 'No', 1, '8.00', '37271.99', '1242.40', 'Changeable', NULL, 'Yes', '606.96', '22976634668822', 'Yes', '708.38', '72913825755166', 'Visa', 'No', NULL, '6765 Salma Mill\nNorth Nico, GA 51183-2570', 0, 'Single', NULL, '539510041', 'Yes', NULL, 5, 'Malachi Lang MD', '10398020776340', 'Ardenberg', '2027-07-29', NULL, NULL, NULL, NULL, NULL, 367336801, 0, 0, 2, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(54, 2606, 1290, 'نجوى ثامر رامز', 'Female', 4, 3, 5, '1982', 'الرياضيات', 'Fair', '2006-06-24', '56866961592021', '2027-09-13', 'East Chaya', 6, 'Muslim', 10, 'conn.audreanne@example.net', 1, 3, 10, '0229761376', '0223799509', '01285120621', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '04603041105088', 'Yes', NULL, NULL, '2023-03-16', 'Employee', 2, 4, 'No', 'No', 2, '8.00', '36712.00', '1223.73', 'Changeable', NULL, 'Yes', '982.04', '57983248366168', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '82641 Hortense View Apt. 339\nNorth Darrel, IA 77620', 0, 'Widowed', NULL, '339344500008', 'Yes', NULL, 5, 'Colby Marquardt', '36079396034964', 'Delphiaberg', '2025-12-07', NULL, NULL, NULL, NULL, NULL, 1506141113, 0, 0, 2, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(55, 8874, 450, 'لبنى وجيه عمار', 'Female', 1, 3, 5, '1999', 'علم الأحياء', 'Very_Good', '2003-03-01', '07844134694183', '2028-10-31', 'Metzport', 7, 'Muslim', 3, 'drew55@example.net', 1, 18, 13, '0234247178', '0228260062', '01174433360', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '14131383789793', 'No', NULL, NULL, '2023-05-18', 'Employee', 6, 4, 'No', 'No', 1, '7.00', '49968.26', '1665.61', 'Fixed', '1058.30', 'Yes', '704.02', '42858511822242', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '521 Pearline Land\nNew Nataliaburgh, AL 67162-4241', 0, 'Widowed', NULL, '662069677', 'Yes', NULL, 1, 'Gina Bartoletti', '22650270319466', 'North Christian', '2029-01-05', NULL, NULL, NULL, NULL, NULL, 237261560, 0, 0, 3, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(56, 7207, 1438, 'شهد بدر هيثم', 'Female', 3, 2, 2, '1985', 'إدارة الأعمال', 'Excellent', '2017-08-28', '07699395333182', '2027-09-13', 'Luettgenton', 3, 'Muslim', 8, 'edgardo43@example.net', 3, 6, 14, '0232376724', '0228707330', '01517825806', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '32964390188637', 'No', NULL, NULL, '2022-04-15', 'Employee', 10, 9, 'Yes', 'Yes', 1, '7.00', '9592.11', '319.74', 'Fixed', '1351.03', 'No', NULL, NULL, 'Yes', '744.36', '46078720662335', 'Cach', 'No', NULL, '90584 Reynolds Ville\nLake Carol, UT 09712', 0, 'Divorced', NULL, '0444415', 'Yes', NULL, 6, 'Hyman Hessel', '30034337114703', 'Destinistad', '2027-11-19', NULL, NULL, NULL, NULL, NULL, 375308471, 0, 0, 1, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(57, 3695, 2671, 'جمانة رياض حسين', 'Female', 2, 4, 1, '2006', 'الهندسة', 'Fair', '2021-06-03', '47600180408810', '2028-06-27', 'South Danykaport', 6, 'Muslim', 1, 'juana79@example.com', 1, 14, 15, '0235971063', '0231559817', '01008167672', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '43149996388917', 'No', NULL, NULL, '2021-09-29', 'Employee', 9, 2, 'No', 'Yes', 3, '7.00', '24928.70', '830.96', 'Fixed', '1175.97', 'No', NULL, NULL, 'Yes', '604.04', '97305836254785', 'Cach', 'Yes', NULL, '97685 Asha Pike Apt. 658\nBechtelarbury, MS 15240-1483', 0, 'Divorced', NULL, '48280244316', 'Yes', NULL, 4, 'Miss Jazlyn Deckow', '52348889902566', 'South Vanshire', '2025-01-29', NULL, NULL, NULL, NULL, NULL, 62459062, 0, 0, 2, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(58, 6834, 1503, 'ميادة عبدالحكيم صهيب', 'Female', 3, 1, 4, '2002', 'الرياضيات', 'Excellent', '2020-01-15', '50015079283462', '2025-04-04', 'Port Rorytown', 3, 'Muslim', 9, 'twila.krajcik@example.com', 3, 3, 5, '0221989874', '0235715695', '01502999020', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '94129681642455', 'No', NULL, NULL, '2022-11-24', 'Employee', 5, 5, 'Yes', 'No', 3, '12.00', '13168.92', '438.96', 'Fixed', '1513.38', 'No', NULL, NULL, 'Yes', '765.32', '40386049847168', 'Visa', 'Yes', NULL, '35760 Madelynn Port\nZiemannhaven, MO 52422-3091', 0, 'Divorced', NULL, '087935', 'Yes', NULL, 4, 'Mabelle Senger', '07006261916499', 'Olsonhaven', '2025-12-28', NULL, NULL, NULL, NULL, NULL, 1595350392, 0, 0, 3, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(59, 8533, 2622, 'فاطمة سامي عدنان', 'Female', 4, 3, 4, '1974', 'الهندسة', 'Excellent', '2014-03-14', '85964323204635', '2026-01-05', 'Hagenesburgh', 3, 'Muslim', 1, 'charlotte.kuphal@example.org', 5, 14, 3, '0234589825', '0228596090', '01105914783', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '75631059317385', 'Yes', NULL, NULL, '2022-06-14', 'Employee', 3, 10, 'Yes', 'Yes', 4, '12.00', '35248.08', '1174.94', 'Changeable', NULL, 'Yes', '943.89', '10527290484188', 'Yes', '621.02', '69795484076595', 'Visa', 'Yes', NULL, '963 Margarete Square\nEast Rey, KS 91559-3793', 0, 'Widowed', NULL, '26224859', 'Yes', NULL, 5, 'Prof. Damion Wolff', '53558624419467', 'Lake Elfrieda', '2026-02-21', NULL, NULL, NULL, NULL, NULL, 195157997, 0, 0, 1, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49');
INSERT INTO `employees` (`id`, `employee_code`, `fp_code`, `name`, `gender`, `branch_id`, `job_grade_id`, `qualification_id`, `qualification_year`, `major`, `graduation_estimate`, `brith_date`, `national_id`, `end_national_id`, `national_id_place`, `blood_types_id`, `religion`, `language_id`, `email`, `country_id`, `governorate_id`, `city_id`, `home_telephone`, `work_telephone`, `mobile`, `military`, `military_date_from`, `military_date_to`, `military_wepon`, `military_exemption_date`, `military_exemption_reason`, `military_postponement_reason`, `date_resignation`, `resignation_reason`, `driving_license`, `driving_license_type`, `driving_License_id`, `has_relatives`, `relatives_details`, `notes`, `work_start_date`, `functional_status`, `department_id`, `job_categories_id`, `has_attendance`, `has_fixed_shift`, `shift_types_id`, `daily_work_hour`, `salary`, `day_price`, `motivation_type`, `motivation`, `social_insurance`, `social_insurance_cut_monthely`, `social_insurance_number`, `medical_insurance`, `medical_insurance_cut_monthely`, `medical_insurance_number`, `Type_salary_receipt`, `active_vacation`, `urgent_person_details`, `staies_address`, `children_number`, `social_status`, `resignation_id`, `bank_number_account`, `disabilities`, `disabilities_type`, `nationality_id`, `name_sponsor`, `pasport_identity`, `pasport_from_place`, `pasport_exp_date`, `num_vacation_days`, `add_service`, `years_service`, `cv`, `basic_address_country`, `fixed_allowances`, `is_done_Vacation_formula`, `is_Sensitive_manager_data`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(60, 4202, 905, 'شهد يوسف أيوب', 'Female', 2, 4, 1, '1983', 'الهندسة', 'Good', '2014-09-29', '09436010919466', '2028-03-14', 'New Kayleigh', 2, 'Muslim', 10, 'schamberger.sallie@example.com', 4, 5, 7, '0237622657', '0230428076', '01118966343', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '27170670981140', 'Yes', NULL, NULL, '2023-08-24', 'Employee', 10, 8, 'Yes', 'No', 4, '12.00', '9513.51', '317.12', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '50252 Garfield Ways\nArnotown, DC 97076', 0, 'Divorced', NULL, '00674020', 'Yes', NULL, 2, 'Miss Jayda Deckow Jr.', '85757517824040', 'Leonelhaven', '2025-03-15', NULL, NULL, NULL, NULL, NULL, 1426171770, 0, 0, 3, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(61, 5105, 1659, 'حاتم زين إسماعيل', 'Male', 2, 2, 1, '1974', 'الرياضيات', 'Very_Good', '2010-05-12', '89200294934072', '2027-10-23', 'Melanyborough', 6, 'Muslim', 8, 'wisoky.elijah@example.org', 3, 27, 15, '0232923154', '0220922113', '01251440486', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '60171962299602', 'Yes', NULL, NULL, '2023-06-08', 'Employee', 10, 1, 'No', 'Yes', 1, '11.00', '43354.30', '1445.14', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '905.67', '58583738629197', 'Visa', 'Yes', NULL, '4346 Brad Street\nWest Elbertshire, MS 15996', 0, 'Married', NULL, '4592662324184', 'Yes', NULL, 5, 'Savanah Simonis', '94761768376121', 'Terryhaven', '2029-12-02', NULL, NULL, NULL, NULL, NULL, 1591660266, 0, 0, 3, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(62, 4775, 210, 'روز أكرم صهيب', 'Female', 3, 3, 1, '1996', 'علوم الحاسوب', 'Very_Good', '2003-04-10', '36712115228636', '2025-12-21', 'East Zanderton', 1, 'Muslim', 10, 'eliza67@example.org', 5, 17, 11, '0225420211', '0220238224', '01241392337', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '63225325194454', 'Yes', NULL, NULL, '2022-07-17', 'Employee', 8, 10, 'No', 'Yes', 1, '8.00', '16244.79', '541.49', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '975.91', '46404216460578', 'Visa', 'No', NULL, '821 Lance Islands\nRachelshire, OR 55140', 0, 'Widowed', NULL, '0574706068', 'Yes', NULL, 5, 'Maurine Hoeger', '14994360253222', 'Annaliseshire', '2028-02-03', NULL, NULL, NULL, NULL, NULL, 1986213795, 0, 0, 4, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(63, 7430, 660, 'سهى ربيع يوسف', 'Female', 4, 3, 1, '1976', 'الفيزياء', 'Fair', '2014-05-18', '06114041583586', '2026-02-12', 'New Rodrickfurt', 5, 'Muslim', 1, 'kaleigh.fahey@example.net', 2, 17, 8, '0228625047', '0231855192', '01547920948', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '91038557188568', 'Yes', NULL, NULL, '2021-12-14', 'Employee', 7, 7, 'No', 'Yes', 1, '12.00', '19383.54', '646.12', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '667.53', '69103982531098', 'Cach', 'Yes', NULL, '81764 Waelchi Prairie\nWalkerberg, IN 99104-1612', 0, 'Single', NULL, '1267597613304', 'Yes', NULL, 3, 'Daphnee Ward', '19812710253022', 'New Eastonchester', '2028-04-29', NULL, NULL, NULL, NULL, NULL, 1038117566, 0, 0, 1, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(64, 2147, 2714, 'وجيه إسماعيل رشيد', 'Male', 3, 3, 4, '1989', 'علم الأحياء', 'Good', '2008-02-15', '25956477544005', '2029-11-23', 'Nienowport', 1, 'Muslim', 2, 'lullrich@example.net', 3, 21, 1, '0231231031', '0222779226', '01031144058', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '21665951299035', 'No', NULL, NULL, '2022-12-26', 'Employee', 8, 5, 'No', 'Yes', 1, '7.00', '41016.02', '1367.20', 'Changeable', NULL, 'Yes', '715.84', '12359640173393', 'No', NULL, NULL, 'Cach', 'No', NULL, '880 Rita Locks\nBaumbachbury, KS 02252', 0, 'Single', NULL, '24443429869864', 'Yes', NULL, 4, 'Nathaniel Yost', '96337608609893', 'North Charlie', '2028-02-28', NULL, NULL, NULL, NULL, NULL, 1198925296, 0, 0, 2, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(65, 1258, 2465, 'ليان سعيد عبدالرزاق', 'Female', 1, 3, 2, '1999', 'الفيزياء', 'Very_Good', '2022-06-30', '23757653331069', '2027-07-11', 'Durganborough', 5, 'Christian', 1, 'cicero13@example.net', 2, 7, 9, '0234555997', '0225957036', '01524098689', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '70813420228939', 'Yes', NULL, NULL, '2021-05-15', 'Employee', 1, 9, 'Yes', 'No', 3, '9.00', '28674.05', '955.80', 'Fixed', '1676.92', 'Yes', '806.07', '51506850297500', 'Yes', '979.22', '90851501301670', 'Visa', 'No', NULL, '541 Effie Turnpike\nEast Wayneborough, SD 98697', 0, 'Married', NULL, '284887118', 'Yes', NULL, 6, 'Verlie Kuvalis IV', '65249755771477', 'Kulasview', '2029-04-14', NULL, NULL, NULL, NULL, NULL, 722886638, 0, 0, 3, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(66, 1815, 199, 'تالين إسماعيل رامي', 'Female', 4, 1, 5, '1997', 'علوم الحاسوب', 'Good', '2021-12-21', '35627651076674', '2025-01-04', 'New Mustafa', 5, 'Christian', 13, 'alayna.blick@example.com', 4, 25, 4, '0221041803', '0230083388', '01197360493', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '93275791033243', 'No', NULL, NULL, '2023-07-21', 'Employee', 9, 3, 'No', 'No', 4, '11.00', '19839.16', '661.31', 'Fixed', '1824.49', 'No', NULL, NULL, 'Yes', '644.42', '05079094126482', 'Cach', 'Yes', NULL, '84671 Waelchi Place\nAuerfurt, IL 41801', 0, 'Married', NULL, '90468837228896647', 'Yes', NULL, 6, 'Wilton Sauer V', '07742146819263', 'South Imogene', '2029-09-14', NULL, NULL, NULL, NULL, NULL, 719190412, 0, 0, 4, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(67, 9740, 49, 'محمود وائل سامي', 'Male', 3, 2, 3, '1982', 'علم الأحياء', 'Good', '2014-06-02', '23257597844240', '2026-12-19', 'Mullerborough', 7, 'Christian', 3, 'cecile.zboncak@example.org', 1, 13, 11, '0237759396', '0235576796', '01015469232', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '42875199730245', 'Yes', NULL, NULL, '2022-09-03', 'Employee', 6, 2, 'Yes', 'Yes', 4, '12.00', '13627.75', '454.26', 'Fixed', '1626.66', 'No', NULL, NULL, 'Yes', '815.07', '31474779769574', 'Visa', 'Yes', NULL, '854 Moore Meadow\nLeonetown, ME 08127-8678', 0, 'Divorced', NULL, '225075392765', 'Yes', NULL, 4, 'Dario Pagac', '20536815731372', 'North Alivia', '2028-07-05', NULL, NULL, NULL, NULL, NULL, 2054201705, 0, 0, 2, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(68, 5317, 1942, 'ناهد معاذ أمجد', 'Female', 2, 3, 2, '2006', 'علم الأحياء', 'Fair', '2001-04-12', '14660392004694', '2026-12-04', 'South Codyville', 1, 'Muslim', 10, 'zgutkowski@example.org', 3, 18, 6, '0221393202', '0224799643', '01523452310', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '96175159431375', 'Yes', NULL, NULL, '2020-04-21', 'Employee', 9, 5, 'Yes', 'No', 1, '7.00', '13652.01', '455.07', 'Fixed', '1361.26', 'No', NULL, NULL, 'Yes', '651.33', '43844123843771', 'Cach', 'Yes', NULL, '329 Jayson Spurs\nKeeleyton, UT 66658', 0, 'Single', NULL, '9716020407564', 'Yes', NULL, 1, 'Kaylee Becker', '66595996874218', 'New Jonatan', '2027-11-12', NULL, NULL, NULL, NULL, NULL, 2008356499, 0, 0, 3, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(69, 1515, 909, 'طلال حذيفة سامي', 'Male', 1, 3, 3, '1988', 'علم الأحياء', 'Excellent', '2001-01-01', '53332320344716', '2028-08-13', 'Port Rosalee', 3, 'Christian', 9, 'chase52@example.org', 1, 23, 10, '0238229941', '0225369844', '01017234785', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '64527778855319', 'No', NULL, NULL, '2022-04-09', 'Employee', 1, 10, 'No', 'No', 3, '10.00', '16902.08', '563.40', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '684 Linda Valleys Suite 961\nEast Theodore, TX 26631', 0, 'Married', NULL, '28294670', 'Yes', NULL, 4, 'Kacie Rippin', '23914094284984', 'Lake Haskellstad', '2027-03-16', NULL, NULL, NULL, NULL, NULL, 189172956, 0, 0, 4, NULL, 1, '2024-12-12 15:30:49', '2024-12-12 15:30:49'),
(70, 4688, 871, 'أحمد بدر منصور', 'Male', 4, 1, 4, '1996', 'علوم الحاسوب', 'Very_Good', '2020-02-11', '21609499480880', '2028-10-18', 'Haagbury', 7, 'Muslim', 4, 'ikoepp@example.org', 3, 3, 3, '0227842128', '0221260613', '01277363831', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '77722037074974', 'Yes', NULL, NULL, '2020-09-03', 'Employee', 5, 2, 'Yes', 'No', 4, '10.00', '46361.36', '1545.38', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '923.45', '23728957808237', 'Cach', 'Yes', NULL, '12180 Guy Villages\nEast Ladarius, AZ 50262-9518', 0, 'Widowed', NULL, '060588302', 'Yes', NULL, 4, 'Ashlynn Nikolaus', '60737588403242', 'Hillfurt', '2025-12-16', NULL, NULL, NULL, NULL, NULL, 439940888, 0, 0, 4, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(71, 7697, 2858, 'طارق رامي أديب', 'Male', 4, 1, 6, '1974', 'الهندسة', 'Good', '2008-01-04', '38250738931851', '2025-10-12', 'East Dayne', 5, 'Christian', 6, 'sofia13@example.com', 6, 8, 12, '0238457550', '0239449407', '01101554936', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '62988985922889', 'Yes', NULL, NULL, '2024-08-23', 'Employee', 1, 8, 'No', 'Yes', 4, '7.00', '21598.56', '719.95', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '847.05', '30796717937684', 'Visa', 'No', NULL, '1021 Kirstin Throughway Apt. 960\nBroderickhaven, VA 00806', 0, 'Single', NULL, '54226313687', 'Yes', NULL, 1, 'Miss Alexandra Koch', '24793356061365', 'Kuhnmouth', '2026-10-23', NULL, NULL, NULL, NULL, NULL, 2143557225, 0, 0, 1, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(72, 6427, 1130, 'حسين عبدالفتاح وائل', 'Male', 3, 1, 2, '2005', 'إدارة الأعمال', 'Fair', '2011-10-15', '79728904834640', '2026-11-09', 'Bennetthaven', 1, 'Muslim', 12, 'kmcclure@example.org', 1, 7, 14, '0238232451', '0225191063', '01249222506', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '33592637434105', 'Yes', NULL, NULL, '2024-12-02', 'Employee', 2, 2, 'Yes', 'Yes', 2, '10.00', '18697.73', '623.26', 'Fixed', '1589.54', 'Yes', '809.10', '55492795727672', 'No', NULL, NULL, 'Cach', 'No', NULL, '8761 Schuppe Corners\nNew Bell, IN 15335', 0, 'Widowed', NULL, '580486362564916', 'Yes', NULL, 6, 'Anais Flatley MD', '41767393180405', 'Lake Celiaside', '2028-04-02', NULL, NULL, NULL, NULL, NULL, 1819863641, 0, 0, 3, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(73, 7006, 1243, 'تالين باسل حذيفة', 'Female', 3, 2, 6, '1995', 'علم الأحياء', 'Excellent', '2005-08-01', '70548873751799', '2026-02-01', 'Lake Jazmyne', 7, 'Christian', 8, 'clement.conroy@example.net', 6, 5, 11, '0223391553', '0236320140', '01204867624', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '24142158472707', 'No', NULL, NULL, '2022-03-24', 'Employee', 5, 7, 'Yes', 'Yes', 2, '10.00', '16048.48', '534.95', 'Changeable', NULL, 'Yes', '862.65', '72627199234222', 'Yes', '913.56', '28117543544543', 'Visa', 'Yes', NULL, '61581 Bonita Ramp Suite 588\nEast Mara, KS 37942-0573', 0, 'Widowed', NULL, '7780677713232', 'Yes', NULL, 2, 'Donnell Terry', '40557210935242', 'Janetstad', '2029-08-07', NULL, NULL, NULL, NULL, NULL, 1292624940, 0, 0, 4, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(74, 3084, 572, 'عمر أحمد عبدالله', 'Male', 4, 2, 5, '1977', 'علم الأحياء', 'Very_Good', '2015-01-24', '64794066117422', '2028-01-16', 'East Collinland', 2, 'Christian', 7, 'augusta62@example.net', 5, 15, 8, '0220662397', '0230351294', '01179469886', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '87056569521825', 'No', NULL, NULL, '2021-07-04', 'Employee', 5, 1, 'No', 'Yes', 4, '9.00', '34528.11', '1150.94', 'Fixed', '1647.94', 'Yes', '710.72', '00493128100902', 'No', NULL, NULL, 'Visa', 'No', NULL, '7497 Elena River\nAngusstad, MT 97724', 0, 'Widowed', NULL, '852240118805', 'Yes', NULL, 4, 'Britney Jakubowski', '15110099487747', 'South Cliftonport', '2026-12-29', NULL, NULL, NULL, NULL, NULL, 1466011592, 0, 0, 3, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(75, 1826, 1022, 'تالين نبيل هيثم', 'Female', 3, 2, 2, '1980', 'الرياضيات', 'Very_Good', '2010-08-22', '10420699116072', '2025-06-12', 'Lucieland', 6, 'Muslim', 1, 'mohammed.kerluke@example.org', 1, 5, 3, '0236829490', '0227239600', '01583460628', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '30233725892233', 'Yes', NULL, NULL, '2021-10-14', 'Employee', 10, 4, 'Yes', 'No', 4, '10.00', '41576.29', '1385.88', 'Fixed', '1895.08', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '79052 Hane Village\nPort Ransom, DC 55842', 0, 'Widowed', NULL, '4698132901', 'Yes', NULL, 2, 'Dr. Emily Abbott PhD', '33577055468512', 'Gulgowskiburgh', '2027-04-21', NULL, NULL, NULL, NULL, NULL, 1597461395, 0, 0, 4, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(76, 3307, 1431, 'هيثم عبدالحكيم طلال', 'Male', 3, 2, 3, '1985', 'علوم الحاسوب', 'Excellent', '2006-01-03', '46051083585301', '2029-07-08', 'North Derek', 3, 'Muslim', 2, 'kaley61@example.net', 2, 3, 8, '0229376937', '0220506568', '01262060555', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '42884585808100', 'No', NULL, NULL, '2022-10-27', 'Employee', 2, 5, 'No', 'Yes', 4, '7.00', '21343.51', '711.45', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '903.70', '44360795274763', 'Visa', 'Yes', NULL, '832 Drake Mission Suite 774\nChristianabury, ME 71290-0094', 0, 'Married', NULL, '904857554970', 'Yes', NULL, 2, 'Denis Casper PhD', '91531487519755', 'Jadynhaven', '2026-09-16', NULL, NULL, NULL, NULL, NULL, 937353555, 0, 0, 4, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(77, 3704, 1124, 'نادية عبدالله رائد', 'Female', 2, 1, 2, '2010', 'علم الأحياء', 'Excellent', '2007-02-13', '90144769598821', '2027-01-14', 'Carlosmouth', 2, 'Christian', 1, 'pmcdermott@example.com', 2, 4, 7, '0239001170', '0239127823', '01023449901', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '22372991290420', 'Yes', NULL, NULL, '2023-04-13', 'Employee', 8, 4, 'No', 'No', 4, '10.00', '12459.41', '415.31', 'Fixed', '1985.44', 'Yes', '788.90', '82224357901826', 'Yes', '745.74', '38829356770786', 'Cach', 'No', NULL, '5927 Vandervort Squares\nCruickshankland, NH 58463', 0, 'Divorced', NULL, '1461506131', 'Yes', NULL, 2, 'Esperanza Welch', '44231253724589', 'West Reillyview', '2027-09-24', NULL, NULL, NULL, NULL, NULL, 638636855, 0, 0, 3, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(78, 7332, 2274, 'أنور أديب أحمد', 'Male', 3, 4, 4, '1981', 'علم الأحياء', 'Fair', '2013-01-06', '97981663957081', '2026-05-30', 'Lake Aracelyside', 6, 'Muslim', 13, 'brody81@example.net', 4, 14, 13, '0220520484', '0229590146', '01188283823', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '10973955587693', 'No', NULL, NULL, '2022-04-16', 'Employee', 1, 4, 'No', 'Yes', 1, '8.00', '15604.63', '520.15', 'Fixed', '1261.11', 'Yes', '748.50', '42991319950636', 'Yes', '816.66', '35881786400703', 'Visa', 'No', NULL, '1863 Schumm Islands\nLake Thoraland, VT 43936', 0, 'Single', NULL, '6289747759', 'Yes', NULL, 5, 'Joseph Veum II', '17375330489735', 'South Irmaberg', '2028-01-19', NULL, NULL, NULL, NULL, NULL, 298095559, 0, 0, 1, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(79, 1919, 502, 'سلمى شاكر حسن', 'Female', 2, 4, 2, '1975', 'الرياضيات', 'Fair', '2013-09-08', '55192372052989', '2028-12-24', 'West Gerardofort', 7, 'Muslim', 12, 'cortez.parker@example.org', 3, 6, 7, '0223672043', '0221090488', '01099869456', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '11941538974342', 'Yes', NULL, NULL, '2021-08-18', 'Employee', 6, 2, 'Yes', 'No', 1, '9.00', '29322.66', '977.42', 'Fixed', '1606.60', 'No', NULL, NULL, 'Yes', '586.45', '36537162320079', 'Visa', 'No', NULL, '367 Parker Canyon Suite 683\nNew Khalidton, SC 22588-2350', 0, 'Widowed', NULL, '86748790183', 'Yes', NULL, 1, 'Amani Herzog', '85720573576480', 'Croninton', '2028-08-17', NULL, NULL, NULL, NULL, NULL, 1807154313, 0, 0, 2, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(80, 9166, 1044, 'جوري حسن أيمن', 'Female', 4, 3, 6, '2002', 'الهندسة', 'Fair', '2018-12-01', '69126320187315', '2029-05-16', 'Eichmannton', 5, 'Christian', 7, 'eveline79@example.com', 2, 20, 12, '0220744812', '0237606820', '01272719016', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '79560781307241', 'No', NULL, NULL, '2022-05-02', 'Employee', 8, 1, 'Yes', 'No', 3, '7.00', '18029.35', '600.98', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '944.35', '13295796102807', 'Visa', 'No', NULL, '54842 O\'Hara Way\nPort Germaineland, NM 75693-2850', 0, 'Widowed', NULL, '87217692109328', 'Yes', NULL, 3, 'Isabel Jacobs II', '41474969859712', 'West Jerel', '2026-10-12', NULL, NULL, NULL, NULL, NULL, 439096479, 0, 0, 2, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(81, 6421, 1404, 'مارين عبدالكريم عماد', 'Female', 3, 4, 6, '2002', 'الرياضيات', 'Good', '2018-11-17', '87395125651238', '2027-07-01', 'East Lorenborough', 4, 'Christian', 8, 'boyle.odie@example.net', 4, 7, 6, '0236977680', '0226556651', '01267538066', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '48840949766809', 'No', NULL, NULL, '2022-11-12', 'Employee', 3, 4, 'No', 'No', 2, '8.00', '34075.94', '1135.86', 'Fixed', '1786.26', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '79225 Marcellus Island Apt. 128\nWintheisershire, SC 88166', 0, 'Widowed', NULL, '0375202073', 'Yes', NULL, 6, 'Angela O\'Conner', '15416279909756', 'Kundemouth', '2029-10-20', NULL, NULL, NULL, NULL, NULL, 1954024457, 0, 0, 4, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(82, 7244, 1988, 'وسام نور عبدالحميد', 'Female', 4, 4, 5, '1991', 'الهندسة', 'Good', '2004-12-19', '57328771009762', '2029-05-28', 'Emeraldmouth', 3, 'Christian', 6, 'wkautzer@example.net', 5, 23, 6, '0228612985', '0225653604', '01508034767', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '96810549606907', 'No', NULL, NULL, '2024-08-30', 'Employee', 8, 9, 'No', 'Yes', 4, '12.00', '19200.75', '640.03', 'Fixed', '1402.16', 'Yes', '975.60', '26537939366508', 'No', NULL, NULL, 'Visa', 'No', NULL, '2579 Ward Plaza Apt. 835\nNew Samstad, MT 92447', 0, 'Married', NULL, '64565125791650', 'Yes', NULL, 5, 'Prof. Khalid Upton I', '72037253462924', 'New Earlene', '2026-02-01', NULL, NULL, NULL, NULL, NULL, 1976202542, 0, 0, 3, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(83, 4556, 2655, 'شاكر منصور ربيع', 'Male', 3, 4, 4, '2000', 'الرياضيات', 'Good', '2022-01-16', '81487148128310', '2028-06-22', 'Sawaynburgh', 3, 'Christian', 6, 'bechtelar.edgar@example.net', 6, 18, 15, '0232058131', '0226957514', '01054443311', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '37395747190630', 'Yes', NULL, NULL, '2020-04-24', 'Employee', 10, 10, 'No', 'No', 4, '9.00', '18368.61', '612.29', 'Fixed', '1881.29', 'No', NULL, NULL, 'Yes', '641.21', '28196683078683', 'Cach', 'Yes', NULL, '7811 Samanta Mews\nWest Christopherview, WA 26755', 0, 'Single', NULL, '87058531124', 'Yes', NULL, 6, 'Mr. Norris Graham', '41306433540651', 'East Dallinside', '2026-12-25', NULL, NULL, NULL, NULL, NULL, 317303180, 0, 0, 1, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(84, 3444, 2601, 'توفيق مالك عبدالفتاح', 'Male', 1, 3, 5, '2010', 'الرياضيات', 'Very_Good', '2012-03-29', '20912426083769', '2028-01-16', 'Estellaside', 3, 'Christian', 6, 'seamus00@example.com', 1, 1, 12, '0225751712', '0234796469', '01570409533', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '04005016641294', 'No', NULL, NULL, '2022-05-24', 'Employee', 1, 5, 'Yes', 'Yes', 1, '9.00', '27895.94', '929.86', 'Changeable', NULL, 'Yes', '986.20', '06365586056148', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '894 Quitzon Summit\nAllanfort, SC 93881', 0, 'Widowed', NULL, '904181616616337', 'Yes', NULL, 2, 'Mr. Julius Bailey Sr.', '16928228399583', 'East Martineshire', '2025-09-06', NULL, NULL, NULL, NULL, NULL, 786939347, 0, 0, 4, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(85, 7737, 2826, 'فاطمة طارق أيوب', 'Female', 4, 2, 5, '1998', 'الرياضيات', 'Good', '2008-08-25', '94468831858033', '2025-04-11', 'Hageneston', 4, 'Christian', 11, 'bogisich.rosina@example.net', 6, 9, 2, '0226063104', '0236253385', '01585706715', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '94766812281163', 'Yes', NULL, NULL, '2023-03-22', 'Employee', 1, 4, 'No', 'Yes', 3, '7.00', '13265.15', '442.17', 'Fixed', '1740.36', 'Yes', '734.65', '93053053016457', 'Yes', '749.97', '03132484564504', 'Visa', 'No', NULL, '77993 Leilani Keys\nKoryfurt, KS 48965-6030', 0, 'Widowed', NULL, '882507566', 'Yes', NULL, 2, 'Genesis Kuhlman', '45153562006007', 'Christiansenshire', '2026-05-08', NULL, NULL, NULL, NULL, NULL, 323326025, 0, 0, 4, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(86, 8355, 968, 'سارة رشيد إسماعيل', 'Female', 4, 3, 5, '1983', 'الفيزياء', 'Excellent', '2022-02-17', '10256516958812', '2026-09-01', 'West Daijaton', 5, 'Christian', 7, 'brenda.medhurst@example.com', 1, 2, 9, '0229241054', '0237170796', '01142265775', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '95006951958503', 'No', NULL, NULL, '2023-06-23', 'Employee', 2, 9, 'Yes', 'Yes', 3, '10.00', '28285.51', '942.85', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '2629 Berge Squares Apt. 363\nStiedemannville, NE 85447', 0, 'Divorced', NULL, '7024537', 'Yes', NULL, 6, 'Prof. Brisa Nolan IV', '92591809836568', 'Port Shyannfurt', '2027-02-01', NULL, NULL, NULL, NULL, NULL, 1143971325, 0, 0, 1, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(87, 1668, 2337, 'عبدالفتاح منصور محمود', 'Male', 1, 3, 2, '1975', 'علم الأحياء', 'Good', '2005-05-12', '92360143435347', '2027-04-14', 'Klingburgh', 2, 'Christian', 4, 'malvina.feil@example.org', 6, 9, 13, '0222860931', '0226886990', '01508727984', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '97248974661296', 'No', NULL, NULL, '2022-10-08', 'Employee', 4, 6, 'Yes', 'Yes', 1, '9.00', '31891.51', '1063.05', 'Fixed', '1620.22', 'No', NULL, NULL, 'Yes', '565.14', '72167373681956', 'Visa', 'No', NULL, '990 Myrtice Loaf Apt. 464\nKesslerchester, VA 65044', 0, 'Widowed', NULL, '7962181564', 'Yes', NULL, 3, 'Stella Walker', '44505613994506', 'Lake Lonny', '2026-11-05', NULL, NULL, NULL, NULL, NULL, 904945486, 0, 0, 1, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(88, 4923, 1766, 'مريم زيد عبدالحكيم', 'Female', 3, 2, 5, '1985', 'الرياضيات', 'Very_Good', '2019-06-11', '52035268165961', '2029-10-02', 'Frederikville', 7, 'Muslim', 1, 'yasmeen05@example.com', 2, 19, 6, '0237263320', '0225338571', '01035763648', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '21578100527178', 'Yes', NULL, NULL, '2020-02-01', 'Employee', 9, 7, 'Yes', 'No', 4, '11.00', '8937.05', '297.90', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '702 Annie Ports\nNew Victoria, MA 12073-3598', 0, 'Single', NULL, '69179872473654', 'Yes', NULL, 2, 'Edmond Aufderhar', '90286983008343', 'Lake Vernie', '2028-06-25', NULL, NULL, NULL, NULL, NULL, 399802818, 0, 0, 2, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(89, 5611, 1892, 'رفيق رياض رشيد', 'Male', 2, 2, 3, '1981', 'الفيزياء', 'Good', '2003-08-01', '26112022878962', '2028-02-23', 'Bethshire', 5, 'Muslim', 4, 'janice81@example.com', 4, 22, 2, '0224336927', '0232903801', '01088258691', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '95718434061747', 'Yes', NULL, NULL, '2021-12-11', 'Employee', 8, 1, 'No', 'Yes', 2, '12.00', '23169.70', '772.32', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '4070 Buddy Vista\nNickolasmouth, NV 65733', 0, 'Widowed', NULL, '3220239235543', 'Yes', NULL, 6, 'Giovanni Veum', '69043899853849', 'Port Westonborough', '2029-03-01', NULL, NULL, NULL, NULL, NULL, 1759813655, 0, 0, 3, NULL, 1, '2024-12-12 15:30:50', '2024-12-12 15:30:50'),
(90, 1605, 2583, 'باسم حسين محمد', 'Male', 2, 1, 4, '1982', 'الفيزياء', 'Good', '2023-09-16', '92710080741870', '2025-12-16', 'West Eleazar', 6, 'Muslim', 11, 'akoch@example.org', 1, 24, 6, '0231233388', '0221775241', '01272233167', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '95100775941793', 'Yes', NULL, NULL, '2023-03-24', 'Employee', 9, 2, 'No', 'Yes', 1, '11.00', '20950.76', '698.36', 'Fixed', '1647.10', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '7813 McDermott Road\nHamillfort, NE 37163-8178', 0, 'Single', NULL, '4553526263', 'Yes', NULL, 2, 'Lyda Hahn', '79166729323150', 'Kulasbury', '2027-12-08', NULL, NULL, NULL, NULL, NULL, 1505406225, 0, 0, 1, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(91, 3427, 121, 'سعاد باسل شريف', 'Female', 4, 2, 3, '1986', 'الفيزياء', 'Good', '2018-12-25', '31532344647271', '2028-08-25', 'South Ollie', 1, 'Muslim', 6, 'jreichert@example.org', 1, 16, 13, '0221157661', '0237720135', '01065974332', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '28904718294520', 'No', NULL, NULL, '2021-07-22', 'Employee', 2, 1, 'Yes', 'Yes', 1, '10.00', '22841.64', '761.39', 'Fixed', '1271.51', 'No', NULL, NULL, 'Yes', '830.08', '17946637454239', 'Cach', 'Yes', NULL, '6968 Merlin Roads\nMarjoryview, KS 19981-7693', 0, 'Widowed', NULL, '2725419', 'Yes', NULL, 1, 'Alexis Huels', '32923949263422', 'Lake Effiefort', '2029-02-06', NULL, NULL, NULL, NULL, NULL, 320088834, 0, 0, 4, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(92, 1923, 2463, 'حسن توفيق عبدالله', 'Male', 2, 2, 1, '1988', 'الفيزياء', 'Excellent', '2017-01-15', '70743586177898', '2028-08-15', 'Coltonchester', 1, 'Christian', 12, 'hazel33@example.org', 3, 19, 8, '0221114283', '0233835330', '01189674243', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '99145286298804', 'Yes', NULL, NULL, '2024-04-14', 'Employee', 5, 1, 'No', 'No', 1, '8.00', '33155.05', '1105.17', 'Fixed', '1677.63', 'Yes', '636.71', '12252211401811', 'Yes', '633.30', '08212265181154', 'Cach', 'Yes', NULL, '376 Violette Stream Suite 787\nSouth Juwanshire, IN 70161', 0, 'Divorced', NULL, '92880838874', 'Yes', NULL, 3, 'Ulices Howell', '83175939864441', 'Satterfieldland', '2029-06-02', NULL, NULL, NULL, NULL, NULL, 1932612625, 0, 0, 4, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(93, 2345, 2801, 'إيمان حامد حسن', 'Female', 3, 3, 3, '1984', 'الهندسة', 'Good', '2018-12-19', '65228973966029', '2027-05-07', 'Birdieton', 2, 'Christian', 5, 'freynolds@example.net', 3, 25, 12, '0228397821', '0228901454', '01177976934', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '35176885756275', 'Yes', NULL, NULL, '2023-06-01', 'Employee', 10, 3, 'Yes', 'Yes', 4, '7.00', '38290.66', '1276.36', 'Changeable', NULL, 'Yes', '543.98', '71337225733586', 'No', NULL, NULL, 'Visa', 'No', NULL, '14218 Huels Land Apt. 242\nKaliborough, ID 41800', 0, 'Widowed', NULL, '3764228824582', 'Yes', NULL, 3, 'Elroy Koepp I', '82869767271582', 'South Toneyborough', '2025-03-28', NULL, NULL, NULL, NULL, NULL, 285035650, 0, 0, 3, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(94, 5115, 545, 'صابرين قاسم رامز', 'Female', 1, 1, 4, '1985', 'الهندسة', 'Fair', '2020-05-08', '51870716956313', '2026-11-02', 'Wizaport', 4, 'Christian', 10, 'emma60@example.net', 1, 26, 6, '0225850221', '0221689895', '01087164459', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '39310551088008', 'Yes', NULL, NULL, '2020-07-17', 'Employee', 8, 5, 'No', 'No', 1, '9.00', '49751.45', '1658.38', 'Changeable', NULL, 'Yes', '755.65', '25960722369031', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '6083 Beer Trace Suite 411\nPort Rachel, MN 28551', 0, 'Married', NULL, '2284755965', 'Yes', NULL, 4, 'Mr. Rupert Beer', '05641014905227', 'West Lauriannemouth', '2029-03-09', NULL, NULL, NULL, NULL, NULL, 1965693603, 0, 0, 3, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(95, 2750, 2749, 'نور سهيل حاتم', 'Male', 2, 2, 6, '1980', 'الهندسة', 'Excellent', '2006-03-14', '85051296343875', '2026-02-12', 'West Leonora', 6, 'Christian', 11, 'litzy10@example.org', 1, 22, 11, '0227590737', '0239573976', '01009512905', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '51863768771093', 'Yes', NULL, NULL, '2023-08-07', 'Employee', 8, 4, 'No', 'Yes', 3, '11.00', '36957.07', '1231.90', 'Fixed', '1105.79', 'Yes', '739.86', '93180084600907', 'No', NULL, NULL, 'Visa', 'No', NULL, '117 Glover Squares\nNorth Catharineville, MS 47897', 0, 'Widowed', NULL, '33611130', 'Yes', NULL, 4, 'Eden Mitchell', '10960168554861', 'Kellenside', '2029-05-21', NULL, NULL, NULL, NULL, NULL, 223155034, 0, 0, 3, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(96, 9255, 302, 'أميرة يوسف بكر', 'Female', 1, 2, 3, '1986', 'الرياضيات', 'Very_Good', '2002-03-18', '96747495329980', '2025-07-18', 'North Elsefort', 6, 'Muslim', 1, 'kautzer.cloyd@example.net', 1, 5, 8, '0221120384', '0229006400', '01584790063', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '93470325864870', 'No', NULL, NULL, '2022-07-14', 'Employee', 4, 3, 'Yes', 'No', 4, '11.00', '9642.57', '321.42', 'Fixed', '1808.00', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '989 Maggio Via\nRettamouth, LA 34078', 0, 'Divorced', NULL, '00960744156', 'Yes', NULL, 6, 'Noel Kub', '68808546317832', 'Port Brenda', '2025-06-15', NULL, NULL, NULL, NULL, NULL, 1731727988, 0, 0, 4, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(97, 3025, 1507, 'وجيه بدر إلياس', 'Male', 2, 2, 4, '1971', 'علوم الحاسوب', 'Fair', '2016-08-04', '94627823946731', '2029-10-14', 'Freidabury', 7, 'Muslim', 5, 'jmitchell@example.org', 6, 23, 9, '0233446531', '0229774632', '01241196143', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '46125954927491', 'Yes', NULL, NULL, '2021-11-01', 'Employee', 3, 3, 'Yes', 'No', 1, '10.00', '49840.16', '1661.34', 'Fixed', '1042.08', 'No', NULL, NULL, 'Yes', '721.21', '57623781581805', 'Visa', 'Yes', NULL, '6009 Aufderhar Circles\nLake Liliane, MA 55520-4661', 0, 'Widowed', NULL, '35801055723901', 'Yes', NULL, 6, 'Ms. Elizabeth Larkin V', '22453344017921', 'Wilfordburgh', '2029-03-21', NULL, NULL, NULL, NULL, NULL, 523468886, 0, 0, 1, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(98, 3537, 2701, 'عبدالكريم إبراهيم حسن', 'Male', 2, 4, 1, '1977', 'علوم الحاسوب', 'Good', '2022-05-19', '33033774207993', '2028-01-11', 'New Maxine', 6, 'Christian', 5, 'chaya79@example.org', 2, 1, 14, '0239553894', '0223699221', '01540257207', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '28056835036868', 'Yes', NULL, NULL, '2021-12-04', 'Employee', 6, 5, 'No', 'No', 2, '8.00', '16169.90', '539.00', 'Fixed', '1257.98', 'No', NULL, NULL, 'Yes', '619.50', '97987588261034', 'Visa', 'Yes', NULL, '6842 Colleen Forest Apt. 318\nPort Alexie, AL 60950-2347', 0, 'Widowed', NULL, '964891068', 'Yes', NULL, 5, 'Dr. Mya Monahan', '49930502308650', 'Johnsontown', '2029-08-27', NULL, NULL, NULL, NULL, NULL, 1660033834, 0, 0, 4, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(99, 7812, 2294, 'سيف طلال هيثم', 'Male', 4, 2, 2, '1996', 'الرياضيات', 'Fair', '2013-09-16', '86357105019151', '2028-02-05', 'New Elnamouth', 2, 'Christian', 5, 'eugenia17@example.net', 4, 25, 12, '0226890359', '0228252081', '01125651834', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '67160652207835', 'No', NULL, NULL, '2022-02-15', 'Employee', 7, 6, 'No', 'No', 3, '12.00', '38212.68', '1273.76', 'Fixed', '1600.01', 'Yes', '666.88', '04617301505476', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '742 Forest Manors\nPort Assunta, MI 72532-6064', 0, 'Divorced', NULL, '14906111462', 'Yes', NULL, 2, 'Mr. Chance Thiel', '97868797648102', 'North Monserrate', '2026-09-14', NULL, NULL, NULL, NULL, NULL, 1468131003, 0, 0, 1, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(100, 7719, 1508, 'يوسف ماهر نور', 'Male', 4, 1, 2, '1997', 'الفيزياء', 'Fair', '2008-12-18', '08244532453291', '2025-05-06', 'Kubport', 7, 'Muslim', 13, 'haskell.davis@example.org', 6, 26, 4, '0220874169', '0230116793', '01298024164', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '07020460570720', 'No', NULL, NULL, '2021-07-20', 'Employee', 6, 7, 'No', 'No', 2, '12.00', '35696.26', '1189.88', 'Changeable', NULL, 'Yes', '685.49', '00824774180440', 'No', NULL, NULL, 'Visa', 'No', NULL, '6687 Rolfson Crossing\nSouth Othafort, MO 27168-9488', 0, 'Single', NULL, '621525619346', 'Yes', NULL, 5, 'Geovany Trantow', '61413596866986', 'Turnermouth', '2029-01-19', NULL, NULL, NULL, NULL, NULL, 1092426039, 0, 0, 1, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(101, 2038, 2651, 'فايزة قاسم مالك', 'Female', 3, 4, 6, '1975', 'الرياضيات', 'Excellent', '2023-02-01', '64413864924845', '2027-05-12', 'Lake Micaelaside', 4, 'Christian', 13, 'vicky06@example.org', 3, 16, 8, '0222832975', '0235844395', '01111095091', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '78397499502226', 'No', NULL, NULL, '2022-05-09', 'Employee', 1, 6, 'Yes', 'Yes', 3, '7.00', '38274.82', '1275.83', 'Fixed', '1510.20', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '85054 Destin Estates Apt. 965\nNorth Blake, IL 17681-4807', 0, 'Married', NULL, '2170276038', 'Yes', NULL, 6, 'Dr. Julia Haley', '90112053872634', 'Lake Malachihaven', '2029-10-06', NULL, NULL, NULL, NULL, NULL, 859403565, 0, 0, 3, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(102, 3856, 173, 'لبنى أنور عبدالعزيز', 'Female', 2, 3, 2, '1978', 'الهندسة', 'Good', '2012-05-19', '77187630817674', '2028-09-02', 'Larissaside', 2, 'Muslim', 6, 'lukas.ankunding@example.net', 5, 17, 6, '0227303631', '0233337107', '01018245571', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '29961918217871', 'Yes', NULL, NULL, '2023-06-16', 'Employee', 2, 4, 'No', 'No', 4, '10.00', '13134.12', '437.80', 'Fixed', '1963.12', 'No', NULL, NULL, 'Yes', '539.09', '44030810559064', 'Visa', 'Yes', NULL, '543 Emard Shores Suite 102\nDorthyview, LA 66423-4329', 0, 'Single', NULL, '524437271', 'Yes', NULL, 6, 'Ms. Rebeka D\'Amore PhD', '79657746615825', 'Lake Anjalimouth', '2027-04-16', NULL, NULL, NULL, NULL, NULL, 737662165, 0, 0, 1, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(103, 4752, 2793, 'أمجد توفيق محمد', 'Male', 3, 4, 4, '1970', 'الفيزياء', 'Good', '2008-07-28', '37241403934264', '2025-10-03', 'South Carli', 2, 'Christian', 5, 'zhaag@example.com', 6, 6, 10, '0232724376', '0232209742', '01272967607', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '49890379279156', 'Yes', NULL, NULL, '2023-05-13', 'Employee', 6, 4, 'No', 'Yes', 4, '12.00', '24252.46', '808.42', 'Changeable', NULL, 'Yes', '513.79', '00744734123410', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '795 Bogan Streets\nPort Lonniebury, MO 33914-0994', 0, 'Married', NULL, '5587648540', 'Yes', NULL, 2, 'Felipa Treutel', '94590615249265', 'Lake Otto', '2026-11-30', NULL, NULL, NULL, NULL, NULL, 2094832885, 0, 0, 1, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(104, 2780, 2808, 'رانيا سامي سهيل', 'Female', 4, 3, 6, '1995', 'الرياضيات', 'Fair', '2010-06-30', '92193301329356', '2027-02-15', 'Paucekbury', 3, 'Christian', 10, 'ffahey@example.net', 1, 23, 15, '0228257022', '0238994592', '01161094124', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '07865189961500', 'No', NULL, NULL, '2021-06-25', 'Employee', 1, 3, 'Yes', 'Yes', 3, '11.00', '9525.15', '317.51', 'Fixed', '1468.47', 'Yes', '797.56', '78384656954681', 'Yes', '882.59', '61554460374255', 'Visa', 'Yes', NULL, '8878 Dejuan Forge Apt. 894\nEast Salmamouth, MN 50044', 0, 'Divorced', NULL, '45190682', 'Yes', NULL, 3, 'Krystal Schamberger', '26673336829328', 'Delbertland', '2028-12-27', NULL, NULL, NULL, NULL, NULL, 1344511731, 0, 0, 1, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(105, 8946, 1133, 'مازن عامر محمد', 'Male', 3, 3, 4, '1991', 'علم الأحياء', 'Good', '2024-05-25', '53077910011111', '2029-07-07', 'Marquardtfort', 1, 'Muslim', 8, 'hackett.walker@example.net', 4, 14, 8, '0237171147', '0223257579', '01561114807', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '37684638407571', 'Yes', NULL, NULL, '2021-04-05', 'Employee', 5, 3, 'Yes', 'Yes', 3, '10.00', '39754.86', '1325.16', 'Changeable', NULL, 'Yes', '587.06', '69320689912263', 'Yes', '898.91', '61693867246465', 'Cach', 'No', NULL, '95833 Kertzmann Route Suite 287\nEast Darlene, MT 93266-2672', 0, 'Widowed', NULL, '24521287', 'Yes', NULL, 4, 'Prof. Xzavier Hartmann', '84847914414222', 'Moriahmouth', '2026-04-21', NULL, NULL, NULL, NULL, NULL, 16177217, 0, 0, 2, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(106, 8860, 1593, 'سمر سامر يوسف', 'Female', 2, 1, 3, '1999', 'علم الأحياء', 'Good', '2007-08-13', '44985783931532', '2026-12-18', 'Rauland', 6, 'Muslim', 8, 'jo.grimes@example.com', 3, 5, 10, '0232205961', '0226986457', '01189959337', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '75188256557455', 'No', NULL, NULL, '2021-12-14', 'Employee', 3, 1, 'No', 'Yes', 3, '9.00', '8076.20', '269.21', 'Fixed', '1459.64', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '8924 Santiago Locks\nWest Serenitybury, IA 46883', 0, 'Single', NULL, '60943369958', 'Yes', NULL, 4, 'Noemy Breitenberg', '23912697880519', 'New Margaretfurt', '2024-12-14', NULL, NULL, NULL, NULL, NULL, 547154563, 0, 0, 3, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(107, 6491, 2646, 'حاتم باسل عبدالسلام', 'Male', 2, 3, 3, '1971', 'إدارة الأعمال', 'Good', '2006-01-05', '70557641356886', '2025-01-17', 'Schimmelchester', 4, 'Muslim', 9, 'larson.ansel@example.org', 3, 5, 15, '0230435871', '0230220692', '01153236053', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '05124787935093', 'Yes', NULL, NULL, '2020-09-07', 'Employee', 4, 7, 'Yes', 'No', 2, '10.00', '27162.82', '905.43', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '84030 Fay Fords\nSouth Consueloside, OH 51501', 0, 'Married', NULL, '6342093155', 'Yes', NULL, 2, 'Esperanza Mann', '13141129803967', 'South Bartholomemouth', '2026-05-18', NULL, NULL, NULL, NULL, NULL, 1293351157, 0, 0, 3, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(108, 1615, 593, 'نور راغب حذيفة', 'Female', 1, 4, 3, '1983', 'علم الأحياء', 'Excellent', '2008-12-16', '36321246125234', '2029-06-03', 'Lake Lizziemouth', 5, 'Muslim', 7, 'dmiller@example.net', 6, 1, 15, '0234460398', '0232419348', '01578646349', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '35001573015197', 'No', NULL, NULL, '2020-02-04', 'Employee', 9, 3, 'Yes', 'Yes', 2, '8.00', '30479.48', '1015.98', 'Fixed', '1744.27', 'No', NULL, NULL, 'Yes', '510.89', '71613866907312', 'Cach', 'No', NULL, '1642 Candice Junctions\nKeeblerton, HI 41647', 0, 'Divorced', NULL, '3179061490', 'Yes', NULL, 3, 'Gillian Bradtke', '30856385647506', 'Port Nathaniel', '2029-02-20', NULL, NULL, NULL, NULL, NULL, 1480713321, 0, 0, 4, NULL, 1, '2024-12-12 15:30:51', '2024-12-12 15:30:51'),
(109, 8525, 1028, 'يوسف عبدالعزيز عمار', 'Male', 2, 2, 5, '1976', 'الرياضيات', 'Excellent', '2002-07-23', '60133686963317', '2026-10-31', 'Jacklynside', 1, 'Muslim', 12, 'wcarroll@example.com', 5, 3, 2, '0234444935', '0225089238', '01235528641', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '39743062338984', 'Yes', NULL, NULL, '2023-12-04', 'Employee', 8, 2, 'Yes', 'No', 2, '8.00', '31837.61', '1061.25', 'Fixed', '1953.72', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '86176 Anderson Extensions\nLake Malinda, NC 25125', 0, 'Divorced', NULL, '878045775', 'Yes', NULL, 3, 'Jess Kuhlman', '92563377154962', 'Audreanneville', '2025-07-23', NULL, NULL, NULL, NULL, NULL, 1972170876, 0, 0, 2, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(110, 5828, 2637, 'أماني وائل هيثم', 'Female', 2, 1, 4, '2009', 'الهندسة', 'Fair', '2014-10-03', '11840038531849', '2027-12-01', 'New Javierton', 2, 'Muslim', 12, 'brando44@example.net', 2, 7, 13, '0237925205', '0222168511', '01157178988', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '51883570074637', 'No', NULL, NULL, '2022-10-27', 'Employee', 9, 6, 'No', 'Yes', 4, '9.00', '43645.77', '1454.86', 'Fixed', '1580.44', 'No', NULL, NULL, 'Yes', '676.59', '43627488407846', 'Cach', 'No', NULL, '24475 Mandy Landing\nEast Liliana, WY 08095-3210', 0, 'Widowed', NULL, '6119290799', 'Yes', NULL, 6, 'Reid Barton', '90630240516688', 'Schummmouth', '2029-08-25', NULL, NULL, NULL, NULL, NULL, 1081306191, 0, 0, 1, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(111, 8415, 766, 'ناهد صابر سيف', 'Female', 4, 3, 2, '1996', 'الهندسة', 'Fair', '2008-01-15', '90203309564149', '2026-10-09', 'Marciachester', 6, 'Muslim', 12, 'ugoodwin@example.net', 5, 3, 1, '0235530589', '0237895872', '01518179063', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '30679406566585', 'No', NULL, NULL, '2020-06-01', 'Employee', 9, 8, 'Yes', 'Yes', 3, '8.00', '33738.05', '1124.60', 'Fixed', '1364.92', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '79844 Douglas Street\nSouth Naomiburgh, CO 38395', 0, 'Divorced', NULL, '7150207621721', 'Yes', NULL, 4, 'Dr. Ena Rolfson', '51827618298303', 'Leathaville', '2025-04-24', NULL, NULL, NULL, NULL, NULL, 191475853, 0, 0, 3, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(112, 9435, 1238, 'ماهر وائل باسم', 'Male', 4, 3, 4, '2013', 'علم الأحياء', 'Excellent', '2020-01-03', '11646365970539', '2024-12-28', 'Eulaton', 6, 'Christian', 6, 'flavio62@example.org', 3, 27, 14, '0229666463', '0225443411', '01514755826', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '32432846168909', 'No', NULL, NULL, '2021-08-12', 'Employee', 8, 9, 'Yes', 'Yes', 1, '8.00', '17516.19', '583.87', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '845.45', '58051800881223', 'Cach', 'No', NULL, '166 Newell Square\nEast Garnett, AZ 58749-4981', 0, 'Divorced', NULL, '549494450', 'Yes', NULL, 5, 'Catalina Howell', '30150985568825', 'East Marcellafurt', '2028-03-06', NULL, NULL, NULL, NULL, NULL, 49447373, 0, 0, 2, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(113, 3461, 2942, 'تولين عمار باسم', 'Female', 2, 2, 5, '2011', 'الفيزياء', 'Excellent', '2015-10-13', '64068859048739', '2029-03-30', 'New Connor', 4, 'Christian', 4, 'lilyan.predovic@example.net', 1, 19, 7, '0223559888', '0226785061', '01529392039', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '36902930787098', 'No', NULL, NULL, '2024-05-18', 'Employee', 5, 10, 'Yes', 'No', 4, '8.00', '15686.88', '522.90', 'Changeable', NULL, 'Yes', '868.06', '92193136791700', 'No', NULL, NULL, 'Visa', 'No', NULL, '87960 Dennis Stream\nNorth Abigayle, DC 99412-5130', 0, 'Single', NULL, '3947608224', 'Yes', NULL, 2, 'Mr. Howard Bergstrom', '69241399364103', 'Tressaborough', '2026-07-12', NULL, NULL, NULL, NULL, NULL, 294745123, 0, 0, 4, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(114, 5227, 2843, 'سلمى توفيق إبراهيم', 'Female', 1, 3, 6, '1971', 'علوم الحاسوب', 'Fair', '2019-04-18', '75459718279714', '2025-01-27', 'West Effietown', 5, 'Muslim', 10, 'douglas.jeanette@example.net', 5, 1, 10, '0224782437', '0228355201', '01595290963', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '21935463684003', 'Yes', NULL, NULL, '2021-04-28', 'Employee', 8, 5, 'Yes', 'No', 3, '9.00', '8692.09', '289.74', 'Fixed', '1188.34', 'Yes', '539.27', '45976836164538', 'No', NULL, NULL, 'Visa', 'No', NULL, '8335 Marvin River Suite 001\nSouth Mavisville, AZ 81095-4618', 0, 'Divorced', NULL, '8081028', 'Yes', NULL, 4, 'Ferne Ondricka', '35792422995649', 'North Jefferey', '2027-09-26', NULL, NULL, NULL, NULL, NULL, 1121699174, 0, 0, 3, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(115, 3140, 404, 'فاطمة عبدالرزاق عبدالكريم', 'Female', 3, 3, 6, '1979', 'الهندسة', 'Excellent', '2014-11-16', '29329365646529', '2025-03-31', 'New Robertoborough', 6, 'Christian', 1, 'jasen53@example.com', 5, 10, 1, '0223216018', '0239499784', '01554080769', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '51601808253628', 'Yes', NULL, NULL, '2019-12-15', 'Employee', 10, 5, 'Yes', 'Yes', 1, '11.00', '30328.90', '1010.96', 'Fixed', '1346.09', 'No', NULL, NULL, 'Yes', '589.56', '27611514611239', 'Cach', 'No', NULL, '5678 Patsy Manor Suite 017\nNew Lavinaview, WA 43471-8334', 0, 'Widowed', NULL, '12675030958', 'Yes', NULL, 5, 'Anne Upton', '18124660505581', 'Mohrview', '2025-08-30', NULL, NULL, NULL, NULL, NULL, 1927407326, 0, 0, 3, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(116, 7982, 2402, 'هيثم عماد عامر', 'Male', 1, 3, 5, '1987', 'الهندسة', 'Excellent', '2003-08-31', '64273185191975', '2026-07-30', 'North Tobinhaven', 5, 'Muslim', 4, 'satterfield.josefina@example.com', 5, 23, 11, '0236449666', '0231589783', '01584852950', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '72014447605855', 'No', NULL, NULL, '2024-07-04', 'Employee', 3, 1, 'Yes', 'No', 4, '12.00', '37821.51', '1260.72', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '2991 Jaiden Gardens\nTorpberg, IL 74304', 0, 'Widowed', NULL, '018025893', 'Yes', NULL, 1, 'Gregory Cruickshank', '99335412251430', 'Port Jamie', '2029-06-03', NULL, NULL, NULL, NULL, NULL, 463409705, 0, 0, 1, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(117, 3883, 1648, 'صهيب عامر تامر', 'Male', 3, 3, 3, '1988', 'علوم الحاسوب', 'Excellent', '2016-12-18', '34932484782283', '2025-11-22', 'Cecilview', 4, 'Muslim', 6, 'mossie78@example.org', 5, 11, 3, '0233796165', '0237883410', '01024033092', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '76031099911935', 'No', NULL, NULL, '2020-12-17', 'Employee', 10, 7, 'No', 'No', 2, '9.00', '5793.99', '193.13', 'Changeable', NULL, 'Yes', '735.93', '63901061553702', 'Yes', '516.88', '82784116654895', 'Visa', 'No', NULL, '85701 Brianne Drive\nPort Arnulfo, NJ 56371', 0, 'Widowed', NULL, '372501695', 'Yes', NULL, 6, 'Leonora Cormier', '03312981198716', 'Abbeyborough', '2026-12-13', NULL, NULL, NULL, NULL, NULL, 2088006889, 0, 0, 1, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(118, 3480, 1347, 'سيف معاذ باسل', 'Male', 3, 1, 4, '2004', 'الفيزياء', 'Very_Good', '2011-04-19', '22945834429603', '2029-07-18', 'Virgieburgh', 4, 'Muslim', 2, 'qcrist@example.com', 2, 5, 4, '0233345187', '0234321592', '01223608678', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '32252120989939', 'Yes', NULL, NULL, '2023-06-15', 'Employee', 6, 7, 'No', 'No', 2, '8.00', '25649.64', '854.99', 'Fixed', '1040.29', 'Yes', '511.71', '31530677235792', 'Yes', '658.43', '56134363752826', 'Visa', 'Yes', NULL, '791 Quigley Brooks\nSouth Ritaville, MO 48126', 0, 'Divorced', NULL, '51026029369831', 'Yes', NULL, 5, 'Palma Hettinger', '24651470206540', 'Jeanetteport', '2027-08-19', NULL, NULL, NULL, NULL, NULL, 550762808, 0, 0, 4, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52');
INSERT INTO `employees` (`id`, `employee_code`, `fp_code`, `name`, `gender`, `branch_id`, `job_grade_id`, `qualification_id`, `qualification_year`, `major`, `graduation_estimate`, `brith_date`, `national_id`, `end_national_id`, `national_id_place`, `blood_types_id`, `religion`, `language_id`, `email`, `country_id`, `governorate_id`, `city_id`, `home_telephone`, `work_telephone`, `mobile`, `military`, `military_date_from`, `military_date_to`, `military_wepon`, `military_exemption_date`, `military_exemption_reason`, `military_postponement_reason`, `date_resignation`, `resignation_reason`, `driving_license`, `driving_license_type`, `driving_License_id`, `has_relatives`, `relatives_details`, `notes`, `work_start_date`, `functional_status`, `department_id`, `job_categories_id`, `has_attendance`, `has_fixed_shift`, `shift_types_id`, `daily_work_hour`, `salary`, `day_price`, `motivation_type`, `motivation`, `social_insurance`, `social_insurance_cut_monthely`, `social_insurance_number`, `medical_insurance`, `medical_insurance_cut_monthely`, `medical_insurance_number`, `Type_salary_receipt`, `active_vacation`, `urgent_person_details`, `staies_address`, `children_number`, `social_status`, `resignation_id`, `bank_number_account`, `disabilities`, `disabilities_type`, `nationality_id`, `name_sponsor`, `pasport_identity`, `pasport_from_place`, `pasport_exp_date`, `num_vacation_days`, `add_service`, `years_service`, `cv`, `basic_address_country`, `fixed_allowances`, `is_done_Vacation_formula`, `is_Sensitive_manager_data`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(119, 4363, 598, 'صهيب عمر عبدالله', 'Male', 2, 2, 2, '1977', 'الفيزياء', 'Very_Good', '2003-04-16', '19873253198463', '2026-01-27', 'Eloyview', 7, 'Muslim', 4, 'noah.koss@example.net', 6, 1, 7, '0225544660', '0220994110', '01011518355', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '33090722182271', 'No', NULL, NULL, '2020-08-02', 'Employee', 2, 4, 'Yes', 'Yes', 3, '7.00', '15939.39', '531.31', 'Fixed', '1237.19', 'No', NULL, NULL, 'Yes', '711.05', '73393114823172', 'Visa', 'Yes', NULL, '4862 Pagac Terrace Apt. 835\nNicklaustown, IA 23948-0228', 0, 'Divorced', NULL, '38714256087158', 'Yes', NULL, 3, 'Gust O\'Keefe Sr.', '43904703941865', 'Lesleyton', '2027-06-28', NULL, NULL, NULL, NULL, NULL, 231126064, 0, 0, 4, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(120, 9280, 2737, 'زينب علاء رامي', 'Female', 3, 4, 1, '2010', 'علم الأحياء', 'Fair', '2005-06-16', '12408270290096', '2026-11-26', 'Brownberg', 5, 'Christian', 13, 'nrau@example.com', 1, 3, 12, '0234873665', '0223833935', '01577158286', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '37431573811285', 'No', NULL, NULL, '2021-01-12', 'Employee', 1, 6, 'Yes', 'Yes', 4, '9.00', '20962.53', '698.75', 'Changeable', NULL, 'Yes', '585.30', '94946488338243', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '7025 Grimes Vista Suite 293\nSouth Jaime, NM 06701-9718', 0, 'Married', NULL, '3087719762', 'Yes', NULL, 5, 'Christy Halvorson MD', '52389341353481', 'Brendonmouth', '2027-09-01', NULL, NULL, NULL, NULL, NULL, 19696602, 0, 0, 2, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(121, 2329, 156, 'ثامر أحمد عبدالسلام', 'Male', 3, 3, 2, '2013', 'الهندسة', 'Good', '2000-12-03', '34863583284331', '2026-10-02', 'New Adahfurt', 7, 'Christian', 10, 'nschulist@example.org', 1, 11, 14, '0221129785', '0233167457', '01274021363', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '72631826321358', 'No', NULL, NULL, '2022-03-13', 'Employee', 8, 1, 'Yes', 'Yes', 4, '7.00', '10215.75', '340.53', 'Changeable', NULL, 'Yes', '868.63', '38925836315517', 'Yes', '877.04', '13343558673045', 'Cach', 'Yes', NULL, '2245 Zula Circles Apt. 733\nEast Walker, VA 98000', 0, 'Widowed', NULL, '579880869822973', 'Yes', NULL, 1, 'Brant Rohan', '79051661156605', 'Townemouth', '2027-09-01', NULL, NULL, NULL, NULL, NULL, 1085940158, 0, 0, 3, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(122, 7920, 1159, 'ديمة ربيع مهند', 'Female', 3, 1, 3, '1975', 'إدارة الأعمال', 'Fair', '1999-12-29', '67926863568298', '2025-12-25', 'Port Leonefort', 4, 'Muslim', 10, 'makayla90@example.com', 6, 21, 13, '0223287527', '0237177795', '01217502450', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '72539106977468', 'Yes', NULL, NULL, '2021-12-12', 'Employee', 6, 10, 'Yes', 'No', 1, '12.00', '10112.79', '337.09', 'Changeable', NULL, 'Yes', '551.19', '47257448609725', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '60407 Murphy Fork\nEast Mariam, SD 00423', 0, 'Widowed', NULL, '05386138149216', 'Yes', NULL, 3, 'Ashleigh Schiller', '16108921983362', 'Lake Nestorfort', '2024-12-28', NULL, NULL, NULL, NULL, NULL, 1940230957, 0, 0, 4, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(123, 1925, 2865, 'آنا زين جمال', 'Female', 2, 2, 3, '2014', 'الفيزياء', 'Excellent', '2023-09-04', '82822774421072', '2027-02-02', 'New Erniemouth', 5, 'Christian', 9, 'lconroy@example.net', 1, 10, 14, '0236674961', '0232527833', '01073936584', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '48471023655227', 'No', NULL, NULL, '2022-03-10', 'Employee', 7, 7, 'Yes', 'No', 1, '7.00', '41324.59', '1377.49', 'Fixed', '1983.19', 'No', NULL, NULL, 'Yes', '941.36', '95640646425245', 'Visa', 'No', NULL, '12033 Schuppe Plains Suite 038\nAuerton, MT 15757', 0, 'Married', NULL, '7095395326', 'Yes', NULL, 1, 'Ralph Kemmer', '52112216264098', 'Mohrburgh', '2028-07-02', NULL, NULL, NULL, NULL, NULL, 325126729, 0, 0, 2, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(124, 7386, 581, 'زين باسم محمد', 'Male', 3, 1, 5, '1983', 'علم الأحياء', 'Good', '2021-01-22', '82270042659411', '2029-06-21', 'South Anniehaven', 5, 'Christian', 11, 'juvenal92@example.net', 4, 12, 10, '0223561460', '0220218408', '01528567213', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '94987466346647', 'Yes', NULL, NULL, '2020-07-26', 'Employee', 2, 4, 'No', 'No', 3, '11.00', '46373.61', '1545.79', 'Fixed', '1786.68', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '179 Deshawn Shore\nNew Giovanna, TX 83988', 0, 'Widowed', NULL, '76224926871689', 'Yes', NULL, 3, 'Nat Russel', '29437151764371', 'North Brownport', '2025-06-19', NULL, NULL, NULL, NULL, NULL, 1824185179, 0, 0, 1, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(125, 4038, 2053, 'روى عبدالحكيم رفيق', 'Female', 1, 2, 1, '1996', 'الهندسة', 'Fair', '2013-03-21', '27744503799464', '2028-10-31', 'Halvorsonville', 1, 'Muslim', 4, 'ggerlach@example.org', 6, 17, 14, '0228057531', '0227418727', '01178575441', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '70645858014719', 'No', NULL, NULL, '2024-04-16', 'Employee', 8, 4, 'Yes', 'Yes', 1, '12.00', '40791.47', '1359.72', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '2141 Oran Mills\nMoshestad, SD 46475-8124', 0, 'Single', NULL, '38794082035', 'Yes', NULL, 1, 'Monique Kunze', '44624526560309', 'Aliyahton', '2027-08-10', NULL, NULL, NULL, NULL, NULL, 1941391883, 0, 0, 1, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(126, 4132, 1917, 'شهد شاكر أمجد', 'Female', 4, 2, 2, '1973', 'علم الأحياء', 'Excellent', '2003-12-02', '84996486529903', '2029-07-26', 'South Conradland', 4, 'Muslim', 8, 'kutch.santa@example.org', 1, 18, 14, '0231147925', '0230608787', '01514579368', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '16414659329954', 'No', NULL, NULL, '2022-05-26', 'Employee', 9, 2, 'Yes', 'Yes', 3, '12.00', '21790.83', '726.36', 'Fixed', '1332.82', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '33336 Adam Shoals\nHarveyberg, MA 03368', 0, 'Single', NULL, '98679767096203', 'Yes', NULL, 3, 'Mr. Chesley Deckow', '50100951630990', 'Port Esta', '2025-09-15', NULL, NULL, NULL, NULL, NULL, 688468760, 0, 0, 1, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(127, 8324, 1326, 'مارين عامر جواد', 'Female', 2, 3, 5, '2004', 'علم الأحياء', 'Good', '2003-07-07', '85839145452024', '2025-12-08', 'New Adrienshire', 4, 'Muslim', 7, 'bayer.loyce@example.com', 1, 16, 14, '0228039120', '0233807134', '01050082201', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '09134065311486', 'Yes', NULL, NULL, '2023-04-25', 'Employee', 10, 10, 'No', 'Yes', 2, '7.00', '40174.56', '1339.15', 'Fixed', '1457.05', 'No', NULL, NULL, 'Yes', '778.48', '18754994911916', 'Cach', 'No', NULL, '935 Predovic View Suite 280\nNew Judahshire, NY 87620', 0, 'Single', NULL, '33053080045164', 'Yes', NULL, 2, 'Angelo Rosenbaum', '54865545905171', 'Port Abeltown', '2027-01-08', NULL, NULL, NULL, NULL, NULL, 2078046800, 0, 0, 2, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(128, 9249, 1794, 'شاكر عدنان عبدالرحمن', 'Male', 3, 4, 5, '1992', 'الهندسة', 'Fair', '2022-04-19', '26096205162288', '2029-05-14', 'West Aliviafurt', 3, 'Muslim', 3, 'vanessa44@example.com', 5, 8, 6, '0231776381', '0225554649', '01576899457', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '88132408881920', 'No', NULL, NULL, '2021-02-12', 'Employee', 1, 7, 'No', 'No', 3, '11.00', '48325.72', '1610.86', 'Fixed', '1623.02', 'Yes', '957.54', '82417488293471', 'Yes', '940.85', '67290944203455', 'Cach', 'Yes', NULL, '60304 Electa Spurs Apt. 753\nBlandaview, AZ 20049', 0, 'Divorced', NULL, '229291142539', 'Yes', NULL, 4, 'Ezekiel Walsh', '56599233769367', 'North Fayport', '2027-08-09', NULL, NULL, NULL, NULL, NULL, 2109057894, 0, 0, 1, NULL, 1, '2024-12-12 15:30:52', '2024-12-12 15:30:52'),
(129, 6999, 1026, 'رحمة أمجد صابر', 'Female', 3, 2, 1, '2010', 'علوم الحاسوب', 'Excellent', '2009-12-09', '91397339421823', '2029-02-06', 'Jasperside', 7, 'Muslim', 10, 'imani.dietrich@example.org', 3, 8, 2, '0221372426', '0235982344', '01087480341', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '28410182614582', 'Yes', NULL, NULL, '2021-06-03', 'Employee', 8, 7, 'No', 'No', 3, '8.00', '6004.57', '200.15', 'Fixed', '1591.41', 'Yes', '689.93', '79333786534927', 'No', NULL, NULL, 'Cach', 'No', NULL, '28735 Morar Ports Suite 254\nWest Kyra, WV 80176-3067', 0, 'Single', NULL, '707954686551', 'Yes', NULL, 4, 'Bernadette Kohler', '66703156437216', 'Wuckertburgh', '2026-11-12', NULL, NULL, NULL, NULL, NULL, 643226404, 0, 0, 4, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(130, 6054, 1315, 'سيف سهيل محمود', 'Male', 1, 1, 3, '1982', 'الفيزياء', 'Very_Good', '2014-04-20', '43461805239133', '2025-08-14', 'New Ole', 6, 'Muslim', 2, 'kozey.lea@example.com', 3, 6, 3, '0238630775', '0238724130', '01190473935', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '75954069679235', 'No', NULL, NULL, '2022-11-06', 'Employee', 3, 6, 'No', 'No', 2, '8.00', '29556.81', '985.23', 'Fixed', '1398.67', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '79972 Marquise Mission Apt. 982\nPort Federico, MA 21210', 0, 'Married', NULL, '5911026', 'Yes', NULL, 5, 'Dino Dietrich PhD', '08965729716348', 'Leschburgh', '2026-02-11', NULL, NULL, NULL, NULL, NULL, 934285096, 0, 0, 1, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(131, 9169, 248, 'غادة عماد محمد', 'Female', 3, 3, 1, '1984', 'الهندسة', 'Fair', '2021-08-13', '22992917585265', '2025-07-05', 'Davischester', 5, 'Christian', 11, 'jacobson.ova@example.net', 4, 25, 7, '0238656826', '0223823474', '01136610777', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '87317590242227', 'No', NULL, NULL, '2021-03-04', 'Employee', 10, 4, 'No', 'Yes', 3, '12.00', '6605.17', '220.17', 'Changeable', NULL, 'Yes', '831.41', '79835347586487', 'Yes', '578.63', '90335167492574', 'Visa', 'No', NULL, '47619 Shaniya Rapid\nNorth Bridgette, CT 36563', 0, 'Divorced', NULL, '70353700037', 'Yes', NULL, 4, 'Dena Hintz', '07915670402184', 'Vernicechester', '2025-01-29', NULL, NULL, NULL, NULL, NULL, 1864048198, 0, 0, 3, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(132, 5886, 990, 'سليمان باسل شاكر', 'Male', 1, 3, 6, '1999', 'الفيزياء', 'Good', '2013-02-13', '25429953124472', '2026-08-12', 'Kaylieborough', 4, 'Christian', 3, 'murray.reina@example.org', 6, 1, 1, '0237150291', '0239423632', '01074859171', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '86144783872260', 'No', NULL, NULL, '2021-06-06', 'Employee', 6, 3, 'No', 'Yes', 1, '9.00', '26018.99', '867.30', 'Fixed', '1693.79', 'Yes', '572.97', '39874638036028', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '444 Kunze Forge Apt. 655\nNorth Bradleyview, UT 44121-1933', 0, 'Single', NULL, '861236596511', 'Yes', NULL, 5, 'Alayna Cummerata', '99908124578150', 'West April', '2026-02-11', NULL, NULL, NULL, NULL, NULL, 1736734311, 0, 0, 1, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(133, 4709, 1332, 'بدر أنس شاكر', 'Male', 4, 2, 1, '2002', 'علوم الحاسوب', 'Very_Good', '2014-10-31', '19361269076133', '2029-06-06', 'West Lazaro', 1, 'Christian', 2, 'damian10@example.com', 6, 4, 2, '0236130487', '0237767267', '01526867032', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '96114651829942', 'Yes', NULL, NULL, '2022-01-07', 'Employee', 1, 6, 'No', 'No', 1, '10.00', '30855.67', '1028.52', 'Fixed', '1091.03', 'Yes', '694.82', '17814641454293', 'No', NULL, NULL, 'Visa', 'No', NULL, '14383 Hill Ports\nNew Coby, NJ 08890-9796', 0, 'Single', NULL, '15002457996', 'Yes', NULL, 4, 'Aurore Kreiger', '01696007406002', 'Port Jaylon', '2028-02-11', NULL, NULL, NULL, NULL, NULL, 1892289168, 0, 0, 4, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(134, 5042, 2057, 'شهد لؤي مالك', 'Female', 3, 4, 3, '2004', 'علوم الحاسوب', 'Fair', '2006-06-15', '94313360146792', '2029-08-24', 'Timmothyfurt', 2, 'Muslim', 2, 'baby33@example.org', 6, 14, 15, '0226069852', '0221336241', '01286164436', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '17027398090461', 'No', NULL, NULL, '2022-12-20', 'Employee', 9, 9, 'Yes', 'No', 1, '7.00', '18929.82', '630.99', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '875.57', '83730409586212', 'Visa', 'No', NULL, '18177 Karl Road\nNorth Mustafaport, AL 56858', 0, 'Single', NULL, '8910054847839', 'Yes', NULL, 2, 'Vesta Connelly', '72162742348831', 'Patienceville', '2028-06-26', NULL, NULL, NULL, NULL, NULL, 1875357101, 0, 0, 1, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(135, 3754, 444, 'روى عمر فارس', 'Female', 4, 4, 2, '2005', 'الهندسة', 'Fair', '2000-10-31', '31369888726541', '2027-02-27', 'North Zoeport', 5, 'Christian', 4, 'fay.madilyn@example.org', 4, 1, 15, '0220815986', '0229370553', '01248363713', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '69686593131467', 'No', NULL, NULL, '2021-06-02', 'Employee', 10, 6, 'No', 'Yes', 4, '10.00', '23971.65', '799.06', 'Changeable', NULL, 'Yes', '997.36', '40142672702214', 'No', NULL, NULL, 'Cach', 'No', NULL, '8615 Arno Gateway\nLexiport, MD 05679', 0, 'Widowed', NULL, '794897603987', 'Yes', NULL, 3, 'Prof. Garett Braun PhD', '90663017849406', 'Thielshire', '2029-10-14', NULL, NULL, NULL, NULL, NULL, 644980144, 0, 0, 2, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(136, 8461, 2539, 'باسم نادر إسماعيل', 'Male', 3, 2, 6, '1984', 'الرياضيات', 'Fair', '2016-05-21', '81360694179545', '2026-12-22', 'South Eugeneport', 3, 'Christian', 6, 'lorena.dach@example.org', 6, 18, 15, '0237355362', '0226423717', '01262886210', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '85288553004063', 'Yes', NULL, NULL, '2023-07-31', 'Employee', 5, 10, 'Yes', 'No', 3, '9.00', '12872.05', '429.07', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '5996 Dylan Knolls\nEast Anna, ID 26348-4111', 0, 'Married', NULL, '3839401119207495', 'Yes', NULL, 4, 'Lexi Quitzon', '72931478267731', 'Eldonmouth', '2027-10-21', NULL, NULL, NULL, NULL, NULL, 1180480403, 0, 0, 2, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(137, 5809, 690, 'كريم يحيى عبدالرحمن', 'Male', 4, 4, 2, '1971', 'علوم الحاسوب', 'Fair', '2014-12-24', '87725321717589', '2028-10-08', 'Thaliafurt', 2, 'Christian', 8, 'morar.cassidy@example.org', 6, 27, 8, '0236279269', '0230985552', '01128854367', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '68661493437004', 'No', NULL, NULL, '2023-10-16', 'Employee', 8, 7, 'No', 'Yes', 4, '9.00', '23294.22', '776.47', 'Fixed', '1737.08', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '38622 Ebert Path Suite 706\nBeierfurt, MO 21988', 0, 'Married', NULL, '45926317467', 'Yes', NULL, 3, 'Daren Legros', '88857309896652', 'Dillanfurt', '2028-03-18', NULL, NULL, NULL, NULL, NULL, 1342231220, 0, 0, 2, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(138, 6294, 601, 'زياد سهيل عبداللطيف', 'Male', 4, 3, 2, '1977', 'الهندسة', 'Excellent', '2003-11-10', '21120006520123', '2029-01-03', 'Vivianbury', 1, 'Christian', 11, 'santos27@example.com', 5, 24, 2, '0236437784', '0236362484', '01294328091', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '29353118451096', 'Yes', NULL, NULL, '2021-07-01', 'Employee', 7, 5, 'Yes', 'Yes', 2, '12.00', '34117.59', '1137.25', 'Changeable', NULL, 'Yes', '798.86', '41220406340286', 'Yes', '637.34', '21039830726314', 'Visa', 'Yes', NULL, '38773 Ronaldo Curve Apt. 709\nJordonbury, LA 57845-1163', 0, 'Single', NULL, '2102825', 'Yes', NULL, 3, 'Carissa Hoppe', '14542901725250', 'West Selinaburgh', '2027-12-26', NULL, NULL, NULL, NULL, NULL, 1806669079, 0, 0, 4, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(139, 9972, 1006, 'إبراهيم عمار جمال', 'Male', 4, 4, 6, '1997', 'علوم الحاسوب', 'Fair', '2000-06-21', '29047382352245', '2027-04-06', 'Rosellashire', 3, 'Muslim', 9, 'otto22@example.com', 3, 10, 6, '0231784756', '0235056453', '01171358969', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '17272801927816', 'Yes', NULL, NULL, '2022-01-08', 'Employee', 6, 10, 'Yes', 'Yes', 4, '9.00', '21031.81', '701.06', 'Fixed', '1117.77', 'Yes', '567.46', '91286051196075', 'No', NULL, NULL, 'Visa', 'No', NULL, '357 Dicki Parkways\nHermannland, VT 18127', 0, 'Married', NULL, '049350', 'Yes', NULL, 5, 'Florida Sanford', '65353478828115', 'Keeblertown', '2026-09-05', NULL, NULL, NULL, NULL, NULL, 154283316, 0, 0, 4, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(140, 9098, 1934, 'إسماعيل عبدالفتاح حذيفة', 'Male', 4, 1, 2, '1982', 'إدارة الأعمال', 'Excellent', '2021-04-19', '49368096951771', '2028-06-28', 'Alainaview', 3, 'Muslim', 12, 'unolan@example.com', 1, 6, 3, '0239037622', '0223978788', '01225964347', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '02932211484625', 'No', NULL, NULL, '2020-12-01', 'Employee', 7, 10, 'No', 'No', 3, '7.00', '35800.35', '1193.35', 'Fixed', '1164.62', 'No', NULL, NULL, 'Yes', '724.42', '40778974620412', 'Visa', 'Yes', NULL, '6131 Timothy Streets\nNew Russell, KY 88733', 0, 'Divorced', NULL, '27226131282', 'Yes', NULL, 2, 'Mrs. Ava Gulgowski Sr.', '72808032764175', 'North Kamryn', '2026-10-06', NULL, NULL, NULL, NULL, NULL, 414689054, 0, 0, 2, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(141, 6911, 1168, 'توفيق عامر ماهر', 'Male', 4, 3, 3, '1986', 'علوم الحاسوب', 'Good', '2012-05-09', '78814449187150', '2028-02-22', 'Turcotteshire', 2, 'Christian', 6, 'oconnell.brooklyn@example.com', 3, 8, 9, '0222221510', '0223820679', '01579725562', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '79290111219639', 'No', NULL, NULL, '2024-10-16', 'Employee', 2, 10, 'Yes', 'Yes', 1, '11.00', '23344.43', '778.15', 'Changeable', NULL, 'Yes', '888.10', '76100006373366', 'Yes', '817.03', '61760374087020', 'Visa', 'Yes', NULL, '9540 Cartwright Centers Apt. 104\nLynnchester, CO 44735-4006', 0, 'Single', NULL, '3359307395404', 'Yes', NULL, 2, 'Deborah Dare', '40121461678302', 'Schmelerport', '2029-01-26', NULL, NULL, NULL, NULL, NULL, 1592637776, 0, 0, 3, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(142, 9496, 2763, 'أيوب بدر أنس', 'Male', 4, 3, 2, '1989', 'الفيزياء', 'Fair', '2014-03-24', '63004315164021', '2028-10-21', 'McDermottstad', 2, 'Christian', 8, 'rowe.selina@example.org', 6, 10, 7, '0235813419', '0220104333', '01197462073', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '41320030117355', 'Yes', NULL, NULL, '2024-11-23', 'Employee', 8, 1, 'No', 'No', 2, '8.00', '48148.64', '1604.95', 'Fixed', '1252.20', 'No', NULL, NULL, 'Yes', '602.94', '51667767685783', 'Cach', 'Yes', NULL, '369 Freeda Village\nNew Ned, OK 86696', 0, 'Married', NULL, '3112919275784', 'Yes', NULL, 6, 'Hester Hermann', '23366460300140', 'Luisside', '2025-08-04', NULL, NULL, NULL, NULL, NULL, 412099109, 0, 0, 3, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(143, 4026, 656, 'رائد شريف أيوب', 'Male', 2, 3, 1, '1997', 'الرياضيات', 'Good', '2006-04-14', '62318113506593', '2027-09-08', 'Treutelton', 5, 'Christian', 10, 'aschaden@example.com', 6, 20, 6, '0232681922', '0221215373', '01072628336', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '34241589913255', 'No', NULL, NULL, '2020-08-13', 'Employee', 6, 1, 'Yes', 'No', 1, '11.00', '6502.39', '216.75', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '17153 Tia Forest\nWest Dinoland, NE 11661-1403', 0, 'Single', NULL, '82298199380', 'Yes', NULL, 3, 'Dr. Sven Herman', '94445658421158', 'Port Gideonshire', '2028-06-29', NULL, NULL, NULL, NULL, NULL, 1132210850, 0, 0, 3, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(144, 5348, 2559, 'دنيا معاذ سليمان', 'Female', 2, 4, 5, '1978', 'علوم الحاسوب', 'Excellent', '2014-04-09', '84673165663591', '2028-01-24', 'Missourimouth', 4, 'Christian', 1, 'elvie.pollich@example.com', 3, 16, 8, '0221905400', '0228440417', '01290668692', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '05548727960814', 'Yes', NULL, NULL, '2021-06-28', 'Employee', 5, 1, 'Yes', 'No', 2, '11.00', '40668.44', '1355.61', 'Fixed', '1263.77', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '472 Al Neck\nEast Jettietown, WY 31421-9598', 0, 'Widowed', NULL, '56736198985', 'Yes', NULL, 6, 'Heber Hettinger', '56476833630585', 'Lake Dock', '2029-03-13', NULL, NULL, NULL, NULL, NULL, 785797483, 0, 0, 4, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(145, 3146, 686, 'سهيل ياسر كريم', 'Male', 2, 2, 5, '2001', 'الهندسة', 'Fair', '2006-02-01', '01283675839142', '2028-03-05', 'Carmelohaven', 5, 'Christian', 13, 'dorothea22@example.org', 1, 23, 7, '0220494923', '0230977417', '01540110438', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '03689363278381', 'Yes', NULL, NULL, '2021-06-13', 'Employee', 7, 9, 'No', 'No', 4, '12.00', '14465.28', '482.18', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '7968 Cullen Via\nStefantown, UT 08110', 0, 'Widowed', NULL, '55011515', 'Yes', NULL, 5, 'Rene Monahan', '79895469382596', 'Krystalstad', '2029-02-10', NULL, NULL, NULL, NULL, NULL, 1833697318, 0, 0, 1, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(146, 7556, 2830, 'ديما أنس زين', 'Female', 4, 2, 4, '1994', 'الفيزياء', 'Good', '2024-11-13', '90445704450938', '2029-07-20', 'Davisfort', 4, 'Christian', 6, 'senger.esther@example.org', 4, 11, 11, '0235653304', '0221923390', '01263478120', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '19621544595134', 'Yes', NULL, NULL, '2024-07-17', 'Employee', 3, 7, 'Yes', 'Yes', 2, '11.00', '31151.21', '1038.37', 'Fixed', '1346.73', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '60299 Auer Shoals\nAmieburgh, KY 57979-3814', 0, 'Divorced', NULL, '1679946100416', 'Yes', NULL, 5, 'Melody Dietrich', '54002417755975', 'Lake Dwightport', '2025-05-02', NULL, NULL, NULL, NULL, NULL, 1214739457, 0, 0, 2, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(147, 1142, 908, 'عدنان عماد بدر', 'Male', 1, 1, 4, '1976', 'علوم الحاسوب', 'Good', '2014-02-14', '71575473064982', '2026-03-10', 'Lake Vickie', 3, 'Christian', 10, 'salvador.crooks@example.net', 4, 20, 10, '0221471606', '0221887087', '01281137230', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '34982944953861', 'No', NULL, NULL, '2022-05-16', 'Employee', 3, 6, 'Yes', 'Yes', 1, '8.00', '41576.81', '1385.89', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '862.01', '67962142375415', 'Cach', 'Yes', NULL, '6626 Art Hills\nNorth Bettyfurt, GA 48518', 0, 'Single', NULL, '6665177115922', 'Yes', NULL, 5, 'Mrs. Destany Champlin', '38911518674753', 'Gleasonport', '2027-02-20', NULL, NULL, NULL, NULL, NULL, 769221402, 0, 0, 3, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(148, 9351, 2495, 'سامر أحمد رياض', 'Male', 3, 4, 6, '2011', 'علوم الحاسوب', 'Excellent', '2000-02-05', '96530332290167', '2028-02-20', 'North Makayla', 6, 'Christian', 7, 'shanelle.cartwright@example.org', 3, 11, 4, '0225777263', '0227516806', '01294704128', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '41290757562587', 'Yes', NULL, NULL, '2022-01-02', 'Employee', 4, 6, 'No', 'No', 2, '8.00', '29431.70', '981.06', 'Changeable', NULL, 'Yes', '920.18', '05596417002308', 'No', NULL, NULL, 'Cach', 'No', NULL, '9773 Runolfsson Dale Apt. 795\nSouth Modestafurt, WV 30432', 0, 'Divorced', NULL, '31576428429', 'Yes', NULL, 3, 'Mr. Jamel Hudson III', '53136686132697', 'Fabiolaborough', '2028-05-04', NULL, NULL, NULL, NULL, NULL, 1479354188, 0, 0, 3, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(149, 7930, 1737, 'لينا نور مهند', 'Female', 1, 1, 5, '1977', 'الفيزياء', 'Very_Good', '2011-11-01', '52065775356236', '2029-10-21', 'Franeckibury', 5, 'Christian', 4, 'ernser.maudie@example.com', 6, 5, 6, '0225530007', '0236278644', '01081949270', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '31280313805583', 'No', NULL, NULL, '2021-02-27', 'Employee', 10, 10, 'Yes', 'No', 4, '12.00', '48096.13', '1603.20', 'Fixed', '1780.89', 'No', NULL, NULL, 'Yes', '505.95', '22075664677669', 'Visa', 'Yes', NULL, '933 Donnelly Mount Suite 020\nBerniceberg, PA 75744-6483', 0, 'Divorced', NULL, '917506206', 'Yes', NULL, 1, 'Israel Mohr', '85345609168951', 'South Linneafurt', '2028-03-28', NULL, NULL, NULL, NULL, NULL, 1549794177, 0, 0, 2, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(150, 4856, 2157, 'عبدالفتاح وجيه ياسر', 'Male', 4, 4, 2, '2006', 'علوم الحاسوب', 'Very_Good', '2014-08-06', '22708539652073', '2029-05-18', 'West Chaim', 1, 'Christian', 1, 'cyundt@example.org', 2, 5, 5, '0238206978', '0221346654', '01572301631', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '32693574183649', 'Yes', NULL, NULL, '2020-09-16', 'Employee', 7, 5, 'No', 'Yes', 2, '12.00', '11035.96', '367.87', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '906 Donnelly Branch Apt. 127\nNew Amirhaven, DC 24192-6865', 0, 'Divorced', NULL, '2633512045', 'Yes', NULL, 5, 'Rhiannon Zboncak', '12226565297896', 'Angelland', '2028-05-21', NULL, NULL, NULL, NULL, NULL, 1387393533, 0, 0, 2, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(151, 4732, 976, 'نورا أكرم عبدالحي', 'Female', 4, 2, 4, '2002', 'الفيزياء', 'Very_Good', '2005-03-04', '10847830966162', '2027-02-02', 'Watersfurt', 2, 'Christian', 3, 'beaulah68@example.com', 4, 20, 6, '0227457188', '0233843395', '01266946969', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '01028898726969', 'Yes', NULL, NULL, '2024-03-31', 'Employee', 3, 4, 'No', 'No', 3, '7.00', '27530.89', '917.70', 'Fixed', '1409.69', 'Yes', '579.81', '63630250761149', 'No', NULL, NULL, 'Cach', 'No', NULL, '38524 Garth Unions\nWest Dominic, VA 50387-2972', 0, 'Widowed', NULL, '0736431977685', 'Yes', NULL, 2, 'Aurore Roberts', '37253991435747', 'Toyland', '2028-08-20', NULL, NULL, NULL, NULL, NULL, 94962937, 0, 0, 1, NULL, 1, '2024-12-12 15:30:53', '2024-12-12 15:30:53'),
(152, 4861, 2820, 'ديمة إلياس قاسم', 'Female', 1, 1, 4, '1981', 'الهندسة', 'Excellent', '2019-12-21', '48967841162328', '2029-10-23', 'New Claudestad', 3, 'Muslim', 3, 'leonel.jaskolski@example.com', 1, 1, 15, '0225511139', '0237182668', '01586768734', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '99437609623218', 'No', NULL, NULL, '2021-07-11', 'Employee', 10, 3, 'Yes', 'No', 3, '9.00', '40094.77', '1336.49', 'Changeable', NULL, 'Yes', '575.49', '99831506204001', 'Yes', '565.34', '90988010466208', 'Visa', 'No', NULL, '51481 Upton Summit\nFrancesborough, HI 07209', 0, 'Single', NULL, '502133700', 'Yes', NULL, 3, 'Verlie Rau', '25507069755709', 'New Antoinettetown', '2029-05-13', NULL, NULL, NULL, NULL, NULL, 580705716, 0, 0, 4, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(153, 3577, 1996, 'جنى فارس راغب', 'Female', 4, 2, 2, '1979', 'الفيزياء', 'Fair', '2004-07-25', '79946886185212', '2025-01-12', 'Roobville', 2, 'Christian', 6, 'beaulah.mclaughlin@example.org', 1, 10, 11, '0226994251', '0233935859', '01011337463', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '81564217515467', 'No', NULL, NULL, '2023-01-23', 'Employee', 6, 2, 'Yes', 'Yes', 2, '10.00', '11907.60', '396.92', 'Fixed', '1481.54', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '75829 Modesta Squares\nPort Jermainefort, GA 90740-2295', 0, 'Widowed', NULL, '74945672', 'Yes', NULL, 4, 'Ms. Muriel Collier', '00228410578686', 'Rennerfort', '2028-10-02', NULL, NULL, NULL, NULL, NULL, 500785228, 0, 0, 1, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(154, 3678, 2572, 'مازن فارس عبدالسلام', 'Male', 2, 2, 1, '2000', 'علم الأحياء', 'Very_Good', '2021-11-06', '20082425596340', '2027-06-30', 'Jeanettehaven', 4, 'Christian', 12, 'dhermiston@example.com', 4, 7, 13, '0224601684', '0223021067', '01191633246', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '75839679440654', 'No', NULL, NULL, '2024-01-11', 'Employee', 2, 9, 'Yes', 'Yes', 1, '10.00', '12239.05', '407.97', 'Fixed', '1912.85', 'No', NULL, NULL, 'Yes', '564.69', '87102584961214', 'Cach', 'No', NULL, '8041 Presley Tunnel\nMargaritachester, AR 07112-4433', 0, 'Married', NULL, '3293544901104', 'Yes', NULL, 4, 'Marques Sawayn MD', '90650558234136', 'North Merlehaven', '2026-07-08', NULL, NULL, NULL, NULL, NULL, 124950906, 0, 0, 2, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(155, 9259, 2648, 'حنان هيثم سالم', 'Female', 2, 2, 3, '2007', 'الرياضيات', 'Very_Good', '2010-11-04', '93601796325996', '2028-02-06', 'Port Antonia', 6, 'Christian', 9, 'jamal.mante@example.org', 5, 10, 8, '0228169369', '0237338273', '01212595615', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '51109472468946', 'No', NULL, NULL, '2022-06-02', 'Employee', 3, 8, 'Yes', 'Yes', 2, '9.00', '6329.99', '211.00', 'Changeable', NULL, 'Yes', '762.38', '49060191680934', 'Yes', '589.78', '39121813738535', 'Visa', 'Yes', NULL, '5684 Hahn Rapids\nSouth Kristaport, OH 49986', 0, 'Married', NULL, '68705967', 'Yes', NULL, 6, 'Hermina Runolfsson', '20736043130090', 'Lake Leannaside', '2026-01-26', NULL, NULL, NULL, NULL, NULL, 52764885, 0, 0, 3, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(156, 6558, 2790, 'معاذ عبدالفتاح عبدالحميد', 'Male', 1, 4, 2, '2012', 'الفيزياء', 'Excellent', '2024-01-11', '47741476783831', '2027-01-06', 'New Derickshire', 4, 'Muslim', 4, 'pfannerstill.era@example.com', 5, 17, 6, '0236852018', '0239085191', '01075964134', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '84453527934504', 'Yes', NULL, NULL, '2021-02-28', 'Employee', 8, 10, 'Yes', 'Yes', 4, '11.00', '39657.61', '1321.92', 'Fixed', '1260.18', 'Yes', '718.57', '27675580297269', 'Yes', '602.22', '63959288866623', 'Cach', 'No', NULL, '495 Hyatt Overpass Apt. 874\nKiraville, ND 50519-4922', 0, 'Divorced', NULL, '8923797840610', 'Yes', NULL, 3, 'Prof. Noble Braun DVM', '65268012523847', 'Harveyshire', '2025-01-02', NULL, NULL, NULL, NULL, NULL, 1144087180, 0, 0, 1, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(157, 5559, 847, 'أنور عمار شاكر', 'Male', 2, 2, 4, '2010', 'الهندسة', 'Very_Good', '2011-11-14', '48331863868233', '2028-10-28', 'Lake Melvinview', 3, 'Christian', 3, 'amorar@example.org', 4, 6, 13, '0232522116', '0220052059', '01242218991', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '27364366067128', 'No', NULL, NULL, '2021-04-12', 'Employee', 10, 2, 'No', 'No', 1, '12.00', '18741.08', '624.70', 'Changeable', NULL, 'Yes', '651.91', '57401829834037', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '91190 Strosin Alley Apt. 502\nNorth Alena, SD 55746', 0, 'Widowed', NULL, '8704679666166', 'Yes', NULL, 3, 'Dr. Derrick Quigley DVM', '09943367980125', 'Gusikowskistad', '2026-10-19', NULL, NULL, NULL, NULL, NULL, 1569465637, 0, 0, 2, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(158, 2856, 275, 'أماني علاء تامر', 'Female', 3, 2, 5, '1979', 'الرياضيات', 'Good', '2002-04-05', '45617910477341', '2026-06-02', 'Angelitaport', 4, 'Muslim', 11, 'cassandre.ullrich@example.com', 2, 18, 9, '0220873540', '0239533046', '01031186782', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '16547705158164', 'No', NULL, NULL, '2024-03-20', 'Employee', 3, 6, 'Yes', 'Yes', 4, '9.00', '11248.04', '374.93', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '166 Abigayle Lodge\nWest Christophe, MN 64738-5922', 0, 'Divorced', NULL, '900166739', 'Yes', NULL, 5, 'Mr. Hyman Klein DVM', '22036296447257', 'South Taryn', '2025-09-15', NULL, NULL, NULL, NULL, NULL, 1792819480, 0, 0, 2, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(159, 3371, 50, 'عبدالرحمن طارق ثامر', 'Male', 1, 3, 1, '2005', 'علم الأحياء', 'Excellent', '2019-10-29', '20722957317178', '2026-09-08', 'Mertzland', 4, 'Christian', 2, 'llynch@example.com', 5, 3, 5, '0229954928', '0231855596', '01140925863', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '35660646936040', 'No', NULL, NULL, '2024-06-09', 'Employee', 2, 9, 'No', 'Yes', 2, '11.00', '9691.91', '323.06', 'Changeable', NULL, 'Yes', '894.16', '10766444833303', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '677 Rowena Lane\nWest Leilaborough, OH 61131', 0, 'Single', NULL, '5067514175238', 'Yes', NULL, 3, 'Sofia Spencer', '82712136077219', 'Hagenesside', '2027-12-08', NULL, NULL, NULL, NULL, NULL, 1236680961, 0, 0, 1, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(160, 4339, 94, 'نجلاء نور جواد', 'Female', 4, 3, 6, '2009', 'الرياضيات', 'Very_Good', '2016-12-11', '88323070585475', '2025-10-03', 'New Pansy', 1, 'Christian', 12, 'dewitt.white@example.net', 5, 2, 1, '0227104326', '0227487410', '01069417250', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '50115955995117', 'Yes', NULL, NULL, '2022-12-26', 'Employee', 8, 9, 'No', 'No', 4, '8.00', '43460.68', '1448.69', 'Fixed', '1160.95', 'No', NULL, NULL, 'Yes', '603.06', '57259699391175', 'Visa', 'No', NULL, '637 Grover Freeway Apt. 078\nTerrillhaven, KY 70652-4890', 0, 'Widowed', NULL, '5282003804', 'Yes', NULL, 1, 'Kavon Pfeffer Jr.', '84068387387797', 'Dickimouth', '2026-09-05', NULL, NULL, NULL, NULL, NULL, 19308849, 0, 0, 3, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(161, 4937, 2237, 'حسن بدر أنس', 'Male', 2, 1, 2, '1972', 'الهندسة', 'Excellent', '2004-09-14', '07018162229576', '2028-08-13', 'Danniefort', 4, 'Muslim', 8, 'selena23@example.org', 5, 26, 15, '0230248992', '0233768862', '01262136431', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '96240792238926', 'Yes', NULL, NULL, '2022-08-27', 'Employee', 9, 5, 'Yes', 'No', 2, '8.00', '48238.22', '1607.94', 'Changeable', NULL, 'Yes', '871.22', '35479638046468', 'Yes', '894.22', '90239073212101', 'Visa', 'Yes', NULL, '6546 Bernhard Plain Apt. 844\nZiemeside, NH 87250-7567', 0, 'Widowed', NULL, '70490264614426', 'Yes', NULL, 1, 'Modesto Barton', '11529120235038', 'New Landen', '2027-02-02', NULL, NULL, NULL, NULL, NULL, 1716553977, 0, 0, 1, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(162, 6461, 1538, 'سارة جواد فارس', 'Female', 4, 1, 4, '1999', 'علم الأحياء', 'Excellent', '2014-05-17', '41186697109353', '2028-02-16', 'New Litzyburgh', 7, 'Christian', 10, 'wunsch.vicky@example.com', 4, 24, 15, '0233370059', '0220850461', '01158357641', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '83593906466468', 'Yes', NULL, NULL, '2021-09-13', 'Employee', 6, 7, 'Yes', 'No', 3, '7.00', '9005.96', '300.20', 'Changeable', NULL, 'Yes', '594.25', '38308501561457', 'No', NULL, NULL, 'Cach', 'No', NULL, '374 Mariam Underpass Suite 503\nWest Elisa, WY 86292-0177', 0, 'Single', NULL, '15630674003', 'Yes', NULL, 6, 'Dante VonRueden', '26766209347226', 'Lake Magnusville', '2025-01-28', NULL, NULL, NULL, NULL, NULL, 619483118, 0, 0, 4, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(163, 7441, 2165, 'شادي عبدالرحمن أمجد', 'Male', 3, 2, 1, '1991', 'الهندسة', 'Excellent', '2022-06-06', '52214099987586', '2026-09-07', 'East Xzavierfurt', 6, 'Muslim', 3, 'florine.rohan@example.com', 3, 12, 8, '0223578833', '0229683047', '01059403083', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '86417519686966', 'No', NULL, NULL, '2021-02-17', 'Employee', 4, 3, 'No', 'Yes', 1, '11.00', '25174.86', '839.16', 'Fixed', '1455.07', 'Yes', '746.20', '52865783289210', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '69964 Jamie Coves\nPort Arleneberg, ID 04511', 0, 'Widowed', NULL, '5987433549', 'Yes', NULL, 1, 'Brenna Breitenberg', '43868933352117', 'Kemmermouth', '2027-01-16', NULL, NULL, NULL, NULL, NULL, 738312077, 0, 0, 3, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(164, 8545, 1079, 'عبدالكريم إلياس ماهر', 'Male', 3, 3, 2, '1994', 'إدارة الأعمال', 'Excellent', '2007-06-02', '76313495821667', '2028-02-08', 'Janeberg', 6, 'Muslim', 12, 'welch.sigurd@example.org', 2, 25, 8, '0231025584', '0230267379', '01154308504', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '92329456008136', 'No', NULL, NULL, '2023-10-18', 'Employee', 1, 7, 'Yes', 'Yes', 2, '7.00', '40548.58', '1351.62', 'Fixed', '1733.96', 'Yes', '884.12', '67282446238798', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '72608 Macejkovic Summit\nMiamouth, NV 70379', 0, 'Divorced', NULL, '45793113280', 'Yes', NULL, 1, 'Emmy Konopelski', '82541452573222', 'Torpchester', '2025-10-10', NULL, NULL, NULL, NULL, NULL, 1621955754, 0, 0, 1, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(165, 4089, 214, 'حذيفة حمزة حاتم', 'Male', 2, 3, 6, '1980', 'إدارة الأعمال', 'Fair', '2015-06-02', '08608774225351', '2029-04-26', 'Daremouth', 5, 'Muslim', 6, 'titus96@example.org', 1, 10, 3, '0238496485', '0230186414', '01188363569', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '24438486183139', 'Yes', NULL, NULL, '2020-01-29', 'Employee', 10, 1, 'Yes', 'Yes', 1, '9.00', '31059.85', '1035.33', 'Fixed', '1842.61', 'Yes', '620.80', '14559853918815', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '54863 Kaitlyn Manors\nPort Dayneside, NH 74163', 0, 'Married', NULL, '313247965', 'Yes', NULL, 5, 'Mrs. Aliya Balistreri MD', '70548999332852', 'West Emmitthaven', '2025-02-03', NULL, NULL, NULL, NULL, NULL, 460959555, 0, 0, 4, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(166, 8484, 179, 'نبيل وائل لؤي', 'Male', 4, 1, 6, '1990', 'الرياضيات', 'Very_Good', '2000-08-27', '72225553915049', '2026-10-27', 'McLaughlinhaven', 5, 'Muslim', 12, 'josephine63@example.org', 2, 23, 6, '0228766881', '0226100413', '01509745113', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '49957136129989', 'No', NULL, NULL, '2020-07-24', 'Employee', 7, 6, 'Yes', 'No', 3, '9.00', '7070.50', '235.68', 'Fixed', '1869.68', 'Yes', '684.74', '44905117489952', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '949 Crooks Via Apt. 250\nPort Melissa, LA 15134', 0, 'Married', NULL, '427023310230', 'Yes', NULL, 2, 'Lauriane Tremblay', '19757340513102', 'Lake Estefania', '2029-04-24', NULL, NULL, NULL, NULL, NULL, 1502685916, 0, 0, 4, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(167, 4032, 356, 'رينا عمر إسماعيل', 'Female', 3, 4, 2, '1993', 'الرياضيات', 'Excellent', '2020-04-08', '26943807850621', '2026-10-25', 'Terryhaven', 4, 'Muslim', 7, 'ugreen@example.org', 3, 23, 10, '0220460806', '0230067789', '01064485199', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '30854942207921', 'Yes', NULL, NULL, '2023-10-16', 'Employee', 4, 3, 'Yes', 'Yes', 2, '12.00', '46663.86', '1555.46', 'Fixed', '1456.58', 'Yes', '863.81', '85003825680306', 'No', NULL, NULL, 'Cach', 'No', NULL, '70016 Mackenzie Circles\nFerryview, RI 76607', 0, 'Divorced', NULL, '56463615942', 'Yes', NULL, 4, 'Prof. Gloria Beatty', '34948942337226', 'South Efrainchester', '2027-02-16', NULL, NULL, NULL, NULL, NULL, 1605053858, 0, 0, 3, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(168, 8791, 1883, 'رولا إلياس يوسف', 'Female', 1, 3, 2, '1991', 'علوم الحاسوب', 'Excellent', '2015-11-14', '91290477696884', '2028-02-02', 'New Chelsea', 2, 'Christian', 12, 'terrill.kunze@example.com', 4, 23, 3, '0236212688', '0227379210', '01532963142', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '10252233605329', 'No', NULL, NULL, '2020-04-28', 'Employee', 2, 2, 'Yes', 'Yes', 3, '12.00', '42760.36', '1425.35', 'Fixed', '1649.21', 'Yes', '952.26', '80259627314213', 'Yes', '578.64', '52526553604654', 'Cach', 'No', NULL, '971 Yesenia Ridges\nSouth Quinnfort, OK 77610-8068', 0, 'Widowed', NULL, '71371251434', 'Yes', NULL, 6, 'Unique Mann MD', '36904894581396', 'North Naomiview', '2029-01-21', NULL, NULL, NULL, NULL, NULL, 320515957, 0, 0, 4, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(169, 4067, 2190, 'آلاء أديب أيمن', 'Female', 2, 3, 3, '2008', 'الفيزياء', 'Fair', '2022-09-15', '55570578774355', '2028-09-02', 'Kohlerburgh', 2, 'Muslim', 12, 'natasha82@example.net', 5, 12, 13, '0226119774', '0226833313', '01297581315', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '05162852908005', 'Yes', NULL, NULL, '2023-01-20', 'Employee', 5, 3, 'Yes', 'Yes', 1, '12.00', '25719.90', '857.33', 'Fixed', '1363.89', 'No', NULL, NULL, 'Yes', '957.86', '59001012920103', 'Cach', 'Yes', NULL, '369 Flavio Knolls Apt. 239\nBednarside, OH 37576-0739', 0, 'Married', NULL, '25875264973', 'Yes', NULL, 5, 'Franz Schultz', '76564519657704', 'South Asiabury', '2026-11-11', NULL, NULL, NULL, NULL, NULL, 2006943324, 0, 0, 4, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(170, 5519, 2281, 'مارين صهيب عبدالحميد', 'Female', 1, 2, 4, '1982', 'الفيزياء', 'Fair', '2018-05-26', '34885759392375', '2027-09-24', 'East Haroldfurt', 5, 'Muslim', 9, 'cydney.deckow@example.com', 2, 10, 8, '0233124872', '0234154449', '01598077698', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '01331966864176', 'Yes', NULL, NULL, '2021-03-25', 'Employee', 3, 5, 'No', 'No', 1, '8.00', '20474.35', '682.48', 'Changeable', NULL, 'Yes', '736.28', '74873838047967', 'Yes', '748.24', '49038623271945', 'Cach', 'Yes', NULL, '828 Annamarie Harbor Apt. 120\nLake Bernard, CO 08300', 0, 'Widowed', NULL, '407996030', 'Yes', NULL, 4, 'Elza Feest V', '35646145591018', 'Brandomouth', '2025-02-25', NULL, NULL, NULL, NULL, NULL, 1873433298, 0, 0, 3, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(171, 4591, 2783, 'حنان شريف عمار', 'Female', 4, 3, 2, '1986', 'علم الأحياء', 'Excellent', '2003-09-30', '80110470447215', '2025-06-08', 'West Lester', 6, 'Muslim', 10, 'rtorp@example.net', 1, 18, 2, '0226755928', '0227214469', '01587066866', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '29100880023029', 'No', NULL, NULL, '2021-06-09', 'Employee', 9, 9, 'Yes', 'No', 2, '7.00', '39993.24', '1333.11', 'Fixed', '1076.64', 'Yes', '756.58', '33496661120098', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '727 Jacobi Divide\nEast Emil, NE 27251', 0, 'Married', NULL, '56686992427379', 'Yes', NULL, 4, 'John Kohler', '61133782178006', 'Lefflerhaven', '2027-06-04', NULL, NULL, NULL, NULL, NULL, 843030081, 0, 0, 1, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(172, 8155, 1264, 'محمود حسين جمال', 'Male', 4, 3, 3, '1981', 'الفيزياء', 'Good', '2015-06-15', '78776845070562', '2026-11-08', 'South Sandraborough', 7, 'Christian', 10, 'lfadel@example.net', 4, 19, 7, '0232432111', '0222770227', '01285314479', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '17744544703446', 'No', NULL, NULL, '2021-11-24', 'Employee', 10, 8, 'Yes', 'Yes', 4, '11.00', '18676.35', '622.55', 'Changeable', NULL, 'Yes', '584.37', '67542967787903', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '768 Jones Turnpike Apt. 129\nChaddport, MO 94280', 0, 'Divorced', NULL, '587875114592', 'Yes', NULL, 6, 'Mr. Stuart Durgan Sr.', '63092133135666', 'Herzogfort', '2025-05-18', NULL, NULL, NULL, NULL, NULL, 128128195, 0, 0, 2, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(173, 8021, 1334, 'أمجد حاتم محمود', 'Male', 3, 2, 6, '1991', 'إدارة الأعمال', 'Fair', '2015-04-18', '87745240808558', '2024-12-30', 'Goodwinborough', 2, 'Muslim', 13, 'oral09@example.com', 5, 12, 10, '0234016647', '0222017516', '01572122968', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '52263786865748', 'No', NULL, NULL, '2022-12-18', 'Employee', 9, 10, 'Yes', 'Yes', 1, '9.00', '47283.24', '1576.11', 'Fixed', '1381.84', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '86627 Mark Highway\nNorth Hallechester, OH 66942', 0, 'Divorced', NULL, '59054139808', 'Yes', NULL, 1, 'Mr. Samir Murray', '55589850076028', 'Port Alexieview', '2025-08-30', NULL, NULL, NULL, NULL, NULL, 726037032, 0, 0, 4, NULL, 1, '2024-12-12 15:30:54', '2024-12-12 15:30:54'),
(174, 3829, 637, 'راغب ربيع عبدالرحمن', 'Male', 3, 2, 5, '2013', 'الرياضيات', 'Excellent', '2003-11-12', '75614765588700', '2026-07-20', 'Lake Jasperport', 2, 'Christian', 11, 'virginia.corkery@example.org', 5, 25, 2, '0221617232', '0237911202', '01033877533', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '40901108416012', 'Yes', NULL, NULL, '2023-12-15', 'Employee', 7, 5, 'Yes', 'No', 1, '10.00', '25594.18', '853.14', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '78371 Archibald Way\nLessiehaven, CA 43130-4393', 0, 'Widowed', NULL, '33257515', 'Yes', NULL, 3, 'Cortez Robel DVM', '94198949093590', 'Jaylinville', '2028-07-30', NULL, NULL, NULL, NULL, NULL, 617245119, 0, 0, 4, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(175, 1173, 969, 'ميس عامر عامر', 'Female', 3, 1, 4, '1997', 'علوم الحاسوب', 'Good', '2001-12-03', '44099502047797', '2029-03-06', 'East Stephaniemouth', 6, 'Christian', 5, 'myron.funk@example.org', 1, 20, 6, '0233515767', '0227446676', '01532283818', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '46197257222556', 'No', NULL, NULL, '2021-05-15', 'Employee', 7, 5, 'Yes', 'No', 1, '7.00', '23354.02', '778.47', 'Changeable', NULL, 'Yes', '847.53', '95136034058967', 'Yes', '730.42', '34726374286339', 'Visa', 'No', NULL, '776 Jeffery Street\nNew Donatomouth, VT 31556', 0, 'Divorced', NULL, '21893202066548', 'Yes', NULL, 4, 'Lenny Graham', '75196285794007', 'South Isabel', '2028-04-29', NULL, NULL, NULL, NULL, NULL, 1693901117, 0, 0, 4, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(176, 2230, 2540, 'علا عدنان مازن', 'Female', 2, 3, 3, '1986', 'إدارة الأعمال', 'Fair', '2016-08-31', '81519742577888', '2026-08-26', 'Alannaville', 5, 'Christian', 4, 'flavio.dickens@example.com', 1, 26, 3, '0236641177', '0229310604', '01572015095', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '31233656637200', 'No', NULL, NULL, '2023-08-23', 'Employee', 10, 7, 'Yes', 'Yes', 2, '7.00', '23795.49', '793.18', 'Fixed', '1375.59', 'No', NULL, NULL, 'Yes', '619.13', '57723709448302', 'Cach', 'Yes', NULL, '599 Ted Ramp Apt. 560\nLake Fanny, AZ 38492-7380', 0, 'Divorced', NULL, '955301533240876', 'Yes', NULL, 4, 'Cecilia Dare', '70332559385590', 'East Jailynmouth', '2026-11-20', NULL, NULL, NULL, NULL, NULL, 1261439483, 0, 0, 2, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(177, 4069, 2997, 'بكر أنور سامي', 'Male', 1, 3, 3, '1970', 'علم الأحياء', 'Excellent', '2018-08-30', '83094073707083', '2026-01-21', 'North Cleomouth', 5, 'Christian', 8, 'sporer.junior@example.com', 1, 23, 14, '0225615486', '0227787247', '01520648455', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '08368125187791', 'Yes', NULL, NULL, '2024-08-14', 'Employee', 1, 2, 'No', 'No', 3, '11.00', '14685.45', '489.52', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '797.03', '27555407587906', 'Visa', 'Yes', NULL, '83211 Virginia Flat Apt. 522\nNew Taurean, LA 80515', 0, 'Widowed', NULL, '2160339290472', 'Yes', NULL, 6, 'Ernestina Predovic', '01830174882626', 'Karinamouth', '2026-09-21', NULL, NULL, NULL, NULL, NULL, 807472310, 0, 0, 4, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55');
INSERT INTO `employees` (`id`, `employee_code`, `fp_code`, `name`, `gender`, `branch_id`, `job_grade_id`, `qualification_id`, `qualification_year`, `major`, `graduation_estimate`, `brith_date`, `national_id`, `end_national_id`, `national_id_place`, `blood_types_id`, `religion`, `language_id`, `email`, `country_id`, `governorate_id`, `city_id`, `home_telephone`, `work_telephone`, `mobile`, `military`, `military_date_from`, `military_date_to`, `military_wepon`, `military_exemption_date`, `military_exemption_reason`, `military_postponement_reason`, `date_resignation`, `resignation_reason`, `driving_license`, `driving_license_type`, `driving_License_id`, `has_relatives`, `relatives_details`, `notes`, `work_start_date`, `functional_status`, `department_id`, `job_categories_id`, `has_attendance`, `has_fixed_shift`, `shift_types_id`, `daily_work_hour`, `salary`, `day_price`, `motivation_type`, `motivation`, `social_insurance`, `social_insurance_cut_monthely`, `social_insurance_number`, `medical_insurance`, `medical_insurance_cut_monthely`, `medical_insurance_number`, `Type_salary_receipt`, `active_vacation`, `urgent_person_details`, `staies_address`, `children_number`, `social_status`, `resignation_id`, `bank_number_account`, `disabilities`, `disabilities_type`, `nationality_id`, `name_sponsor`, `pasport_identity`, `pasport_from_place`, `pasport_exp_date`, `num_vacation_days`, `add_service`, `years_service`, `cv`, `basic_address_country`, `fixed_allowances`, `is_done_Vacation_formula`, `is_Sensitive_manager_data`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(178, 9682, 2585, 'سهى عادل عمار', 'Female', 1, 1, 3, '1972', 'إدارة الأعمال', 'Fair', '2019-05-16', '32291730357259', '2027-07-26', 'East Wilmer', 2, 'Muslim', 4, 'kailyn64@example.net', 3, 12, 5, '0225675611', '0231948777', '01584011911', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '61611690464222', 'No', NULL, NULL, '2024-08-31', 'Employee', 1, 4, 'No', 'Yes', 3, '10.00', '36742.43', '1224.75', 'Changeable', NULL, 'Yes', '991.64', '65828551107739', 'Yes', '834.89', '51205234128715', 'Visa', 'No', NULL, '68810 Green Square Suite 988\nWelchport, NM 73230-9228', 0, 'Single', NULL, '0892703620567', 'Yes', NULL, 6, 'Kurt Halvorson', '14175602491311', 'Ferryburgh', '2029-08-20', NULL, NULL, NULL, NULL, NULL, 328156273, 0, 0, 4, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(179, 1831, 310, 'شادي محمود عدنان', 'Male', 4, 4, 4, '1978', 'إدارة الأعمال', 'Fair', '2003-04-20', '49932165865676', '2029-04-21', 'South Marcburgh', 5, 'Muslim', 1, 'daphney.spinka@example.net', 3, 16, 4, '0233904974', '0222590359', '01275480198', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '12265335578541', 'Yes', NULL, NULL, '2023-07-29', 'Employee', 9, 3, 'No', 'No', 2, '12.00', '20823.50', '694.12', 'Fixed', '1264.31', 'Yes', '744.99', '02073618298146', 'Yes', '954.38', '43409889406359', 'Visa', 'No', NULL, '20035 Osvaldo Trace\nNorth Mohammadberg, VT 80805', 0, 'Divorced', NULL, '158097991', 'Yes', NULL, 3, 'Prof. Deon Schneider', '58071979364038', 'East Rhettview', '2029-08-17', NULL, NULL, NULL, NULL, NULL, 1152461110, 0, 0, 2, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(180, 2298, 1082, 'يحيى قاسم سعيد', 'Male', 2, 4, 6, '2012', 'الهندسة', 'Fair', '2012-09-23', '21084367792516', '2027-01-15', 'Watsicamouth', 1, 'Christian', 7, 'ferne01@example.com', 5, 5, 3, '0224631801', '0221516114', '01582171481', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '24003498168881', 'No', NULL, NULL, '2024-03-10', 'Employee', 7, 3, 'Yes', 'No', 1, '10.00', '8710.90', '290.36', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '842 Durgan Squares Suite 258\nNew Kristin, GA 39040-5066', 0, 'Widowed', NULL, '8445653607', 'Yes', NULL, 4, 'Shanny Hauck', '40131118942900', 'Archfort', '2026-04-16', NULL, NULL, NULL, NULL, NULL, 1829939805, 0, 0, 4, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(181, 9675, 394, 'فايزة رامي عماد', 'Female', 1, 2, 1, '1998', 'إدارة الأعمال', 'Fair', '2009-08-26', '98600540510456', '2026-10-13', 'Erynport', 3, 'Christian', 2, 'gutmann.kassandra@example.com', 1, 6, 14, '0231033897', '0239020224', '01533629756', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '73731828218584', 'No', NULL, NULL, '2022-08-23', 'Employee', 9, 3, 'Yes', 'No', 3, '11.00', '19270.69', '642.36', 'Fixed', '1111.14', 'Yes', '896.17', '21510177201860', 'Yes', '506.22', '93314533119349', 'Cach', 'No', NULL, '756 Liliane Ridges\nKacistad, MA 07266-9018', 0, 'Widowed', NULL, '28544684693', 'Yes', NULL, 4, 'Dandre McKenzie', '41367311685352', 'East Antoinetteview', '2026-05-30', NULL, NULL, NULL, NULL, NULL, 881558623, 0, 0, 4, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(182, 3988, 463, 'توفيق أكرم رامي', 'Male', 4, 3, 6, '2011', 'علم الأحياء', 'Good', '2002-11-07', '48309450008307', '2025-01-19', 'Dickinsonborough', 6, 'Christian', 1, 'dickinson.zakary@example.net', 6, 4, 7, '0222029626', '0222401086', '01124898438', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '09593405390085', 'No', NULL, NULL, '2023-01-20', 'Employee', 5, 6, 'No', 'No', 2, '9.00', '25056.30', '835.21', 'Fixed', '1748.54', 'Yes', '885.96', '09383114911856', 'Yes', '998.81', '25878769139460', 'Visa', 'No', NULL, '9766 Murphy Extension\nCaesarshire, LA 33343-1324', 0, 'Widowed', NULL, '604865334', 'Yes', NULL, 6, 'Annetta Spinka', '34654169629439', 'Lake Dalefort', '2029-02-09', NULL, NULL, NULL, NULL, NULL, 654900321, 0, 0, 2, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(183, 8033, 1550, 'بدر راغب أديب', 'Male', 1, 1, 4, '1995', 'علوم الحاسوب', 'Very_Good', '2008-03-13', '98337017763074', '2026-10-03', 'East Miracle', 2, 'Muslim', 3, 'jeanne51@example.net', 2, 1, 13, '0238702672', '0238855890', '01123587506', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '40851790662025', 'Yes', NULL, NULL, '2024-02-23', 'Employee', 9, 8, 'No', 'No', 3, '10.00', '47289.35', '1576.31', 'Changeable', NULL, 'Yes', '715.89', '25996020667782', 'Yes', '919.92', '52331272586339', 'Cach', 'No', NULL, '592 Vanessa Alley\nCarlotown, DC 03326', 0, 'Widowed', NULL, '93626902812', 'Yes', NULL, 4, 'Willy Mosciski', '81850324885161', 'Lake Judge', '2027-11-05', NULL, NULL, NULL, NULL, NULL, 1823506283, 0, 0, 1, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(184, 9452, 2538, 'رنا قاسم يوسف', 'Female', 3, 4, 3, '1993', 'الرياضيات', 'Excellent', '2008-11-07', '34455545878515', '2026-08-05', 'Samanthaville', 1, 'Christian', 5, 'velma.barrows@example.net', 3, 2, 3, '0228865690', '0222821619', '01252295570', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '36738654437285', 'Yes', NULL, NULL, '2020-08-24', 'Employee', 8, 4, 'No', 'No', 2, '10.00', '42101.92', '1403.40', 'Fixed', '1217.24', 'Yes', '801.13', '46533469334014', 'No', NULL, NULL, 'Visa', 'No', NULL, '330 Erik Grove\nJovanberg, DE 26789', 0, 'Married', NULL, '0406473449665', 'Yes', NULL, 6, 'Miss Jacky Mosciski II', '03230126115033', 'South Arielville', '2026-08-07', NULL, NULL, NULL, NULL, NULL, 491819410, 0, 0, 1, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(185, 5306, 1274, 'نادر باسم حامد', 'Male', 4, 2, 6, '1979', 'علم الأحياء', 'Good', '2012-09-12', '07815215634163', '2025-11-05', 'Hesseltown', 4, 'Muslim', 6, 'hank60@example.net', 6, 21, 12, '0232077957', '0221987288', '01522505133', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '97718589366682', 'Yes', NULL, NULL, '2020-07-04', 'Employee', 6, 9, 'No', 'No', 1, '8.00', '48819.14', '1627.30', 'Fixed', '1944.61', 'Yes', '616.48', '00013593725311', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '83694 Sawayn Landing Apt. 956\nHoppestad, FL 34966', 0, 'Divorced', NULL, '0636645279342543', 'Yes', NULL, 2, 'Zoey Torphy', '10813442508944', 'Markfurt', '2028-12-06', NULL, NULL, NULL, NULL, NULL, 1196747596, 0, 0, 1, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(186, 9388, 1033, 'فايزة رياض زياد', 'Female', 1, 2, 4, '1982', 'الهندسة', 'Fair', '2004-02-01', '70757304640456', '2028-06-10', 'Lourdesshire', 3, 'Muslim', 7, 'qadams@example.net', 2, 15, 7, '0228421070', '0220711899', '01549603146', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '47829025603255', 'Yes', NULL, NULL, '2020-12-15', 'Employee', 10, 2, 'Yes', 'No', 3, '8.00', '11151.56', '371.72', 'Changeable', NULL, 'Yes', '931.08', '10100648275945', 'Yes', '571.35', '38284109702317', 'Cach', 'No', NULL, '941 Emard Freeway\nPort Alexandroborough, KS 66413', 0, 'Single', NULL, '8813422915823', 'Yes', NULL, 1, 'Prof. Glenna O\'Reilly', '33133218531426', 'Kuhnland', '2029-05-26', NULL, NULL, NULL, NULL, NULL, 1759029759, 0, 0, 4, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(187, 8477, 194, 'نبيل عبداللطيف تامر', 'Male', 4, 2, 6, '2014', 'الرياضيات', 'Excellent', '2019-01-22', '71266715593692', '2029-09-29', 'Casandraland', 7, 'Muslim', 2, 'schmidt.patricia@example.com', 4, 17, 5, '0239962402', '0222240535', '01087463410', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '73933878088652', 'Yes', NULL, NULL, '2022-11-25', 'Employee', 5, 3, 'No', 'Yes', 2, '7.00', '45151.19', '1505.04', 'Fixed', '1994.64', 'Yes', '698.27', '90277734120379', 'Yes', '511.61', '75289090606012', 'Cach', 'No', NULL, '5294 Casper Pines\nFadelfort, ME 25031-9183', 0, 'Widowed', NULL, '52112869920', 'Yes', NULL, 3, 'Mabelle Wiegand', '13043350069249', 'West Jean', '2025-05-13', NULL, NULL, NULL, NULL, NULL, 652976250, 0, 0, 4, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(188, 4551, 2343, 'سعاد عبدالحي أنور', 'Female', 3, 4, 2, '1994', 'الرياضيات', 'Very_Good', '2001-09-24', '77385083732295', '2026-07-29', 'Marlonview', 2, 'Christian', 12, 'valentine44@example.com', 6, 3, 15, '0238820863', '0222806895', '01534881199', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '56019493634437', 'Yes', NULL, NULL, '2021-01-11', 'Employee', 1, 4, 'Yes', 'No', 3, '8.00', '32600.37', '1086.68', 'Fixed', '1832.06', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '2316 Pacocha Rapids\nKorbinside, AL 16735-1081', 0, 'Married', NULL, '68544711316997', 'Yes', NULL, 2, 'Karolann Bayer II', '87804937180108', 'Chloeview', '2029-04-25', NULL, NULL, NULL, NULL, NULL, 432211089, 0, 0, 1, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(189, 9086, 2017, 'جميلة عصام وائل', 'Female', 3, 3, 6, '1987', 'علم الأحياء', 'Very_Good', '2004-11-30', '64986737071261', '2028-07-05', 'South Adelia', 2, 'Christian', 1, 'mustafa.mayer@example.net', 6, 18, 2, '0220974595', '0222844996', '01016275934', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '97632827090139', 'Yes', NULL, NULL, '2022-02-16', 'Employee', 6, 10, 'Yes', 'No', 3, '10.00', '30373.65', '1012.46', 'Fixed', '1908.05', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '86861 Sandrine Stravenue\nBradlyview, OH 08254', 0, 'Widowed', NULL, '765475845227', 'Yes', NULL, 5, 'Eloise Keebler', '23790432054362', 'Port Deionfurt', '2025-02-01', NULL, NULL, NULL, NULL, NULL, 69473709, 0, 0, 1, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(190, 9820, 2794, 'عبدالرزاق عماد رامز', 'Male', 1, 2, 6, '2008', 'إدارة الأعمال', 'Excellent', '2021-02-13', '04747024077212', '2028-03-28', 'Brannonhaven', 2, 'Christian', 6, 'forest30@example.com', 4, 5, 5, '0239874421', '0225756327', '01266885233', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '16676693117438', 'Yes', NULL, NULL, '2022-03-09', 'Employee', 7, 8, 'Yes', 'Yes', 1, '8.00', '42941.47', '1431.38', 'Changeable', NULL, 'Yes', '544.97', '43481134020316', 'No', NULL, NULL, 'Visa', 'No', NULL, '335 Feil Field\nDanikachester, OR 53070-8498', 0, 'Widowed', NULL, '917312205739', 'Yes', NULL, 1, 'Mr. Berry Goodwin', '47719652971579', 'South Sydnee', '2028-11-23', NULL, NULL, NULL, NULL, NULL, 809927685, 0, 0, 3, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(191, 7272, 1297, 'هند عبدالله عبدالفتاح', 'Female', 2, 3, 6, '1988', 'الفيزياء', 'Fair', '2018-04-21', '37333311739721', '2029-03-26', 'Bashirianport', 2, 'Christian', 3, 'dagmar23@example.net', 5, 13, 7, '0233316781', '0224872134', '01594475441', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '05794195512430', 'No', NULL, NULL, '2020-12-28', 'Employee', 4, 4, 'No', 'No', 4, '11.00', '5740.22', '191.34', 'Fixed', '1493.86', 'Yes', '858.81', '41285320555257', 'No', NULL, NULL, 'Visa', 'No', NULL, '535 Dante Underpass\nNew Alaynaburgh, SC 25313', 0, 'Divorced', NULL, '117257389', 'Yes', NULL, 1, 'Prof. Rosella Aufderhar', '87975235904765', 'Franeckiport', '2025-04-27', NULL, NULL, NULL, NULL, NULL, 756434598, 0, 0, 1, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(192, 2675, 324, 'سهى علي وجيه', 'Female', 1, 2, 2, '2009', 'إدارة الأعمال', 'Fair', '2013-08-07', '27098780543698', '2029-10-06', 'South Jasen', 3, 'Muslim', 11, 'hillard30@example.net', 2, 27, 14, '0233804329', '0236367434', '01550221574', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '13747022565637', 'Yes', NULL, NULL, '2021-05-06', 'Employee', 7, 4, 'No', 'No', 4, '7.00', '42983.73', '1432.79', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '688.83', '79646755590280', 'Visa', 'No', NULL, '9043 Perry Lodge\nNorth Ricky, MT 75521', 0, 'Widowed', NULL, '352052601988', 'Yes', NULL, 3, 'Raven Ferry', '96099579401234', 'Theodorefort', '2029-09-03', NULL, NULL, NULL, NULL, NULL, 756959174, 0, 0, 2, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(193, 7446, 1872, 'صفا عماد حاتم', 'Female', 3, 2, 6, '1977', 'إدارة الأعمال', 'Excellent', '2019-11-12', '71392972571280', '2026-06-29', 'Port Onieside', 6, 'Muslim', 4, 'sgibson@example.com', 5, 23, 14, '0227167783', '0229156819', '01164426828', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '72312868275733', 'Yes', NULL, NULL, '2023-05-23', 'Employee', 6, 3, 'No', 'No', 4, '10.00', '14672.49', '489.08', 'Changeable', NULL, 'Yes', '547.19', '82009996954620', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '3467 Mackenzie Orchard Apt. 974\nWest Theodora, WV 87043', 0, 'Widowed', NULL, '10679737', 'Yes', NULL, 3, 'Trace Kautzer Jr.', '05124127821967', 'Geomouth', '2027-04-16', NULL, NULL, NULL, NULL, NULL, 1874411163, 0, 0, 3, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(194, 7546, 835, 'مارين حسن زيد', 'Female', 2, 3, 3, '2010', 'إدارة الأعمال', 'Fair', '2006-08-31', '05407500149963', '2026-09-04', 'New Trevermouth', 3, 'Christian', 8, 'yessenia87@example.org', 5, 2, 4, '0236219664', '0236917880', '01006236261', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '92379405969204', 'Yes', NULL, NULL, '2022-01-23', 'Employee', 10, 1, 'Yes', 'No', 4, '11.00', '23471.50', '782.38', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '2285 Abernathy Parks Apt. 606\nNew Allison, MN 90473-6335', 0, 'Widowed', NULL, '2592785', 'Yes', NULL, 2, 'Mr. Casey Schroeder', '41556067787790', 'Marcelinohaven', '2025-04-14', NULL, NULL, NULL, NULL, NULL, 1547915634, 0, 0, 4, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(195, 1383, 590, 'نوران حمزة راغب', 'Female', 2, 4, 3, '1998', 'الرياضيات', 'Good', '2006-06-28', '52435659582872', '2026-12-02', 'South Hailey', 4, 'Muslim', 5, 'alangworth@example.org', 4, 11, 15, '0224960347', '0232075910', '01575479136', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '17935921707023', 'Yes', NULL, NULL, '2020-12-15', 'Employee', 6, 2, 'Yes', 'Yes', 2, '9.00', '31905.95', '1063.53', 'Fixed', '1938.68', 'No', NULL, NULL, 'Yes', '830.59', '40592580221518', 'Visa', 'No', NULL, '7608 Fred Courts Suite 815\nLake Emery, IN 75520-6707', 0, 'Widowed', NULL, '548341642', 'Yes', NULL, 2, 'Hipolito Ferry', '44141586925808', 'East Dana', '2028-10-29', NULL, NULL, NULL, NULL, NULL, 636704011, 0, 0, 2, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(196, 7569, 200, 'محمود راغب أديب', 'Male', 3, 1, 4, '2000', 'الفيزياء', 'Very_Good', '2000-07-14', '41828546256895', '2025-06-05', 'Champlinfurt', 7, 'Christian', 2, 'gaylord.otilia@example.com', 5, 8, 15, '0227562729', '0228468439', '01030911868', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '52071802981995', 'Yes', NULL, NULL, '2022-08-26', 'Employee', 9, 8, 'No', 'No', 3, '12.00', '27744.38', '924.81', 'Changeable', NULL, 'Yes', '689.48', '07628641195792', 'No', NULL, NULL, 'Visa', 'No', NULL, '114 Kyler Courts\nAlanisland, MA 59700-3754', 0, 'Widowed', NULL, '111407026139', 'Yes', NULL, 4, 'Jedediah Labadie', '30792863338831', 'Strosinview', '2028-05-17', NULL, NULL, NULL, NULL, NULL, 2087836368, 0, 0, 4, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(197, 2643, 888, 'مايا مازن عمر', 'Female', 3, 3, 2, '1989', 'علوم الحاسوب', 'Very_Good', '2017-10-23', '22368559044104', '2026-03-03', 'Jadehaven', 7, 'Muslim', 7, 'oconner.lambert@example.net', 3, 6, 2, '0232476738', '0239466360', '01557678526', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '58043761195217', 'No', NULL, NULL, '2022-07-12', 'Employee', 6, 1, 'No', 'Yes', 1, '8.00', '22166.62', '738.89', 'Fixed', '1511.28', 'Yes', '558.32', '40802819501223', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '375 Borer Glen\nBruentown, WI 53019', 0, 'Widowed', NULL, '8978971624633', 'Yes', NULL, 5, 'Mrs. Alysa Moore IV', '20748035275495', 'Hermannstad', '2027-01-02', NULL, NULL, NULL, NULL, NULL, 316665989, 0, 0, 4, NULL, 1, '2024-12-12 15:30:55', '2024-12-12 15:30:55'),
(198, 9737, 763, 'كريم نادر مصطفى', 'Male', 2, 3, 4, '1981', 'الرياضيات', 'Excellent', '2003-06-15', '89983631027286', '2027-12-16', 'Raphaelleshire', 1, 'Muslim', 5, 'wintheiser.ramona@example.org', 6, 1, 10, '0228995017', '0230165222', '01230183438', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '27022352281167', 'No', NULL, NULL, '2020-08-08', 'Employee', 8, 8, 'No', 'Yes', 1, '9.00', '15103.52', '503.45', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '78177 Vallie Center Suite 759\nAidanland, WY 36353-7746', 0, 'Divorced', NULL, '56703219920', 'Yes', NULL, 4, 'Benton Schamberger Sr.', '39662807873626', 'West Mariam', '2026-01-26', NULL, NULL, NULL, NULL, NULL, 1041997160, 0, 0, 3, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(199, 3516, 1655, 'لجين عبدالحكيم سامر', 'Female', 1, 3, 5, '1983', 'إدارة الأعمال', 'Very_Good', '2004-07-16', '28229958459578', '2026-10-26', 'Marcellusland', 2, 'Christian', 8, 'opaucek@example.net', 4, 5, 8, '0231305343', '0228095257', '01136532049', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '84651996852793', 'No', NULL, NULL, '2022-05-17', 'Employee', 1, 7, 'No', 'No', 2, '12.00', '49446.58', '1648.22', 'Fixed', '1007.15', 'Yes', '624.89', '96898662671591', 'No', NULL, NULL, 'Cach', 'No', NULL, '6942 Jenifer Path Suite 205\nNorth Leonard, NJ 04675-0396', 0, 'Divorced', NULL, '0661167127066', 'Yes', NULL, 3, 'Nora Sauer PhD', '86223336504000', 'Hobartstad', '2025-10-30', NULL, NULL, NULL, NULL, NULL, 1355795765, 0, 0, 1, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(200, 7715, 2505, 'صهيب عبدالرزاق ثامر', 'Male', 1, 4, 2, '1977', 'الهندسة', 'Good', '2015-04-17', '18411408367227', '2026-09-11', 'West Eliasburgh', 7, 'Muslim', 4, 'maureen87@example.org', 4, 11, 15, '0238089279', '0233888311', '01588192293', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '04940637734686', 'No', NULL, NULL, '2024-05-28', 'Employee', 9, 2, 'Yes', 'No', 4, '8.00', '10878.32', '362.61', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '449 Ferry Canyon\nDelaneymouth, CO 49809-0293', 0, 'Widowed', NULL, '285967714', 'Yes', NULL, 4, 'Alena Dare', '97712706721060', 'North Anjali', '2029-11-16', NULL, NULL, NULL, NULL, NULL, 791926412, 0, 0, 4, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(201, 7279, 1057, 'نوران عبدالحكيم زين', 'Female', 2, 1, 2, '2014', 'علم الأحياء', 'Excellent', '2011-03-16', '92601383563649', '2027-07-15', 'Port Alverta', 5, 'Christian', 5, 'cratke@example.org', 2, 13, 14, '0220038808', '0239060058', '01011855883', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '09807652987917', 'No', NULL, NULL, '2020-08-19', 'Employee', 1, 4, 'Yes', 'No', 4, '10.00', '12028.93', '400.96', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '1713 Cooper Street\nLake Alecville, DE 30241-5834', 0, 'Married', NULL, '1035723238', 'Yes', NULL, 2, 'Miss Kaylie Weimann', '20271543189690', 'South Abigale', '2025-03-01', NULL, NULL, NULL, NULL, NULL, 1723398378, 0, 0, 4, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(202, 5569, 2645, 'رانيا راغب عبدالباسط', 'Female', 4, 4, 2, '2014', 'علوم الحاسوب', 'Very_Good', '2009-01-11', '66683228578291', '2029-09-27', 'East Majorville', 4, 'Christian', 2, 'gay.hahn@example.org', 5, 12, 12, '0222761038', '0232491690', '01541870507', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '94638951041149', 'No', NULL, NULL, '2022-05-26', 'Employee', 6, 2, 'Yes', 'Yes', 3, '11.00', '14426.77', '480.89', 'Changeable', NULL, 'Yes', '619.65', '52672649427572', 'No', NULL, NULL, 'Cach', 'No', NULL, '99005 Dibbert Rue Suite 359\nWillmsville, MD 68767-4948', 0, 'Divorced', NULL, '02302281515', 'Yes', NULL, 1, 'Albert Durgan', '34819434755589', 'Lake Dominicborough', '2027-02-28', NULL, NULL, NULL, NULL, NULL, 1036872597, 0, 0, 4, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(203, 9016, 1240, 'بسمة وائل عبدالسلام', 'Female', 3, 4, 6, '1971', 'الرياضيات', 'Excellent', '2019-01-06', '30052121879760', '2027-10-11', 'Huntermouth', 6, 'Christian', 2, 'darrick.hoeger@example.net', 1, 3, 6, '0223935431', '0230539759', '01562976339', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '17830057366895', 'No', NULL, NULL, '2023-03-28', 'Employee', 2, 6, 'No', 'No', 3, '11.00', '27141.28', '904.71', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '42692 Hoppe Corners\nWest Gunnar, NV 66341', 0, 'Married', NULL, '138687465999', 'Yes', NULL, 1, 'Kariane Cormier', '11254900747645', 'Kautzerside', '2028-07-16', NULL, NULL, NULL, NULL, NULL, 1722075596, 0, 0, 3, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(204, 9738, 1620, 'جمانة وجيه شريف', 'Female', 2, 2, 5, '1971', 'الهندسة', 'Excellent', '2021-06-06', '56610256658419', '2028-06-09', 'Port Timmy', 4, 'Christian', 1, 'kathlyn14@example.net', 6, 11, 11, '0227159587', '0239571433', '01287572830', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '57683283879970', 'No', NULL, NULL, '2021-01-23', 'Employee', 4, 8, 'No', 'No', 3, '12.00', '23244.90', '774.83', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '79584 Murray Freeway Apt. 427\nNorth Cyrus, IA 80011', 0, 'Divorced', NULL, '5811227535902', 'Yes', NULL, 3, 'Shawna Feeney', '58865212309013', 'Kuhicburgh', '2027-11-11', NULL, NULL, NULL, NULL, NULL, 1120287114, 0, 0, 3, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(205, 1720, 486, 'عبدالسلام طلال عماد', 'Male', 3, 3, 1, '1973', 'الفيزياء', 'Fair', '2023-01-14', '92919690738039', '2028-02-01', 'Havenside', 7, 'Christian', 11, 'moen.eula@example.net', 3, 17, 1, '0227610578', '0222041343', '01013784604', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '22841407865148', 'Yes', NULL, NULL, '2022-07-03', 'Employee', 8, 8, 'Yes', 'No', 2, '9.00', '44341.42', '1478.05', 'Fixed', '1685.76', 'Yes', '791.29', '57718950059789', 'No', NULL, NULL, 'Visa', 'No', NULL, '24927 Bednar Drive\nEast Lolitachester, WV 10965', 0, 'Single', NULL, '84673363', 'Yes', NULL, 5, 'Monserrate Kemmer', '97707308399355', 'Kuhnville', '2029-04-12', NULL, NULL, NULL, NULL, NULL, 1491177313, 0, 0, 1, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(206, 2871, 1039, 'حمزة حذيفة سامي', 'Male', 1, 4, 6, '2000', 'الرياضيات', 'Fair', '2024-10-19', '62253390074063', '2027-03-01', 'Batzside', 3, 'Muslim', 3, 'fbednar@example.com', 1, 27, 4, '0239243884', '0225679031', '01082047696', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '08523951420078', 'Yes', NULL, NULL, '2021-01-27', 'Employee', 9, 1, 'Yes', 'No', 4, '9.00', '16161.74', '538.72', 'Changeable', NULL, 'Yes', '626.42', '64510824758887', 'No', NULL, NULL, 'Visa', 'No', NULL, '14332 Whitney Mountain Suite 024\nBogisichbury, KY 84038-4247', 0, 'Married', NULL, '094082609', 'Yes', NULL, 6, 'Mr. Madison Kunze IV', '99040645049444', 'Nienowville', '2029-05-28', NULL, NULL, NULL, NULL, NULL, 1015184248, 0, 0, 2, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(207, 5548, 2807, 'لينا سامر حذيفة', 'Female', 2, 1, 3, '1981', 'إدارة الأعمال', 'Excellent', '2015-04-05', '65396139007538', '2027-08-24', 'Kuvalisport', 4, 'Muslim', 11, 'georgianna72@example.net', 4, 25, 10, '0232538848', '0229095446', '01021908035', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '36336004523243', 'No', NULL, NULL, '2020-02-09', 'Employee', 7, 1, 'Yes', 'Yes', 3, '9.00', '19622.95', '654.10', 'Fixed', '1296.99', 'No', NULL, NULL, 'Yes', '927.61', '49435488601248', 'Cach', 'Yes', NULL, '974 Steve Loaf Apt. 610\nConcepcionberg, SD 92039-9554', 0, 'Married', NULL, '986274459808', 'Yes', NULL, 2, 'Mrs. Marianna Rosenbaum', '10409262824613', 'Lake Jo', '2026-12-03', NULL, NULL, NULL, NULL, NULL, 159134979, 0, 0, 2, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(208, 4522, 2621, 'عدنان عمر مصطفى', 'Male', 4, 4, 1, '1986', 'علوم الحاسوب', 'Fair', '2013-09-13', '28997760334833', '2027-08-10', 'South Van', 7, 'Christian', 12, 'lorna.predovic@example.net', 3, 26, 3, '0228285234', '0226128942', '01074909408', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '18020352942400', 'Yes', NULL, NULL, '2022-10-21', 'Employee', 2, 10, 'Yes', 'No', 3, '7.00', '13546.48', '451.55', 'Fixed', '1462.53', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '911 Magali Cove\nBrakuston, NV 68004-5039', 0, 'Single', NULL, '070993275991957', 'Yes', NULL, 2, 'Lavinia Schmitt', '38749873114384', 'South Lillianaville', '2027-01-06', NULL, NULL, NULL, NULL, NULL, 159782733, 0, 0, 1, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(209, 3082, 2924, 'كنزي شاكر عبدالرزاق', 'Female', 3, 4, 1, '1980', 'إدارة الأعمال', 'Excellent', '2017-08-03', '35826179773301', '2029-06-25', 'Westton', 4, 'Christian', 7, 'hammes.antone@example.org', 5, 16, 4, '0227025143', '0229709775', '01113411762', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '58067785199616', 'Yes', NULL, NULL, '2023-10-06', 'Employee', 8, 4, 'No', 'No', 1, '11.00', '38634.07', '1287.80', 'Fixed', '1773.20', 'Yes', '778.89', '30210610401485', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '929 Kiehn Hollow Suite 736\nWest Patsyhaven, SC 41084-7798', 0, 'Divorced', NULL, '14584866383', 'Yes', NULL, 4, 'Mr. Justus Zieme', '95849377899578', 'West Monroe', '2026-07-11', NULL, NULL, NULL, NULL, NULL, 1950150845, 0, 0, 4, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(210, 8766, 378, 'روى صهيب عماد', 'Female', 4, 3, 1, '1990', 'الرياضيات', 'Good', '2024-08-12', '90245526863332', '2027-12-25', 'New Edwardo', 7, 'Christian', 6, 'hudson.rachel@example.com', 2, 14, 9, '0226128022', '0227725210', '01049123226', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '78916898343307', 'Yes', NULL, NULL, '2020-07-31', 'Employee', 2, 10, 'Yes', 'No', 1, '10.00', '15192.86', '506.43', 'Fixed', '1904.65', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '1147 Kiehn Parks Suite 147\nStehrshire, WV 11312-3705', 0, 'Married', NULL, '5871626356788', 'Yes', NULL, 1, 'Adele Ondricka I', '37479071915549', 'Williamsontown', '2027-10-21', NULL, NULL, NULL, NULL, NULL, 1552047904, 0, 0, 1, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(211, 8962, 629, 'روى أيوب طلال', 'Female', 1, 3, 4, '1978', 'علم الأحياء', 'Excellent', '2005-04-24', '87024599424912', '2027-04-03', 'Schillerport', 4, 'Muslim', 9, 'gschmidt@example.com', 4, 10, 7, '0224177675', '0221206404', '01134831687', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '78488674772806', 'Yes', NULL, NULL, '2024-10-11', 'Employee', 10, 7, 'No', 'Yes', 3, '9.00', '23183.81', '772.79', 'Fixed', '1866.05', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'No', NULL, '7269 Eunice Ville\nHettingermouth, CT 71027-6189', 0, 'Divorced', NULL, '43537528652', 'Yes', NULL, 6, 'Magnolia Nitzsche', '19169413057185', 'East Birdietown', '2028-02-15', NULL, NULL, NULL, NULL, NULL, 639134178, 0, 0, 1, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(212, 7488, 2639, 'مايا أحمد عامر', 'Female', 3, 3, 1, '2008', 'إدارة الأعمال', 'Excellent', '2013-11-14', '54070407779027', '2026-05-12', 'Hassiefurt', 3, 'Muslim', 7, 'shayna50@example.com', 3, 7, 3, '0236798049', '0228624256', '01195498961', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '14166480210036', 'No', NULL, NULL, '2023-11-14', 'Employee', 9, 5, 'Yes', 'No', 1, '7.00', '31746.20', '1058.21', 'Changeable', NULL, 'Yes', '569.91', '74571219723521', 'Yes', '819.09', '68655668705449', 'Cach', 'No', NULL, '3522 Angeline Park Suite 921\nEast Wilsonhaven, WA 54165', 0, 'Widowed', NULL, '6219312329', 'Yes', NULL, 5, 'Christiana Bahringer', '25129174926906', 'West Madelynmouth', '2025-11-08', NULL, NULL, NULL, NULL, NULL, 124223729, 0, 0, 3, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(213, 3489, 1434, 'نادية فارس عبدالحكيم', 'Female', 1, 1, 5, '2000', 'إدارة الأعمال', 'Good', '2005-06-29', '56512690306982', '2029-03-13', 'North Richie', 2, 'Christian', 9, 'jonatan.kuhn@example.com', 2, 21, 15, '0229473728', '0224936979', '01230648325', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '26725832236772', 'Yes', NULL, NULL, '2020-10-14', 'Employee', 6, 5, 'No', 'Yes', 3, '7.00', '10878.92', '362.63', 'Fixed', '1554.41', 'No', NULL, NULL, 'Yes', '929.02', '97075355517550', 'Visa', 'No', NULL, '28941 Nyah Turnpike\nEast Judeville, OK 96654-5140', 0, 'Married', NULL, '615214414540', 'Yes', NULL, 2, 'Delta McDermott', '24034879530131', 'East Mae', '2029-04-14', NULL, NULL, NULL, NULL, NULL, 1711542965, 0, 0, 1, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(214, 9121, 895, 'رولا يوسف جواد', 'Female', 3, 3, 5, '1974', 'الفيزياء', 'Fair', '2019-03-09', '77740254571154', '2025-12-18', 'West Orin', 3, 'Muslim', 9, 'elnora74@example.org', 1, 23, 14, '0235774072', '0227676609', '01590350713', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '90698735857459', 'No', NULL, NULL, '2023-11-22', 'Employee', 2, 1, 'Yes', 'No', 4, '8.00', '49422.16', '1647.41', 'Fixed', '1512.71', 'Yes', '769.21', '47263477558345', 'Yes', '672.77', '88244975685561', 'Visa', 'Yes', NULL, '3898 Phyllis Extensions Suite 746\nNorth Reedside, MS 91747', 0, 'Divorced', NULL, '04063957249257', 'Yes', NULL, 1, 'Gust Reilly', '24031774232867', 'Rathmouth', '2029-03-02', NULL, NULL, NULL, NULL, NULL, 109787205, 0, 0, 4, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(215, 4130, 229, 'فايزة عدنان مصطفى', 'Female', 1, 4, 3, '2004', 'إدارة الأعمال', 'Very_Good', '2021-07-12', '88910640070506', '2029-03-21', 'East Chesterside', 6, 'Christian', 5, 'mercedes22@example.com', 4, 25, 4, '0235554553', '0235925610', '01540217552', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '16977295666976', 'Yes', NULL, NULL, '2024-07-09', 'Employee', 5, 5, 'Yes', 'No', 4, '7.00', '30501.19', '1016.71', 'Fixed', '1446.68', 'Yes', '602.81', '57389065564986', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '89440 Daugherty Mountain\nPort Beatriceberg, NE 85994-0537', 0, 'Married', NULL, '183673467', 'Yes', NULL, 2, 'Jamarcus Bode', '10884446709371', 'Margaritamouth', '2027-10-11', NULL, NULL, NULL, NULL, NULL, 1693794365, 0, 0, 3, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(216, 8073, 530, 'عماد إبراهيم وائل', 'Male', 3, 1, 5, '2012', 'إدارة الأعمال', 'Excellent', '2007-07-09', '89496964622277', '2026-03-11', 'Heidenreichside', 7, 'Christian', 7, 'pagac.ursula@example.org', 2, 15, 8, '0221443737', '0238874854', '01141488422', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '20193091444603', 'No', NULL, NULL, '2024-01-22', 'Employee', 4, 8, 'Yes', 'No', 4, '10.00', '14105.89', '470.20', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '69573 Nelle Pike Apt. 480\nLurlineside, OK 86807', 0, 'Divorced', NULL, '4237602310', 'Yes', NULL, 6, 'Lorine Prosacco', '99742803150935', 'West Marcelino', '2028-05-10', NULL, NULL, NULL, NULL, NULL, 308757159, 0, 0, 1, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(217, 3276, 56, 'روز ثامر إبراهيم', 'Female', 1, 3, 3, '1970', 'إدارة الأعمال', 'Fair', '2004-08-17', '53365089338901', '2029-10-31', 'Katherineborough', 2, 'Christian', 5, 'gabrielle.hegmann@example.org', 5, 11, 6, '0236283193', '0238656505', '01550919932', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '28486079605970', 'No', NULL, NULL, '2021-08-24', 'Employee', 2, 1, 'No', 'Yes', 4, '11.00', '21168.49', '705.62', 'Fixed', '1429.86', 'Yes', '666.94', '07091634252863', 'Yes', '968.77', '76842558351705', 'Cach', 'Yes', NULL, '5671 Delia Parks\nNorth Ahmad, ND 14222', 0, 'Widowed', NULL, '801099748045', 'Yes', NULL, 5, 'Era Torphy', '76569066233799', 'Apriltown', '2027-03-17', NULL, NULL, NULL, NULL, NULL, 582650224, 0, 0, 2, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(218, 3535, 1882, 'سلمى شادي مازن', 'Female', 3, 4, 1, '1971', 'الرياضيات', 'Fair', '2000-03-09', '55509526856961', '2028-09-29', 'East Trentshire', 4, 'Christian', 5, 'vincenzo.conn@example.com', 6, 5, 10, '0236455404', '0229407184', '01124880820', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '44650397734306', 'Yes', NULL, NULL, '2021-03-22', 'Employee', 9, 3, 'No', 'Yes', 1, '11.00', '26941.42', '898.05', 'Changeable', NULL, 'Yes', '763.98', '93450792213891', 'Yes', '910.39', '08864985354815', 'Cach', 'No', NULL, '4120 Glover Hollow\nKerlukeland, AL 97334', 0, 'Single', NULL, '4614701616945', 'Yes', NULL, 2, 'Dr. Melissa Kertzmann MD', '82500275573052', 'Friesenport', '2028-06-29', NULL, NULL, NULL, NULL, NULL, 539966023, 0, 0, 2, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(219, 1967, 2293, 'شهد إسماعيل ثامر', 'Female', 2, 4, 4, '2009', 'إدارة الأعمال', 'Fair', '2014-11-09', '10775381576490', '2029-04-11', 'Emilianoside', 7, 'Muslim', 3, 'makayla46@example.com', 6, 4, 6, '0234870847', '0227395865', '01152859396', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '34734082959293', 'No', NULL, NULL, '2024-06-26', 'Employee', 2, 9, 'No', 'No', 4, '12.00', '26318.85', '877.30', 'Fixed', '1805.67', 'No', NULL, NULL, 'Yes', '915.95', '57869153834825', 'Visa', 'Yes', NULL, '911 Orn Meadow\nPort Jazmyn, WY 06103', 0, 'Divorced', NULL, '403305185', 'Yes', NULL, 6, 'Geovanny Wunsch', '68005722177110', 'Lake Llewellyn', '2029-09-04', NULL, NULL, NULL, NULL, NULL, 110178208, 0, 0, 4, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(220, 3048, 680, 'أنور وجيه ثامر', 'Male', 3, 1, 3, '1995', 'إدارة الأعمال', 'Fair', '2015-10-27', '62323378020610', '2029-08-09', 'North Joany', 2, 'Muslim', 6, 'tstrosin@example.org', 2, 10, 8, '0229810670', '0234332052', '01105724975', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '72082326503239', 'No', NULL, NULL, '2022-07-07', 'Employee', 8, 10, 'No', 'Yes', 4, '7.00', '22717.51', '757.25', 'Fixed', '1844.84', 'Yes', '516.44', '47268916583123', 'No', NULL, NULL, 'Visa', 'No', NULL, '12230 Willms Lake Apt. 260\nPort Deanna, PA 67232-7267', 0, 'Single', NULL, '7205846503', 'Yes', NULL, 1, 'Chelsey Walsh', '70051484525787', 'O\'Reillyberg', '2028-04-30', NULL, NULL, NULL, NULL, NULL, 1727502459, 0, 0, 1, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(221, 8942, 1439, 'سيف هيثم قاسم', 'Male', 3, 2, 6, '2005', 'الهندسة', 'Good', '2008-05-20', '56452943639863', '2028-12-12', 'Littleport', 4, 'Muslim', 3, 'gusikowski.clark@example.com', 3, 3, 8, '0220350000', '0222122163', '01149448059', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '50488242171918', 'No', NULL, NULL, '2023-05-15', 'Employee', 8, 10, 'Yes', 'Yes', 1, '7.00', '32150.24', '1071.67', 'Changeable', NULL, 'Yes', '527.71', '96955531713430', 'Yes', '606.60', '69294647378750', 'Cach', 'Yes', NULL, '3300 Alison Hollow Apt. 456\nNorth Paula, MS 82215-4796', 0, 'Divorced', NULL, '66036781249337', 'Yes', NULL, 5, 'Clarabelle Durgan', '09470826108462', 'Isommouth', '2026-09-22', NULL, NULL, NULL, NULL, NULL, 1738479272, 0, 0, 1, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(222, 7289, 333, 'راغب نادر أنس', 'Male', 4, 1, 1, '2002', 'الهندسة', 'Excellent', '2013-04-27', '24802484809721', '2026-01-07', 'Port Faustoview', 3, 'Christian', 5, 'nathanael.kihn@example.net', 2, 17, 3, '0234566189', '0237647885', '01103492470', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '59524856596713', 'No', NULL, NULL, '2024-11-15', 'Employee', 9, 1, 'Yes', 'No', 1, '8.00', '14126.23', '470.87', 'Changeable', NULL, 'Yes', '905.06', '17484203375569', 'Yes', '747.47', '82378173040270', 'Cach', 'Yes', NULL, '7541 Harry Passage\nJastmouth, AZ 33759', 0, 'Divorced', NULL, '995933742516', 'Yes', NULL, 6, 'Mr. Ron Bayer I', '45968671690526', 'New Loganhaven', '2028-04-21', NULL, NULL, NULL, NULL, NULL, 19722185, 0, 0, 2, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(223, 7944, 90, 'فارس نبيل عبدالباسط', 'Male', 1, 2, 6, '2000', 'الهندسة', 'Very_Good', '2022-04-16', '14555893536819', '2028-04-14', 'Lake Antoinettemouth', 5, 'Christian', 10, 'stacey30@example.org', 2, 5, 2, '0228595854', '0226708328', '01033205869', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '64092998149985', 'Yes', NULL, NULL, '2022-12-10', 'Employee', 5, 8, 'No', 'No', 4, '10.00', '8227.46', '274.25', 'Fixed', '1847.54', 'No', NULL, NULL, 'Yes', '777.05', '53014182191191', 'Cach', 'Yes', NULL, '9664 Little Lake\nLangoshberg, MD 85958', 0, 'Divorced', NULL, '8684889947177', 'Yes', NULL, 3, 'Linnie Nader V', '66649098491115', 'Coryfort', '2025-05-30', NULL, NULL, NULL, NULL, NULL, 1994387137, 0, 0, 4, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(224, 5642, 1527, 'إيمان كريم أديب', 'Female', 2, 1, 5, '2001', 'علوم الحاسوب', 'Very_Good', '2007-05-29', '76750401323542', '2027-01-11', 'South Willland', 1, 'Muslim', 7, 'turcotte.samanta@example.org', 4, 13, 12, '0228433966', '0222464287', '01194197554', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '42373616353079', 'Yes', NULL, NULL, '2024-04-07', 'Employee', 6, 2, 'No', 'No', 3, '9.00', '46510.57', '1550.35', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '653 Feest Heights Suite 339\nEast Cleo, MI 05667', 0, 'Widowed', NULL, '8297459935162', 'Yes', NULL, 4, 'Mateo Schaden', '13082222361969', 'West Francisco', '2027-02-21', NULL, NULL, NULL, NULL, NULL, 729647149, 0, 0, 3, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(225, 8528, 1410, 'ليان ماهر سليمان', 'Female', 2, 4, 2, '1992', 'الفيزياء', 'Fair', '2008-01-16', '81221335125731', '2029-06-20', 'Schummchester', 1, 'Christian', 11, 'larson.harold@example.net', 6, 6, 2, '0236907959', '0222935257', '01524691850', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '14791956630624', 'Yes', NULL, NULL, '2024-11-01', 'Employee', 2, 5, 'Yes', 'Yes', 1, '9.00', '23524.17', '784.14', 'Fixed', '1630.81', 'Yes', '660.50', '19730358878174', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '93243 Aufderhar Islands\nSouth Vickiefurt, ID 46179-6506', 0, 'Single', NULL, '3315011', 'Yes', NULL, 6, 'Zackery Gorczany Sr.', '31904820457922', 'Fisherberg', '2027-07-13', NULL, NULL, NULL, NULL, NULL, 1059085046, 0, 0, 2, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(226, 2543, 2369, 'لجين ربيع أمجد', 'Female', 3, 4, 4, '1988', 'إدارة الأعمال', 'Very_Good', '2017-04-01', '81763551612025', '2029-03-10', 'North Coryshire', 5, 'Christian', 10, 'medhurst.bernita@example.net', 2, 7, 11, '0223626404', '0223068529', '01564495618', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '00731463670602', 'Yes', NULL, NULL, '2024-01-31', 'Employee', 5, 1, 'Yes', 'No', 1, '7.00', '44788.00', '1492.93', 'Fixed', '1064.54', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '7427 Rowland Isle Suite 833\nWest Emmy, OH 74666-8238', 0, 'Widowed', NULL, '448063647986', 'Yes', NULL, 5, 'Davonte Rath', '49941200565965', 'East Elisabethstad', '2025-01-14', NULL, NULL, NULL, NULL, NULL, 519687228, 0, 0, 2, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(227, 5999, 8, 'صابرين عبدالفتاح إسماعيل', 'Female', 2, 3, 6, '1987', 'إدارة الأعمال', 'Excellent', '2017-09-13', '44148102412782', '2028-11-09', 'New Jarviston', 1, 'Muslim', 8, 'otillman@example.com', 3, 24, 6, '0238344871', '0220466951', '01291520637', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '08587882848018', 'Yes', NULL, NULL, '2023-07-09', 'Employee', 2, 10, 'Yes', 'No', 3, '9.00', '37589.25', '1252.98', 'Changeable', NULL, 'Yes', '578.94', '01281887292657', 'Yes', '906.79', '12193404217287', 'Cach', 'Yes', NULL, '468 Adrienne Creek Suite 792\nNorth Alexis, ID 15430', 0, 'Married', NULL, '937947205', 'Yes', NULL, 5, 'Natasha Hartmann', '22040024015076', 'New Ladariusville', '2025-02-17', NULL, NULL, NULL, NULL, NULL, 581879786, 0, 0, 3, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(228, 7830, 282, 'وائل أنس سامي', 'Male', 3, 2, 6, '1992', 'الهندسة', 'Excellent', '2013-11-23', '42488032481240', '2025-11-03', 'Teaganberg', 4, 'Muslim', 13, 'dewayne.altenwerth@example.org', 4, 2, 13, '0221769789', '0220719121', '01577973155', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '11614976100261', 'Yes', NULL, NULL, '2023-07-10', 'Employee', 7, 6, 'No', 'No', 2, '9.00', '47440.07', '1581.34', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '165 Frami Via\nWittingview, AL 84644', 0, 'Widowed', NULL, '107285937141', 'Yes', NULL, 3, 'Janice Hills PhD', '39733429347761', 'East Parismouth', '2027-04-01', NULL, NULL, NULL, NULL, NULL, 1909203171, 0, 0, 1, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(229, 6723, 1073, 'هيا يحيى عامر', 'Female', 4, 3, 3, '2003', 'إدارة الأعمال', 'Good', '2021-04-02', '03775055197440', '2029-07-07', 'Lake Francesca', 1, 'Muslim', 4, 'cordell06@example.org', 6, 24, 1, '0235497821', '0225589926', '01018685340', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '25475881195591', 'No', NULL, NULL, '2023-03-30', 'Employee', 8, 10, 'No', 'Yes', 1, '11.00', '17669.90', '589.00', 'Fixed', '1688.32', 'Yes', '970.12', '25469026537591', 'Yes', '740.23', '81259449392831', 'Cach', 'No', NULL, '341 Breanna Burgs\nSammouth, OH 52767-0858', 0, 'Widowed', NULL, '5731154', 'Yes', NULL, 3, 'Lily Braun', '52238016465060', 'South Nayeli', '2025-04-25', NULL, NULL, NULL, NULL, NULL, 1149911182, 0, 0, 4, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(230, 9250, 1288, 'ناجي أكرم طلال', 'Male', 1, 4, 6, '1992', 'الفيزياء', 'Excellent', '2012-02-21', '20632029226917', '2029-07-13', 'Lake Catalina', 2, 'Christian', 1, 'ereynolds@example.com', 1, 6, 5, '0232297109', '0223055323', '01568397400', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '31157860741359', 'No', NULL, NULL, '2020-08-02', 'Employee', 3, 9, 'Yes', 'No', 1, '7.00', '34810.91', '1160.36', 'Fixed', '1362.80', 'No', NULL, NULL, 'Yes', '544.98', '71138627481572', 'Cach', 'Yes', NULL, '337 Tobin Causeway\nAnkundingmouth, MS 03483', 0, 'Single', NULL, '8480695288', 'Yes', NULL, 5, 'Zackery Barrows', '80276980670140', 'East Ottoburgh', '2028-01-23', NULL, NULL, NULL, NULL, NULL, 797180248, 0, 0, 3, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(231, 5141, 2107, 'صفاء علاء قاسم', 'Female', 4, 4, 5, '2005', 'الفيزياء', 'Very_Good', '2008-11-17', '26393492152179', '2026-05-06', 'New Shayleeville', 4, 'Christian', 13, 'randall.kuphal@example.com', 1, 12, 11, '0223547707', '0236463283', '01136650947', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '64083814954526', 'Yes', NULL, NULL, '2024-08-29', 'Employee', 3, 6, 'No', 'No', 1, '7.00', '23255.52', '775.18', 'Fixed', '1762.37', 'No', NULL, NULL, 'Yes', '734.06', '88395744790699', 'Cach', 'No', NULL, '49191 Tyrique Ways Suite 199\nBirdieview, MI 80688-3417', 0, 'Widowed', NULL, '882348149', 'Yes', NULL, 5, 'Ms. Sylvia Crona', '22641574671800', 'Treutelborough', '2026-08-19', NULL, NULL, NULL, NULL, NULL, 895811072, 0, 0, 3, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(232, 2289, 1147, 'يسرا إبراهيم رامي', 'Female', 2, 1, 3, '1970', 'الهندسة', 'Very_Good', '2006-02-20', '74695591759005', '2025-02-06', 'Lake Waldo', 3, 'Christian', 11, 'vsipes@example.org', 3, 25, 1, '0221703549', '0225384950', '01075762354', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '36617363707105', 'No', NULL, NULL, '2022-06-21', 'Employee', 2, 7, 'No', 'Yes', 2, '8.00', '21469.85', '715.66', 'Changeable', NULL, 'Yes', '756.32', '46199962210924', 'Yes', '930.37', '99952089357738', 'Visa', 'No', NULL, '645 Myles Plaza\nNew Odellfurt, NV 04980', 0, 'Divorced', NULL, '83952471', 'Yes', NULL, 5, 'Destany Kovacek', '43498566358617', 'West Desmondburgh', '2025-04-30', NULL, NULL, NULL, NULL, NULL, 565691423, 0, 0, 4, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(233, 1854, 150, 'ثريا فارس عامر', 'Female', 3, 4, 4, '2003', 'إدارة الأعمال', 'Fair', '2000-07-09', '41931607100158', '2028-07-28', 'Stiedemannside', 4, 'Christian', 11, 'colt26@example.net', 5, 4, 15, '0237538477', '0223475029', '01045028244', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '79709825977662', 'No', NULL, NULL, '2020-07-25', 'Employee', 2, 5, 'No', 'No', 4, '10.00', '45611.66', '1520.39', 'Changeable', NULL, 'Yes', '920.50', '72299379320916', 'Yes', '780.27', '10509896759367', 'Visa', 'Yes', NULL, '98276 Runolfsdottir Path\nUbaldobury, SC 44553-2693', 0, 'Married', NULL, '363223784861', 'Yes', NULL, 3, 'Miss Myrna Franecki', '95980424581470', 'South Georgette', '2026-06-10', NULL, NULL, NULL, NULL, NULL, 507603021, 0, 0, 4, NULL, 1, '2024-12-12 15:30:56', '2024-12-12 15:30:56'),
(234, 7187, 2317, 'سمر عامر أحمد', 'Female', 4, 4, 3, '2006', 'الفيزياء', 'Good', '2009-12-07', '49929240983883', '2025-04-09', 'Lubowitzmouth', 1, 'Muslim', 13, 'kira.mcglynn@example.org', 5, 11, 9, '0233931649', '0225027488', '01128703273', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '21993456957034', 'No', NULL, NULL, '2023-10-13', 'Employee', 9, 8, 'No', 'No', 2, '8.00', '29798.91', '993.30', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '625.40', '30778085029184', 'Cach', 'Yes', NULL, '57319 Smitham Via\nSkilesmouth, MO 56883', 0, 'Widowed', NULL, '53649121593', 'Yes', NULL, 4, 'Etha Gutkowski', '76711819504577', 'Huelsfurt', '2027-07-09', NULL, NULL, NULL, NULL, NULL, 1516291930, 0, 0, 3, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(235, 9193, 961, 'عماد عمر جواد', 'Male', 2, 2, 6, '1977', 'علم الأحياء', 'Good', '2020-04-24', '14336818623523', '2029-02-05', 'Hellerport', 2, 'Muslim', 9, 'gwendolyn.hettinger@example.com', 4, 2, 8, '0228395452', '0231440818', '01034691062', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '71425347736674', 'Yes', NULL, NULL, '2021-11-30', 'Employee', 4, 1, 'Yes', 'Yes', 2, '9.00', '31801.19', '1060.04', 'Fixed', '1343.87', 'Yes', '534.87', '64594778442167', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '96227 Pauline Union Apt. 489\nNellebury, UT 36398', 0, 'Widowed', NULL, '61322855', 'Yes', NULL, 5, 'Isabel Pollich', '54606742361626', 'Kesslerstad', '2025-08-08', NULL, NULL, NULL, NULL, NULL, 202571626, 0, 0, 2, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(236, 2819, 1181, 'هاجر عبدالله ماهر', 'Female', 4, 1, 3, '1986', 'الهندسة', 'Very_Good', '2013-06-14', '32699365207847', '2029-05-23', 'Lake Lisatown', 2, 'Muslim', 12, 'schuyler.blick@example.net', 6, 7, 7, '0222403766', '0230134813', '01088430231', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '87766318464002', 'No', NULL, NULL, '2024-06-30', 'Employee', 10, 3, 'No', 'Yes', 1, '9.00', '10583.56', '352.79', 'Changeable', NULL, 'Yes', '902.88', '05799888132912', 'No', NULL, NULL, 'Visa', 'No', NULL, '1108 Hills Streets\nLake Larissa, IA 94181-0625', 0, 'Widowed', NULL, '64103950200', 'Yes', NULL, 4, 'Ericka Smitham', '77699554299524', 'Zemlakville', '2025-07-09', NULL, NULL, NULL, NULL, NULL, 2091199467, 0, 0, 2, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57');
INSERT INTO `employees` (`id`, `employee_code`, `fp_code`, `name`, `gender`, `branch_id`, `job_grade_id`, `qualification_id`, `qualification_year`, `major`, `graduation_estimate`, `brith_date`, `national_id`, `end_national_id`, `national_id_place`, `blood_types_id`, `religion`, `language_id`, `email`, `country_id`, `governorate_id`, `city_id`, `home_telephone`, `work_telephone`, `mobile`, `military`, `military_date_from`, `military_date_to`, `military_wepon`, `military_exemption_date`, `military_exemption_reason`, `military_postponement_reason`, `date_resignation`, `resignation_reason`, `driving_license`, `driving_license_type`, `driving_License_id`, `has_relatives`, `relatives_details`, `notes`, `work_start_date`, `functional_status`, `department_id`, `job_categories_id`, `has_attendance`, `has_fixed_shift`, `shift_types_id`, `daily_work_hour`, `salary`, `day_price`, `motivation_type`, `motivation`, `social_insurance`, `social_insurance_cut_monthely`, `social_insurance_number`, `medical_insurance`, `medical_insurance_cut_monthely`, `medical_insurance_number`, `Type_salary_receipt`, `active_vacation`, `urgent_person_details`, `staies_address`, `children_number`, `social_status`, `resignation_id`, `bank_number_account`, `disabilities`, `disabilities_type`, `nationality_id`, `name_sponsor`, `pasport_identity`, `pasport_from_place`, `pasport_exp_date`, `num_vacation_days`, `add_service`, `years_service`, `cv`, `basic_address_country`, `fixed_allowances`, `is_done_Vacation_formula`, `is_Sensitive_manager_data`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(237, 2785, 1823, 'رنا بدر محمود', 'Female', 1, 3, 4, '2003', 'إدارة الأعمال', 'Very_Good', '2023-05-21', '19098018721596', '2026-04-15', 'Port Abelshire', 7, 'Muslim', 3, 'nikko.treutel@example.net', 6, 25, 14, '0237643908', '0228580799', '01288674653', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '06098549520855', 'Yes', NULL, NULL, '2022-02-14', 'Employee', 2, 4, 'No', 'Yes', 2, '10.00', '40121.46', '1337.38', 'Fixed', '1114.09', 'Yes', '672.58', '27348166040143', 'No', NULL, NULL, 'Cach', 'No', NULL, '2410 Senger Hollow\nSouth Herbert, WV 75626', 0, 'Divorced', NULL, '53151649606292', 'Yes', NULL, 2, 'Derek Stracke', '42772287992301', 'North Jeramy', '2026-07-25', NULL, NULL, NULL, NULL, NULL, 1249532013, 0, 0, 3, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(238, 4447, 266, 'شاكر مازن رفيق', 'Male', 2, 2, 2, '1974', 'علوم الحاسوب', 'Very_Good', '2009-04-08', '33095020430746', '2025-11-22', 'East Billfort', 3, 'Muslim', 2, 'chase56@example.org', 6, 17, 10, '0225669906', '0232340622', '01196166280', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '03198826547317', 'No', NULL, NULL, '2024-09-29', 'Employee', 5, 5, 'Yes', 'No', 1, '9.00', '35687.85', '1189.60', 'Fixed', '1897.82', 'Yes', '567.58', '09190669709180', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '3488 Wolf Flats\nSouth Eltaview, NM 01701-7032', 0, 'Divorced', NULL, '5780507300170', 'Yes', NULL, 4, 'Forrest Orn MD', '46561844230640', 'South Frederickland', '2027-07-25', NULL, NULL, NULL, NULL, NULL, 1764299233, 0, 0, 3, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(239, 4903, 1785, 'جوري ياسر سليمان', 'Female', 1, 3, 4, '2007', 'إدارة الأعمال', 'Very_Good', '2021-04-28', '35204995779209', '2029-03-04', 'Georgiannaview', 5, 'Muslim', 2, 'scottie.gerhold@example.com', 2, 26, 3, '0238566036', '0230266607', '01062428919', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '61985315082091', 'No', NULL, NULL, '2021-08-24', 'Employee', 10, 10, 'Yes', 'No', 1, '10.00', '7135.73', '237.86', 'Fixed', '1558.31', 'Yes', '747.70', '31662707333825', 'Yes', '818.82', '49639683417374', 'Cach', 'No', NULL, '151 Baron Camp Suite 120\nLake Jaleel, NE 46624-2909', 0, 'Divorced', NULL, '12591439253470', 'Yes', NULL, 2, 'Prof. Ottilie Armstrong V', '77035262482066', 'Port Karen', '2025-03-12', NULL, NULL, NULL, NULL, NULL, 236129626, 0, 0, 3, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(240, 7492, 2765, 'مايا توفيق نور', 'Female', 4, 2, 5, '1986', 'إدارة الأعمال', 'Excellent', '2002-08-27', '29054662720547', '2027-04-18', 'North Edmondmouth', 5, 'Christian', 13, 'hmcdermott@example.net', 3, 4, 14, '0237516194', '0225705235', '01113085810', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '60233348006336', 'No', NULL, NULL, '2019-12-23', 'Employee', 6, 4, 'No', 'Yes', 1, '11.00', '32787.09', '1092.90', 'Fixed', '1501.10', 'Yes', '988.82', '89086396438807', 'Yes', '650.41', '00850068142106', 'Visa', 'No', NULL, '329 Kub Brook Suite 241\nPort Robbland, KY 58381', 0, 'Married', NULL, '23536905157440', 'Yes', NULL, 1, 'Mr. Kyle Hills Sr.', '79323497514104', 'Jaceyland', '2026-07-29', NULL, NULL, NULL, NULL, NULL, 411518168, 0, 0, 3, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(241, 4722, 1768, 'أماني سليمان عبدالحميد', 'Female', 2, 3, 1, '1994', 'الفيزياء', 'Fair', '2014-12-26', '20561670933362', '2028-06-30', 'Mercedesborough', 1, 'Christian', 9, 'hosea.koch@example.net', 5, 4, 8, '0233369841', '0233282084', '01299528503', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '21802581362231', 'No', NULL, NULL, '2020-07-30', 'Employee', 10, 4, 'No', 'No', 2, '12.00', '5465.23', '182.17', 'Fixed', '1189.52', 'No', NULL, NULL, 'Yes', '773.54', '31069689781903', 'Cach', 'No', NULL, '56223 Borer Rapids\nKuphalmouth, ND 11091-7247', 0, 'Divorced', NULL, '110972612', 'Yes', NULL, 4, 'Dr. Roma Schumm MD', '86406970528031', 'Port Lou', '2027-10-21', NULL, NULL, NULL, NULL, NULL, 617240403, 0, 0, 2, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(242, 9594, 875, 'آنا أيوب إبراهيم', 'Female', 3, 4, 2, '1986', 'الهندسة', 'Fair', '2016-06-16', '57552547392981', '2025-02-03', 'North Elviechester', 4, 'Christian', 13, 'srath@example.org', 3, 5, 15, '0236553882', '0230331509', '01000716943', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '47994070465324', 'Yes', NULL, NULL, '2023-03-19', 'Employee', 9, 1, 'Yes', 'No', 4, '7.00', '9140.16', '304.67', 'Changeable', NULL, 'Yes', '554.03', '70591161234613', 'No', NULL, NULL, 'Visa', 'No', NULL, '5528 Kasey Squares\nKeshawnborough, ID 32187-7715', 0, 'Married', NULL, '04786799618', 'Yes', NULL, 2, 'Prof. Tania Tromp', '12838147916435', 'New Elmobury', '2029-06-01', NULL, NULL, NULL, NULL, NULL, 291245279, 0, 0, 4, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(243, 4544, 2617, 'مايا سامر عبدالكريم', 'Female', 3, 3, 3, '1988', 'علم الأحياء', 'Excellent', '2010-12-25', '73494464466667', '2028-02-20', 'Jerdeville', 3, 'Christian', 6, 'linnie10@example.net', 6, 24, 13, '0231620673', '0225805162', '01192080480', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '49404002700704', 'Yes', NULL, NULL, '2022-12-15', 'Employee', 6, 7, 'No', 'No', 4, '11.00', '19422.93', '647.43', 'Fixed', '1787.01', 'Yes', '840.81', '54584566965429', 'Yes', '562.91', '52553101976435', 'Cach', 'Yes', NULL, '508 Reichert Street Apt. 619\nDalehaven, NJ 19328', 0, 'Divorced', NULL, '08121930989', 'Yes', NULL, 6, 'Aiden Kuhlman', '44923325039040', 'Romaguerahaven', '2029-05-14', NULL, NULL, NULL, NULL, NULL, 863821202, 0, 0, 4, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(244, 6827, 668, 'سهى محمود إبراهيم', 'Female', 2, 1, 1, '1981', 'إدارة الأعمال', 'Good', '2012-06-08', '94999553660673', '2029-08-18', 'Port Hayley', 5, 'Muslim', 5, 'wmuller@example.com', 3, 8, 3, '0229481508', '0221468977', '01115394179', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '69021585076293', 'Yes', NULL, NULL, '2022-12-06', 'Employee', 1, 7, 'Yes', 'Yes', 1, '7.00', '35021.54', '1167.38', 'Fixed', '1903.18', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '20260 Maegan Isle Suite 204\nKylerside, AK 77598', 0, 'Divorced', NULL, '28237173', 'Yes', NULL, 6, 'Braeden Gaylord DVM', '45138950819200', 'Lake Neoma', '2025-11-01', NULL, NULL, NULL, NULL, NULL, 524303595, 0, 0, 4, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(245, 8922, 2164, 'رائد شاكر علاء', 'Male', 3, 3, 1, '1973', 'الهندسة', 'Excellent', '2009-12-19', '38830407496570', '2028-11-15', 'Karleyshire', 6, 'Muslim', 2, 'aliza21@example.org', 5, 12, 10, '0236855784', '0234898608', '01100706952', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '08385292017750', 'Yes', NULL, NULL, '2020-04-15', 'Employee', 6, 1, 'Yes', 'No', 4, '8.00', '5954.13', '198.47', 'Changeable', NULL, 'Yes', '946.88', '75973839663569', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '75035 Linnea Tunnel Suite 492\nGavinton, KY 03608-9474', 0, 'Widowed', NULL, '94909236732', 'Yes', NULL, 6, 'Favian Mitchell', '37736226456922', 'Port Antonehaven', '2029-04-12', NULL, NULL, NULL, NULL, NULL, 1624142740, 0, 0, 4, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(246, 7297, 21, 'باسم عبدالسلام طلال', 'Male', 1, 1, 1, '1981', 'إدارة الأعمال', 'Fair', '2023-07-08', '08451238247193', '2029-04-29', 'East Deshaunbury', 2, 'Christian', 3, 'joaquin.kuhlman@example.com', 5, 10, 7, '0233115873', '0230963238', '01175571305', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '46263260701507', 'Yes', NULL, NULL, '2020-02-11', 'Employee', 8, 5, 'No', 'No', 3, '11.00', '47497.79', '1583.26', 'Changeable', NULL, 'Yes', '580.06', '36357518624247', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '91285 Rosamond Tunnel Suite 907\nRebekahaven, NM 35470', 0, 'Single', NULL, '42995831647663', 'Yes', NULL, 5, 'Alexie Cummerata', '74622634819866', 'North Sandra', '2026-08-01', NULL, NULL, NULL, NULL, NULL, 1086754509, 0, 0, 2, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(247, 9337, 1944, 'هدى عمر ياسر', 'Female', 3, 2, 3, '2006', 'الفيزياء', 'Fair', '2024-06-12', '67559408032426', '2026-02-01', 'East Shermanmouth', 1, 'Muslim', 9, 'woodrow.kris@example.org', 2, 7, 15, '0229762900', '0225979740', '01065470187', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '83248252121168', 'Yes', NULL, NULL, '2024-08-15', 'Employee', 7, 4, 'No', 'No', 1, '9.00', '48452.57', '1615.09', 'Changeable', NULL, 'Yes', '976.89', '55696780411545', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '1112 Bertha Rue Suite 380\nReingerfort, OK 91050-7692', 0, 'Married', NULL, '172507769023', 'Yes', NULL, 2, 'Mireille Pacocha', '03162817982234', 'Hiltonmouth', '2025-03-18', NULL, NULL, NULL, NULL, NULL, 1625590709, 0, 0, 2, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(248, 6517, 2778, 'راغب محمود ياسر', 'Male', 3, 3, 6, '1975', 'علوم الحاسوب', 'Good', '2006-09-03', '18938763930510', '2027-08-25', 'New Fayehaven', 4, 'Muslim', 10, 'hillary44@example.org', 3, 17, 15, '0238289658', '0233068728', '01576545266', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '67866148436705', 'No', NULL, NULL, '2022-07-13', 'Employee', 7, 3, 'Yes', 'No', 3, '11.00', '49735.57', '1657.85', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '693.71', '76908455747073', 'Cach', 'No', NULL, '9368 Adrien Shores Suite 162\nLetafort, ME 81897', 0, 'Widowed', NULL, '478824219', 'Yes', NULL, 3, 'Bernard Stroman', '80353795268757', 'Port Shayne', '2027-01-15', NULL, NULL, NULL, NULL, NULL, 2020683106, 0, 0, 3, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(249, 7755, 2054, 'عبدالكريم باسم بدر', 'Male', 1, 1, 4, '2013', 'علم الأحياء', 'Good', '2022-03-16', '83780218223402', '2027-09-10', 'West Ottis', 3, 'Christian', 10, 'wisozk.gwen@example.org', 5, 7, 14, '0235643075', '0225174897', '01125810906', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '11822515425684', 'No', NULL, NULL, '2024-03-25', 'Employee', 8, 8, 'Yes', 'Yes', 3, '10.00', '26911.63', '897.05', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '644.69', '76634932268318', 'Cach', 'No', NULL, '33894 Cole Station Suite 529\nSouth Kenny, SD 17158-3861', 0, 'Single', NULL, '0123045864', 'Yes', NULL, 2, 'Orland Buckridge', '16138222189022', 'North Tomas', '2026-10-22', NULL, NULL, NULL, NULL, NULL, 1145208103, 0, 0, 1, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(250, 1394, 2127, 'رغد سامي عصام', 'Female', 3, 1, 1, '2003', 'الرياضيات', 'Good', '2021-09-09', '07424488100420', '2028-01-22', 'New Noel', 6, 'Muslim', 3, 'howell.viola@example.net', 5, 10, 3, '0225000289', '0238126985', '01569600061', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '61983353403619', 'Yes', NULL, NULL, '2020-01-28', 'Employee', 2, 6, 'Yes', 'No', 3, '9.00', '23130.89', '771.03', 'Fixed', '1683.20', 'Yes', '681.39', '63360504843885', 'Yes', '901.81', '87488263270361', 'Visa', 'No', NULL, '89155 Maximo Path Suite 471\nNorth Ruben, UT 07504', 0, 'Widowed', NULL, '779352404', 'Yes', NULL, 2, 'Enoch Rutherford DDS', '96008419546589', 'New Ivy', '2028-11-23', NULL, NULL, NULL, NULL, NULL, 1345089327, 0, 0, 4, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(251, 9054, 747, 'عبداللطيف عامر عبدالرحمن', 'Male', 4, 4, 4, '1972', 'الرياضيات', 'Fair', '2010-05-27', '75395996486978', '2028-02-25', 'Ortizfort', 1, 'Christian', 12, 'bradford95@example.org', 3, 8, 10, '0220321007', '0220626687', '01242992849', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '21771993216436', 'Yes', NULL, NULL, '2022-12-30', 'Employee', 2, 7, 'No', 'Yes', 2, '7.00', '37531.56', '1251.05', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '635.43', '86404985745338', 'Cach', 'No', NULL, '435 Pagac Pine Suite 117\nNorth Maeve, NC 08533', 0, 'Divorced', NULL, '19786017956', 'Yes', NULL, 6, 'Tamara Crist', '41650475439848', 'Bauchhaven', '2027-06-27', NULL, NULL, NULL, NULL, NULL, 947558372, 0, 0, 4, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(252, 8560, 129, 'صفاء باسل إبراهيم', 'Female', 4, 2, 4, '1997', 'الرياضيات', 'Very_Good', '2011-11-09', '55745921416001', '2027-03-03', 'South Filomena', 7, 'Christian', 5, 'towne.estel@example.net', 4, 23, 11, '0233033234', '0235299505', '01285493833', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '12583442676447', 'No', NULL, NULL, '2020-09-01', 'Employee', 9, 5, 'No', 'Yes', 4, '7.00', '7193.45', '239.78', 'Fixed', '1791.55', 'Yes', '667.45', '14243005411874', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '533 Johns Mill\nWest Jalyntown, AK 17061', 0, 'Divorced', NULL, '224387178', 'Yes', NULL, 4, 'Ethelyn Ruecker', '91722821631350', 'East Nellaton', '2025-04-17', NULL, NULL, NULL, NULL, NULL, 1670872340, 0, 0, 3, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(253, 3819, 1900, 'عبير أحمد جواد', 'Female', 2, 3, 2, '1993', 'الرياضيات', 'Good', '2005-10-15', '82218164862399', '2028-09-22', 'Hauckfurt', 1, 'Christian', 13, 'tdickinson@example.net', 5, 19, 10, '0234497315', '0232958484', '01522722450', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '81280925650002', 'No', NULL, NULL, '2023-07-01', 'Employee', 2, 9, 'Yes', 'Yes', 3, '7.00', '41116.02', '1370.53', 'Fixed', '1946.04', 'Yes', '847.92', '31622655788111', 'No', NULL, NULL, 'Visa', 'Yes', NULL, '68034 Hermann Light Suite 489\nKirlinland, NJ 44108-1195', 0, 'Married', NULL, '6655322665492', 'Yes', NULL, 2, 'Dr. Llewellyn Jones Jr.', '15537754417050', 'Nickville', '2027-02-01', NULL, NULL, NULL, NULL, NULL, 969398300, 0, 0, 2, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(254, 1505, 2014, 'رفيق عبدالحكيم أحمد', 'Male', 3, 1, 2, '1987', 'علم الأحياء', 'Good', '2020-07-31', '39527291546538', '2029-07-14', 'West Sydnee', 3, 'Christian', 9, 'rward@example.net', 4, 1, 5, '0222071245', '0227560309', '01250940185', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '29728399379117', 'Yes', NULL, NULL, '2022-02-07', 'Employee', 2, 3, 'Yes', 'Yes', 1, '10.00', '46925.63', '1564.19', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '546.60', '58137917288626', 'Visa', 'Yes', NULL, '6723 Kshlerin Shoals Apt. 606\nAliyaside, DE 10693-1154', 0, 'Single', NULL, '69258752642', 'Yes', NULL, 1, 'Irma Price', '48166225646583', 'East Elliot', '2029-12-05', NULL, NULL, NULL, NULL, NULL, 491063579, 0, 0, 4, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(255, 7204, 513, 'علاء جواد فارس', 'Male', 2, 1, 6, '1976', 'علوم الحاسوب', 'Very_Good', '2023-10-22', '71035919261795', '2025-12-12', 'South Omaburgh', 5, 'Muslim', 6, 'kathleen.wintheiser@example.net', 1, 10, 4, '0233850752', '0227141298', '01014161615', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '95593005072891', 'Yes', NULL, NULL, '2023-01-01', 'Employee', 3, 3, 'No', 'Yes', 2, '10.00', '6211.64', '207.05', 'Fixed', '1539.86', 'Yes', '751.89', '25842319235425', 'No', NULL, NULL, 'Cach', 'No', NULL, '8714 Kari Islands Apt. 898\nNorth Merle, LA 20680', 0, 'Divorced', NULL, '5071620345417203', 'Yes', NULL, 1, 'Verlie Marvin', '59326989371193', 'Port Fabiola', '2025-01-23', NULL, NULL, NULL, NULL, NULL, 1534462166, 0, 0, 4, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(256, 9628, 122, 'إلياس عبدالرزاق صهيب', 'Male', 2, 3, 5, '1979', 'الهندسة', 'Fair', '2012-03-04', '78288822678785', '2028-08-08', 'Port Emiliamouth', 6, 'Christian', 11, 'ocie.langosh@example.com', 3, 6, 10, '0230847605', '0231617436', '01179762655', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '17487385846690', 'No', NULL, NULL, '2021-02-14', 'Employee', 7, 8, 'Yes', 'No', 4, '11.00', '15039.09', '501.30', 'Fixed', '1070.69', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '7059 Gerhold Isle\nWest Justice, ID 69624', 0, 'Divorced', NULL, '15442255186', 'Yes', NULL, 3, 'Prof. Judd Schowalter', '13314560726820', 'South Emmaleebury', '2027-02-21', NULL, NULL, NULL, NULL, NULL, 842444566, 0, 0, 1, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(257, 1639, 2015, 'عبدالحميد زيد جمال', 'Male', 4, 3, 1, '1989', 'علم الأحياء', 'Good', '2008-08-29', '85076622326406', '2029-04-14', 'Kaitlintown', 3, 'Muslim', 2, 'xbeer@example.com', 1, 12, 8, '0230229398', '0224050847', '01236707697', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '36215701619164', 'Yes', NULL, NULL, '2022-04-17', 'Employee', 1, 10, 'Yes', 'No', 3, '11.00', '11478.80', '382.63', 'Fixed', '1855.14', 'Yes', '578.68', '73096911123098', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '722 Frankie Falls\nEast Kaci, VT 44273', 0, 'Married', NULL, '2121257725', 'Yes', NULL, 6, 'Rupert Hirthe', '10202646746377', 'Santinaberg', '2026-11-22', NULL, NULL, NULL, NULL, NULL, 427859843, 0, 0, 2, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(258, 1556, 1688, 'جميلة أنس عبدالعزيز', 'Female', 2, 2, 6, '1998', 'علوم الحاسوب', 'Good', '2011-03-23', '84246146814003', '2025-03-03', 'Port Bernadette', 3, 'Muslim', 3, 'gankunding@example.org', 1, 25, 11, '0231092217', '0237473480', '01174162532', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '50694251621628', 'No', NULL, NULL, '2024-04-27', 'Employee', 7, 1, 'No', 'Yes', 2, '11.00', '15738.05', '524.60', 'Fixed', '1868.05', 'No', NULL, NULL, 'Yes', '582.52', '62118305499779', 'Visa', 'Yes', NULL, '9167 Arnold Streets Suite 586\nIsobelview, CO 47335-2685', 0, 'Single', NULL, '44822284775', 'Yes', NULL, 6, 'Mr. Forrest Lind DDS', '78720573024245', 'Port Lynnside', '2025-01-26', NULL, NULL, NULL, NULL, NULL, 2002174953, 0, 0, 4, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(259, 4872, 1018, 'فرح إسماعيل حاتم', 'Female', 2, 3, 2, '1992', 'الفيزياء', 'Fair', '2008-09-18', '56177750365931', '2026-06-27', 'East Myraview', 3, 'Christian', 6, 'yadira.schowalter@example.org', 3, 1, 5, '0239689748', '0238669687', '01071153292', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '64243151727573', 'No', NULL, NULL, '2022-04-23', 'Employee', 9, 6, 'Yes', 'Yes', 2, '8.00', '48933.08', '1631.10', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '9325 Goyette Valley\nBraunland, AK 17368', 0, 'Divorced', NULL, '31854221157', 'Yes', NULL, 3, 'Roma Bosco', '28492011475058', 'Stevieland', '2028-06-06', NULL, NULL, NULL, NULL, NULL, 1552143196, 0, 0, 4, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(260, 4901, 1981, 'سهيل عبدالرحمن عمر', 'Male', 3, 4, 5, '1985', 'علم الأحياء', 'Very_Good', '2002-09-26', '65457661752002', '2026-04-28', 'Nolanview', 5, 'Christian', 11, 'walker.sonia@example.net', 5, 20, 2, '0227057776', '0226557682', '01207364523', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '09661471691791', 'Yes', NULL, NULL, '2023-02-19', 'Employee', 9, 2, 'No', 'No', 1, '9.00', '14838.56', '494.62', 'Fixed', '1310.88', 'Yes', '858.30', '87443409739052', 'Yes', '653.74', '05187814584347', 'Cach', 'No', NULL, '2767 Andrew Drives Apt. 267\nFaestad, LA 30038-5081', 0, 'Widowed', NULL, '3482970', 'Yes', NULL, 4, 'Jaylan Fisher', '80474376114871', 'East Hilario', '2029-12-09', NULL, NULL, NULL, NULL, NULL, 871036939, 0, 0, 4, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(261, 6374, 1094, 'أكرم أيوب سهيل', 'Male', 2, 2, 5, '2012', 'الرياضيات', 'Excellent', '2022-08-03', '65017017866232', '2026-05-28', 'Keyontown', 7, 'Muslim', 1, 'percival78@example.net', 2, 1, 12, '0225194036', '0228766425', '01551999836', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '50010967972029', 'Yes', NULL, NULL, '2023-10-27', 'Employee', 9, 6, 'Yes', 'Yes', 2, '7.00', '39490.59', '1316.35', 'Fixed', '1250.78', 'No', NULL, NULL, 'Yes', '704.38', '04700650402010', 'Cach', 'No', NULL, '3590 Batz Field Apt. 294\nAlfredashire, IL 02732-2995', 0, 'Single', NULL, '751686936665', 'Yes', NULL, 2, 'Colton Rath', '19590533323863', 'Collinsburgh', '2029-09-10', NULL, NULL, NULL, NULL, NULL, 1873969902, 0, 0, 2, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(262, 8704, 2673, 'جمانة حذيفة رامز', 'Female', 1, 2, 5, '1995', 'إدارة الأعمال', 'Good', '2005-03-09', '99947999517626', '2026-07-11', 'North Delphia', 4, 'Muslim', 2, 'reta63@example.net', 3, 21, 15, '0229444500', '0235878090', '01156048026', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '97609314373513', 'Yes', NULL, NULL, '2022-01-03', 'Employee', 10, 6, 'Yes', 'Yes', 3, '9.00', '10547.16', '351.57', 'Fixed', '1846.27', 'No', NULL, NULL, 'Yes', '792.00', '38898011670690', 'Cach', 'No', NULL, '596 Hegmann Stravenue Suite 309\nLangland, MI 91774', 0, 'Married', NULL, '7282631066', 'Yes', NULL, 2, 'Kailey Stamm', '50056426358428', 'Bahringerborough', '2029-01-13', NULL, NULL, NULL, NULL, NULL, 174601429, 0, 0, 2, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(263, 1707, 2232, 'حلا جواد شريف', 'Female', 4, 4, 3, '2006', 'إدارة الأعمال', 'Excellent', '2006-11-19', '78417047304494', '2028-04-13', 'West Johathanland', 7, 'Muslim', 6, 'murazik.kathlyn@example.org', 3, 13, 9, '0233706474', '0225899938', '01204452721', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '20104839151274', 'No', NULL, NULL, '2023-09-23', 'Employee', 6, 1, 'Yes', 'Yes', 4, '9.00', '17898.65', '596.62', 'Changeable', NULL, 'Yes', '798.13', '90373609865808', 'Yes', '516.39', '18388859611336', 'Visa', 'No', NULL, '38832 Stacey Heights\nRyleeton, PA 20775', 0, 'Widowed', NULL, '558623094450', 'Yes', NULL, 3, 'Delfina Rutherford', '53866546185528', 'West Kattie', '2027-06-09', NULL, NULL, NULL, NULL, NULL, 235139573, 0, 0, 2, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(264, 7464, 1899, 'روان حامد أمجد', 'Female', 2, 2, 1, '1971', 'الهندسة', 'Very_Good', '2012-01-15', '97043050106844', '2029-04-28', 'Sydneemouth', 4, 'Christian', 10, 'christa.leannon@example.net', 1, 4, 15, '0224375763', '0231529968', '01114997744', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '24621181684413', 'No', NULL, NULL, '2021-10-15', 'Employee', 4, 5, 'Yes', 'Yes', 3, '11.00', '30915.41', '1030.51', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '687.89', '36797796406887', 'Cach', 'No', NULL, '8300 Spinka Fall\nSteuberburgh, CA 99271-2312', 0, 'Divorced', NULL, '5499699432', 'Yes', NULL, 1, 'Litzy Gusikowski', '40301166119142', 'North Caterinafurt', '2028-06-15', NULL, NULL, NULL, NULL, NULL, 1086076448, 0, 0, 2, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(265, 1874, 2511, 'راغب عادل عبدالله', 'Male', 2, 3, 6, '1982', 'الرياضيات', 'Excellent', '2003-05-24', '33491905999704', '2027-07-07', 'Schmelermouth', 5, 'Christian', 10, 'dquitzon@example.org', 4, 19, 15, '0220500180', '0232012061', '01173109957', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '53184714780009', 'Yes', NULL, NULL, '2023-05-02', 'Employee', 7, 2, 'Yes', 'No', 4, '12.00', '28403.26', '946.78', 'Fixed', '1623.74', 'No', NULL, NULL, 'Yes', '815.57', '83018565708341', 'Visa', 'Yes', NULL, '4117 Russel Lodge\nAdelafort, MN 72828-1003', 0, 'Widowed', NULL, '2300892', 'Yes', NULL, 4, 'Ashlee Sauer', '31500637425217', 'Gunnarfurt', '2027-09-18', NULL, NULL, NULL, NULL, NULL, 1152565655, 0, 0, 1, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(266, 2034, 520, 'عماد كريم سليمان', 'Male', 2, 3, 3, '1975', 'علم الأحياء', 'Good', '2019-06-17', '87002025739557', '2025-03-30', 'New Christellefurt', 3, 'Muslim', 2, 'abarrows@example.net', 4, 6, 15, '0237782941', '0231523510', '01252629158', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '37831946475112', 'No', NULL, NULL, '2021-10-11', 'Employee', 2, 1, 'No', 'Yes', 2, '9.00', '43216.79', '1440.56', 'Fixed', '1541.09', 'Yes', '769.11', '47534945903639', 'Yes', '690.84', '06732278405661', 'Visa', 'Yes', NULL, '188 Schroeder Roads Apt. 870\nLake Karl, ND 09796-5245', 0, 'Single', NULL, '28199490', 'Yes', NULL, 5, 'Evangeline Turner', '46904289710069', 'New Rosendoberg', '2029-06-08', NULL, NULL, NULL, NULL, NULL, 1734315880, 0, 0, 2, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(267, 3279, 898, 'آنا أيوب نور', 'Female', 1, 1, 2, '2011', 'الهندسة', 'Good', '2017-10-12', '50404573424425', '2029-07-27', 'North Ernestina', 7, 'Muslim', 12, 'jmayer@example.net', 2, 21, 7, '0221025944', '0227859414', '01168505301', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '42898329964673', 'Yes', NULL, NULL, '2022-06-15', 'Employee', 8, 4, 'Yes', 'Yes', 2, '9.00', '39209.50', '1306.98', 'Fixed', '1020.71', 'No', NULL, NULL, 'Yes', '567.08', '37499793678175', 'Cach', 'Yes', NULL, '347 Crona Mountain\nMillerborough, IL 64337', 0, 'Widowed', NULL, '0727895409', 'Yes', NULL, 2, 'Isabelle Walter Jr.', '82748264647613', 'Gladycemouth', '2026-11-25', NULL, NULL, NULL, NULL, NULL, 1721908371, 0, 0, 1, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(268, 9880, 2501, 'إلياس منصور هيثم', 'Male', 2, 1, 2, '1995', 'الفيزياء', 'Very_Good', '2024-02-04', '61091390080625', '2026-01-14', 'North Amiya', 3, 'Christian', 8, 'kortiz@example.org', 5, 25, 3, '0229752608', '0236740749', '01507293369', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '75532654576302', 'No', NULL, NULL, '2024-09-09', 'Employee', 3, 3, 'No', 'No', 2, '9.00', '47504.79', '1583.49', 'Changeable', NULL, 'Yes', '538.76', '82396972315790', 'Yes', '711.36', '61699064559683', 'Visa', 'Yes', NULL, '2268 Rolfson Port Apt. 906\nWest Jazlynland, WV 77577', 0, 'Married', NULL, '728185798969', 'Yes', NULL, 6, 'Robb Kertzmann', '28927781575855', 'Jaylonfort', '2028-11-26', NULL, NULL, NULL, NULL, NULL, 735938991, 0, 0, 2, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(269, 4138, 1702, 'عبدالفتاح عدنان راغب', 'Male', 1, 3, 2, '1974', 'الرياضيات', 'Fair', '2024-09-30', '96198482084591', '2027-05-16', 'Port Deanchester', 5, 'Muslim', 4, 'emely06@example.org', 4, 3, 15, '0233630341', '0222267723', '01554086299', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '86256571392956', 'No', NULL, NULL, '2023-06-03', 'Employee', 2, 10, 'Yes', 'No', 3, '11.00', '11834.07', '394.47', 'Fixed', '1449.43', 'Yes', '845.87', '28323194181387', 'Yes', '805.66', '53709204378451', 'Visa', 'No', NULL, '18833 Dominic Extension Apt. 706\nNorth Mathildeside, AZ 12434', 0, 'Widowed', NULL, '3819186824491946', 'Yes', NULL, 6, 'Mr. Arnoldo Boyer III', '98828687567167', 'Windlerbury', '2025-11-25', NULL, NULL, NULL, NULL, NULL, 231674298, 0, 0, 1, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(270, 2762, 1077, 'لارا لؤي عبدالحكيم', 'Female', 2, 2, 6, '1978', 'الهندسة', 'Fair', '2009-02-11', '28549189122964', '2025-05-11', 'Uptonport', 7, 'Christian', 13, 'predovic.sigmund@example.org', 2, 17, 15, '0221581172', '0237908792', '01228842702', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', '29515997732306', 'Yes', NULL, NULL, '2021-10-23', 'Employee', 8, 5, 'No', 'No', 3, '7.00', '45546.34', '1518.21', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '2076 Wehner Rapids Apt. 778\nDarlenebury, WY 78815', 0, 'Divorced', NULL, '46473570595', 'Yes', NULL, 2, 'Unique Lockman', '18869747822955', 'South Euna', '2025-11-25', NULL, NULL, NULL, NULL, NULL, 2131240252, 0, 0, 1, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(271, 2064, 1857, 'شهد علاء محمد', 'Female', 4, 1, 5, '1970', 'الهندسة', 'Fair', '2020-02-15', '42532216472217', '2029-07-26', 'South Faustinotown', 6, 'Christian', 6, 'johnston.opal@example.net', 2, 6, 13, '0238977551', '0232459388', '01257767984', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '71754062637381', 'No', NULL, NULL, '2023-03-15', 'Employee', 2, 8, 'No', 'Yes', 3, '11.00', '24251.52', '808.38', 'Fixed', '1840.17', 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'No', NULL, '20058 Kelli Brook Suite 690\nWest Nolabury, MO 25932-6139', 0, 'Married', NULL, '8104204', 'Yes', NULL, 2, 'Marion Mann', '75005869671881', 'Marialand', '2025-09-13', NULL, NULL, NULL, NULL, NULL, 804799831, 0, 0, 4, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(272, 3267, 349, 'صهيب أحمد طلال', 'Male', 1, 1, 1, '1986', 'الرياضيات', 'Fair', '2004-07-03', '18414477534159', '2028-05-05', 'South Roxaneland', 6, 'Muslim', 10, 'kody.weissnat@example.com', 2, 11, 4, '0224529994', '0236099509', '01298078451', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '26922223029949', 'No', NULL, NULL, '2024-03-26', 'Employee', 4, 9, 'No', 'No', 4, '10.00', '38829.51', '1294.32', 'Fixed', '1846.57', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '77429 Quitzon Passage\nWest Germanburgh, SD 42792', 0, 'Widowed', NULL, '854526854815', 'Yes', NULL, 4, 'Miss Yasmin Johnson', '21133484184995', 'Port Ocieside', '2029-11-02', NULL, NULL, NULL, NULL, NULL, 1499443564, 0, 0, 4, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(273, 2970, 1317, 'صهيب علي أنس', 'Male', 2, 3, 4, '2008', 'الفيزياء', 'Fair', '2024-11-25', '52643873336952', '2025-07-22', 'South Mattfort', 4, 'Muslim', 8, 'schroeder.dayton@example.net', 4, 8, 12, '0236358155', '0227726495', '01062316256', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '32426946356337', 'No', NULL, NULL, '2021-06-19', 'Employee', 3, 8, 'No', 'No', 2, '8.00', '7675.34', '255.84', 'Fixed', '1996.38', 'Yes', '524.92', '25660565575155', 'No', NULL, NULL, 'Cach', 'No', NULL, '4594 Gwendolyn Rapid Suite 360\nBrownton, AL 52060', 0, 'Widowed', NULL, '365405757', 'Yes', NULL, 6, 'Helga Bosco I', '92954066595273', 'Lake Emery', '2025-02-28', NULL, NULL, NULL, NULL, NULL, 1258326246, 0, 0, 2, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(274, 4648, 730, 'لارا بدر مازن', 'Female', 2, 4, 5, '1983', 'إدارة الأعمال', 'Excellent', '2005-04-27', '83107341946058', '2029-10-15', 'Lake Michealbury', 2, 'Christian', 7, 'howard43@example.net', 4, 27, 9, '0221340977', '0230151969', '01599215016', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '22557213757106', 'No', NULL, NULL, '2020-12-19', 'Employee', 2, 9, 'Yes', 'No', 4, '8.00', '23299.16', '776.64', 'Fixed', '1419.60', 'Yes', '730.68', '71405020594726', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '420 Jakubowski Ports Apt. 705\nNew Aryanna, CT 20719', 0, 'Married', NULL, '70920618664', 'Yes', NULL, 6, 'Adell Homenick IV', '22618190113781', 'West Cruzstad', '2028-04-04', NULL, NULL, NULL, NULL, NULL, 702386499, 0, 0, 4, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(275, 2062, 628, 'تامر عدنان نادر', 'Male', 1, 4, 6, '2009', 'الفيزياء', 'Excellent', '2024-08-04', '92700420649393', '2029-07-16', 'East Aidan', 2, 'Muslim', 5, 'grayce.keebler@example.net', 4, 23, 11, '0232965953', '0229537277', '01589664756', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '75493905450071', 'Yes', NULL, NULL, '2021-08-03', 'Employee', 3, 3, 'Yes', 'No', 2, '7.00', '8380.61', '279.35', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '597.39', '58860815482729', 'Visa', 'No', NULL, '2572 O\'Kon Common Suite 129\nLake Lolatown, IN 65740', 0, 'Widowed', NULL, '722171365', 'Yes', NULL, 1, 'Jackson Mertz', '56398455066970', 'Purdystad', '2028-01-16', NULL, NULL, NULL, NULL, NULL, 515876862, 0, 0, 3, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(276, 1838, 1933, 'سيرين ياسر أحمد', 'Female', 1, 1, 3, '2009', 'إدارة الأعمال', 'Very_Good', '2016-08-04', '30972807909731', '2027-08-11', 'Cummerataborough', 7, 'Christian', 2, 'ydaniel@example.net', 6, 19, 4, '0221108680', '0224336165', '01262428520', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '05272466832921', 'Yes', NULL, NULL, '2020-07-08', 'Employee', 8, 2, 'Yes', 'No', 3, '12.00', '16161.50', '538.72', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '1215 Wilfred Overpass Suite 109\nBoganfort, NY 69158-0143', 0, 'Single', NULL, '737933451', 'Yes', NULL, 5, 'Laney Stehr DDS', '98610180951659', 'Caspermouth', '2029-04-19', NULL, NULL, NULL, NULL, NULL, 798107620, 0, 0, 1, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(277, 6469, 1268, 'ناهد حمزة ناجي', 'Female', 1, 3, 6, '2006', 'علم الأحياء', 'Very_Good', '2014-01-19', '50198010687954', '2029-02-25', 'Lake Maybell', 4, 'Christian', 10, 'njaskolski@example.org', 6, 23, 8, '0235896988', '0235905142', '01503095365', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '52361319788343', 'Yes', NULL, NULL, '2020-09-27', 'Employee', 5, 3, 'No', 'No', 3, '9.00', '37887.95', '1262.93', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '175 Zieme Mews Suite 929\nEast Lesliehaven, CO 32731', 0, 'Widowed', NULL, '37976409060', 'Yes', NULL, 2, 'Baby Littel', '59202943625723', 'North Bettychester', '2027-06-28', NULL, NULL, NULL, NULL, NULL, 1201021253, 0, 0, 1, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(278, 8851, 2580, 'حسن أنور منصور', 'Male', 4, 4, 2, '2005', 'إدارة الأعمال', 'Very_Good', '2014-04-23', '92725986885170', '2027-08-08', 'Concepcionside', 7, 'Christian', 9, 'gorczany.logan@example.com', 6, 16, 9, '0232525062', '0221423355', '01230557510', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Fourth', '66788732120258', 'No', NULL, NULL, '2022-11-11', 'Employee', 1, 2, 'Yes', 'Yes', 2, '12.00', '33747.44', '1124.91', 'Fixed', '1503.84', 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '37591 Brannon Courts Suite 332\nIzaiahchester, OH 75365-7262', 0, 'Widowed', NULL, '5964943341', 'Yes', NULL, 2, 'Burley Morar', '77865218951779', 'Port Germaine', '2025-05-08', NULL, NULL, NULL, NULL, NULL, 1488140445, 0, 0, 2, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(279, 3123, 1216, 'مالك عبدالعزيز رفيق', 'Male', 2, 4, 5, '1985', 'علوم الحاسوب', 'Very_Good', '2013-07-08', '68072217449820', '2025-09-06', 'Juniuston', 7, 'Muslim', 13, 'jlabadie@example.net', 6, 11, 13, '0220071603', '0223193120', '01567338000', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '77979365863579', 'No', NULL, NULL, '2020-08-22', 'Employee', 8, 10, 'Yes', 'No', 3, '12.00', '11935.14', '397.84', 'Fixed', '1668.72', 'No', NULL, NULL, 'Yes', '993.63', '16230882408848', 'Visa', 'No', NULL, '79573 Lockman Vista\nGarnetmouth, AL 83941-8967', 0, 'Single', NULL, '443674519845', 'Yes', NULL, 2, 'Mustafa Cummerata DDS', '16067473006588', 'North Marie', '2024-12-19', NULL, NULL, NULL, NULL, NULL, 651425461, 0, 0, 1, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(280, 2880, 756, 'جمانة وجيه إسماعيل', 'Female', 3, 1, 3, '1995', 'الرياضيات', 'Excellent', '2013-09-04', '87733817487741', '2028-03-21', 'Hegmanntown', 5, 'Christian', 11, 'loraine29@example.net', 2, 21, 8, '0226516495', '0233391044', '01294081534', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '59064709018676', 'Yes', NULL, NULL, '2023-05-16', 'Employee', 10, 5, 'Yes', 'Yes', 3, '10.00', '26957.95', '898.60', 'Fixed', '1980.77', 'Yes', '754.82', '29621708524576', 'No', NULL, NULL, 'Visa', 'No', NULL, '16883 Francisco Inlet\nSchaeferfurt, MT 70831-6781', 0, 'Divorced', NULL, '124234123689', 'Yes', NULL, 5, 'Ray Langosh', '07642512013342', 'South Letatown', '2026-05-19', NULL, NULL, NULL, NULL, NULL, 570208725, 0, 0, 1, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(281, 7183, 212, 'سعيد حسين حامد', 'Male', 2, 3, 5, '2005', 'إدارة الأعمال', 'Excellent', '2007-04-22', '22190743467348', '2025-10-12', 'Lake Rosariobury', 5, 'Muslim', 5, 'aleen12@example.org', 5, 5, 12, '0229535973', '0227963338', '01575623739', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '84171565907479', 'Yes', NULL, NULL, '2024-05-11', 'Employee', 3, 4, 'No', 'No', 2, '10.00', '9470.24', '315.67', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '816.24', '65210140587407', 'Cach', 'Yes', NULL, '80313 Satterfield Station\nEast Ken, OR 63134', 0, 'Single', NULL, '62762874607948', 'Yes', NULL, 5, 'Giovanni Pagac', '36892998731182', 'Lake Lacey', '2026-05-27', NULL, NULL, NULL, NULL, NULL, 897725355, 0, 0, 2, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(282, 8531, 424, 'منصور أكرم حسن', 'Male', 1, 1, 1, '2002', 'إدارة الأعمال', 'Good', '2004-02-02', '58151097063640', '2027-05-28', 'Jacintoland', 6, 'Christian', 7, 'freeman.reynolds@example.org', 6, 20, 15, '0222129325', '0238116965', '01205982085', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Fourth', '01008195741014', 'No', NULL, NULL, '2020-05-16', 'Employee', 6, 8, 'No', 'Yes', 2, '9.00', '15212.91', '507.10', 'Fixed', '1341.64', 'No', NULL, NULL, 'Yes', '536.38', '24607595158347', 'Visa', 'No', NULL, '7648 Helen Inlet Apt. 817\nLake Uniquestad, KY 35138-2442', 0, 'Divorced', NULL, '93578620938317', 'Yes', NULL, 4, 'Noah Vandervort DDS', '94276242579739', 'South Leilani', '2026-03-21', NULL, NULL, NULL, NULL, NULL, 1000635007, 0, 0, 3, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(283, 5574, 2504, 'فريدة عبداللطيف حاتم', 'Female', 1, 1, 4, '1974', 'الرياضيات', 'Very_Good', '2009-07-01', '84492190078191', '2027-10-24', 'Ceciliaville', 5, 'Christian', 2, 'nreichel@example.com', 6, 5, 6, '0232201244', '0225559265', '01556914693', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Motorcycle', '14250548496062', 'Yes', NULL, NULL, '2024-08-10', 'Employee', 9, 6, 'No', 'No', 4, '12.00', '27256.52', '908.55', 'Fixed', '1343.18', 'Yes', '735.97', '37966732065525', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '13744 Aaliyah Pass Apt. 137\nSethchester, HI 18300-1295', 0, 'Single', NULL, '1692068', 'Yes', NULL, 3, 'Izaiah Brown', '36812213904443', 'East Pierce', '2028-11-21', NULL, NULL, NULL, NULL, NULL, 36594502, 0, 0, 1, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(284, 3613, 2822, 'عبدالحي نبيل عبدالباسط', 'Male', 3, 3, 6, '1985', 'الفيزياء', 'Fair', '1999-12-30', '32439765399292', '2027-07-06', 'Port Brandi', 2, 'Muslim', 12, 'agustin31@example.net', 3, 13, 2, '0233221562', '0228530794', '01182767642', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '52337974847733', 'No', NULL, NULL, '2021-10-18', 'Employee', 10, 8, 'Yes', 'No', 2, '7.00', '40801.96', '1360.07', 'Changeable', NULL, 'No', NULL, NULL, 'Yes', '970.40', '90069663953763', 'Cach', 'Yes', NULL, '9194 Wunsch Falls Apt. 877\nLake Hudsonland, DE 15404-2306', 0, 'Married', NULL, '86717204840', 'Yes', NULL, 4, 'Logan Haley', '39318664279934', 'East Candace', '2026-05-04', NULL, NULL, NULL, NULL, NULL, 2121408875, 0, 0, 4, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(285, 2151, 1810, 'لمى أديب أكرم', 'Female', 2, 1, 6, '1991', 'علم الأحياء', 'Good', '2020-12-29', '72642699371935', '2026-09-24', 'Roslynville', 6, 'Christian', 8, 'bharris@example.org', 6, 1, 2, '0220904047', '0232580598', '01002664318', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '34828592359927', 'Yes', NULL, NULL, '2020-03-13', 'Employee', 3, 3, 'Yes', 'No', 3, '11.00', '5505.96', '183.53', 'Fixed', '1198.53', 'Yes', '755.77', '06353226074115', 'Yes', '912.34', '08815395358142', 'Cach', 'Yes', NULL, '5956 Dooley Roads Suite 535\nBuckridgemouth, WV 73396-7542', 0, 'Single', NULL, '8395618019', 'Yes', NULL, 1, 'Trycia Doyle', '42755130947195', 'Nathanaelmouth', '2029-12-03', NULL, NULL, NULL, NULL, NULL, 476031730, 0, 0, 1, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(286, 1219, 1950, 'صهيب عبدالحي تامر', 'Male', 4, 1, 6, '2007', 'علم الأحياء', 'Excellent', '2016-04-12', '99470421880578', '2028-10-05', 'Port Ociefort', 4, 'Christian', 10, 'georgiana.pfannerstill@example.net', 6, 23, 1, '0220295687', '0237580973', '01248270311', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Second', '68697589750275', 'No', NULL, NULL, '2024-01-06', 'Employee', 10, 5, 'Yes', 'No', 4, '11.00', '19731.40', '657.71', 'Fixed', '1618.03', 'Yes', '893.50', '67682724007905', 'Yes', '900.34', '79533287615895', 'Visa', 'No', NULL, '5271 Kendrick Extension Suite 710\nAdrielhaven, WY 50671-0508', 0, 'Single', NULL, '858649411341', 'Yes', NULL, 5, 'Katheryn Brekke', '01051453261799', 'Lake Leonieville', '2029-02-22', NULL, NULL, NULL, NULL, NULL, 745163992, 0, 0, 3, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(287, 1148, 2389, 'عبدالحي جواد حمزة', 'Male', 3, 2, 5, '1998', 'الرياضيات', 'Good', '2009-11-20', '56166247381183', '2025-03-04', 'South Davionview', 6, 'Muslim', 6, 'iparker@example.com', 3, 16, 12, '0224367632', '0221126641', '01575958268', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '12932883102075', 'No', NULL, NULL, '2023-05-12', 'Employee', 8, 5, 'Yes', 'No', 4, '10.00', '7442.43', '248.08', 'Fixed', '1269.83', 'Yes', '706.39', '09783456729079', 'Yes', '857.11', '25363467006411', 'Cach', 'Yes', NULL, '143 Kelly Island\nPollichchester, TX 94606', 0, 'Married', NULL, '3401732', 'Yes', NULL, 5, 'Emilie Ernser', '60427763417460', 'Johathantown', '2025-09-07', NULL, NULL, NULL, NULL, NULL, 853009064, 0, 0, 2, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(288, 3488, 904, 'إسماعيل طلال راغب', 'Male', 2, 2, 2, '1995', 'علم الأحياء', 'Very_Good', '2018-09-13', '86534327642756', '2026-01-20', 'South Beauport', 6, 'Muslim', 10, 'lubowitz.serenity@example.com', 4, 13, 3, '0232606226', '0222692057', '01123511194', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '10351220989059', 'No', NULL, NULL, '2022-02-16', 'Employee', 7, 1, 'Yes', 'No', 2, '8.00', '9127.45', '304.25', 'Changeable', NULL, 'Yes', '746.01', '41546695248647', 'No', NULL, NULL, 'Cach', 'No', NULL, '74990 Gottlieb Gardens\nEast Ernestina, VT 34271', 0, 'Divorced', NULL, '9641473626161', 'Yes', NULL, 1, 'Aaliyah Kris Jr.', '17547895441382', 'Amelybury', '2029-07-06', NULL, NULL, NULL, NULL, NULL, 1097424848, 0, 0, 3, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(289, 4247, 1474, 'تولين حسن عبدالكريم', 'Female', 2, 3, 4, '1974', 'علوم الحاسوب', 'Fair', '2001-12-31', '85528403077913', '2028-07-22', 'Ziemeview', 3, 'Christian', 7, 'wbotsford@example.net', 4, 21, 3, '0223535883', '0226837320', '01130026142', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '27515135071297', 'Yes', NULL, NULL, '2022-08-18', 'Employee', 10, 3, 'Yes', 'Yes', 1, '11.00', '29056.10', '968.54', 'Fixed', '1289.30', 'Yes', '944.29', '22073760660880', 'Yes', '586.84', '74065277727630', 'Visa', 'Yes', NULL, '5391 Mary Falls\nErnserville, MA 02272', 0, 'Married', NULL, '9495181', 'Yes', NULL, 6, 'Savannah Torp', '14406438384528', 'Hillsborough', '2028-04-30', NULL, NULL, NULL, NULL, NULL, 998840630, 0, 0, 3, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(290, 4795, 1472, 'جواد ماهر يوسف', 'Male', 1, 2, 2, '2000', 'علم الأحياء', 'Excellent', '2004-06-15', '44223670996478', '2026-03-13', 'Kerlukeland', 5, 'Christian', 12, 'letitia81@example.com', 5, 25, 10, '0232681311', '0224880402', '01221786880', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '57349461397287', 'No', NULL, NULL, '2022-05-04', 'Employee', 7, 3, 'No', 'No', 4, '11.00', '29586.39', '986.21', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Visa', 'Yes', NULL, '237 Schulist Loop\nPort Bethanyfort, MI 99753', 0, 'Married', NULL, '908238444317', 'Yes', NULL, 5, 'Elissa King', '00299410921964', 'Emmieton', '2026-12-30', NULL, NULL, NULL, NULL, NULL, 332373916, 0, 0, 3, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(291, 2217, 1716, 'توفيق حامد سامر', 'Male', 4, 2, 5, '1993', 'إدارة الأعمال', 'Excellent', '2020-05-04', '92977800682934', '2026-02-27', 'Bashirianport', 2, 'Muslim', 2, 'runolfsson.ladarius@example.org', 5, 21, 8, '0235212014', '0238299170', '01251941231', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Third', '17811856145622', 'Yes', NULL, NULL, '2021-07-13', 'Employee', 2, 4, 'Yes', 'Yes', 2, '10.00', '23184.16', '772.81', 'Changeable', NULL, 'Yes', '763.45', '94497346949843', 'Yes', '523.28', '15039291814534', 'Visa', 'No', NULL, '9813 Corkery Drive Suite 320\nKautzerville, CA 95289-3689', 0, 'Widowed', NULL, '9186764218766', 'Yes', NULL, 2, 'Dr. London Larkin PhD', '51153009396743', 'Bessieside', '2025-06-29', NULL, NULL, NULL, NULL, NULL, 2028550584, 0, 0, 4, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(292, 3812, 2782, 'ياسمين إسماعيل عبدالله', 'Female', 3, 2, 5, '1973', 'علوم الحاسوب', 'Good', '2021-01-20', '36272715204828', '2025-02-02', 'Nienowchester', 7, 'Christian', 12, 'marcelina26@example.com', 6, 20, 7, '0236443805', '0236118603', '01050332624', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Second', '08468087981936', 'No', NULL, NULL, '2022-08-09', 'Employee', 8, 8, 'No', 'Yes', 4, '9.00', '28671.60', '955.72', 'Changeable', NULL, 'Yes', '765.86', '02708166946840', 'No', NULL, NULL, 'Cach', 'Yes', NULL, '783 Annetta Summit Apt. 617\nNew Merrittberg, MD 72084-1686', 0, 'Divorced', NULL, '31629929589', 'Yes', NULL, 2, 'Clement Bode', '89652712424474', 'West Camilla', '2026-07-10', NULL, NULL, NULL, NULL, NULL, 1781263542, 0, 0, 3, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(293, 9765, 850, 'ليلى بكر محمد', 'Female', 1, 1, 2, '1990', 'علم الأحياء', 'Excellent', '2023-12-25', '88143518572365', '2026-10-20', 'Port Ernestoberg', 4, 'Christian', 7, 'rosa.schmeler@example.net', 4, 7, 8, '0220487440', '0238923915', '01150682788', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Pro', '39202820183652', 'Yes', NULL, NULL, '2021-06-29', 'Employee', 2, 1, 'Yes', 'No', 1, '7.00', '40950.07', '1365.00', 'Changeable', NULL, 'Yes', '736.74', '61674732847354', 'No', NULL, NULL, 'Visa', 'No', NULL, '87155 O\'Hara Green\nNorth Newellfurt, TN 67911', 0, 'Single', NULL, '335431046', 'Yes', NULL, 2, 'Tillman Leannon', '61911572986059', 'Napoleonshire', '2027-09-19', NULL, NULL, NULL, NULL, NULL, 1425079172, 0, 0, 2, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(294, 9709, 2713, 'شاكر هيثم إبراهيم', 'Male', 1, 3, 3, '1973', 'الرياضيات', 'Very_Good', '2007-08-21', '08122006769204', '2029-08-09', 'Pollichmouth', 4, 'Muslim', 5, 'jarrell.thompson@example.net', 2, 22, 14, '0232713179', '0239582283', '01213423147', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Third', '80682763753806', 'Yes', NULL, NULL, '2021-10-17', 'Employee', 3, 10, 'Yes', 'Yes', 4, '9.00', '35059.03', '1168.63', 'Changeable', NULL, 'Yes', '548.44', '68011326021992', 'Yes', '514.81', '14201109475059', 'Cach', 'No', NULL, '377 Veum Turnpike\nLake Amosport, OR 18227-0330', 0, 'Single', NULL, '2065133521', 'Yes', NULL, 5, 'Mrs. Jana Bradtke Jr.', '45691754971266', 'Zulaufmouth', '2026-09-07', NULL, NULL, NULL, NULL, NULL, 522973586, 0, 0, 3, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(295, 1633, 189, 'عصام كريم أديب', 'Male', 1, 1, 3, '1999', 'الرياضيات', 'Very_Good', '2008-11-15', '21835126544942', '2026-07-23', 'Hermanland', 3, 'Christian', 8, 'ckiehn@example.net', 1, 23, 4, '0233027709', '0233083392', '01216119103', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'First', '46221071598938', 'No', NULL, NULL, '2021-08-27', 'Employee', 9, 2, 'Yes', 'No', 4, '8.00', '31361.03', '1045.37', 'Fixed', '1369.20', 'No', NULL, NULL, 'Yes', '909.45', '80257667665182', 'Visa', 'No', NULL, '53192 Larry Orchard\nNew Reeceberg, WA 40565', 0, 'Married', NULL, '8876962113378', 'Yes', NULL, 3, 'Harry King', '99207919231352', 'Cotymouth', '2026-03-02', NULL, NULL, NULL, NULL, NULL, 98197935, 0, 0, 3, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57');
INSERT INTO `employees` (`id`, `employee_code`, `fp_code`, `name`, `gender`, `branch_id`, `job_grade_id`, `qualification_id`, `qualification_year`, `major`, `graduation_estimate`, `brith_date`, `national_id`, `end_national_id`, `national_id_place`, `blood_types_id`, `religion`, `language_id`, `email`, `country_id`, `governorate_id`, `city_id`, `home_telephone`, `work_telephone`, `mobile`, `military`, `military_date_from`, `military_date_to`, `military_wepon`, `military_exemption_date`, `military_exemption_reason`, `military_postponement_reason`, `date_resignation`, `resignation_reason`, `driving_license`, `driving_license_type`, `driving_License_id`, `has_relatives`, `relatives_details`, `notes`, `work_start_date`, `functional_status`, `department_id`, `job_categories_id`, `has_attendance`, `has_fixed_shift`, `shift_types_id`, `daily_work_hour`, `salary`, `day_price`, `motivation_type`, `motivation`, `social_insurance`, `social_insurance_cut_monthely`, `social_insurance_number`, `medical_insurance`, `medical_insurance_cut_monthely`, `medical_insurance_number`, `Type_salary_receipt`, `active_vacation`, `urgent_person_details`, `staies_address`, `children_number`, `social_status`, `resignation_id`, `bank_number_account`, `disabilities`, `disabilities_type`, `nationality_id`, `name_sponsor`, `pasport_identity`, `pasport_from_place`, `pasport_exp_date`, `num_vacation_days`, `add_service`, `years_service`, `cv`, `basic_address_country`, `fixed_allowances`, `is_done_Vacation_formula`, `is_Sensitive_manager_data`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(296, 4383, 1352, 'لميس زيد كريم', 'Female', 1, 1, 3, '2012', 'علوم الحاسوب', 'Very_Good', '2012-07-05', '28060373457837', '2029-06-21', 'West Llewellynland', 7, 'Christian', 4, 'psmith@example.org', 1, 6, 9, '0237706017', '0223158811', '01563921718', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Special', '06283292698945', 'No', NULL, NULL, '2022-01-09', 'Employee', 2, 3, 'Yes', 'No', 3, '9.00', '18392.05', '613.07', 'Fixed', '1269.78', 'Yes', '816.53', '52902901659802', 'Yes', '723.20', '97098756068381', 'Visa', 'Yes', NULL, '75375 Fay Light\nDougmouth, ID 60567', 0, 'Divorced', NULL, '085969443', 'Yes', NULL, 4, 'Mohammad Reichert DVM', '35205368729890', 'Kyleeborough', '2029-12-03', NULL, NULL, NULL, NULL, NULL, 504190315, 0, 0, 1, NULL, 1, '2024-12-12 15:30:57', '2024-12-12 15:30:57'),
(297, 4340, 1723, 'يوسف حسن عبدالحميد', 'Male', 3, 4, 3, '1993', 'علوم الحاسوب', 'Good', '2009-05-08', '25510171837259', '2027-08-14', 'South Ines', 1, 'Christian', 3, 'vleffler@example.net', 2, 16, 8, '0231509131', '0235793794', '01124103608', 'Complete', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'First', '32072799630760', 'No', NULL, NULL, '2023-01-24', 'Employee', 3, 3, 'No', 'Yes', 4, '11.00', '10059.85', '335.33', 'Changeable', NULL, 'Yes', '620.95', '46989443682259', 'Yes', '664.48', '15749495962625', 'Visa', 'Yes', NULL, '961 Derek Fort\nPadbergside, MI 13297', 0, 'Married', NULL, '4513183086', 'Yes', NULL, 1, 'Mary Williamson', '07554206030277', 'Wymanmouth', '2025-03-03', NULL, NULL, NULL, NULL, NULL, 1750714809, 0, 0, 3, NULL, 1, '2024-12-12 15:30:58', '2024-12-12 15:30:58'),
(298, 4419, 893, 'نبيل رامي عماد', 'Male', 3, 1, 3, '1987', 'الفيزياء', 'Good', '2000-12-19', '23346157831054', '2026-06-08', 'Jonburgh', 6, 'Muslim', 5, 'stone.lesch@example.net', 6, 1, 8, '0229490008', '0226860760', '01023142364', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '71718777501906', 'No', NULL, NULL, '2020-09-08', 'Employee', 7, 8, 'No', 'Yes', 3, '9.00', '31011.76', '1033.73', 'Fixed', '1661.32', 'No', NULL, NULL, 'Yes', '676.17', '46647829349925', 'Visa', 'No', NULL, '6478 King Crescent Suite 994\nRandalmouth, TX 00303', 0, 'Divorced', NULL, '10425752778460', 'Yes', NULL, 6, 'Trevor Schimmel', '17487463623281', 'New Hillard', '2028-11-15', NULL, NULL, NULL, NULL, NULL, 843954112, 0, 0, 4, NULL, 1, '2024-12-12 15:30:58', '2024-12-12 15:30:58'),
(299, 1450, 859, 'تولين إلياس عبدالحميد', 'Female', 4, 3, 2, '1971', 'إدارة الأعمال', 'Very_Good', '2019-09-14', '91630416280153', '2025-04-02', 'Lake Jaron', 1, 'Christian', 11, 'ava.ward@example.com', 4, 9, 13, '0229184087', '0220192363', '01038913138', 'Exemption', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Yes', 'Pro', '14411170620521', 'No', NULL, NULL, '2023-04-25', 'Employee', 7, 6, 'No', 'Yes', 4, '12.00', '5558.30', '185.28', 'Changeable', NULL, 'No', NULL, NULL, 'No', NULL, NULL, 'Cach', 'Yes', NULL, '555 Jamir Hollow Suite 340\nNew Heath, DC 56029', 0, 'Married', NULL, '96950689809', 'Yes', NULL, 4, 'Prof. Jada Schowalter II', '17793068961726', 'Lake Virgilchester', '2026-09-04', NULL, NULL, NULL, NULL, NULL, 1497438034, 0, 0, 4, NULL, 1, '2024-12-12 15:30:58', '2024-12-12 15:30:58'),
(300, 5211, 318, 'تالين مازن زين', 'Female', 3, 4, 1, '1990', 'إدارة الأعمال', 'Excellent', '2013-10-06', '43211136829236', '2028-07-19', 'Paucekton', 5, 'Christian', 2, 'peggie11@example.net', 2, 13, 2, '0238406721', '0229379526', '01136471048', 'Exemption_Temporary', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'No', 'Motorcycle', '64998553579944', 'Yes', NULL, NULL, '2021-11-24', 'Employee', 1, 6, 'No', 'No', 2, '10.00', '17233.51', '574.45', 'Changeable', NULL, 'Yes', '896.12', '84543318378333', 'No', NULL, NULL, 'Visa', 'No', NULL, '46485 Avis Mount\nJameyhaven, IN 22254', 0, 'Married', NULL, '7604201085', 'Yes', NULL, 5, 'Isabelle Wilkinson IV', '01061572758735', 'Port Torrancefurt', '2026-10-05', NULL, NULL, NULL, NULL, NULL, 1180528918, 0, 0, 4, NULL, 1, '2024-12-12 15:30:58', '2024-12-12 15:30:58');

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
(1, '2024', 'السنه المالية لسنه 2024', '2024-01-01', '2024-12-31', 1, 1, 1, 1, '2024-12-12 15:30:29', '2024-12-12 15:32:12');

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
(1, 1, '2024', 1, '2024-01', '2024-01-01', '2024-01-31', 31, '2024-01-01', '2024-01-31', 1, 1, 1, 1, '2024-12-12 15:30:29', '2024-12-12 15:32:21'),
(2, 1, '2024', 2, '2024-02', '2024-02-01', '2024-02-28', 28, '2024-02-01', '2024-02-28', 0, 1, 1, 1, '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(3, 1, '2024', 3, '2024-03', '2024-03-01', '2024-03-31', 31, '2024-03-01', '2024-03-31', 0, 1, 1, 1, '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(4, 1, '2024', 4, '2024-04', '2024-04-01', '2024-04-30', 30, '2024-04-01', '2024-04-30', 0, 1, 1, 1, '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(5, 1, '2024', 5, '2024-05', '2024-05-01', '2024-05-31', 31, '2024-05-01', '2024-05-31', 0, 1, 1, 1, '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(6, 1, '2024', 6, '2024-06', '2024-06-01', '2024-06-30', 30, '2024-06-01', '2024-06-30', 0, 1, 1, 1, '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(7, 1, '2024', 7, '2024-07', '2024-07-01', '2024-07-31', 31, '2024-07-01', '2024-07-31', 0, 1, 1, 1, '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(8, 1, '2024', 8, '2024-08', '2024-08-01', '2024-08-31', 31, '2024-08-01', '2024-08-31', 0, 1, 1, 1, '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(9, 1, '2024', 9, '2024-09', '2024-09-01', '2024-09-30', 30, '2024-09-01', '2024-09-30', 0, 1, 1, 1, '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(10, 1, '2024', 10, '2024-10', '2024-10-01', '2024-10-31', 31, '2024-10-01', '2024-10-31', 0, 1, 1, 1, '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(11, 1, '2024', 11, '2024-11', '2024-11-01', '2024-11-30', 30, '2024-11-01', '2024-11-30', 0, 1, 1, 1, '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(12, 1, '2024', 12, '2024-02', '2024-12-01', '2024-12-31', 31, '2024-12-01', '2024-12-30', 0, 1, 1, 1, '2024-12-12 15:30:29', '2024-12-12 15:30:29');

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
(10, 'مصمم جرافيك', 1, 1, 1, 1, NULL, NULL);

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

--
-- Dumping data for table `main_salary_employees`
--

INSERT INTO `main_salary_employees` (`id`, `finance_cln_periods_id`, `financial_year`, `year_month`, `employee_code`, `employee_name`, `salary_employee`, `day_price`, `branch_id`, `employee_status`, `employee_department_code`, `employee_jobs_id`, `total_rewards_salary`, `motivation`, `additional_days_counter`, `additional_days_total`, `fixed_allowances`, `changeable_allowance`, `total_benefits`, `sanctions_days_counter`, `sanctions_days_total`, `absence_days_counter`, `absence_days_total`, `monthly_loan`, `permanent_loan`, `discount`, `phones_bill`, `medical_insurance_monthly`, `medical_social_monthly`, `total_deductions`, `net_salary`, `net_salary_after_close_for_deportation`, `archive_by`, `is_archived`, `archived_date`, `last_salary_remain_balance`, `last_main_salary_record_id`, `is_take_action_disbursed_collect`, `cash_visa`, `is_sensitive_manager_data`, `is_stopped`, `com_code`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, '2024', '2024-01', 1142, 'عدنان عماد بدر', '41576.81', '1385.89', 1, 'Employee', 3, 6, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '41576.81', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '862.01', NULL, '862.01', '40714.80', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:21', '2024-12-12 15:32:21'),
(2, 1, '2024', '2024-01', 1148, 'عبدالحي جواد حمزة', '7442.43', '248.08', 3, 'Employee', 8, 5, '0.00', '1269.83', '0.00', '0.00', '0.00', '0.00', '8712.26', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '857.11', '706.39', '1563.50', '7148.76', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:21', '2024-12-12 15:32:21'),
(3, 1, '2024', '2024-01', 1173, 'ميس عامر عامر', '23354.02', '778.47', 3, 'Employee', 7, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '23354.02', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '730.42', '847.53', '1577.95', '21776.07', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:21', '2024-12-12 15:32:21'),
(4, 1, '2024', '2024-01', 1205, 'عادل عصام معاذ', '15898.03', '529.93', 4, 'Employee', 4, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '15898.03', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '15898.03', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:21', '2024-12-12 15:32:21'),
(5, 1, '2024', '2024-01', 1219, 'صهيب عبدالحي تامر', '19731.40', '657.71', 4, 'Employee', 10, 5, '0.00', '1618.03', '0.00', '0.00', '0.00', '0.00', '21349.43', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '900.34', '893.50', '1793.84', '19555.59', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:21', '2024-12-12 15:32:21'),
(6, 1, '2024', '2024-01', 1258, 'ليان سعيد عبدالرزاق', '28674.05', '955.80', 1, 'Employee', 1, 9, '0.00', '1676.92', '0.00', '0.00', '0.00', '0.00', '30350.97', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '979.22', '806.07', '1785.29', '28565.68', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:21', '2024-12-12 15:32:21'),
(7, 1, '2024', '2024-01', 1383, 'نوران حمزة راغب', '31905.95', '1063.53', 2, 'Employee', 6, 2, '0.00', '1938.68', '0.00', '0.00', '0.00', '0.00', '33844.63', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '830.59', NULL, '830.59', '33014.04', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:21', '2024-12-12 15:32:22'),
(8, 1, '2024', '2024-01', 1386, 'طارق سعيد ياسر', '18199.85', '606.66', 1, 'Employee', 10, 6, '0.00', '1631.43', '0.00', '0.00', '0.00', '0.00', '19831.28', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '19831.28', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(9, 1, '2024', '2024-01', 1394, 'رغد سامي عصام', '23130.89', '771.03', 3, 'Employee', 2, 6, '0.00', '1683.20', '0.00', '0.00', '0.00', '0.00', '24814.09', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '901.81', '681.39', '1583.20', '23230.89', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(10, 1, '2024', '2024-01', 1450, 'تولين إلياس عبدالحميد', '5558.30', '185.28', 4, 'Employee', 7, 6, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '5558.30', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '5558.30', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(11, 1, '2024', '2024-01', 1464, 'حسين رشيد سعيد', '35601.54', '1186.72', 1, 'Employee', 7, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '35601.54', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '654.98', '654.98', '34946.56', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(12, 1, '2024', '2024-01', 1505, 'رفيق عبدالحكيم أحمد', '46925.63', '1564.19', 3, 'Employee', 2, 3, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '46925.63', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '546.60', NULL, '546.60', '46379.03', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(13, 1, '2024', '2024-01', 1515, 'طلال حذيفة سامي', '16902.08', '563.40', 1, 'Employee', 1, 10, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '16902.08', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '16902.08', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(14, 1, '2024', '2024-01', 1556, 'جميلة أنس عبدالعزيز', '15738.05', '524.60', 2, 'Employee', 7, 1, '0.00', '1868.05', '0.00', '0.00', '0.00', '0.00', '17606.10', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '582.52', NULL, '582.52', '17023.58', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(15, 1, '2024', '2024-01', 1605, 'باسم حسين محمد', '20950.76', '698.36', 2, 'Employee', 9, 2, '0.00', '1647.10', '0.00', '0.00', '0.00', '0.00', '22597.86', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '22597.86', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(16, 1, '2024', '2024-01', 1615, 'نور راغب حذيفة', '30479.48', '1015.98', 1, 'Employee', 9, 3, '0.00', '1744.27', '0.00', '0.00', '0.00', '0.00', '32223.75', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '510.89', NULL, '510.89', '31712.86', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(17, 1, '2024', '2024-01', 1633, 'عصام كريم أديب', '31361.03', '1045.37', 1, 'Employee', 9, 2, '0.00', '1369.20', '0.00', '0.00', '0.00', '0.00', '32730.23', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '909.45', NULL, '909.45', '31820.78', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(18, 1, '2024', '2024-01', 1639, 'عبدالحميد زيد جمال', '11478.80', '382.63', 4, 'Employee', 1, 10, '0.00', '1855.14', '0.00', '0.00', '0.00', '0.00', '13333.94', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '578.68', '578.68', '12755.26', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(19, 1, '2024', '2024-01', 1668, 'عبدالفتاح منصور محمود', '31891.51', '1063.05', 1, 'Employee', 4, 6, '0.00', '1620.22', '0.00', '0.00', '0.00', '0.00', '33511.73', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '565.14', NULL, '565.14', '32946.59', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(20, 1, '2024', '2024-01', 1707, 'حلا جواد شريف', '17898.65', '596.62', 4, 'Employee', 6, 1, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '17898.65', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '516.39', '798.13', '1314.52', '16584.13', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(21, 1, '2024', '2024-01', 1720, 'عبدالسلام طلال عماد', '44341.42', '1478.05', 3, 'Employee', 8, 8, '0.00', '1685.76', '0.00', '0.00', '0.00', '0.00', '46027.18', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '791.29', '791.29', '45235.89', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(22, 1, '2024', '2024-01', 1764, 'حمزة أكرم ثامر', '44877.51', '1495.92', 3, 'Employee', 4, 2, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '44877.51', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '578.63', NULL, '578.63', '44298.88', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(23, 1, '2024', '2024-01', 1815, 'تالين إسماعيل رامي', '19839.16', '661.31', 4, 'Employee', 9, 3, '0.00', '1824.49', '0.00', '0.00', '0.00', '0.00', '21663.65', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '644.42', NULL, '644.42', '21019.23', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(24, 1, '2024', '2024-01', 1826, 'تالين نبيل هيثم', '41576.29', '1385.88', 3, 'Employee', 10, 4, '0.00', '1895.08', '0.00', '0.00', '0.00', '0.00', '43471.37', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '43471.37', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(25, 1, '2024', '2024-01', 1831, 'شادي محمود عدنان', '20823.50', '694.12', 4, 'Employee', 9, 3, '0.00', '1264.31', '0.00', '0.00', '0.00', '0.00', '22087.81', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '954.38', '744.99', '1699.37', '20388.44', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(26, 1, '2024', '2024-01', 1838, 'سيرين ياسر أحمد', '16161.50', '538.72', 1, 'Employee', 8, 2, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '16161.50', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '16161.50', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(27, 1, '2024', '2024-01', 1854, 'ثريا فارس عامر', '45611.66', '1520.39', 3, 'Employee', 2, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '45611.66', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '780.27', '920.50', '1700.77', '43910.89', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(28, 1, '2024', '2024-01', 1874, 'راغب عادل عبدالله', '28403.26', '946.78', 2, 'Employee', 7, 2, '0.00', '1623.74', '0.00', '0.00', '0.00', '0.00', '30027.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '815.57', NULL, '815.57', '29211.43', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(29, 1, '2024', '2024-01', 1919, 'سلمى شاكر حسن', '29322.66', '977.42', 2, 'Employee', 6, 2, '0.00', '1606.60', '0.00', '0.00', '0.00', '0.00', '30929.26', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '586.45', NULL, '586.45', '30342.81', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(30, 1, '2024', '2024-01', 1923, 'حسن توفيق عبدالله', '33155.05', '1105.17', 2, 'Employee', 5, 1, '0.00', '1677.63', '0.00', '0.00', '0.00', '0.00', '34832.68', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '633.30', '636.71', '1270.01', '33562.67', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(31, 1, '2024', '2024-01', 1925, 'آنا زين جمال', '41324.59', '1377.49', 2, 'Employee', 7, 7, '0.00', '1983.19', '0.00', '0.00', '0.00', '0.00', '43307.78', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '941.36', NULL, '941.36', '42366.42', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(32, 1, '2024', '2024-01', 1964, 'منى يحيى ياسر', '37549.66', '1251.66', 1, 'Employee', 2, 5, '0.00', '1178.73', '0.00', '0.00', '0.00', '0.00', '38728.39', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '711.83', NULL, '711.83', '38016.56', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(33, 1, '2024', '2024-01', 1967, 'شهد إسماعيل ثامر', '26318.85', '877.30', 2, 'Employee', 2, 9, '0.00', '1805.67', '0.00', '0.00', '0.00', '0.00', '28124.52', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '915.95', NULL, '915.95', '27208.57', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(34, 1, '2024', '2024-01', 2005, 'فاطمة عمر طارق', '31630.32', '1054.34', 3, 'Employee', 8, 1, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '31630.32', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '712.20', '832.56', '1544.76', '30085.56', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(35, 1, '2024', '2024-01', 2034, 'عماد كريم سليمان', '43216.79', '1440.56', 2, 'Employee', 2, 1, '0.00', '1541.09', '0.00', '0.00', '0.00', '0.00', '44757.88', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '690.84', '769.11', '1459.95', '43297.93', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(36, 1, '2024', '2024-01', 2038, 'فايزة قاسم مالك', '38274.82', '1275.83', 3, 'Employee', 1, 6, '0.00', '1510.20', '0.00', '0.00', '0.00', '0.00', '39785.02', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '39785.02', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(37, 1, '2024', '2024-01', 2056, 'رنا معاذ رياض', '10946.61', '364.89', 1, 'Employee', 7, 2, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '10946.61', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '812.78', '928.66', '1741.44', '9205.17', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(38, 1, '2024', '2024-01', 2062, 'تامر عدنان نادر', '8380.61', '279.35', 1, 'Employee', 3, 3, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '8380.61', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '597.39', NULL, '597.39', '7783.22', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(39, 1, '2024', '2024-01', 2064, 'شهد علاء محمد', '24251.52', '808.38', 4, 'Employee', 2, 8, '0.00', '1840.17', '0.00', '0.00', '0.00', '0.00', '26091.69', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '26091.69', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(40, 1, '2024', '2024-01', 2067, 'ميرال مصطفى يوسف', '24559.03', '818.63', 2, 'Employee', 1, 2, '0.00', '1846.91', '0.00', '0.00', '0.00', '0.00', '26405.94', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '739.98', NULL, '739.98', '25665.96', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(41, 1, '2024', '2024-01', 2147, 'وجيه إسماعيل رشيد', '41016.02', '1367.20', 3, 'Employee', 8, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '41016.02', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '715.84', '715.84', '40300.18', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(42, 1, '2024', '2024-01', 2151, 'لمى أديب أكرم', '5505.96', '183.53', 2, 'Employee', 3, 3, '0.00', '1198.53', '0.00', '0.00', '0.00', '0.00', '6704.49', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '912.34', '755.77', '1668.11', '5036.38', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(43, 1, '2024', '2024-01', 2217, 'توفيق حامد سامر', '23184.16', '772.81', 4, 'Employee', 2, 4, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '23184.16', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '523.28', '763.45', '1286.73', '21897.43', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(44, 1, '2024', '2024-01', 2230, 'علا عدنان مازن', '23795.49', '793.18', 2, 'Employee', 10, 7, '0.00', '1375.59', '0.00', '0.00', '0.00', '0.00', '25171.08', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '619.13', NULL, '619.13', '24551.95', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(45, 1, '2024', '2024-01', 2236, 'عادل بدر سهيل', '44795.40', '1493.18', 4, 'Employee', 2, 6, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '44795.40', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '44795.40', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(46, 1, '2024', '2024-01', 2289, 'يسرا إبراهيم رامي', '21469.85', '715.66', 2, 'Employee', 2, 7, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '21469.85', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '930.37', '756.32', '1686.69', '19783.16', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(47, 1, '2024', '2024-01', 2298, 'يحيى قاسم سعيد', '8710.90', '290.36', 2, 'Employee', 7, 3, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '8710.90', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '8710.90', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(48, 1, '2024', '2024-01', 2329, 'ثامر أحمد عبدالسلام', '10215.75', '340.53', 3, 'Employee', 8, 1, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '10215.75', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '877.04', '868.63', '1745.67', '8470.08', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(49, 1, '2024', '2024-01', 2345, 'إيمان حامد حسن', '38290.66', '1276.36', 3, 'Employee', 10, 3, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '38290.66', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '543.98', '543.98', '37746.68', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(50, 1, '2024', '2024-01', 2543, 'لجين ربيع أمجد', '44788.00', '1492.93', 3, 'Employee', 5, 1, '0.00', '1064.54', '0.00', '0.00', '0.00', '0.00', '45852.54', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '45852.54', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(51, 1, '2024', '2024-01', 2578, 'ياسمين صهيب علاء', '14619.81', '487.33', 3, 'Employee', 4, 7, '0.00', '1053.81', '0.00', '0.00', '0.00', '0.00', '15673.62', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '916.35', NULL, '916.35', '14757.27', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(52, 1, '2024', '2024-01', 2606, 'نجوى ثامر رامز', '36712.00', '1223.73', 4, 'Employee', 2, 4, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '36712.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '982.04', '982.04', '35729.96', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(53, 1, '2024', '2024-01', 2643, 'مايا مازن عمر', '22166.62', '738.89', 3, 'Employee', 6, 1, '0.00', '1511.28', '0.00', '0.00', '0.00', '0.00', '23677.90', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '558.32', '558.32', '23119.58', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(54, 1, '2024', '2024-01', 2675, 'سهى علي وجيه', '42983.73', '1432.79', 1, 'Employee', 7, 4, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '42983.73', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '688.83', NULL, '688.83', '42294.90', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(55, 1, '2024', '2024-01', 2750, 'نور سهيل حاتم', '36957.07', '1231.90', 2, 'Employee', 8, 4, '0.00', '1105.79', '0.00', '0.00', '0.00', '0.00', '38062.86', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '739.86', '739.86', '37323.00', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(56, 1, '2024', '2024-01', 2762, 'لارا لؤي عبدالحكيم', '45546.34', '1518.21', 2, 'Employee', 8, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '45546.34', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '45546.34', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(57, 1, '2024', '2024-01', 2780, 'رانيا سامي سهيل', '9525.15', '317.51', 4, 'Employee', 1, 3, '0.00', '1468.47', '0.00', '0.00', '0.00', '0.00', '10993.62', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '882.59', '797.56', '1680.15', '9313.47', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(58, 1, '2024', '2024-01', 2785, 'رنا بدر محمود', '40121.46', '1337.38', 1, 'Employee', 2, 4, '0.00', '1114.09', '0.00', '0.00', '0.00', '0.00', '41235.55', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '672.58', '672.58', '40562.97', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(59, 1, '2024', '2024-01', 2817, 'ليان فارس وائل', '22840.97', '761.37', 4, 'Employee', 1, 4, '0.00', '1787.72', '0.00', '0.00', '0.00', '0.00', '24628.69', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '801.97', '801.97', '23826.72', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(60, 1, '2024', '2024-01', 2819, 'هاجر عبدالله ماهر', '10583.56', '352.79', 4, 'Employee', 10, 3, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '10583.56', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '902.88', '902.88', '9680.68', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(61, 1, '2024', '2024-01', 2856, 'أماني علاء تامر', '11248.04', '374.93', 3, 'Employee', 3, 6, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '11248.04', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '11248.04', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(62, 1, '2024', '2024-01', 2871, 'حمزة حذيفة سامي', '16161.74', '538.72', 1, 'Employee', 9, 1, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '16161.74', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '626.42', '626.42', '15535.32', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(63, 1, '2024', '2024-01', 2880, 'جمانة وجيه إسماعيل', '26957.95', '898.60', 3, 'Employee', 10, 5, '0.00', '1980.77', '0.00', '0.00', '0.00', '0.00', '28938.72', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '754.82', '754.82', '28183.90', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(64, 1, '2024', '2024-01', 2970, 'صهيب علي أنس', '7675.34', '255.84', 2, 'Employee', 3, 8, '0.00', '1996.38', '0.00', '0.00', '0.00', '0.00', '9671.72', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '524.92', '524.92', '9146.80', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(65, 1, '2024', '2024-01', 3025, 'وجيه بدر إلياس', '49840.16', '1661.34', 2, 'Employee', 3, 3, '0.00', '1042.08', '0.00', '0.00', '0.00', '0.00', '50882.24', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '721.21', NULL, '721.21', '50161.03', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(66, 1, '2024', '2024-01', 3048, 'أنور وجيه ثامر', '22717.51', '757.25', 3, 'Employee', 8, 10, '0.00', '1844.84', '0.00', '0.00', '0.00', '0.00', '24562.35', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '516.44', '516.44', '24045.91', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(67, 1, '2024', '2024-01', 3082, 'كنزي شاكر عبدالرزاق', '38634.07', '1287.80', 3, 'Employee', 8, 4, '0.00', '1773.20', '0.00', '0.00', '0.00', '0.00', '40407.27', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '778.89', '778.89', '39628.38', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(68, 1, '2024', '2024-01', 3084, 'عمر أحمد عبدالله', '34528.11', '1150.94', 4, 'Employee', 5, 1, '0.00', '1647.94', '0.00', '0.00', '0.00', '0.00', '36176.05', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '710.72', '710.72', '35465.33', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(69, 1, '2024', '2024-01', 3099, 'روان عبدالرحمن أكرم', '44176.74', '1472.56', 1, 'Employee', 2, 10, '0.00', '1829.83', '0.00', '0.00', '0.00', '0.00', '46006.57', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '598.83', '646.06', '1244.89', '44761.68', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:22', '2024-12-12 15:32:22'),
(70, 1, '2024', '2024-01', 3103, 'عامر سامر عصام', '34576.92', '1152.56', 1, 'Employee', 9, 2, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '34576.92', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '660.92', '958.77', '1619.69', '32957.23', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(71, 1, '2024', '2024-01', 3123, 'مالك عبدالعزيز رفيق', '11935.14', '397.84', 2, 'Employee', 8, 10, '0.00', '1668.72', '0.00', '0.00', '0.00', '0.00', '13603.86', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '993.63', NULL, '993.63', '12610.23', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(72, 1, '2024', '2024-01', 3140, 'فاطمة عبدالرزاق عبدالكريم', '30328.90', '1010.96', 3, 'Employee', 10, 5, '0.00', '1346.09', '0.00', '0.00', '0.00', '0.00', '31674.99', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '589.56', NULL, '589.56', '31085.43', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(73, 1, '2024', '2024-01', 3146, 'سهيل ياسر كريم', '14465.28', '482.18', 2, 'Employee', 7, 9, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '14465.28', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '14465.28', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(74, 1, '2024', '2024-01', 3243, 'ساجدة رفيق إبراهيم', '48183.88', '1606.13', 4, 'Employee', 9, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '48183.88', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '727.44', '727.44', '47456.44', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(75, 1, '2024', '2024-01', 3267, 'صهيب أحمد طلال', '38829.51', '1294.32', 1, 'Employee', 4, 9, '0.00', '1846.57', '0.00', '0.00', '0.00', '0.00', '40676.08', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '40676.08', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(76, 1, '2024', '2024-01', 3276, 'روز ثامر إبراهيم', '21168.49', '705.62', 1, 'Employee', 2, 1, '0.00', '1429.86', '0.00', '0.00', '0.00', '0.00', '22598.35', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '968.77', '666.94', '1635.71', '20962.64', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(77, 1, '2024', '2024-01', 3279, 'آنا أيوب نور', '39209.50', '1306.98', 1, 'Employee', 8, 4, '0.00', '1020.71', '0.00', '0.00', '0.00', '0.00', '40230.21', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '567.08', NULL, '567.08', '39663.13', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(78, 1, '2024', '2024-01', 3307, 'هيثم عبدالحكيم طلال', '21343.51', '711.45', 3, 'Employee', 2, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '21343.51', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '903.70', NULL, '903.70', '20439.81', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(79, 1, '2024', '2024-01', 3371, 'عبدالرحمن طارق ثامر', '9691.91', '323.06', 1, 'Employee', 2, 9, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '9691.91', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '894.16', '894.16', '8797.75', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(80, 1, '2024', '2024-01', 3427, 'سعاد باسل شريف', '22841.64', '761.39', 4, 'Employee', 2, 1, '0.00', '1271.51', '0.00', '0.00', '0.00', '0.00', '24113.15', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '830.08', NULL, '830.08', '23283.07', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(81, 1, '2024', '2024-01', 3440, 'سالم مازن قاسم', '22883.08', '762.77', 1, 'Employee', 4, 9, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '22883.08', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '22883.08', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(82, 1, '2024', '2024-01', 3444, 'توفيق مالك عبدالفتاح', '27895.94', '929.86', 1, 'Employee', 1, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '27895.94', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '986.20', '986.20', '26909.74', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(83, 1, '2024', '2024-01', 3461, 'تولين عمار باسم', '15686.88', '522.90', 2, 'Employee', 5, 10, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '15686.88', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '868.06', '868.06', '14818.82', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(84, 1, '2024', '2024-01', 3480, 'سيف معاذ باسل', '25649.64', '854.99', 3, 'Employee', 6, 7, '0.00', '1040.29', '0.00', '0.00', '0.00', '0.00', '26689.93', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '658.43', '511.71', '1170.14', '25519.79', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(85, 1, '2024', '2024-01', 3488, 'إسماعيل طلال راغب', '9127.45', '304.25', 2, 'Employee', 7, 1, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '9127.45', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '746.01', '746.01', '8381.44', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(86, 1, '2024', '2024-01', 3489, 'نادية فارس عبدالحكيم', '10878.92', '362.63', 1, 'Employee', 6, 5, '0.00', '1554.41', '0.00', '0.00', '0.00', '0.00', '12433.33', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '929.02', NULL, '929.02', '11504.31', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(87, 1, '2024', '2024-01', 3516, 'لجين عبدالحكيم سامر', '49446.58', '1648.22', 1, 'Employee', 1, 7, '0.00', '1007.15', '0.00', '0.00', '0.00', '0.00', '50453.73', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '624.89', '624.89', '49828.84', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(88, 1, '2024', '2024-01', 3535, 'سلمى شادي مازن', '26941.42', '898.05', 3, 'Employee', 9, 3, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '26941.42', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '910.39', '763.98', '1674.37', '25267.05', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(89, 1, '2024', '2024-01', 3537, 'عبدالكريم إبراهيم حسن', '16169.90', '539.00', 2, 'Employee', 6, 5, '0.00', '1257.98', '0.00', '0.00', '0.00', '0.00', '17427.88', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '619.50', NULL, '619.50', '16808.38', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(90, 1, '2024', '2024-01', 3564, 'صابر حمزة قاسم', '12092.69', '403.09', 3, 'Employee', 8, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '12092.69', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '571.11', '938.38', '1509.49', '10583.20', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(91, 1, '2024', '2024-01', 3577, 'جنى فارس راغب', '11907.60', '396.92', 4, 'Employee', 6, 2, '0.00', '1481.54', '0.00', '0.00', '0.00', '0.00', '13389.14', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '13389.14', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(92, 1, '2024', '2024-01', 3613, 'عبدالحي نبيل عبدالباسط', '40801.96', '1360.07', 3, 'Employee', 10, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '40801.96', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '970.40', NULL, '970.40', '39831.56', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(93, 1, '2024', '2024-01', 3678, 'مازن فارس عبدالسلام', '12239.05', '407.97', 2, 'Employee', 2, 9, '0.00', '1912.85', '0.00', '0.00', '0.00', '0.00', '14151.90', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '564.69', NULL, '564.69', '13587.21', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(94, 1, '2024', '2024-01', 3695, 'جمانة رياض حسين', '24928.70', '830.96', 2, 'Employee', 9, 2, '0.00', '1175.97', '0.00', '0.00', '0.00', '0.00', '26104.67', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '604.04', NULL, '604.04', '25500.63', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(95, 1, '2024', '2024-01', 3704, 'نادية عبدالله رائد', '12459.41', '415.31', 2, 'Employee', 8, 4, '0.00', '1985.44', '0.00', '0.00', '0.00', '0.00', '14444.85', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '745.74', '788.90', '1534.64', '12910.21', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(96, 1, '2024', '2024-01', 3752, 'عصام عمر عامر', '43039.72', '1434.66', 4, 'Employee', 3, 7, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '43039.72', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '794.00', '888.75', '1682.75', '41356.97', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(97, 1, '2024', '2024-01', 3754, 'روى عمر فارس', '23971.65', '799.06', 4, 'Employee', 10, 6, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '23971.65', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '997.36', '997.36', '22974.29', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(98, 1, '2024', '2024-01', 3812, 'ياسمين إسماعيل عبدالله', '28671.60', '955.72', 3, 'Employee', 8, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '28671.60', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '765.86', '765.86', '27905.74', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(99, 1, '2024', '2024-01', 3819, 'عبير أحمد جواد', '41116.02', '1370.53', 2, 'Employee', 2, 9, '0.00', '1946.04', '0.00', '0.00', '0.00', '0.00', '43062.06', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '847.92', '847.92', '42214.14', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(100, 1, '2024', '2024-01', 3823, 'تامر صهيب علاء', '49308.01', '1643.60', 2, 'Employee', 1, 6, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '49308.01', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '637.36', '637.36', '48670.65', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(101, 1, '2024', '2024-01', 3829, 'راغب ربيع عبدالرحمن', '25594.18', '853.14', 3, 'Employee', 7, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '25594.18', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '25594.18', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(102, 1, '2024', '2024-01', 3856, 'لبنى أنور عبدالعزيز', '13134.12', '437.80', 2, 'Employee', 2, 4, '0.00', '1963.12', '0.00', '0.00', '0.00', '0.00', '15097.24', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '539.09', NULL, '539.09', '14558.15', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(103, 1, '2024', '2024-01', 3869, 'أسماء رامي مهند', '21206.72', '706.89', 4, 'Employee', 8, 10, '0.00', '1290.83', '0.00', '0.00', '0.00', '0.00', '22497.55', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '564.68', '564.68', '21932.87', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(104, 1, '2024', '2024-01', 3883, 'صهيب عامر تامر', '5793.99', '193.13', 3, 'Employee', 10, 7, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '5793.99', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '516.88', '735.93', '1252.81', '4541.18', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(105, 1, '2024', '2024-01', 3988, 'توفيق أكرم رامي', '25056.30', '835.21', 4, 'Employee', 5, 6, '0.00', '1748.54', '0.00', '0.00', '0.00', '0.00', '26804.84', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '998.81', '885.96', '1884.77', '24920.07', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(106, 1, '2024', '2024-01', 4026, 'رائد شريف أيوب', '6502.39', '216.75', 2, 'Employee', 6, 1, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '6502.39', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '6502.39', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(107, 1, '2024', '2024-01', 4032, 'رينا عمر إسماعيل', '46663.86', '1555.46', 3, 'Employee', 4, 3, '0.00', '1456.58', '0.00', '0.00', '0.00', '0.00', '48120.44', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '863.81', '863.81', '47256.63', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(108, 1, '2024', '2024-01', 4038, 'روى عبدالحكيم رفيق', '40791.47', '1359.72', 1, 'Employee', 8, 4, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '40791.47', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '40791.47', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(109, 1, '2024', '2024-01', 4067, 'آلاء أديب أيمن', '25719.90', '857.33', 2, 'Employee', 5, 3, '0.00', '1363.89', '0.00', '0.00', '0.00', '0.00', '27083.79', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '957.86', NULL, '957.86', '26125.93', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(110, 1, '2024', '2024-01', 4069, 'بكر أنور سامي', '14685.45', '489.52', 1, 'Employee', 1, 2, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '14685.45', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '797.03', NULL, '797.03', '13888.42', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(111, 1, '2024', '2024-01', 4089, 'حذيفة حمزة حاتم', '31059.85', '1035.33', 2, 'Employee', 10, 1, '0.00', '1842.61', '0.00', '0.00', '0.00', '0.00', '32902.46', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '620.80', '620.80', '32281.66', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(112, 1, '2024', '2024-01', 4130, 'فايزة عدنان مصطفى', '30501.19', '1016.71', 1, 'Employee', 5, 5, '0.00', '1446.68', '0.00', '0.00', '0.00', '0.00', '31947.87', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '602.81', '602.81', '31345.06', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(113, 1, '2024', '2024-01', 4132, 'شهد شاكر أمجد', '21790.83', '726.36', 4, 'Employee', 9, 2, '0.00', '1332.82', '0.00', '0.00', '0.00', '0.00', '23123.65', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '23123.65', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(114, 1, '2024', '2024-01', 4138, 'عبدالفتاح عدنان راغب', '11834.07', '394.47', 1, 'Employee', 2, 10, '0.00', '1449.43', '0.00', '0.00', '0.00', '0.00', '13283.50', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '805.66', '845.87', '1651.53', '11631.97', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(115, 1, '2024', '2024-01', 4202, 'شهد يوسف أيوب', '9513.51', '317.12', 2, 'Employee', 10, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '9513.51', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '9513.51', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(116, 1, '2024', '2024-01', 4236, 'سهيل رائد عبدالسلام', '49667.24', '1655.57', 1, 'Employee', 6, 9, '0.00', '1942.00', '0.00', '0.00', '0.00', '0.00', '51609.24', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '51609.24', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(117, 1, '2024', '2024-01', 4247, 'تولين حسن عبدالكريم', '29056.10', '968.54', 2, 'Employee', 10, 3, '0.00', '1289.30', '0.00', '0.00', '0.00', '0.00', '30345.40', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '586.84', '944.29', '1531.13', '28814.27', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(118, 1, '2024', '2024-01', 4339, 'نجلاء نور جواد', '43460.68', '1448.69', 4, 'Employee', 8, 9, '0.00', '1160.95', '0.00', '0.00', '0.00', '0.00', '44621.63', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '603.06', NULL, '603.06', '44018.57', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(119, 1, '2024', '2024-01', 4340, 'يوسف حسن عبدالحميد', '10059.85', '335.33', 3, 'Employee', 3, 3, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '10059.85', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '664.48', '620.95', '1285.43', '8774.42', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(120, 1, '2024', '2024-01', 4363, 'صهيب عمر عبدالله', '15939.39', '531.31', 2, 'Employee', 2, 4, '0.00', '1237.19', '0.00', '0.00', '0.00', '0.00', '17176.58', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '711.05', NULL, '711.05', '16465.53', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(121, 1, '2024', '2024-01', 4383, 'لميس زيد كريم', '18392.05', '613.07', 1, 'Employee', 2, 3, '0.00', '1269.78', '0.00', '0.00', '0.00', '0.00', '19661.83', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '723.20', '816.53', '1539.73', '18122.10', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(122, 1, '2024', '2024-01', 4419, 'نبيل رامي عماد', '31011.76', '1033.73', 3, 'Employee', 7, 8, '0.00', '1661.32', '0.00', '0.00', '0.00', '0.00', '32673.08', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '676.17', NULL, '676.17', '31996.91', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(123, 1, '2024', '2024-01', 4447, 'شاكر مازن رفيق', '35687.85', '1189.60', 2, 'Employee', 5, 5, '0.00', '1897.82', '0.00', '0.00', '0.00', '0.00', '37585.67', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '567.58', '567.58', '37018.09', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(124, 1, '2024', '2024-01', 4522, 'عدنان عمر مصطفى', '13546.48', '451.55', 4, 'Employee', 2, 10, '0.00', '1462.53', '0.00', '0.00', '0.00', '0.00', '15009.01', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '15009.01', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(125, 1, '2024', '2024-01', 4544, 'مايا سامر عبدالكريم', '19422.93', '647.43', 3, 'Employee', 6, 7, '0.00', '1787.01', '0.00', '0.00', '0.00', '0.00', '21209.94', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '562.91', '840.81', '1403.72', '19806.22', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(126, 1, '2024', '2024-01', 4551, 'سعاد عبدالحي أنور', '32600.37', '1086.68', 3, 'Employee', 1, 4, '0.00', '1832.06', '0.00', '0.00', '0.00', '0.00', '34432.43', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '34432.43', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(127, 1, '2024', '2024-01', 4556, 'شاكر منصور ربيع', '18368.61', '612.29', 3, 'Employee', 10, 10, '0.00', '1881.29', '0.00', '0.00', '0.00', '0.00', '20249.90', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '641.21', NULL, '641.21', '19608.69', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23');
INSERT INTO `main_salary_employees` (`id`, `finance_cln_periods_id`, `financial_year`, `year_month`, `employee_code`, `employee_name`, `salary_employee`, `day_price`, `branch_id`, `employee_status`, `employee_department_code`, `employee_jobs_id`, `total_rewards_salary`, `motivation`, `additional_days_counter`, `additional_days_total`, `fixed_allowances`, `changeable_allowance`, `total_benefits`, `sanctions_days_counter`, `sanctions_days_total`, `absence_days_counter`, `absence_days_total`, `monthly_loan`, `permanent_loan`, `discount`, `phones_bill`, `medical_insurance_monthly`, `medical_social_monthly`, `total_deductions`, `net_salary`, `net_salary_after_close_for_deportation`, `archive_by`, `is_archived`, `archived_date`, `last_salary_remain_balance`, `last_main_salary_record_id`, `is_take_action_disbursed_collect`, `cash_visa`, `is_sensitive_manager_data`, `is_stopped`, `com_code`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(128, 1, '2024', '2024-01', 4576, 'عامر عبداللطيف حسن', '46981.91', '1566.06', 4, 'Employee', 4, 1, '0.00', '1754.88', '0.00', '0.00', '0.00', '0.00', '48736.79', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '48736.79', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(129, 1, '2024', '2024-01', 4585, 'رفيق مهند زياد', '29546.63', '984.89', 1, 'Employee', 8, 6, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '29546.63', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '696.75', '696.75', '28849.88', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(130, 1, '2024', '2024-01', 4591, 'حنان شريف عمار', '39993.24', '1333.11', 4, 'Employee', 9, 9, '0.00', '1076.64', '0.00', '0.00', '0.00', '0.00', '41069.88', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '756.58', '756.58', '40313.30', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(131, 1, '2024', '2024-01', 4648, 'لارا بدر مازن', '23299.16', '776.64', 2, 'Employee', 2, 9, '0.00', '1419.60', '0.00', '0.00', '0.00', '0.00', '24718.76', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '730.68', '730.68', '23988.08', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(132, 1, '2024', '2024-01', 4688, 'أحمد بدر منصور', '46361.36', '1545.38', 4, 'Employee', 5, 2, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '46361.36', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '923.45', NULL, '923.45', '45437.91', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(133, 1, '2024', '2024-01', 4709, 'بدر أنس شاكر', '30855.67', '1028.52', 4, 'Employee', 1, 6, '0.00', '1091.03', '0.00', '0.00', '0.00', '0.00', '31946.70', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '694.82', '694.82', '31251.88', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(134, 1, '2024', '2024-01', 4722, 'أماني سليمان عبدالحميد', '5465.23', '182.17', 2, 'Employee', 10, 4, '0.00', '1189.52', '0.00', '0.00', '0.00', '0.00', '6654.75', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '773.54', NULL, '773.54', '5881.21', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(135, 1, '2024', '2024-01', 4732, 'نورا أكرم عبدالحي', '27530.89', '917.70', 4, 'Employee', 3, 4, '0.00', '1409.69', '0.00', '0.00', '0.00', '0.00', '28940.58', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '579.81', '579.81', '28360.77', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(136, 1, '2024', '2024-01', 4749, 'أميرة ناجي أكرم', '37271.99', '1242.40', 3, 'Employee', 6, 4, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '37271.99', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '708.38', '606.96', '1315.34', '35956.65', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(137, 1, '2024', '2024-01', 4752, 'أمجد توفيق محمد', '24252.46', '808.42', 3, 'Employee', 6, 4, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '24252.46', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '513.79', '513.79', '23738.67', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(138, 1, '2024', '2024-01', 4775, 'روز أكرم صهيب', '16244.79', '541.49', 3, 'Employee', 8, 10, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '16244.79', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '975.91', NULL, '975.91', '15268.88', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(139, 1, '2024', '2024-01', 4795, 'جواد ماهر يوسف', '29586.39', '986.21', 1, 'Employee', 7, 3, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '29586.39', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '29586.39', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:23'),
(140, 1, '2024', '2024-01', 4828, 'معاذ زيد محمود', '45663.08', '1522.10', 2, 'Employee', 4, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '45663.08', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '45663.08', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:23', '2024-12-12 15:32:24'),
(141, 1, '2024', '2024-01', 4856, 'عبدالفتاح وجيه ياسر', '11035.96', '367.87', 4, 'Employee', 7, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '11035.96', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '11035.96', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(142, 1, '2024', '2024-01', 4861, 'ديمة إلياس قاسم', '40094.77', '1336.49', 1, 'Employee', 10, 3, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '40094.77', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '565.34', '575.49', '1140.83', '38953.94', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(143, 1, '2024', '2024-01', 4870, 'نور عبدالكريم سعيد', '14894.46', '496.48', 1, 'Employee', 9, 10, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '14894.46', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '14894.46', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(144, 1, '2024', '2024-01', 4872, 'فرح إسماعيل حاتم', '48933.08', '1631.10', 2, 'Employee', 9, 6, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '48933.08', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '48933.08', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(145, 1, '2024', '2024-01', 4898, 'كنزي شاكر يوسف', '9512.90', '317.10', 3, 'Employee', 6, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '9512.90', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '9512.90', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(146, 1, '2024', '2024-01', 4901, 'سهيل عبدالرحمن عمر', '14838.56', '494.62', 3, 'Employee', 9, 2, '0.00', '1310.88', '0.00', '0.00', '0.00', '0.00', '16149.44', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '653.74', '858.30', '1512.04', '14637.40', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(147, 1, '2024', '2024-01', 4903, 'جوري ياسر سليمان', '7135.73', '237.86', 1, 'Employee', 10, 10, '0.00', '1558.31', '0.00', '0.00', '0.00', '0.00', '8694.04', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '818.82', '747.70', '1566.52', '7127.52', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(148, 1, '2024', '2024-01', 4923, 'مريم زيد عبدالحكيم', '8937.05', '297.90', 3, 'Employee', 9, 7, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '8937.05', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '8937.05', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(149, 1, '2024', '2024-01', 4937, 'حسن بدر أنس', '48238.22', '1607.94', 2, 'Employee', 9, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '48238.22', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '894.22', '871.22', '1765.44', '46472.78', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(150, 1, '2024', '2024-01', 4962, 'نادية سهيل وجيه', '30922.40', '1030.75', 2, 'Employee', 4, 4, '0.00', '1467.90', '0.00', '0.00', '0.00', '0.00', '32390.30', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '812.01', '517.58', '1329.59', '31060.71', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(151, 1, '2024', '2024-01', 5039, 'معاذ مازن مهند', '39056.47', '1301.88', 2, 'Employee', 7, 6, '0.00', '1635.83', '0.00', '0.00', '0.00', '0.00', '40692.30', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '40692.30', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(152, 1, '2024', '2024-01', 5042, 'شهد لؤي مالك', '18929.82', '630.99', 3, 'Employee', 9, 9, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '18929.82', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '875.57', NULL, '875.57', '18054.25', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(153, 1, '2024', '2024-01', 5105, 'حاتم زين إسماعيل', '43354.30', '1445.14', 2, 'Employee', 10, 1, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '43354.30', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '905.67', NULL, '905.67', '42448.63', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(154, 1, '2024', '2024-01', 5115, 'صابرين قاسم رامز', '49751.45', '1658.38', 1, 'Employee', 8, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '49751.45', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '755.65', '755.65', '48995.80', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(155, 1, '2024', '2024-01', 5141, 'صفاء علاء قاسم', '23255.52', '775.18', 4, 'Employee', 3, 6, '0.00', '1762.37', '0.00', '0.00', '0.00', '0.00', '25017.89', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '734.06', NULL, '734.06', '24283.83', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(156, 1, '2024', '2024-01', 5211, 'تالين مازن زين', '17233.51', '574.45', 3, 'Employee', 1, 6, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '17233.51', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '896.12', '896.12', '16337.39', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(157, 1, '2024', '2024-01', 5227, 'سلمى توفيق إبراهيم', '8692.09', '289.74', 1, 'Employee', 8, 5, '0.00', '1188.34', '0.00', '0.00', '0.00', '0.00', '9880.43', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '539.27', '539.27', '9341.16', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(158, 1, '2024', '2024-01', 5279, 'نوران مصطفى عادل', '11406.92', '380.23', 3, 'Employee', 10, 9, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '11406.92', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '799.73', '610.55', '1410.28', '9996.64', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(159, 1, '2024', '2024-01', 5306, 'نادر باسم حامد', '48819.14', '1627.30', 4, 'Employee', 6, 9, '0.00', '1944.61', '0.00', '0.00', '0.00', '0.00', '50763.75', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '616.48', '616.48', '50147.27', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(160, 1, '2024', '2024-01', 5317, 'ناهد معاذ أمجد', '13652.01', '455.07', 2, 'Employee', 9, 5, '0.00', '1361.26', '0.00', '0.00', '0.00', '0.00', '15013.27', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '651.33', NULL, '651.33', '14361.94', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(161, 1, '2024', '2024-01', 5348, 'دنيا معاذ سليمان', '40668.44', '1355.61', 2, 'Employee', 5, 1, '0.00', '1263.77', '0.00', '0.00', '0.00', '0.00', '41932.21', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '41932.21', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(162, 1, '2024', '2024-01', 5519, 'مارين صهيب عبدالحميد', '20474.35', '682.48', 1, 'Employee', 3, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '20474.35', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '748.24', '736.28', '1484.52', '18989.83', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(163, 1, '2024', '2024-01', 5548, 'لينا سامر حذيفة', '19622.95', '654.10', 2, 'Employee', 7, 1, '0.00', '1296.99', '0.00', '0.00', '0.00', '0.00', '20919.94', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '927.61', NULL, '927.61', '19992.33', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(164, 1, '2024', '2024-01', 5559, 'أنور عمار شاكر', '18741.08', '624.70', 2, 'Employee', 10, 2, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '18741.08', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '651.91', '651.91', '18089.17', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(165, 1, '2024', '2024-01', 5569, 'رانيا راغب عبدالباسط', '14426.77', '480.89', 4, 'Employee', 6, 2, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '14426.77', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '619.65', '619.65', '13807.12', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(166, 1, '2024', '2024-01', 5574, 'فريدة عبداللطيف حاتم', '27256.52', '908.55', 1, 'Employee', 9, 6, '0.00', '1343.18', '0.00', '0.00', '0.00', '0.00', '28599.70', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '735.97', '735.97', '27863.73', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(167, 1, '2024', '2024-01', 5611, 'رفيق رياض رشيد', '23169.70', '772.32', 2, 'Employee', 8, 1, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '23169.70', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '23169.70', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(168, 1, '2024', '2024-01', 5642, 'إيمان كريم أديب', '46510.57', '1550.35', 2, 'Employee', 6, 2, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '46510.57', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '46510.57', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(169, 1, '2024', '2024-01', 5683, 'نور صهيب سيف', '21116.61', '703.89', 3, 'Employee', 6, 4, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '21116.61', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '21116.61', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(170, 1, '2024', '2024-01', 5722, 'مريم عامر كريم', '22018.53', '733.95', 1, 'Employee', 1, 2, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '22018.53', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '846.32', '846.32', '21172.21', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(171, 1, '2024', '2024-01', 5807, 'مها مهند حامد', '7888.05', '262.94', 2, 'Employee', 10, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '7888.05', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '592.83', '703.93', '1296.76', '6591.29', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(172, 1, '2024', '2024-01', 5809, 'كريم يحيى عبدالرحمن', '23294.22', '776.47', 4, 'Employee', 8, 7, '0.00', '1737.08', '0.00', '0.00', '0.00', '0.00', '25031.30', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '25031.30', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(173, 1, '2024', '2024-01', 5815, 'رامز لؤي أديب', '21935.02', '731.17', 1, 'Employee', 9, 7, '0.00', '1874.40', '0.00', '0.00', '0.00', '0.00', '23809.42', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '986.67', NULL, '986.67', '22822.75', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(174, 1, '2024', '2024-01', 5820, 'رنا يوسف منصور', '20465.30', '682.18', 4, 'Employee', 4, 3, '0.00', '1914.65', '0.00', '0.00', '0.00', '0.00', '22379.95', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '666.78', '666.78', '21713.17', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(175, 1, '2024', '2024-01', 5828, 'أماني وائل هيثم', '43645.77', '1454.86', 2, 'Employee', 9, 6, '0.00', '1580.44', '0.00', '0.00', '0.00', '0.00', '45226.21', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '676.59', NULL, '676.59', '44549.62', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(176, 1, '2024', '2024-01', 5886, 'سليمان باسل شاكر', '26018.99', '867.30', 1, 'Employee', 6, 3, '0.00', '1693.79', '0.00', '0.00', '0.00', '0.00', '27712.78', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '572.97', '572.97', '27139.81', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(177, 1, '2024', '2024-01', 5999, 'صابرين عبدالفتاح إسماعيل', '37589.25', '1252.98', 2, 'Employee', 2, 10, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '37589.25', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '906.79', '578.94', '1485.73', '36103.52', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(178, 1, '2024', '2024-01', 6026, 'زياد إلياس أنور', '24267.45', '808.92', 1, 'Employee', 3, 7, '0.00', '1268.72', '0.00', '0.00', '0.00', '0.00', '25536.17', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '604.30', '604.30', '24931.87', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(179, 1, '2024', '2024-01', 6054, 'سيف سهيل محمود', '29556.81', '985.23', 1, 'Employee', 3, 6, '0.00', '1398.67', '0.00', '0.00', '0.00', '0.00', '30955.48', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '30955.48', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(180, 1, '2024', '2024-01', 6086, 'عامر مالك جواد', '14442.23', '481.41', 4, 'Employee', 10, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '14442.23', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '767.01', '767.56', '1534.57', '12907.66', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(181, 1, '2024', '2024-01', 6284, 'عصام جمال عمار', '15706.45', '523.55', 1, 'Employee', 1, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '15706.45', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '763.46', NULL, '763.46', '14942.99', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(182, 1, '2024', '2024-01', 6294, 'زياد سهيل عبداللطيف', '34117.59', '1137.25', 4, 'Employee', 7, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '34117.59', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '637.34', '798.86', '1436.20', '32681.39', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(183, 1, '2024', '2024-01', 6374, 'أكرم أيوب سهيل', '39490.59', '1316.35', 2, 'Employee', 9, 6, '0.00', '1250.78', '0.00', '0.00', '0.00', '0.00', '40741.37', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '704.38', NULL, '704.38', '40036.99', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(184, 1, '2024', '2024-01', 6421, 'مارين عبدالكريم عماد', '34075.94', '1135.86', 3, 'Employee', 3, 4, '0.00', '1786.26', '0.00', '0.00', '0.00', '0.00', '35862.20', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '35862.20', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(185, 1, '2024', '2024-01', 6427, 'حسين عبدالفتاح وائل', '18697.73', '623.26', 3, 'Employee', 2, 2, '0.00', '1589.54', '0.00', '0.00', '0.00', '0.00', '20287.27', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '809.10', '809.10', '19478.17', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(186, 1, '2024', '2024-01', 6461, 'سارة جواد فارس', '9005.96', '300.20', 4, 'Employee', 6, 7, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '9005.96', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '594.25', '594.25', '8411.71', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(187, 1, '2024', '2024-01', 6469, 'ناهد حمزة ناجي', '37887.95', '1262.93', 1, 'Employee', 5, 3, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '37887.95', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '37887.95', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(188, 1, '2024', '2024-01', 6491, 'حاتم باسل عبدالسلام', '27162.82', '905.43', 2, 'Employee', 4, 7, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '27162.82', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '27162.82', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(189, 1, '2024', '2024-01', 6517, 'راغب محمود ياسر', '49735.57', '1657.85', 3, 'Employee', 7, 3, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '49735.57', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '693.71', NULL, '693.71', '49041.86', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(190, 1, '2024', '2024-01', 6556, 'جوري عبدالله حمزة', '22976.13', '765.87', 3, 'Employee', 5, 3, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '22976.13', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '22976.13', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(191, 1, '2024', '2024-01', 6558, 'معاذ عبدالفتاح عبدالحميد', '39657.61', '1321.92', 1, 'Employee', 8, 10, '0.00', '1260.18', '0.00', '0.00', '0.00', '0.00', '40917.79', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '602.22', '718.57', '1320.79', '39597.00', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(192, 1, '2024', '2024-01', 6638, 'إلياس حذيفة هيثم', '46494.44', '1549.81', 2, 'Employee', 7, 3, '0.00', '1771.98', '0.00', '0.00', '0.00', '0.00', '48266.42', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '866.03', '866.03', '47400.39', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(193, 1, '2024', '2024-01', 6723, 'هيا يحيى عامر', '17669.90', '589.00', 4, 'Employee', 8, 10, '0.00', '1688.32', '0.00', '0.00', '0.00', '0.00', '19358.22', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '740.23', '970.12', '1710.35', '17647.87', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(194, 1, '2024', '2024-01', 6784, 'محمود صهيب أمجد', '34149.53', '1138.32', 2, 'Employee', 2, 10, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '34149.53', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '34149.53', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(195, 1, '2024', '2024-01', 6827, 'سهى محمود إبراهيم', '35021.54', '1167.38', 2, 'Employee', 1, 7, '0.00', '1903.18', '0.00', '0.00', '0.00', '0.00', '36924.72', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '36924.72', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(196, 1, '2024', '2024-01', 6834, 'ميادة عبدالحكيم صهيب', '13168.92', '438.96', 3, 'Employee', 5, 5, '0.00', '1513.38', '0.00', '0.00', '0.00', '0.00', '14682.30', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '765.32', NULL, '765.32', '13916.98', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(197, 1, '2024', '2024-01', 6911, 'توفيق عامر ماهر', '23344.43', '778.15', 4, 'Employee', 2, 10, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '23344.43', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '817.03', '888.10', '1705.13', '21639.30', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(198, 1, '2024', '2024-01', 6922, 'ثامر شاكر عبدالله', '21407.06', '713.57', 2, 'Employee', 7, 1, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '21407.06', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '949.07', '669.68', '1618.75', '19788.31', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(199, 1, '2024', '2024-01', 6999, 'رحمة أمجد صابر', '6004.57', '200.15', 3, 'Employee', 8, 7, '0.00', '1591.41', '0.00', '0.00', '0.00', '0.00', '7595.98', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '689.93', '689.93', '6906.05', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(200, 1, '2024', '2024-01', 7006, 'تالين باسل حذيفة', '16048.48', '534.95', 3, 'Employee', 5, 7, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '16048.48', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '913.56', '862.65', '1776.21', '14272.27', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(201, 1, '2024', '2024-01', 7067, 'علي هيثم بكر', '18761.44', '625.38', 2, 'Employee', 4, 6, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '18761.44', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '18761.44', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(202, 1, '2024', '2024-01', 7183, 'سعيد حسين حامد', '9470.24', '315.67', 2, 'Employee', 3, 4, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '9470.24', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '816.24', NULL, '816.24', '8654.00', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(203, 1, '2024', '2024-01', 7187, 'سمر عامر أحمد', '29798.91', '993.30', 4, 'Employee', 9, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '29798.91', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '625.40', NULL, '625.40', '29173.51', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(204, 1, '2024', '2024-01', 7204, 'علاء جواد فارس', '6211.64', '207.05', 2, 'Employee', 3, 3, '0.00', '1539.86', '0.00', '0.00', '0.00', '0.00', '7751.50', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '751.89', '751.89', '6999.61', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(205, 1, '2024', '2024-01', 7207, 'شهد بدر هيثم', '9592.11', '319.74', 3, 'Employee', 10, 9, '0.00', '1351.03', '0.00', '0.00', '0.00', '0.00', '10943.14', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '744.36', NULL, '744.36', '10198.78', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(206, 1, '2024', '2024-01', 7244, 'وسام نور عبدالحميد', '19200.75', '640.03', 4, 'Employee', 8, 9, '0.00', '1402.16', '0.00', '0.00', '0.00', '0.00', '20602.91', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '975.60', '975.60', '19627.31', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(207, 1, '2024', '2024-01', 7272, 'هند عبدالله عبدالفتاح', '5740.22', '191.34', 2, 'Employee', 4, 4, '0.00', '1493.86', '0.00', '0.00', '0.00', '0.00', '7234.08', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '858.81', '858.81', '6375.27', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(208, 1, '2024', '2024-01', 7279, 'نوران عبدالحكيم زين', '12028.93', '400.96', 2, 'Employee', 1, 4, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '12028.93', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '12028.93', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(209, 1, '2024', '2024-01', 7289, 'راغب نادر أنس', '14126.23', '470.87', 4, 'Employee', 9, 1, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '14126.23', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '747.47', '905.06', '1652.53', '12473.70', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(210, 1, '2024', '2024-01', 7297, 'باسم عبدالسلام طلال', '47497.79', '1583.26', 1, 'Employee', 8, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '47497.79', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '580.06', '580.06', '46917.73', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(211, 1, '2024', '2024-01', 7332, 'أنور أديب أحمد', '15604.63', '520.15', 3, 'Employee', 1, 4, '0.00', '1261.11', '0.00', '0.00', '0.00', '0.00', '16865.74', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '816.66', '748.50', '1565.16', '15300.58', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:24'),
(212, 1, '2024', '2024-01', 7386, 'زين باسم محمد', '46373.61', '1545.79', 3, 'Employee', 2, 4, '0.00', '1786.68', '0.00', '0.00', '0.00', '0.00', '48160.29', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '48160.29', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:24', '2024-12-12 15:32:25'),
(213, 1, '2024', '2024-01', 7430, 'سهى ربيع يوسف', '19383.54', '646.12', 4, 'Employee', 7, 7, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '19383.54', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '667.53', NULL, '667.53', '18716.01', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(214, 1, '2024', '2024-01', 7441, 'شادي عبدالرحمن أمجد', '25174.86', '839.16', 3, 'Employee', 4, 3, '0.00', '1455.07', '0.00', '0.00', '0.00', '0.00', '26629.93', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '746.20', '746.20', '25883.73', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(215, 1, '2024', '2024-01', 7446, 'صفا عماد حاتم', '14672.49', '489.08', 3, 'Employee', 6, 3, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '14672.49', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '547.19', '547.19', '14125.30', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(216, 1, '2024', '2024-01', 7464, 'روان حامد أمجد', '30915.41', '1030.51', 2, 'Employee', 4, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '30915.41', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '687.89', NULL, '687.89', '30227.52', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(217, 1, '2024', '2024-01', 7488, 'مايا أحمد عامر', '31746.20', '1058.21', 3, 'Employee', 9, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '31746.20', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '819.09', '569.91', '1389.00', '30357.20', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(218, 1, '2024', '2024-01', 7492, 'مايا توفيق نور', '32787.09', '1092.90', 4, 'Employee', 6, 4, '0.00', '1501.10', '0.00', '0.00', '0.00', '0.00', '34288.19', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '650.41', '988.82', '1639.23', '32648.96', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(219, 1, '2024', '2024-01', 7546, 'مارين حسن زيد', '23471.50', '782.38', 2, 'Employee', 10, 1, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '23471.50', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '23471.50', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(220, 1, '2024', '2024-01', 7556, 'ديما أنس زين', '31151.21', '1038.37', 4, 'Employee', 3, 7, '0.00', '1346.73', '0.00', '0.00', '0.00', '0.00', '32497.94', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '32497.94', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(221, 1, '2024', '2024-01', 7569, 'محمود راغب أديب', '27744.38', '924.81', 3, 'Employee', 9, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '27744.38', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '689.48', '689.48', '27054.90', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(222, 1, '2024', '2024-01', 7610, 'دنيا أنور نادر', '10336.10', '344.54', 4, 'Employee', 6, 10, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '10336.10', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '915.01', '915.01', '9421.09', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(223, 1, '2024', '2024-01', 7697, 'طارق رامي أديب', '21598.56', '719.95', 4, 'Employee', 1, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '21598.56', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '847.05', NULL, '847.05', '20751.51', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(224, 1, '2024', '2024-01', 7715, 'صهيب عبدالرزاق ثامر', '10878.32', '362.61', 1, 'Employee', 9, 2, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '10878.32', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '10878.32', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(225, 1, '2024', '2024-01', 7719, 'يوسف ماهر نور', '35696.26', '1189.88', 4, 'Employee', 6, 7, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '35696.26', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '685.49', '685.49', '35010.77', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(226, 1, '2024', '2024-01', 7737, 'فاطمة طارق أيوب', '13265.15', '442.17', 4, 'Employee', 1, 4, '0.00', '1740.36', '0.00', '0.00', '0.00', '0.00', '15005.51', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '749.97', '734.65', '1484.62', '13520.89', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(227, 1, '2024', '2024-01', 7755, 'عبدالكريم باسم بدر', '26911.63', '897.05', 1, 'Employee', 8, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '26911.63', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '644.69', NULL, '644.69', '26266.94', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(228, 1, '2024', '2024-01', 7806, 'ريم إلياس رفيق', '7079.06', '235.97', 2, 'Employee', 7, 5, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '7079.06', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '908.56', '568.88', '1477.44', '5601.62', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(229, 1, '2024', '2024-01', 7812, 'سيف طلال هيثم', '38212.68', '1273.76', 4, 'Employee', 7, 6, '0.00', '1600.01', '0.00', '0.00', '0.00', '0.00', '39812.69', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '666.88', '666.88', '39145.81', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(230, 1, '2024', '2024-01', 7830, 'وائل أنس سامي', '47440.07', '1581.34', 3, 'Employee', 7, 6, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '47440.07', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '47440.07', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(231, 1, '2024', '2024-01', 7920, 'ديمة ربيع مهند', '10112.79', '337.09', 3, 'Employee', 6, 10, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '10112.79', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '551.19', '551.19', '9561.60', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(232, 1, '2024', '2024-01', 7930, 'لينا نور مهند', '48096.13', '1603.20', 1, 'Employee', 10, 10, '0.00', '1780.89', '0.00', '0.00', '0.00', '0.00', '49877.02', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '505.95', NULL, '505.95', '49371.07', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(233, 1, '2024', '2024-01', 7944, 'فارس نبيل عبدالباسط', '8227.46', '274.25', 1, 'Employee', 5, 8, '0.00', '1847.54', '0.00', '0.00', '0.00', '0.00', '10075.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '777.05', NULL, '777.05', '9297.95', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(234, 1, '2024', '2024-01', 7982, 'هيثم عماد عامر', '37821.51', '1260.72', 1, 'Employee', 3, 1, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '37821.51', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '37821.51', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(235, 1, '2024', '2024-01', 8021, 'أمجد حاتم محمود', '47283.24', '1576.11', 3, 'Employee', 9, 10, '0.00', '1381.84', '0.00', '0.00', '0.00', '0.00', '48665.08', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '48665.08', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(236, 1, '2024', '2024-01', 8033, 'بدر راغب أديب', '47289.35', '1576.31', 1, 'Employee', 9, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '47289.35', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '919.92', '715.89', '1635.81', '45653.54', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(237, 1, '2024', '2024-01', 8051, 'عبدالكريم عبدالسلام آدم', '48731.77', '1624.39', 3, 'Employee', 9, 4, '0.00', '1413.98', '0.00', '0.00', '0.00', '0.00', '50145.75', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '747.22', '642.53', '1389.75', '48756.00', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(238, 1, '2024', '2024-01', 8073, 'عماد إبراهيم وائل', '14105.89', '470.20', 3, 'Employee', 4, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '14105.89', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '14105.89', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(239, 1, '2024', '2024-01', 8085, 'لؤي أنس منصور', '29301.68', '976.72', 2, 'Employee', 5, 5, '0.00', '1081.76', '0.00', '0.00', '0.00', '0.00', '30383.44', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '700.55', '700.55', '29682.89', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(240, 1, '2024', '2024-01', 8135, 'وسام محمد وجيه', '42624.99', '1420.83', 3, 'Employee', 2, 7, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '42624.99', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '960.93', '848.97', '1809.90', '40815.09', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(241, 1, '2024', '2024-01', 8155, 'محمود حسين جمال', '18676.35', '622.55', 4, 'Employee', 10, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '18676.35', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '584.37', '584.37', '18091.98', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(242, 1, '2024', '2024-01', 8276, 'هالة محمود صهيب', '43829.49', '1460.98', 2, 'Employee', 5, 5, '0.00', '1764.35', '0.00', '0.00', '0.00', '0.00', '45593.84', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '968.09', '968.09', '44625.75', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(243, 1, '2024', '2024-01', 8324, 'مارين عامر جواد', '40174.56', '1339.15', 2, 'Employee', 10, 10, '0.00', '1457.05', '0.00', '0.00', '0.00', '0.00', '41631.61', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '778.48', NULL, '778.48', '40853.13', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(244, 1, '2024', '2024-01', 8355, 'سارة رشيد إسماعيل', '28285.51', '942.85', 4, 'Employee', 2, 9, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '28285.51', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '28285.51', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(245, 1, '2024', '2024-01', 8415, 'ناهد صابر سيف', '33738.05', '1124.60', 4, 'Employee', 9, 8, '0.00', '1364.92', '0.00', '0.00', '0.00', '0.00', '35102.97', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '35102.97', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(246, 1, '2024', '2024-01', 8461, 'باسم نادر إسماعيل', '12872.05', '429.07', 3, 'Employee', 5, 10, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '12872.05', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '12872.05', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(247, 1, '2024', '2024-01', 8477, 'نبيل عبداللطيف تامر', '45151.19', '1505.04', 4, 'Employee', 5, 3, '0.00', '1994.64', '0.00', '0.00', '0.00', '0.00', '47145.83', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '511.61', '698.27', '1209.88', '45935.95', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(248, 1, '2024', '2024-01', 8484, 'نبيل وائل لؤي', '7070.50', '235.68', 4, 'Employee', 7, 6, '0.00', '1869.68', '0.00', '0.00', '0.00', '0.00', '8940.18', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '684.74', '684.74', '8255.44', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(249, 1, '2024', '2024-01', 8525, 'يوسف عبدالعزيز عمار', '31837.61', '1061.25', 2, 'Employee', 8, 2, '0.00', '1953.72', '0.00', '0.00', '0.00', '0.00', '33791.33', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '33791.33', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(250, 1, '2024', '2024-01', 8528, 'ليان ماهر سليمان', '23524.17', '784.14', 2, 'Employee', 2, 5, '0.00', '1630.81', '0.00', '0.00', '0.00', '0.00', '25154.98', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '660.50', '660.50', '24494.48', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(251, 1, '2024', '2024-01', 8531, 'منصور أكرم حسن', '15212.91', '507.10', 1, 'Employee', 6, 8, '0.00', '1341.64', '0.00', '0.00', '0.00', '0.00', '16554.55', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '536.38', NULL, '536.38', '16018.17', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(252, 1, '2024', '2024-01', 8533, 'فاطمة سامي عدنان', '35248.08', '1174.94', 4, 'Employee', 3, 10, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '35248.08', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '621.02', '943.89', '1564.91', '33683.17', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(253, 1, '2024', '2024-01', 8545, 'عبدالكريم إلياس ماهر', '40548.58', '1351.62', 3, 'Employee', 1, 7, '0.00', '1733.96', '0.00', '0.00', '0.00', '0.00', '42282.54', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '884.12', '884.12', '41398.42', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(254, 1, '2024', '2024-01', 8560, 'صفاء باسل إبراهيم', '7193.45', '239.78', 4, 'Employee', 9, 5, '0.00', '1791.55', '0.00', '0.00', '0.00', '0.00', '8985.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '667.45', '667.45', '8317.55', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25');
INSERT INTO `main_salary_employees` (`id`, `finance_cln_periods_id`, `financial_year`, `year_month`, `employee_code`, `employee_name`, `salary_employee`, `day_price`, `branch_id`, `employee_status`, `employee_department_code`, `employee_jobs_id`, `total_rewards_salary`, `motivation`, `additional_days_counter`, `additional_days_total`, `fixed_allowances`, `changeable_allowance`, `total_benefits`, `sanctions_days_counter`, `sanctions_days_total`, `absence_days_counter`, `absence_days_total`, `monthly_loan`, `permanent_loan`, `discount`, `phones_bill`, `medical_insurance_monthly`, `medical_social_monthly`, `total_deductions`, `net_salary`, `net_salary_after_close_for_deportation`, `archive_by`, `is_archived`, `archived_date`, `last_salary_remain_balance`, `last_main_salary_record_id`, `is_take_action_disbursed_collect`, `cash_visa`, `is_sensitive_manager_data`, `is_stopped`, `com_code`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(255, 1, '2024', '2024-01', 8704, 'جمانة حذيفة رامز', '10547.16', '351.57', 1, 'Employee', 10, 6, '0.00', '1846.27', '0.00', '0.00', '0.00', '0.00', '12393.43', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '792.00', NULL, '792.00', '11601.43', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(256, 1, '2024', '2024-01', 8766, 'روى صهيب عماد', '15192.86', '506.43', 4, 'Employee', 2, 10, '0.00', '1904.65', '0.00', '0.00', '0.00', '0.00', '17097.51', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '17097.51', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(257, 1, '2024', '2024-01', 8791, 'رولا إلياس يوسف', '42760.36', '1425.35', 1, 'Employee', 2, 2, '0.00', '1649.21', '0.00', '0.00', '0.00', '0.00', '44409.57', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '578.64', '952.26', '1530.90', '42878.67', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(258, 1, '2024', '2024-01', 8851, 'حسن أنور منصور', '33747.44', '1124.91', 4, 'Employee', 1, 2, '0.00', '1503.84', '0.00', '0.00', '0.00', '0.00', '35251.28', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '35251.28', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(259, 1, '2024', '2024-01', 8860, 'سمر سامر يوسف', '8076.20', '269.21', 2, 'Employee', 3, 1, '0.00', '1459.64', '0.00', '0.00', '0.00', '0.00', '9535.84', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '9535.84', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(260, 1, '2024', '2024-01', 8874, 'لبنى وجيه عمار', '49968.26', '1665.61', 1, 'Employee', 6, 4, '0.00', '1058.30', '0.00', '0.00', '0.00', '0.00', '51026.56', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '704.02', '704.02', '50322.54', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(261, 1, '2024', '2024-01', 8922, 'رائد شاكر علاء', '5954.13', '198.47', 3, 'Employee', 6, 1, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '5954.13', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '946.88', '946.88', '5007.25', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(262, 1, '2024', '2024-01', 8942, 'سيف هيثم قاسم', '32150.24', '1071.67', 3, 'Employee', 8, 10, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '32150.24', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '606.60', '527.71', '1134.31', '31015.93', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(263, 1, '2024', '2024-01', 8946, 'مازن عامر محمد', '39754.86', '1325.16', 3, 'Employee', 5, 3, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '39754.86', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '898.91', '587.06', '1485.97', '38268.89', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(264, 1, '2024', '2024-01', 8962, 'روى أيوب طلال', '23183.81', '772.79', 1, 'Employee', 10, 7, '0.00', '1866.05', '0.00', '0.00', '0.00', '0.00', '25049.86', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '25049.86', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(265, 1, '2024', '2024-01', 9016, 'بسمة وائل عبدالسلام', '27141.28', '904.71', 3, 'Employee', 2, 6, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '27141.28', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '27141.28', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(266, 1, '2024', '2024-01', 9054, 'عبداللطيف عامر عبدالرحمن', '37531.56', '1251.05', 4, 'Employee', 2, 7, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '37531.56', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '635.43', NULL, '635.43', '36896.13', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(267, 1, '2024', '2024-01', 9086, 'جميلة عصام وائل', '30373.65', '1012.46', 3, 'Employee', 6, 10, '0.00', '1908.05', '0.00', '0.00', '0.00', '0.00', '32281.70', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '32281.70', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(268, 1, '2024', '2024-01', 9098, 'إسماعيل عبدالفتاح حذيفة', '35800.35', '1193.35', 4, 'Employee', 7, 10, '0.00', '1164.62', '0.00', '0.00', '0.00', '0.00', '36964.97', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '724.42', NULL, '724.42', '36240.55', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(269, 1, '2024', '2024-01', 9121, 'رولا يوسف جواد', '49422.16', '1647.41', 3, 'Employee', 2, 1, '0.00', '1512.71', '0.00', '0.00', '0.00', '0.00', '50934.87', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '672.77', '769.21', '1441.98', '49492.89', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(270, 1, '2024', '2024-01', 9166, 'جوري حسن أيمن', '18029.35', '600.98', 4, 'Employee', 8, 1, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '18029.35', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '944.35', NULL, '944.35', '17085.00', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(271, 1, '2024', '2024-01', 9169, 'غادة عماد محمد', '6605.17', '220.17', 3, 'Employee', 10, 4, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '6605.17', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '578.63', '831.41', '1410.04', '5195.13', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(272, 1, '2024', '2024-01', 9193, 'عماد عمر جواد', '31801.19', '1060.04', 2, 'Employee', 4, 1, '0.00', '1343.87', '0.00', '0.00', '0.00', '0.00', '33145.06', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '534.87', '534.87', '32610.19', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(273, 1, '2024', '2024-01', 9249, 'شاكر عدنان عبدالرحمن', '48325.72', '1610.86', 3, 'Employee', 1, 7, '0.00', '1623.02', '0.00', '0.00', '0.00', '0.00', '49948.74', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '940.85', '957.54', '1898.39', '48050.35', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(274, 1, '2024', '2024-01', 9250, 'ناجي أكرم طلال', '34810.91', '1160.36', 1, 'Employee', 3, 9, '0.00', '1362.80', '0.00', '0.00', '0.00', '0.00', '36173.71', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '544.98', NULL, '544.98', '35628.73', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(275, 1, '2024', '2024-01', 9255, 'أميرة يوسف بكر', '9642.57', '321.42', 1, 'Employee', 4, 3, '0.00', '1808.00', '0.00', '0.00', '0.00', '0.00', '11450.57', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '11450.57', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(276, 1, '2024', '2024-01', 9259, 'حنان هيثم سالم', '6329.99', '211.00', 2, 'Employee', 3, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '6329.99', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '589.78', '762.38', '1352.16', '4977.83', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(277, 1, '2024', '2024-01', 9280, 'زينب علاء رامي', '20962.53', '698.75', 3, 'Employee', 1, 6, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '20962.53', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '585.30', '585.30', '20377.23', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(278, 1, '2024', '2024-01', 9337, 'هدى عمر ياسر', '48452.57', '1615.09', 3, 'Employee', 7, 4, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '48452.57', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '976.89', '976.89', '47475.68', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(279, 1, '2024', '2024-01', 9351, 'سامر أحمد رياض', '29431.70', '981.06', 3, 'Employee', 4, 6, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '29431.70', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '920.18', '920.18', '28511.52', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(280, 1, '2024', '2024-01', 9370, 'عبير حامد أحمد', '46520.81', '1550.69', 3, 'Employee', 9, 9, '0.00', '1024.52', '0.00', '0.00', '0.00', '0.00', '47545.33', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '507.72', NULL, '507.72', '47037.61', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(281, 1, '2024', '2024-01', 9388, 'فايزة رياض زياد', '11151.56', '371.72', 1, 'Employee', 10, 2, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '11151.56', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '571.35', '931.08', '1502.43', '9649.13', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(282, 1, '2024', '2024-01', 9435, 'ماهر وائل باسم', '17516.19', '583.87', 4, 'Employee', 8, 9, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '17516.19', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '845.45', NULL, '845.45', '16670.74', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(283, 1, '2024', '2024-01', 9452, 'رنا قاسم يوسف', '42101.92', '1403.40', 3, 'Employee', 8, 4, '0.00', '1217.24', '0.00', '0.00', '0.00', '0.00', '43319.16', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '801.13', '801.13', '42518.03', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(284, 1, '2024', '2024-01', 9496, 'أيوب بدر أنس', '48148.64', '1604.95', 4, 'Employee', 8, 1, '0.00', '1252.20', '0.00', '0.00', '0.00', '0.00', '49400.84', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '602.94', NULL, '602.94', '48797.90', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:25'),
(285, 1, '2024', '2024-01', 9594, 'آنا أيوب إبراهيم', '9140.16', '304.67', 3, 'Employee', 9, 1, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '9140.16', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '554.03', '554.03', '8586.13', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:25', '2024-12-12 15:32:26'),
(286, 1, '2024', '2024-01', 9596, 'عبدالحميد مازن مهند', '36538.62', '1217.95', 1, 'Employee', 1, 2, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '36538.62', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '669.89', '652.77', '1322.66', '35215.96', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:26', '2024-12-12 15:32:26'),
(287, 1, '2024', '2024-01', 9608, 'روز صهيب يوسف', '48159.43', '1605.31', 4, 'Employee', 5, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '48159.43', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '544.75', NULL, '544.75', '47614.68', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:26', '2024-12-12 15:32:26'),
(288, 1, '2024', '2024-01', 9628, 'إلياس عبدالرزاق صهيب', '15039.09', '501.30', 2, 'Employee', 7, 8, '0.00', '1070.69', '0.00', '0.00', '0.00', '0.00', '16109.78', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '16109.78', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:26', '2024-12-12 15:32:26'),
(289, 1, '2024', '2024-01', 9675, 'فايزة رامي عماد', '19270.69', '642.36', 1, 'Employee', 9, 3, '0.00', '1111.14', '0.00', '0.00', '0.00', '0.00', '20381.83', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '506.22', '896.17', '1402.39', '18979.44', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:26', '2024-12-12 15:32:26'),
(290, 1, '2024', '2024-01', 9682, 'سهى عادل عمار', '36742.43', '1224.75', 1, 'Employee', 1, 4, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '36742.43', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '834.89', '991.64', '1826.53', '34915.90', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:26', '2024-12-12 15:32:26'),
(291, 1, '2024', '2024-01', 9709, 'شاكر هيثم إبراهيم', '35059.03', '1168.63', 1, 'Employee', 3, 10, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '35059.03', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '514.81', '548.44', '1063.25', '33995.78', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:26', '2024-12-12 15:32:26'),
(292, 1, '2024', '2024-01', 9737, 'كريم نادر مصطفى', '15103.52', '503.45', 2, 'Employee', 8, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '15103.52', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '15103.52', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:26', '2024-12-12 15:32:26'),
(293, 1, '2024', '2024-01', 9738, 'جمانة وجيه شريف', '23244.90', '774.83', 2, 'Employee', 4, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '23244.90', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '23244.90', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:26', '2024-12-12 15:32:26'),
(294, 1, '2024', '2024-01', 9740, 'محمود وائل سامي', '13627.75', '454.26', 3, 'Employee', 6, 2, '0.00', '1626.66', '0.00', '0.00', '0.00', '0.00', '15254.41', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '815.07', NULL, '815.07', '14439.34', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:26', '2024-12-12 15:32:26'),
(295, 1, '2024', '2024-01', 9765, 'ليلى بكر محمد', '40950.07', '1365.00', 1, 'Employee', 2, 1, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '40950.07', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '736.74', '736.74', '40213.33', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:26', '2024-12-12 15:32:26'),
(296, 1, '2024', '2024-01', 9820, 'عبدالرزاق عماد رامز', '42941.47', '1431.38', 1, 'Employee', 7, 8, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '42941.47', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '544.97', '544.97', '42396.50', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:26', '2024-12-12 15:32:26'),
(297, 1, '2024', '2024-01', 9829, 'عبدالعزيز عامر عدنان', '26733.93', '891.13', 3, 'Employee', 4, 6, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '26733.93', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '596.96', NULL, '596.96', '26136.97', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:26', '2024-12-12 15:32:26'),
(298, 1, '2024', '2024-01', 9880, 'إلياس منصور هيثم', '47504.79', '1583.49', 2, 'Employee', 3, 3, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '47504.79', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '711.36', '538.76', '1250.12', '46254.67', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:26', '2024-12-12 15:32:26'),
(299, 1, '2024', '2024-01', 9972, 'إبراهيم عمار جمال', '21031.81', '701.06', 4, 'Employee', 6, 10, '0.00', '1117.77', '0.00', '0.00', '0.00', '0.00', '22149.58', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, '567.46', '567.46', '21582.12', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:26', '2024-12-12 15:32:26'),
(300, 1, '2024', '2024-01', 9996, 'نور حسين نبيل', '47441.66', '1581.39', 1, 'Employee', 1, 7, '0.00', NULL, '0.00', '0.00', '0.00', '0.00', '47441.66', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', NULL, NULL, '0.00', '47441.66', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-12-12 15:32:26', '2024-12-12 15:32:26');

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
(1, 'view role', 'Roles', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(2, 'create role', 'Roles', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(3, 'update role', 'Roles', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(4, 'delete role', 'Roles', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(5, 'view permission', 'Permissions', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(6, 'create permission', 'Permissions', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(7, 'update permission', 'Permissions', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(8, 'delete permission', 'Permissions', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(9, 'view user', 'Users', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(10, 'create user', 'Users', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(11, 'update user', 'Users', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(12, 'delete user', 'Users', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(13, 'قائمة الأعدادات', 'Settings', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(14, 'الضبط العام', 'generalSettings', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(15, 'تعديل الضبط العام', 'generalSettings', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(16, 'السنوات المالية', 'financeCalendars', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(17, 'اضافة السنوات المالية', 'financeCalendars', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(18, 'تعديل السنوات المالية', 'financeCalendars', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(19, 'حذف السنوات المالية', 'financeCalendars', 'admin', '2024-12-12 15:30:29', '2024-12-12 15:30:29'),
(20, 'عرض شهور السنه السنوات مالية', 'financeCalendars', 'admin', '2024-12-12 15:30:30', '2024-12-12 15:30:30'),
(21, 'فتح السنوات المالية', 'financeCalendars', 'admin', '2024-12-12 15:30:30', '2024-12-12 15:30:30'),
(22, 'غلق السنوات المالية', 'financeCalendars', 'admin', '2024-12-12 15:30:30', '2024-12-12 15:30:30'),
(23, 'الفروع', 'branches', 'admin', '2024-12-12 15:30:30', '2024-12-12 15:30:30'),
(24, 'اضافة الفروع', 'branches', 'admin', '2024-12-12 15:30:30', '2024-12-12 15:30:30'),
(25, 'تعديل الفروع', 'branches', 'admin', '2024-12-12 15:30:30', '2024-12-12 15:30:30'),
(26, 'حذف الفروع', 'branches', 'admin', '2024-12-12 15:30:30', '2024-12-12 15:30:30'),
(27, 'الشفتات', 'shiftsTypes', 'admin', '2024-12-12 15:30:30', '2024-12-12 15:30:30'),
(28, 'اضافة الشفتات', 'shiftsTypes', 'admin', '2024-12-12 15:30:30', '2024-12-12 15:30:30'),
(29, 'تعديل الشفتات', 'shiftsTypes', 'admin', '2024-12-12 15:30:30', '2024-12-12 15:30:30'),
(30, 'حذف الشفتات', 'shiftsTypes', 'admin', '2024-12-12 15:30:30', '2024-12-12 15:30:30'),
(31, 'الأدارات', 'departments', 'admin', '2024-12-12 15:30:30', '2024-12-12 15:30:30'),
(32, 'اضافة الأدارات', 'departments', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(33, 'تعديل الأدارات', 'departments', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(34, 'حذف الأدارات', 'departments', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(35, 'الوظائف', 'jobsCategories', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(36, 'اضافة الوظائف', 'jobsCategories', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(37, 'تعديل الوظائف', 'jobsCategories', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(38, 'حذف الوظائف', 'jobsCategories', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(39, 'الدرجات الوظيفية', 'jobsGrades', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(40, 'اضافة الدرجات الوظيفية', 'jobsGrades', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(41, 'تعديل الدرجات الوظيفية', 'jobsGrades', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(42, 'حذف الدرجات الوظيفية', 'jobsGrades', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(43, 'المؤهل', 'qualifications', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(44, 'اضافة المؤهل', 'qualifications', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(45, 'تعديل المؤهل', 'qualifications', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(46, 'حذف المؤهل', 'qualifications', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(47, 'العطلات الرسمية', 'holidays', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(48, 'اضافة العطلات الرسمية', 'holidays', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(49, 'تعديل العطلات الرسمية', 'holidays', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(50, 'حذف العطلات الرسمية', 'holidays', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(51, 'الأستقالة', 'resignations', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(52, 'اضافة الأستقالة', 'resignations', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(53, 'تعديل الأستقالة', 'resignations', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(54, 'حذف الأستقالة', 'resignations', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(55, 'الأجازات', 'vacations', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(56, 'اضافة الأجازات', 'vacations', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(57, 'تعديل الأجازات', 'vacations', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(58, 'حذف الأجازات', 'vacations', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(59, 'البلاد', 'countries', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(60, 'اضافة البلاد', 'countries', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(61, 'تعديل البلاد', 'countries', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(62, 'حذف البلاد', 'countries', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(63, 'المنطقه', 'cities', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(64, 'اضافة المنطقه', 'cities', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(65, 'تعديل المنطقه', 'cities', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(66, 'حذف المنطقه', 'cities', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(67, 'الجنسيات', 'nationalities', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(68, 'اضافة الجنسيات', 'nationalities', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(69, 'تعديل الجنسيات', 'nationalities', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(70, 'حذف الجنسيات', 'nationalities', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(71, 'فصيلة الدم', 'bloodTypes', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(72, 'اضافة فصيلة الدم', 'bloodTypes', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(73, 'تعديل فصيلة الدم', 'bloodTypes', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(74, 'حذف فصيلة الدم', 'bloodTypes', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(75, 'قائمة بيانات شئون الموظفين', 'affairsEmployees', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(76, 'بيانات الموظفين', 'Employees', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(77, 'جدول الموظفين', 'Employees', 'admin', '2024-12-12 15:30:31', '2024-12-12 15:30:31'),
(78, 'أضافة موظف', 'Employees', 'admin', '2024-12-12 15:30:32', '2024-12-12 15:30:32'),
(79, 'تعديل الموظف', 'Employees', 'admin', '2024-12-12 15:30:32', '2024-12-12 15:30:32'),
(80, 'حذف الموظف', 'Employees', 'admin', '2024-12-12 15:30:32', '2024-12-12 15:30:32'),
(81, 'عرض حساب الأجازات', 'Employees', 'admin', '2024-12-12 15:30:32', '2024-12-12 15:30:32'),
(82, 'بحث الموظفين', 'Employees', 'admin', '2024-12-12 15:30:32', '2024-12-12 15:30:32'),
(83, 'اضافة بدل ثابت', 'Employees', 'admin', '2024-12-12 15:30:32', '2024-12-12 15:30:32'),
(84, 'الراتب المؤرشف', 'Employees', 'admin', '2024-12-12 15:30:32', '2024-12-12 15:30:32'),
(85, 'جدول الملفات الشخصية', 'Employees', 'admin', '2024-12-12 15:30:32', '2024-12-12 15:30:32'),
(86, 'اضافة ملفات شخصية', 'Employees', 'admin', '2024-12-12 15:30:32', '2024-12-12 15:30:32'),
(87, 'تحميل من جدول ملفات شخصية', 'Employees', 'admin', '2024-12-12 15:30:32', '2024-12-12 15:30:32'),
(88, 'حذف من جدول ملفات شخصية', 'Employees', 'admin', '2024-12-12 15:30:32', '2024-12-12 15:30:32'),
(89, 'الأضافى للراتب', 'additional_types', 'admin', '2024-12-12 15:30:32', '2024-12-12 15:30:32'),
(90, 'اضافة الأضافى للراتب', 'additional_types', 'admin', '2024-12-12 15:30:32', '2024-12-12 15:30:32'),
(91, 'تعديل الأضافى للراتب', 'additional_types', 'admin', '2024-12-12 15:30:32', '2024-12-12 15:30:32'),
(92, 'حذف الأضافى للراتب', 'additional_types', 'admin', '2024-12-12 15:30:32', '2024-12-12 15:30:32'),
(93, 'الخصم', 'discount_types', 'admin', '2024-12-12 15:30:32', '2024-12-12 15:30:32'),
(94, 'اضافة الخصم', 'discount_types', 'admin', '2024-12-12 15:30:32', '2024-12-12 15:30:32'),
(95, 'تعديل الخصم', 'discount_types', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(96, 'حذف الخصم', 'discount_types', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(97, 'البدلات', 'allowances', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(98, 'اضافة البدلات', 'allowances', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(99, 'تعديل البدلات', 'allowances', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(100, 'حذف البدلات', 'allowances', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(101, 'قائمة الأجور', 'salaries', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(102, 'السجلات الرئيسية للرواتب', 'salaryRecords', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(103, 'ارشفة الشهر المالى', 'salaryRecords', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(104, 'فتح الشهر المالى', 'salaryRecords', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(105, 'الجزاءات', 'sanctions', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(106, 'عرض الجزاءات', 'sanctions', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(107, 'بحث الجزاءات', 'sanctions', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(108, 'اضافة الجزاءات', 'sanctions', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(109, 'تعديل الجزاءات', 'sanctions', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(110, 'حذف الجزاءات', 'sanctions', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(111, 'طباعه الجزاءات', 'sanctions', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(112, 'الغيابات', 'absences', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(113, 'عرض الغيابات', 'absences', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(114, 'بحث الغيابات', 'absences', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(115, 'اضافة الغيابات', 'absences', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(116, 'تعديل الغيابات', 'absences', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(117, 'حذف الغيابات', 'absences', 'admin', '2024-12-12 15:30:33', '2024-12-12 15:30:33'),
(118, 'طباعه الغيابات', 'absences', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(119, 'الأضافى', 'additionals', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(120, 'عرض الأضافى', 'additionals', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(121, 'بحث الأضافى', 'additionals', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(122, 'اضافة الأضافى', 'additionals', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(123, 'تعديل الأضافى', 'additionals', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(124, 'حذف الأضافى', 'additionals', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(125, 'طباعه الأضافى', 'additionals', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(126, 'الخصومات', 'discounts', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(127, 'عرض الخصومات', 'discounts', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(128, 'بحث الخصومات', 'discounts', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(129, 'اضافة الخصومات', 'discounts', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(130, 'تعديل الخصومات', 'discounts', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(131, 'حذف الخصومات', 'discounts', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(132, 'طباعه الخصومات', 'discounts', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(133, 'المكافئات', 'rewards', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(134, 'عرض المكافئات', 'rewards', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(135, 'بحث المكافئات', 'rewards', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(136, 'اضافة المكافئات', 'rewards', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(137, 'تعديل المكافئات', 'rewards', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(138, 'حذف المكافئات', 'rewards', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(139, 'طباعه المكافئات', 'rewards', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(140, 'البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(141, 'عرض البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(142, 'بحث البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(143, 'اضافة البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(144, 'تعديل البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(145, 'حذف البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(146, 'طباعه البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-12-12 15:30:34', '2024-12-12 15:30:34'),
(147, 'السلف الشهرية', 'loans', 'admin', '2024-12-12 15:30:35', '2024-12-12 15:30:35'),
(148, 'عرض السلف الشهرية', 'loans', 'admin', '2024-12-12 15:30:35', '2024-12-12 15:30:35'),
(149, 'بحث السلف الشهرية', 'loans', 'admin', '2024-12-12 15:30:35', '2024-12-12 15:30:35'),
(150, 'اضافة السلف الشهرية', 'loans', 'admin', '2024-12-12 15:30:35', '2024-12-12 15:30:35'),
(151, 'تعديل السلف الشهرية', 'loans', 'admin', '2024-12-12 15:30:35', '2024-12-12 15:30:35'),
(152, 'حذف السلف الشهرية', 'loans', 'admin', '2024-12-12 15:30:35', '2024-12-12 15:30:35'),
(153, 'طباعه السلف الشهرية', 'loans', 'admin', '2024-12-12 15:30:35', '2024-12-12 15:30:35'),
(154, 'السلف المستديمة', 'permanentLoan', 'admin', '2024-12-12 15:30:35', '2024-12-12 15:30:35'),
(155, 'بحث السلف المستديمة', 'permanentLoan', 'admin', '2024-12-12 15:30:35', '2024-12-12 15:30:35'),
(156, 'صرف السلف المستديمة', 'permanentLoan', 'admin', '2024-12-12 15:30:35', '2024-12-12 15:30:35'),
(157, 'الدفع كاش السلف المستديمة', 'permanentLoan', 'admin', '2024-12-12 15:30:35', '2024-12-12 15:30:35'),
(158, 'تفاصيل السلف المستديمة', 'permanentLoan', 'admin', '2024-12-12 15:30:35', '2024-12-12 15:30:35'),
(159, 'اضافة السلف المستديمة', 'permanentLoan', 'admin', '2024-12-12 15:30:35', '2024-12-12 15:30:35'),
(160, 'تعديل السلف المستديمة', 'permanentLoan', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(161, 'حذف السلف المستديمة', 'permanentLoan', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(162, 'طباعه السلف المستديمة', 'permanentLoan', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(163, 'رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(164, 'عرض رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(165, 'بحث رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(166, 'اضافة مرتب يدوى', 'mainSalaryEmployees', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(167, 'اضافة رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(168, 'تعديل رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(169, 'حذف رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(170, 'بيانات الموظفين للرواتب', 'mainSalaryEmployees', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(171, 'طباعه رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(172, 'طباعه بحث تفصيلى للرواتب', 'mainSalaryEmployees', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(173, 'طباعه بحث اجمالى للرواتب', 'mainSalaryEmployees', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(174, 'طباعه مفردات المرتب', 'mainSalaryEmployees', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(175, 'ايقاف المرتب', 'mainSalaryEmployees', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(176, 'ارشفه المرتب يدوى', 'mainSalaryEmployees', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(177, 'حذف المرتب', 'mainSalaryEmployees', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(178, 'قائمة سجلات بصمة الموظفين', 'attendanceDeparturesFP', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(179, 'سجلات بصمة الموظفين', 'attendanceDepartures', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(180, 'عرض بصمة الموظفين', 'attendanceDepartures', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(181, 'بحث بصمة الموظفين', 'attendanceDepartures', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(182, 'إرفاق ملف البصمة مرتب يدوى', 'attendanceDepartures', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(183, 'عرض بصمات الموظفين', 'attendanceDepartures', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(184, 'تحميل بصمات الموظفين', 'attendanceDepartures', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(185, 'عرض سجل أرشيف بصمات الموظفين', 'attendanceDepartures', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(186, 'عرض حركات بصمات الموظفين', 'attendanceDepartures', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(187, 'تفاصيل أجازه الموظفين الموظفين', 'attendanceDepartures', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(188, 'طباعه بصمات الموظفين', 'attendanceDepartures', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(189, 'إعادة ضبط بصمات الموظفين', 'attendanceDepartures', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(190, 'قائمة المستخدمين', 'UserList', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(191, 'المستخدمين', 'users', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(192, 'اضافة المستخدمين', 'users', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(193, 'تعديل المستخدمين', 'users', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(194, 'حذف المستخدمين', 'users', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(195, 'الصلاحيات', 'roles', 'admin', '2024-12-12 15:30:36', '2024-12-12 15:30:36'),
(196, 'اضافة الصلاحيات', 'roles', 'admin', '2024-12-12 15:30:37', '2024-12-12 15:30:37'),
(197, 'تعديل الصلاحيات', 'roles', 'admin', '2024-12-12 15:30:37', '2024-12-12 15:30:37'),
(198, 'حذف الصلاحيات', 'roles', 'admin', '2024-12-12 15:30:37', '2024-12-12 15:30:37'),
(199, 'إضافة وتعديل أذونات الصلاحية', 'roles', 'admin', '2024-12-12 15:30:37', '2024-12-12 15:30:37'),
(200, 'الأذونات', 'permissions', 'admin', '2024-12-12 15:30:37', '2024-12-12 15:30:37'),
(201, 'اضافة الأذونات', 'permissions', 'admin', '2024-12-12 15:30:37', '2024-12-12 15:30:37'),
(202, 'تعديل الأذونات', 'permissions', 'admin', '2024-12-12 15:30:37', '2024-12-12 15:30:37'),
(203, 'حذف الأذونات', 'permissions', 'admin', '2024-12-12 15:30:37', '2024-12-12 15:30:37');

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
(1, 'super-admin', 'admin', '2024-12-12 15:30:37', '2024-12-12 15:30:37'),
(2, 'admin', 'admin', '2024-12-12 15:30:37', '2024-12-12 15:30:37'),
(3, 'staff', 'admin', '2024-12-12 15:30:37', '2024-12-12 15:30:37'),
(4, 'user', 'admin', '2024-12-12 15:30:37', '2024-12-12 15:30:37');

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
(1, 'رشا موسى', 'rasha@dt.com', NULL, '$2y$10$.ICxKqtnOxN1H5f2t0nbleGHCsClG7F3.Vs8Cz9aDxhHqPEYfMc7i', 'active', '2024-07-02', NULL, NULL, NULL);

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=301;

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
