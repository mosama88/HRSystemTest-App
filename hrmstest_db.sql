-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 05, 2024 at 09:46 AM
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
(1, 'محمد أسامه', 'mosama', 'mosama@dt.com', NULL, '$2y$10$Av4lGRtan/k9KAmo0I2Lee.XTjPwj4PJqdd7OjhIiq.EW3/QIDE0K', 1, 1, 'active', '2024-10-05', 1, NULL, NULL, NULL),
(2, 'Super Admin', 'superadmin', 'superadmin@dt.com', NULL, '$2y$10$5PI8nfCxiIxR6dV26P8RcuEdzcBY4WBopXoxjdOQFnVp/wiRbEtbO', 1, NULL, 'active', NULL, NULL, NULL, '2024-10-05 09:39:35', '2024-10-05 09:39:35'),
(3, 'Admin', 'admin', 'admin@dt.com', NULL, '$2y$10$yNvg6mJOkK4mrPK7aka9cuOwhyaNT/AgH7g0fOr3fOzL/qTDNsSYG', 1, NULL, 'active', NULL, 1, NULL, '2024-10-05 09:39:35', '2024-10-05 09:39:35'),
(4, 'Staff', 'staff', 'staff@dt.com', NULL, '$2y$10$Xt/q9tWSfo.qttM.UQQ9YuK/yzeNSgllVucmpFfHtHwX1DMBgnooC', 1, NULL, 'active', NULL, 1, NULL, '2024-10-05 09:39:35', '2024-10-05 09:39:35');

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
(1, 'مستشفى المروة', 1, NULL, NULL, '01228759920', '45 شارع جامعه الدول ناصيه شهاب', 'info@almarwa.com', '4.00', 3, '15.00', '15.00', '30.00', '2.00', '4.00', '6.00', '7.00', '8.00', '8.00', '9.00', '10.00', '11.00', 1, 1, 1, '2024-10-05 09:39:15', '2024-10-05 09:39:15'),
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
(1, 1, 83, 'محمد اسامه محمد حسين', 'Male', 1, 1, 6, '2009', 'علوم الحاسب', 'Very_Good', '1988-03-28', '564154151515', '2028-08-02', 'بولاق الدكرور', 3, 'Muslim', 1, 'mosama88@hotmail.com', 1, 2, 2, '01228755885', '01228759920', '01228759920', 'Exemption', NULL, NULL, NULL, '2019-08-01', 'ليس لدية أخوات', NULL, NULL, NULL, 'Yes', 'Special', '32432432432423', 'Yes', NULL, NULL, '2016-04-06', 'Employee', 10, 3, 'Yes', 'No', NULL, '7.00', '6000.00', '200.00', 'Fixed', '500.00', 'Yes', '500.00', '500', 'Yes', '500.00', '8755488999', 'Visa', 'Yes', 'احمد السيد ذكى - 01110050006', '8 شارع مدرسة نصرالدين اول الهرم', 3, 'Married', NULL, NULL, 'No', NULL, 1, 'احمد السيد', '28803280102556', 'مجمع التحرير', '2029-08-01', '30', '2', '10', NULL, NULL, 1, 0, NULL, 1, 1, 1, '2024-08-21 09:19:47', '2024-09-26 13:27:11'),
(2, 2, 12, 'منى طارق سعيد أبو العلا', 'Female', 4, 4, 6, '2012', 'بكالوريوس إدارة أعمال', 'Fair', '1991-01-16', '298195612305612', '2027-08-03', 'م نصر', 5, 'Muslim', 1, 'monat@gmail.com', 1, 1, 3, '0227828958', '01015713256', '01112812255', 'Exemption', NULL, NULL, NULL, '2012-08-01', 'أنثى', NULL, NULL, NULL, 'No', NULL, NULL, 'No', NULL, NULL, '2019-07-31', 'Employee', 7, 4, 'Yes', 'Yes', 1, '8.00', '8000.00', '266.67', 'Changeable', NULL, 'Yes', '1000.00', '521545861205', 'Yes', '800.00', '51512055051051', 'Cach', 'Yes', 'مى سعيد - 01213578556', '12أ شارع الدكتور محمد أحمد سليم – من ش حافظ بدوي – الحي السابع – مدينة نصر', NULL, 'Divorced', NULL, NULL, 'No', NULL, 1, 'احمد عباس مصطفى', '45548548420518548', 'مجمع التحرير', '2029-07-31', '21', '1', '6', '1727253486329.pdf', NULL, 1, 0, NULL, 1, 1, 1, '2024-08-25 21:23:34', '2024-09-25 03:34:19'),
(3, 3, 510, 'هادى محمود عبدالله', 'Male', 2, 4, 4, '2007', 'إدارة الأعمـال', 'Very_Good', '1986-07-02', '12314815106449', '2026-09-15', 'احمد عرابى', 7, 'Muslim', 1, 'hady@hotmail.com', 1, 2, 6, '0223591420', '0223536720', '01223599920', 'Complete', '2009-09-01', '2010-12-01', 'سلاح الطيران', NULL, NULL, NULL, NULL, NULL, 'Yes', 'Special', NULL, 'Yes', 'عبدالراضى اسماعيل بالادارة العليا', NULL, '2012-09-05', 'Employee', 4, 1, 'Yes', 'Yes', 3, '8.00', '9500.00', '316.67', 'Fixed', '500.00', 'Yes', '500.00', '521545861205', 'Yes', '500.00', '521543591205', 'Visa', 'Yes', 'ابن العم 01512589894', '45 شارع جامعه الدول ناصيه شهاب المهندسين', 2, 'Widowed', NULL, NULL, 'No', NULL, 1, 'Thor Leonard', NULL, NULL, NULL, '30', NULL, '12', NULL, NULL, 0, 0, NULL, 1, 1, 1, '2024-09-25 03:43:52', '2024-09-26 13:26:34');

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

--
-- Dumping data for table `employee_salary_absence_days`
--

INSERT INTO `employee_salary_absence_days` (`id`, `main_salary_employees_id`, `finance_cln_periods_id`, `is_auto`, `employee_code`, `day_price`, `value`, `total`, `is_archived`, `archived_by`, `archived_at`, `notes`, `active`, `com_code`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, '200.00', '1.00', '200.00', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:41:25', '2024-10-05 09:41:25'),
(2, 2, 1, 1, 2, '266.67', '1.00', '266.67', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:41:32', '2024-10-05 09:41:32'),
(3, 3, 1, 1, 3, '316.67', '1.00', '316.67', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:41:39', '2024-10-05 09:41:39');

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

--
-- Dumping data for table `employee_salary_additionals`
--

INSERT INTO `employee_salary_additionals` (`id`, `main_salary_employees_id`, `finance_cln_periods_id`, `is_auto`, `employee_code`, `day_price`, `value`, `total`, `is_archived`, `archived_by`, `archived_at`, `notes`, `active`, `com_code`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, '200.00', '1.00', '200.00', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:41:54', '2024-10-05 09:41:54'),
(2, 2, 1, 1, 2, '266.67', '1.00', '266.67', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:42:02', '2024-10-05 09:42:02'),
(3, 3, 1, 1, 3, '316.67', '1.00', '316.67', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:42:08', '2024-10-05 09:42:08');

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

--
-- Dumping data for table `employee_salary_allowances`
--

INSERT INTO `employee_salary_allowances` (`id`, `main_salary_employees_id`, `finance_cln_periods_id`, `is_auto`, `employee_code`, `day_price`, `allowance_id`, `total`, `is_archived`, `archived_by`, `archived_at`, `notes`, `active`, `com_code`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, '200.00', 1, '1500.00', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:44:17', '2024-10-05 09:44:17'),
(2, 2, 1, 1, 2, '266.67', 1, '1000.00', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:44:27', '2024-10-05 09:44:27'),
(3, 3, 1, 1, 3, '316.67', 4, '500.00', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:44:36', '2024-10-05 09:44:36');

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

--
-- Dumping data for table `employee_salary_discounts`
--

INSERT INTO `employee_salary_discounts` (`id`, `main_salary_employees_id`, `finance_cln_periods_id`, `is_auto`, `employee_code`, `day_price`, `discount_types_id`, `total`, `is_archived`, `archived_by`, `archived_at`, `notes`, `active`, `com_code`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, '200.00', 9, '300.00', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:42:33', '2024-10-05 09:42:33'),
(2, 2, 1, 1, 2, '266.67', 13, '500.00', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:42:43', '2024-10-05 09:42:43'),
(3, 3, 1, 1, 3, '316.67', 12, '1500.00', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:42:55', '2024-10-05 09:42:55');

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

--
-- Dumping data for table `employee_salary_loans`
--

INSERT INTO `employee_salary_loans` (`id`, `main_salary_employees_id`, `finance_cln_periods_id`, `employee_code`, `day_price`, `total`, `is_archived`, `archived_by`, `archived_at`, `notes`, `active`, `com_code`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '200.00', '1000.00', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:44:52', '2024-10-05 09:44:52'),
(2, 2, 1, 2, '266.67', '2000.00', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:45:01', '2024-10-05 09:45:01'),
(3, 3, 1, 3, '316.67', '3000.00', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:45:09', '2024-10-05 09:45:09');

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

--
-- Dumping data for table `employee_salary_permanent_loans`
--

INSERT INTO `employee_salary_permanent_loans` (`id`, `employee_code`, `employee_salary`, `total`, `month_number_installment`, `month_installment_value`, `year_month_start`, `year_month_start_date`, `installment_paid`, `installment_remain`, `has_disbursed_done`, `disbursed_by`, `disbursed_at`, `is_archived`, `archived_by`, `archived_at`, `notes`, `active`, `com_code`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 3, '9500.00', '10000.00', 4, '2500.00', '2025-02', '2025-02-01', '0.00', '0.00', 1, 1, '2024-10-05', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:45:35', '2024-10-05 09:46:23'),
(2, 2, '8000.00', '8000.00', 4, '2000.00', '2025-02', '2025-02-01', '0.00', '0.00', 1, 1, '2024-10-05', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:45:54', '2024-10-05 09:46:21'),
(3, 1, '6000.00', '5000.00', 4, '1250.00', '2025-02', '2025-02-01', '0.00', '0.00', 1, 1, '2024-10-05', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:46:13', '2024-10-05 09:46:18');

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

--
-- Dumping data for table `employee_salary_rewards`
--

INSERT INTO `employee_salary_rewards` (`id`, `main_salary_employees_id`, `finance_cln_periods_id`, `is_auto`, `employee_code`, `day_price`, `additional_types_id`, `total`, `is_archived`, `archived_by`, `archived_at`, `notes`, `active`, `com_code`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, '200.00', 1, '1.00', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:43:12', '2024-10-05 09:43:12'),
(2, 2, 1, 1, 2, '266.67', 2, '800.00', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:43:40', '2024-10-05 09:43:40'),
(3, 3, 1, 1, 3, '316.67', 1, '200.00', 0, NULL, NULL, NULL, 1, 1, 1, 1, '2024-10-05 09:43:49', '2024-10-05 09:43:57');

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

--
-- Dumping data for table `employee_salary_sanctions`
--

INSERT INTO `employee_salary_sanctions` (`id`, `main_salary_employees_id`, `finance_cln_periods_id`, `is_auto`, `employee_code`, `day_price`, `sanctions_type`, `value`, `total`, `is_archived`, `archived_by`, `archived_at`, `notes`, `active`, `com_code`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, '200.00', 1, '1.00', '200.00', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:40:57', '2024-10-05 09:40:57'),
(2, 2, 1, 1, 2, '266.67', 1, '1.00', '266.67', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:41:05', '2024-10-05 09:41:05'),
(3, 3, 1, 1, 3, '316.67', 1, '1.00', '316.67', 0, NULL, NULL, NULL, 1, 1, 1, NULL, '2024-10-05 09:41:13', '2024-10-05 09:41:13');

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
(1, '2025', 'السنه المالية لسنه 2025', '2025-01-01', '2025-12-31', 1, 1, 1, 1, '2024-10-05 09:39:15', '2024-10-05 09:40:26');

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
(1, 1, '2025', 1, '2025-01', '2025-01-01', '2025-01-31', 31, '2025-01-01', '2025-01-31', 1, 1, 1, 1, '2024-10-05 09:39:15', '2024-10-05 09:40:45'),
(2, 1, '2025', 2, '2025-02', '2025-02-01', '2025-02-28', 28, '2025-02-01', '2025-02-28', 0, 1, 1, 1, '2024-10-05 09:39:15', '2024-10-05 09:39:15'),
(3, 1, '2025', 3, '2025-03', '2025-03-01', '2025-03-31', 31, '2025-03-01', '2025-03-31', 0, 1, 1, 1, '2024-10-05 09:39:15', '2024-10-05 09:39:15'),
(4, 1, '2025', 4, '2025-04', '2025-04-01', '2025-04-30', 30, '2025-04-01', '2025-04-30', 0, 1, 1, 1, '2024-10-05 09:39:15', '2024-10-05 09:39:15'),
(5, 1, '2025', 5, '2025-05', '2025-05-01', '2025-05-31', 31, '2025-05-01', '2025-05-31', 0, 1, 1, 1, '2024-10-05 09:39:15', '2024-10-05 09:39:15'),
(6, 1, '2025', 6, '2025-06', '2025-06-01', '2025-06-30', 30, '2025-06-01', '2025-06-30', 0, 1, 1, 1, '2024-10-05 09:39:15', '2024-10-05 09:39:15'),
(7, 1, '2025', 7, '2025-07', '2025-07-01', '2025-07-31', 31, '2025-07-01', '2025-07-31', 0, 1, 1, 1, '2024-10-05 09:39:15', '2024-10-05 09:39:15'),
(8, 1, '2025', 8, '2025-08', '2025-08-01', '2025-08-31', 31, '2025-08-01', '2025-08-31', 0, 1, 1, 1, '2024-10-05 09:39:15', '2024-10-05 09:39:15'),
(9, 1, '2025', 9, '2025-09', '2025-09-01', '2025-09-30', 30, '2025-09-01', '2025-09-30', 0, 1, 1, 1, '2024-10-05 09:39:15', '2024-10-05 09:39:15'),
(10, 1, '2025', 10, '2025-10', '2025-10-01', '2025-10-31', 31, '2025-10-01', '2025-10-31', 0, 1, 1, 1, '2024-10-05 09:39:15', '2024-10-05 09:39:15'),
(11, 1, '2025', 11, '2025-11', '2025-11-01', '2025-11-30', 30, '2025-11-01', '2025-11-30', 0, 1, 1, 1, '2024-10-05 09:39:15', '2024-10-05 09:39:15'),
(12, 1, '2025', 12, '2025-02', '2025-12-01', '2025-12-31', 31, '2025-12-01', '2025-12-30', 0, 1, 1, 1, '2024-10-05 09:39:15', '2024-10-05 09:39:15');

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
(1, 1, '2025', '2025-01', 1, 'محمد اسامه محمد حسين', '6000.00', '200.00', 1, 'Employee', 10, 3, '1.00', '500.00', '1.00', '200.00', '0.00', '1500.00', '8201.00', '1.00', '200.00', '1.00', '200.00', '1000.00', '0.00', '300.00', '0.00', '500.00', '500.00', '2700.00', '5501.00', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-10-05 09:40:45', '2024-10-05 09:46:18'),
(2, 1, '2025', '2025-01', 2, 'منى طارق سعيد أبو العلا', '8000.00', '266.67', 4, 'Employee', 7, 4, '800.00', NULL, '1.00', '266.67', '0.00', '1000.00', '10066.67', '1.00', '266.67', '1.00', '266.67', '2000.00', '0.00', '500.00', '0.00', '800.00', '1000.00', '4833.34', '5233.33', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Cach', 'yes', 'unstopped', 1, 1, NULL, '2024-10-05 09:40:45', '2024-10-05 09:46:21'),
(3, 1, '2025', '2025-01', 3, 'هادى محمود عبدالله', '9500.00', '316.67', 2, 'Employee', 4, 1, '200.00', '500.00', '1.00', '316.67', '0.00', '500.00', '11016.67', '1.00', '316.67', '1.00', '316.67', '3000.00', '0.00', '1500.00', '0.00', '500.00', '500.00', '6133.34', '4883.33', '0.00', NULL, 0, NULL, '0.00', NULL, 0, 'Visa', 'yes', 'unstopped', 1, 1, NULL, '2024-10-05 09:40:45', '2024-10-05 09:46:23');

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
(47, '2024_09_26_095531_create_vacation_types_table', 1);

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

--
-- Dumping data for table `permanent_loans_installments`
--

INSERT INTO `permanent_loans_installments` (`id`, `employee_code`, `employee_permanent_loans_id`, `main_salary_employees_id`, `month_installment_value`, `year_month`, `status`, `has_parent_disbursed_done`, `is_archived`, `archived_by`, `archived_at`, `notes`, `created_by`, `updated_by`, `com_code`, `created_at`, `updated_at`) VALUES
(1, 3, 1, 3, '2500.00', '2025-02', 0, 1, 0, NULL, NULL, NULL, 1, NULL, 1, '2024-10-05 09:45:35', '2024-10-05 09:46:23'),
(2, 3, 1, 3, '2500.00', '2025-03', 0, 1, 0, NULL, NULL, NULL, 1, NULL, 1, '2024-10-05 09:45:35', '2024-10-05 09:46:23'),
(3, 3, 1, 3, '2500.00', '2025-04', 0, 1, 0, NULL, NULL, NULL, 1, NULL, 1, '2024-10-05 09:45:35', '2024-10-05 09:46:23'),
(4, 3, 1, 3, '2500.00', '2025-05', 0, 1, 0, NULL, NULL, NULL, 1, NULL, 1, '2024-10-05 09:45:35', '2024-10-05 09:46:23'),
(5, 2, 2, 2, '2000.00', '2025-02', 0, 1, 0, NULL, NULL, NULL, 1, NULL, 1, '2024-10-05 09:45:54', '2024-10-05 09:46:21'),
(6, 2, 2, 2, '2000.00', '2025-03', 0, 1, 0, NULL, NULL, NULL, 1, NULL, 1, '2024-10-05 09:45:54', '2024-10-05 09:46:21'),
(7, 2, 2, 2, '2000.00', '2025-04', 0, 1, 0, NULL, NULL, NULL, 1, NULL, 1, '2024-10-05 09:45:54', '2024-10-05 09:46:21'),
(8, 2, 2, 2, '2000.00', '2025-05', 0, 1, 0, NULL, NULL, NULL, 1, NULL, 1, '2024-10-05 09:45:54', '2024-10-05 09:46:21'),
(9, 1, 3, 1, '1250.00', '2025-02', 0, 1, 0, NULL, NULL, NULL, 1, NULL, 1, '2024-10-05 09:46:13', '2024-10-05 09:46:18'),
(10, 1, 3, 1, '1250.00', '2025-03', 0, 1, 0, NULL, NULL, NULL, 1, NULL, 1, '2024-10-05 09:46:13', '2024-10-05 09:46:18'),
(11, 1, 3, 1, '1250.00', '2025-04', 0, 1, 0, NULL, NULL, NULL, 1, NULL, 1, '2024-10-05 09:46:13', '2024-10-05 09:46:18'),
(12, 1, 3, 1, '1250.00', '2025-05', 0, 1, 0, NULL, NULL, NULL, 1, NULL, 1, '2024-10-05 09:46:13', '2024-10-05 09:46:18');

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
(1, 'view role', 'Roles', 'admin', '2024-10-05 09:39:16', '2024-10-05 09:39:16'),
(2, 'create role', 'Roles', 'admin', '2024-10-05 09:39:16', '2024-10-05 09:39:16'),
(3, 'update role', 'Roles', 'admin', '2024-10-05 09:39:16', '2024-10-05 09:39:16'),
(4, 'delete role', 'Roles', 'admin', '2024-10-05 09:39:16', '2024-10-05 09:39:16'),
(5, 'view permission', 'Permissions', 'admin', '2024-10-05 09:39:16', '2024-10-05 09:39:16'),
(6, 'create permission', 'Permissions', 'admin', '2024-10-05 09:39:16', '2024-10-05 09:39:16'),
(7, 'update permission', 'Permissions', 'admin', '2024-10-05 09:39:16', '2024-10-05 09:39:16'),
(8, 'delete permission', 'Permissions', 'admin', '2024-10-05 09:39:16', '2024-10-05 09:39:16'),
(9, 'view user', 'Users', 'admin', '2024-10-05 09:39:17', '2024-10-05 09:39:17'),
(10, 'create user', 'Users', 'admin', '2024-10-05 09:39:17', '2024-10-05 09:39:17'),
(11, 'update user', 'Users', 'admin', '2024-10-05 09:39:17', '2024-10-05 09:39:17'),
(12, 'delete user', 'Users', 'admin', '2024-10-05 09:39:17', '2024-10-05 09:39:17'),
(13, 'قائمة الأعدادات', 'Settings', 'admin', '2024-10-05 09:39:17', '2024-10-05 09:39:17'),
(14, 'الضبط العام', 'generalSettings', 'admin', '2024-10-05 09:39:17', '2024-10-05 09:39:17'),
(15, 'تعديل الضبط العام', 'generalSettings', 'admin', '2024-10-05 09:39:17', '2024-10-05 09:39:17'),
(16, 'السنوات المالية', 'financeCalendars', 'admin', '2024-10-05 09:39:17', '2024-10-05 09:39:17'),
(17, 'اضافة السنوات المالية', 'financeCalendars', 'admin', '2024-10-05 09:39:17', '2024-10-05 09:39:17'),
(18, 'تعديل السنوات المالية', 'financeCalendars', 'admin', '2024-10-05 09:39:17', '2024-10-05 09:39:17'),
(19, 'حذف السنوات المالية', 'financeCalendars', 'admin', '2024-10-05 09:39:17', '2024-10-05 09:39:17'),
(20, 'عرض شهور السنه السنوات مالية', 'financeCalendars', 'admin', '2024-10-05 09:39:17', '2024-10-05 09:39:17'),
(21, 'فتح السنوات المالية', 'financeCalendars', 'admin', '2024-10-05 09:39:17', '2024-10-05 09:39:17'),
(22, 'غلق السنوات المالية', 'financeCalendars', 'admin', '2024-10-05 09:39:18', '2024-10-05 09:39:18'),
(23, 'الفروع', 'branches', 'admin', '2024-10-05 09:39:18', '2024-10-05 09:39:18'),
(24, 'اضافة الفروع', 'branches', 'admin', '2024-10-05 09:39:18', '2024-10-05 09:39:18'),
(25, 'تعديل الفروع', 'branches', 'admin', '2024-10-05 09:39:18', '2024-10-05 09:39:18'),
(26, 'حذف الفروع', 'branches', 'admin', '2024-10-05 09:39:18', '2024-10-05 09:39:18'),
(27, 'الشفتات', 'shiftsTypes', 'admin', '2024-10-05 09:39:18', '2024-10-05 09:39:18'),
(28, 'اضافة الشفتات', 'shiftsTypes', 'admin', '2024-10-05 09:39:18', '2024-10-05 09:39:18'),
(29, 'تعديل الشفتات', 'shiftsTypes', 'admin', '2024-10-05 09:39:18', '2024-10-05 09:39:18'),
(30, 'حذف الشفتات', 'shiftsTypes', 'admin', '2024-10-05 09:39:18', '2024-10-05 09:39:18'),
(31, 'الأدارات', 'departments', 'admin', '2024-10-05 09:39:18', '2024-10-05 09:39:18'),
(32, 'اضافة الأدارات', 'departments', 'admin', '2024-10-05 09:39:18', '2024-10-05 09:39:18'),
(33, 'تعديل الأدارات', 'departments', 'admin', '2024-10-05 09:39:18', '2024-10-05 09:39:18'),
(34, 'حذف الأدارات', 'departments', 'admin', '2024-10-05 09:39:18', '2024-10-05 09:39:18'),
(35, 'الوظائف', 'jobsCategories', 'admin', '2024-10-05 09:39:18', '2024-10-05 09:39:18'),
(36, 'اضافة الوظائف', 'jobsCategories', 'admin', '2024-10-05 09:39:18', '2024-10-05 09:39:18'),
(37, 'تعديل الوظائف', 'jobsCategories', 'admin', '2024-10-05 09:39:18', '2024-10-05 09:39:18'),
(38, 'حذف الوظائف', 'jobsCategories', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(39, 'الدرجات الوظيفية', 'jobsGrades', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(40, 'اضافة الدرجات الوظيفية', 'jobsGrades', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(41, 'تعديل الدرجات الوظيفية', 'jobsGrades', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(42, 'حذف الدرجات الوظيفية', 'jobsGrades', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(43, 'المؤهل', 'qualifications', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(44, 'اضافة المؤهل', 'qualifications', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(45, 'تعديل المؤهل', 'qualifications', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(46, 'حذف المؤهل', 'qualifications', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(47, 'العطلات الرسمية', 'holidays', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(48, 'اضافة العطلات الرسمية', 'holidays', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(49, 'تعديل العطلات الرسمية', 'holidays', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(50, 'حذف العطلات الرسمية', 'holidays', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(51, 'الأستقالة', 'resignations', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(52, 'اضافة الأستقالة', 'resignations', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(53, 'تعديل الأستقالة', 'resignations', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(54, 'حذف الأستقالة', 'resignations', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(55, 'الأجازات', 'vacations', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(56, 'اضافة الأجازات', 'vacations', 'admin', '2024-10-05 09:39:19', '2024-10-05 09:39:19'),
(57, 'تعديل الأجازات', 'vacations', 'admin', '2024-10-05 09:39:20', '2024-10-05 09:39:20'),
(58, 'حذف الأجازات', 'vacations', 'admin', '2024-10-05 09:39:20', '2024-10-05 09:39:20'),
(59, 'البلاد', 'countries', 'admin', '2024-10-05 09:39:20', '2024-10-05 09:39:20'),
(60, 'اضافة البلاد', 'countries', 'admin', '2024-10-05 09:39:20', '2024-10-05 09:39:20'),
(61, 'تعديل البلاد', 'countries', 'admin', '2024-10-05 09:39:20', '2024-10-05 09:39:20'),
(62, 'حذف البلاد', 'countries', 'admin', '2024-10-05 09:39:20', '2024-10-05 09:39:20'),
(63, 'المنطقه', 'cities', 'admin', '2024-10-05 09:39:20', '2024-10-05 09:39:20'),
(64, 'اضافة المنطقه', 'cities', 'admin', '2024-10-05 09:39:20', '2024-10-05 09:39:20'),
(65, 'تعديل المنطقه', 'cities', 'admin', '2024-10-05 09:39:20', '2024-10-05 09:39:20'),
(66, 'حذف المنطقه', 'cities', 'admin', '2024-10-05 09:39:20', '2024-10-05 09:39:20'),
(67, 'الجنسيات', 'nationalities', 'admin', '2024-10-05 09:39:20', '2024-10-05 09:39:20'),
(68, 'اضافة الجنسيات', 'nationalities', 'admin', '2024-10-05 09:39:20', '2024-10-05 09:39:20'),
(69, 'تعديل الجنسيات', 'nationalities', 'admin', '2024-10-05 09:39:20', '2024-10-05 09:39:20'),
(70, 'حذف الجنسيات', 'nationalities', 'admin', '2024-10-05 09:39:20', '2024-10-05 09:39:20'),
(71, 'فصيلة الدم', 'bloodTypes', 'admin', '2024-10-05 09:39:20', '2024-10-05 09:39:20'),
(72, 'اضافة فصيلة الدم', 'bloodTypes', 'admin', '2024-10-05 09:39:20', '2024-10-05 09:39:20'),
(73, 'تعديل فصيلة الدم', 'bloodTypes', 'admin', '2024-10-05 09:39:20', '2024-10-05 09:39:20'),
(74, 'حذف فصيلة الدم', 'bloodTypes', 'admin', '2024-10-05 09:39:21', '2024-10-05 09:39:21'),
(75, 'قائمة بيانات شئون الموظفين', 'affairsEmployees', 'admin', '2024-10-05 09:39:21', '2024-10-05 09:39:21'),
(76, 'بيانات الموظفين', 'Employees', 'admin', '2024-10-05 09:39:21', '2024-10-05 09:39:21'),
(77, 'جدول الموظفين', 'Employees', 'admin', '2024-10-05 09:39:21', '2024-10-05 09:39:21'),
(78, 'أضافة موظف', 'Employees', 'admin', '2024-10-05 09:39:21', '2024-10-05 09:39:21'),
(79, 'تعديل الموظف', 'Employees', 'admin', '2024-10-05 09:39:21', '2024-10-05 09:39:21'),
(80, 'حذف الموظف', 'Employees', 'admin', '2024-10-05 09:39:21', '2024-10-05 09:39:21'),
(81, 'عرض حساب الأجازات', 'Employees', 'admin', '2024-10-05 09:39:21', '2024-10-05 09:39:21'),
(82, 'بحث الموظفين', 'Employees', 'admin', '2024-10-05 09:39:21', '2024-10-05 09:39:21'),
(83, 'اضافة بدل ثابت', 'Employees', 'admin', '2024-10-05 09:39:21', '2024-10-05 09:39:21'),
(84, 'الراتب المؤرشف', 'Employees', 'admin', '2024-10-05 09:39:21', '2024-10-05 09:39:21'),
(85, 'جدول الملفات الشخصية', 'Employees', 'admin', '2024-10-05 09:39:21', '2024-10-05 09:39:21'),
(86, 'اضافة ملفات شخصية', 'Employees', 'admin', '2024-10-05 09:39:21', '2024-10-05 09:39:21'),
(87, 'تحميل من جدول ملفات شخصية', 'Employees', 'admin', '2024-10-05 09:39:22', '2024-10-05 09:39:22'),
(88, 'حذف من جدول ملفات شخصية', 'Employees', 'admin', '2024-10-05 09:39:22', '2024-10-05 09:39:22'),
(89, 'الأضافى للراتب', 'additional_types', 'admin', '2024-10-05 09:39:22', '2024-10-05 09:39:22'),
(90, 'اضافة الأضافى للراتب', 'additional_types', 'admin', '2024-10-05 09:39:22', '2024-10-05 09:39:22'),
(91, 'تعديل الأضافى للراتب', 'additional_types', 'admin', '2024-10-05 09:39:22', '2024-10-05 09:39:22'),
(92, 'حذف الأضافى للراتب', 'additional_types', 'admin', '2024-10-05 09:39:22', '2024-10-05 09:39:22'),
(93, 'الخصم', 'discount_types', 'admin', '2024-10-05 09:39:22', '2024-10-05 09:39:22'),
(94, 'اضافة الخصم', 'discount_types', 'admin', '2024-10-05 09:39:23', '2024-10-05 09:39:23'),
(95, 'تعديل الخصم', 'discount_types', 'admin', '2024-10-05 09:39:23', '2024-10-05 09:39:23'),
(96, 'حذف الخصم', 'discount_types', 'admin', '2024-10-05 09:39:23', '2024-10-05 09:39:23'),
(97, 'البدلات', 'allowances', 'admin', '2024-10-05 09:39:23', '2024-10-05 09:39:23'),
(98, 'اضافة البدلات', 'allowances', 'admin', '2024-10-05 09:39:23', '2024-10-05 09:39:23'),
(99, 'تعديل البدلات', 'allowances', 'admin', '2024-10-05 09:39:23', '2024-10-05 09:39:23'),
(100, 'حذف البدلات', 'allowances', 'admin', '2024-10-05 09:39:23', '2024-10-05 09:39:23'),
(101, 'قائمة الأجور', 'salaries', 'admin', '2024-10-05 09:39:23', '2024-10-05 09:39:23'),
(102, 'السجلات الرئيسية للرواتب', 'salaryRecords', 'admin', '2024-10-05 09:39:23', '2024-10-05 09:39:23'),
(103, 'ارشفة الشهر المالى', 'salaryRecords', 'admin', '2024-10-05 09:39:24', '2024-10-05 09:39:24'),
(104, 'فتح الشهر المالى', 'salaryRecords', 'admin', '2024-10-05 09:39:24', '2024-10-05 09:39:24'),
(105, 'الجزاءات', 'sanctions', 'admin', '2024-10-05 09:39:24', '2024-10-05 09:39:24'),
(106, 'عرض الجزاءات', 'sanctions', 'admin', '2024-10-05 09:39:24', '2024-10-05 09:39:24'),
(107, 'بحث الجزاءات', 'sanctions', 'admin', '2024-10-05 09:39:24', '2024-10-05 09:39:24'),
(108, 'اضافة الجزاءات', 'sanctions', 'admin', '2024-10-05 09:39:24', '2024-10-05 09:39:24'),
(109, 'تعديل الجزاءات', 'sanctions', 'admin', '2024-10-05 09:39:24', '2024-10-05 09:39:24'),
(110, 'حذف الجزاءات', 'sanctions', 'admin', '2024-10-05 09:39:24', '2024-10-05 09:39:24'),
(111, 'طباعه الجزاءات', 'sanctions', 'admin', '2024-10-05 09:39:24', '2024-10-05 09:39:24'),
(112, 'الغيابات', 'absences', 'admin', '2024-10-05 09:39:24', '2024-10-05 09:39:24'),
(113, 'عرض الغيابات', 'absences', 'admin', '2024-10-05 09:39:24', '2024-10-05 09:39:24'),
(114, 'بحث الغيابات', 'absences', 'admin', '2024-10-05 09:39:24', '2024-10-05 09:39:24'),
(115, 'اضافة الغيابات', 'absences', 'admin', '2024-10-05 09:39:24', '2024-10-05 09:39:24'),
(116, 'تعديل الغيابات', 'absences', 'admin', '2024-10-05 09:39:25', '2024-10-05 09:39:25'),
(117, 'حذف الغيابات', 'absences', 'admin', '2024-10-05 09:39:25', '2024-10-05 09:39:25'),
(118, 'طباعه الغيابات', 'absences', 'admin', '2024-10-05 09:39:25', '2024-10-05 09:39:25'),
(119, 'الأضافى', 'additionals', 'admin', '2024-10-05 09:39:25', '2024-10-05 09:39:25'),
(120, 'عرض الأضافى', 'additionals', 'admin', '2024-10-05 09:39:25', '2024-10-05 09:39:25'),
(121, 'بحث الأضافى', 'additionals', 'admin', '2024-10-05 09:39:25', '2024-10-05 09:39:25'),
(122, 'اضافة الأضافى', 'additionals', 'admin', '2024-10-05 09:39:25', '2024-10-05 09:39:25'),
(123, 'تعديل الأضافى', 'additionals', 'admin', '2024-10-05 09:39:25', '2024-10-05 09:39:25'),
(124, 'حذف الأضافى', 'additionals', 'admin', '2024-10-05 09:39:26', '2024-10-05 09:39:26'),
(125, 'طباعه الأضافى', 'additionals', 'admin', '2024-10-05 09:39:26', '2024-10-05 09:39:26'),
(126, 'الخصومات', 'discounts', 'admin', '2024-10-05 09:39:26', '2024-10-05 09:39:26'),
(127, 'عرض الخصومات', 'discounts', 'admin', '2024-10-05 09:39:26', '2024-10-05 09:39:26'),
(128, 'بحث الخصومات', 'discounts', 'admin', '2024-10-05 09:39:26', '2024-10-05 09:39:26'),
(129, 'اضافة الخصومات', 'discounts', 'admin', '2024-10-05 09:39:26', '2024-10-05 09:39:26'),
(130, 'تعديل الخصومات', 'discounts', 'admin', '2024-10-05 09:39:26', '2024-10-05 09:39:26'),
(131, 'حذف الخصومات', 'discounts', 'admin', '2024-10-05 09:39:26', '2024-10-05 09:39:26'),
(132, 'طباعه الخصومات', 'discounts', 'admin', '2024-10-05 09:39:26', '2024-10-05 09:39:26'),
(133, 'المكافئات', 'rewards', 'admin', '2024-10-05 09:39:26', '2024-10-05 09:39:26'),
(134, 'عرض المكافئات', 'rewards', 'admin', '2024-10-05 09:39:26', '2024-10-05 09:39:26'),
(135, 'بحث المكافئات', 'rewards', 'admin', '2024-10-05 09:39:26', '2024-10-05 09:39:26'),
(136, 'اضافة المكافئات', 'rewards', 'admin', '2024-10-05 09:39:26', '2024-10-05 09:39:26'),
(137, 'تعديل المكافئات', 'rewards', 'admin', '2024-10-05 09:39:27', '2024-10-05 09:39:27'),
(138, 'حذف المكافئات', 'rewards', 'admin', '2024-10-05 09:39:27', '2024-10-05 09:39:27'),
(139, 'طباعه المكافئات', 'rewards', 'admin', '2024-10-05 09:39:27', '2024-10-05 09:39:27'),
(140, 'البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-10-05 09:39:27', '2024-10-05 09:39:27'),
(141, 'عرض البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-10-05 09:39:27', '2024-10-05 09:39:27'),
(142, 'بحث البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-10-05 09:39:27', '2024-10-05 09:39:27'),
(143, 'اضافة البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-10-05 09:39:27', '2024-10-05 09:39:27'),
(144, 'تعديل البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-10-05 09:39:27', '2024-10-05 09:39:27'),
(145, 'حذف البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-10-05 09:39:28', '2024-10-05 09:39:28'),
(146, 'طباعه البدلات المتغيرة', 'allowancesSalary', 'admin', '2024-10-05 09:39:28', '2024-10-05 09:39:28'),
(147, 'السلف الشهرية', 'loans', 'admin', '2024-10-05 09:39:28', '2024-10-05 09:39:28'),
(148, 'عرض السلف الشهرية', 'loans', 'admin', '2024-10-05 09:39:28', '2024-10-05 09:39:28'),
(149, 'بحث السلف الشهرية', 'loans', 'admin', '2024-10-05 09:39:28', '2024-10-05 09:39:28'),
(150, 'اضافة السلف الشهرية', 'loans', 'admin', '2024-10-05 09:39:28', '2024-10-05 09:39:28'),
(151, 'تعديل السلف الشهرية', 'loans', 'admin', '2024-10-05 09:39:29', '2024-10-05 09:39:29'),
(152, 'حذف السلف الشهرية', 'loans', 'admin', '2024-10-05 09:39:29', '2024-10-05 09:39:29'),
(153, 'طباعه السلف الشهرية', 'loans', 'admin', '2024-10-05 09:39:29', '2024-10-05 09:39:29'),
(154, 'السلف المستديمة', 'permanentLoan', 'admin', '2024-10-05 09:39:29', '2024-10-05 09:39:29'),
(155, 'بحث السلف المستديمة', 'permanentLoan', 'admin', '2024-10-05 09:39:29', '2024-10-05 09:39:29'),
(156, 'صرف السلف المستديمة', 'permanentLoan', 'admin', '2024-10-05 09:39:29', '2024-10-05 09:39:29'),
(157, 'الدفع كاش السلف المستديمة', 'permanentLoan', 'admin', '2024-10-05 09:39:30', '2024-10-05 09:39:30'),
(158, 'تفاصيل السلف المستديمة', 'permanentLoan', 'admin', '2024-10-05 09:39:30', '2024-10-05 09:39:30'),
(159, 'اضافة السلف المستديمة', 'permanentLoan', 'admin', '2024-10-05 09:39:30', '2024-10-05 09:39:30'),
(160, 'تعديل السلف المستديمة', 'permanentLoan', 'admin', '2024-10-05 09:39:30', '2024-10-05 09:39:30'),
(161, 'حذف السلف المستديمة', 'permanentLoan', 'admin', '2024-10-05 09:39:30', '2024-10-05 09:39:30'),
(162, 'طباعه السلف المستديمة', 'permanentLoan', 'admin', '2024-10-05 09:39:30', '2024-10-05 09:39:30'),
(163, 'رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-10-05 09:39:30', '2024-10-05 09:39:30'),
(164, 'عرض رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-10-05 09:39:30', '2024-10-05 09:39:30'),
(165, 'بحث رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-10-05 09:39:30', '2024-10-05 09:39:30'),
(166, 'اضافة مرتب يدوى', 'mainSalaryEmployees', 'admin', '2024-10-05 09:39:30', '2024-10-05 09:39:30'),
(167, 'اضافة رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-10-05 09:39:30', '2024-10-05 09:39:30'),
(168, 'تعديل رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-10-05 09:39:30', '2024-10-05 09:39:30'),
(169, 'حذف رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-10-05 09:39:30', '2024-10-05 09:39:30'),
(170, 'بيانات الموظفين للرواتب', 'mainSalaryEmployees', 'admin', '2024-10-05 09:39:31', '2024-10-05 09:39:31'),
(171, 'طباعه رواتب الموظفين', 'mainSalaryEmployees', 'admin', '2024-10-05 09:39:31', '2024-10-05 09:39:31'),
(172, 'طباعه بحث تفصيلى للرواتب', 'mainSalaryEmployees', 'admin', '2024-10-05 09:39:31', '2024-10-05 09:39:31'),
(173, 'طباعه بحث اجمالى للرواتب', 'mainSalaryEmployees', 'admin', '2024-10-05 09:39:31', '2024-10-05 09:39:31'),
(174, 'طباعه مفردات المرتب', 'mainSalaryEmployees', 'admin', '2024-10-05 09:39:31', '2024-10-05 09:39:31'),
(175, 'ايقاف المرتب', 'mainSalaryEmployees', 'admin', '2024-10-05 09:39:31', '2024-10-05 09:39:31'),
(176, 'ارشفه المرتب يدوى', 'mainSalaryEmployees', 'admin', '2024-10-05 09:39:31', '2024-10-05 09:39:31'),
(177, 'حذف المرتب', 'mainSalaryEmployees', 'admin', '2024-10-05 09:39:31', '2024-10-05 09:39:31'),
(178, 'قائمة سجلات بصمة الموظفين', 'attendanceDeparturesFP', 'admin', '2024-10-05 09:39:31', '2024-10-05 09:39:31'),
(179, 'سجلات بصمة الموظفين', 'attendanceDepartures', 'admin', '2024-10-05 09:39:31', '2024-10-05 09:39:31'),
(180, 'عرض بصمة الموظفين', 'attendanceDepartures', 'admin', '2024-10-05 09:39:32', '2024-10-05 09:39:32'),
(181, 'بحث بصمة الموظفين', 'attendanceDepartures', 'admin', '2024-10-05 09:39:32', '2024-10-05 09:39:32'),
(182, 'إرفاق ملف البصمة مرتب يدوى', 'attendanceDepartures', 'admin', '2024-10-05 09:39:32', '2024-10-05 09:39:32'),
(183, 'عرض بصمات الموظفين', 'attendanceDepartures', 'admin', '2024-10-05 09:39:32', '2024-10-05 09:39:32'),
(184, 'تحميل بصمات الموظفين', 'attendanceDepartures', 'admin', '2024-10-05 09:39:32', '2024-10-05 09:39:32'),
(185, 'عرض سجل أرشيف بصمات الموظفين', 'attendanceDepartures', 'admin', '2024-10-05 09:39:32', '2024-10-05 09:39:32'),
(186, 'عرض حركات بصمات الموظفين', 'attendanceDepartures', 'admin', '2024-10-05 09:39:32', '2024-10-05 09:39:32'),
(187, 'تفاصيل أجازه الموظفين الموظفين', 'attendanceDepartures', 'admin', '2024-10-05 09:39:32', '2024-10-05 09:39:32'),
(188, 'طباعه بصمات الموظفين', 'attendanceDepartures', 'admin', '2024-10-05 09:39:33', '2024-10-05 09:39:33'),
(189, 'إعادة ضبط بصمات الموظفين', 'attendanceDepartures', 'admin', '2024-10-05 09:39:33', '2024-10-05 09:39:33'),
(190, 'قائمة المستخدمين', 'UserList', 'admin', '2024-10-05 09:39:33', '2024-10-05 09:39:33'),
(191, 'المستخدمين', 'users', 'admin', '2024-10-05 09:39:33', '2024-10-05 09:39:33'),
(192, 'اضافة المستخدمين', 'users', 'admin', '2024-10-05 09:39:33', '2024-10-05 09:39:33'),
(193, 'تعديل المستخدمين', 'users', 'admin', '2024-10-05 09:39:33', '2024-10-05 09:39:33'),
(194, 'حذف المستخدمين', 'users', 'admin', '2024-10-05 09:39:33', '2024-10-05 09:39:33'),
(195, 'الصلاحيات', 'roles', 'admin', '2024-10-05 09:39:33', '2024-10-05 09:39:33'),
(196, 'اضافة الصلاحيات', 'roles', 'admin', '2024-10-05 09:39:33', '2024-10-05 09:39:33'),
(197, 'تعديل الصلاحيات', 'roles', 'admin', '2024-10-05 09:39:33', '2024-10-05 09:39:33'),
(198, 'حذف الصلاحيات', 'roles', 'admin', '2024-10-05 09:39:33', '2024-10-05 09:39:33'),
(199, 'إضافة وتعديل أذونات الصلاحية', 'roles', 'admin', '2024-10-05 09:39:34', '2024-10-05 09:39:34'),
(200, 'الأذونات', 'permissions', 'admin', '2024-10-05 09:39:34', '2024-10-05 09:39:34'),
(201, 'اضافة الأذونات', 'permissions', 'admin', '2024-10-05 09:39:34', '2024-10-05 09:39:34'),
(202, 'تعديل الأذونات', 'permissions', 'admin', '2024-10-05 09:39:34', '2024-10-05 09:39:34'),
(203, 'حذف الأذونات', 'permissions', 'admin', '2024-10-05 09:39:34', '2024-10-05 09:39:34');

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
(1, 'super-admin', 'admin', '2024-10-05 09:39:34', '2024-10-05 09:39:34'),
(2, 'admin', 'admin', '2024-10-05 09:39:34', '2024-10-05 09:39:34'),
(3, 'staff', 'admin', '2024-10-05 09:39:34', '2024-10-05 09:39:34'),
(4, 'user', 'admin', '2024-10-05 09:39:35', '2024-10-05 09:39:35');

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
(1, 'رشا موسى', 'rasha@dt.com', NULL, '$2y$10$HdwrEv.JhIOD/e9UJDprvOK6Fj8/XnrFc77IW0lgICgJnJzxTD6Ia', 'active', '2024-07-02', NULL, NULL, NULL);

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employee_salary_additionals`
--
ALTER TABLE `employee_salary_additionals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employee_salary_allowances`
--
ALTER TABLE `employee_salary_allowances`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employee_salary_discounts`
--
ALTER TABLE `employee_salary_discounts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employee_salary_loans`
--
ALTER TABLE `employee_salary_loans`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employee_salary_permanent_loans`
--
ALTER TABLE `employee_salary_permanent_loans`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employee_salary_rewards`
--
ALTER TABLE `employee_salary_rewards`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `employee_salary_sanctions`
--
ALTER TABLE `employee_salary_sanctions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
-- AUTO_INCREMENT for table `main_salary_employees`
--
ALTER TABLE `main_salary_employees`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
