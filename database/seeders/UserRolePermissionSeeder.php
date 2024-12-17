<?php

namespace Database\Seeders;

use App\Models\Admin;
use App\Models\User;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Permission;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class UserRolePermissionSeeder extends Seeder
{




    public function run(): void
    {




        // Define the guard
        $guardAdmin = 'admin';

        // Create Permissions
        $permissions = [
            ['name' => 'view role', 'category' => 'Roles', 'guard_name' => $guardAdmin],
            ['name' => 'create role', 'category' => 'Roles', 'guard_name' => $guardAdmin],
            ['name' => 'update role', 'category' => 'Roles', 'guard_name' => $guardAdmin],
            ['name' => 'delete role', 'category' => 'Roles', 'guard_name' => $guardAdmin],

            ['name' => 'view permission', 'category' => 'Permissions', 'guard_name' => $guardAdmin],
            ['name' => 'create permission', 'category' => 'Permissions', 'guard_name' => $guardAdmin],
            ['name' => 'update permission', 'category' => 'Permissions', 'guard_name' => $guardAdmin],
            ['name' => 'delete permission', 'category' => 'Permissions', 'guard_name' => $guardAdmin],

            ['name' => 'view user', 'category' => 'Users', 'guard_name' => $guardAdmin],
            ['name' => 'create user', 'category' => 'Users', 'guard_name' => $guardAdmin],
            ['name' => 'update user', 'category' => 'Users', 'guard_name' => $guardAdmin],
            ['name' => 'delete user', 'category' => 'Users', 'guard_name' => $guardAdmin],





            // قائمة الأعدادات
            ['name' => 'قائمة الأعدادات', 'category' => 'Settings', 'guard_name' => $guardAdmin],

            // الضبط العام
            ['name' => 'الضبط العام', 'category' => 'generalSettings', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل الضبط العام', 'category' => 'generalSettings', 'guard_name' => $guardAdmin],

            // السنوات المالية
            ['name' => 'السنوات المالية', 'category' => 'financeCalendars', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة السنوات المالية', 'category' => 'financeCalendars', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل السنوات المالية', 'category' => 'financeCalendars', 'guard_name' => $guardAdmin],
            ['name' => 'حذف السنوات المالية', 'category' => 'financeCalendars', 'guard_name' => $guardAdmin],
            ['name' => 'عرض شهور السنه السنوات مالية', 'category' => 'financeCalendars', 'guard_name' => $guardAdmin],
            ['name' => 'فتح السنوات المالية', 'category' => 'financeCalendars', 'guard_name' => $guardAdmin],
            ['name' => 'غلق السنوات المالية', 'category' => 'financeCalendars', 'guard_name' => $guardAdmin],

            // الفروع
            ['name' => 'الفروع', 'category' => 'branches', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة الفروع', 'category' => 'branches', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل الفروع', 'category' => 'branches', 'guard_name' => $guardAdmin],
            ['name' => 'حذف الفروع', 'category' => 'branches', 'guard_name' => $guardAdmin],

            // أنواع الشفتات
            ['name' => 'الشفتات', 'category' => 'shiftsTypes', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة الشفتات', 'category' => 'shiftsTypes', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل الشفتات', 'category' => 'shiftsTypes', 'guard_name' => $guardAdmin],
            ['name' => 'حذف الشفتات', 'category' => 'shiftsTypes', 'guard_name' => $guardAdmin],


            //الأدارات
            ['name' => 'الأدارات', 'category' => 'departments', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة الأدارات', 'category' => 'departments', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل الأدارات', 'category' => 'departments', 'guard_name' => $guardAdmin],
            ['name' => 'حذف الأدارات', 'category' => 'departments', 'guard_name' => $guardAdmin],


            //    الوظائف
            ['name' => 'الوظائف', 'category' => 'jobsCategories', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة الوظائف', 'category' => 'jobsCategories', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل الوظائف', 'category' => 'jobsCategories', 'guard_name' => $guardAdmin],
            ['name' => 'حذف الوظائف', 'category' => 'jobsCategories', 'guard_name' => $guardAdmin],

            // الدرجات الوظيفية
            ['name' => 'الدرجات الوظيفية', 'category' => 'jobsGrades', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة الدرجات الوظيفية', 'category' => 'jobsGrades', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل الدرجات الوظيفية', 'category' => 'jobsGrades', 'guard_name' => $guardAdmin],
            ['name' => 'حذف الدرجات الوظيفية', 'category' => 'jobsGrades', 'guard_name' => $guardAdmin],

            //    المؤهل
            ['name' => 'المؤهل', 'category' => 'qualifications', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة المؤهل', 'category' => 'qualifications', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل المؤهل', 'category' => 'qualifications', 'guard_name' => $guardAdmin],
            ['name' => 'حذف المؤهل', 'category' => 'qualifications', 'guard_name' => $guardAdmin],

            //    العطلات الرسمية
            ['name' => 'العطلات الرسمية', 'category' => 'holidays', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة العطلات الرسمية', 'category' => 'holidays', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل العطلات الرسمية', 'category' => 'holidays', 'guard_name' => $guardAdmin],
            ['name' => 'حذف العطلات الرسمية', 'category' => 'holidays', 'guard_name' => $guardAdmin],

            //    الأستقالة
            ['name' => 'الأستقالة', 'category' => 'resignations', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة الأستقالة', 'category' => 'resignations', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل الأستقالة', 'category' => 'resignations', 'guard_name' => $guardAdmin],
            ['name' => 'حذف الأستقالة', 'category' => 'resignations', 'guard_name' => $guardAdmin],

            //    أنواع الأجازات
            ['name' => 'الأجازات', 'category' => 'vacations', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة الأجازات', 'category' => 'vacations', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل الأجازات', 'category' => 'vacations', 'guard_name' => $guardAdmin],
            ['name' => 'حذف الأجازات', 'category' => 'vacations', 'guard_name' => $guardAdmin],

            //    البلاد
            ['name' => 'البلاد', 'category' => 'countries', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة البلاد', 'category' => 'countries', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل البلاد', 'category' => 'countries', 'guard_name' => $guardAdmin],
            ['name' => 'حذف البلاد', 'category' => 'countries', 'guard_name' => $guardAdmin],

            //    المحافظات
            ['name' => 'المحافظات', 'category' => 'governorates', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة المحافظات', 'category' => 'governorates', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل المحافظات', 'category' => 'governorates', 'guard_name' => $guardAdmin],
            ['name' => 'حذف المحافظات', 'category' => 'governorates', 'guard_name' => $guardAdmin],


            //    المنطقه
            ['name' => 'المنطقه', 'category' => 'cities', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة المنطقه', 'category' => 'cities', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل المنطقه', 'category' => 'cities', 'guard_name' => $guardAdmin],
            ['name' => 'حذف المنطقه', 'category' => 'cities', 'guard_name' => $guardAdmin],

            //    الجنسيات
            ['name' => 'الجنسيات', 'category' => 'nationalities', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة الجنسيات', 'category' => 'nationalities', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل الجنسيات', 'category' => 'nationalities', 'guard_name' => $guardAdmin],
            ['name' => 'حذف الجنسيات', 'category' => 'nationalities', 'guard_name' => $guardAdmin],

            //    فصيلة الدم
            ['name' => 'فصيلة الدم', 'category' => 'bloodTypes', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة فصيلة الدم', 'category' => 'bloodTypes', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل فصيلة الدم', 'category' => 'bloodTypes', 'guard_name' => $guardAdmin],
            ['name' => 'حذف فصيلة الدم', 'category' => 'bloodTypes', 'guard_name' => $guardAdmin],

            // ###################################################################################################################

            // قائمة بيانات شئون الموظفين
            ['name' => 'قائمة بيانات شئون الموظفين', 'category' => 'affairsEmployees', 'guard_name' => $guardAdmin],

            // بيانات الموظفين
            ['name' => 'بيانات الموظفين', 'category' => 'Employees', 'guard_name' => $guardAdmin],
            ['name' => 'جدول الموظفين', 'category' => 'Employees', 'guard_name' => $guardAdmin],
            ['name' => 'أضافة موظف', 'category' => 'Employees', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل الموظف', 'category' => 'Employees', 'guard_name' => $guardAdmin],
            ['name' => 'حذف الموظف', 'category' => 'Employees', 'guard_name' => $guardAdmin],
            ['name' => 'عرض حساب الأجازات', 'category' => 'Employees', 'guard_name' => $guardAdmin],
            ['name' => 'بحث الموظفين', 'category' => 'Employees', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة بدل ثابت', 'category' => 'Employees', 'guard_name' => $guardAdmin],
            ['name' => 'الراتب المؤرشف', 'category' => 'Employees', 'guard_name' => $guardAdmin],
            ['name' => 'جدول الملفات الشخصية', 'category' => 'Employees', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة ملفات شخصية', 'category' => 'Employees', 'guard_name' => $guardAdmin],
            ['name' => 'تحميل من جدول ملفات شخصية', 'category' => 'Employees', 'guard_name' => $guardAdmin],
            ['name' => 'حذف من جدول ملفات شخصية', 'category' => 'Employees', 'guard_name' => $guardAdmin],

            //    الأضافى للراتب
            ['name' => 'الأضافى للراتب', 'category' => 'additional_types', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة الأضافى للراتب', 'category' => 'additional_types', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل الأضافى للراتب', 'category' => 'additional_types', 'guard_name' => $guardAdmin],
            ['name' => 'حذف الأضافى للراتب', 'category' => 'additional_types', 'guard_name' => $guardAdmin],


            //    الخصم
            ['name' => 'الخصم', 'category' => 'discount_types', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة الخصم', 'category' => 'discount_types', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل الخصم', 'category' => 'discount_types', 'guard_name' => $guardAdmin],
            ['name' => 'حذف الخصم', 'category' => 'discount_types', 'guard_name' => $guardAdmin],

            //    البدلات
            ['name' => 'البدلات', 'category' => 'allowances', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة البدلات', 'category' => 'allowances', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل البدلات', 'category' => 'allowances', 'guard_name' => $guardAdmin],
            ['name' => 'حذف البدلات', 'category' => 'allowances', 'guard_name' => $guardAdmin],

            // ###################################################################################################################
            // قائمة الأجور
            ['name' => 'قائمة الأجور', 'category' => 'salaries', 'guard_name' => $guardAdmin],

            // السجلات الرئيسية للرواتب
            ['name' => 'السجلات الرئيسية للرواتب', 'category' => 'salaryRecords', 'guard_name' => $guardAdmin],
            ['name' => 'ارشفة الشهر المالى', 'category' => 'salaryRecords', 'guard_name' => $guardAdmin],
            ['name' => 'فتح الشهر المالى', 'category' => 'salaryRecords', 'guard_name' => $guardAdmin],


            //    الجزاءات
            ['name' => 'الجزاءات', 'category' => 'sanctions', 'guard_name' => $guardAdmin],
            ['name' => 'عرض الجزاءات', 'category' => 'sanctions', 'guard_name' => $guardAdmin],
            ['name' => 'بحث الجزاءات', 'category' => 'sanctions', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة الجزاءات', 'category' => 'sanctions', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل الجزاءات', 'category' => 'sanctions', 'guard_name' => $guardAdmin],
            ['name' => 'حذف الجزاءات', 'category' => 'sanctions', 'guard_name' => $guardAdmin],
            ['name' => 'طباعه الجزاءات', 'category' => 'sanctions', 'guard_name' => $guardAdmin],

            //    الغيابات
            ['name' => 'الغيابات', 'category' => 'absences', 'guard_name' => $guardAdmin],
            ['name' => 'عرض الغيابات', 'category' => 'absences', 'guard_name' => $guardAdmin],
            ['name' => 'بحث الغيابات', 'category' => 'absences', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة الغيابات', 'category' => 'absences', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل الغيابات', 'category' => 'absences', 'guard_name' => $guardAdmin],
            ['name' => 'حذف الغيابات', 'category' => 'absences', 'guard_name' => $guardAdmin],
            ['name' => 'طباعه الغيابات', 'category' => 'absences', 'guard_name' => $guardAdmin],

            //    الأضافى
            ['name' => 'الأضافى', 'category' => 'additionals', 'guard_name' => $guardAdmin],
            ['name' => 'عرض الأضافى', 'category' => 'additionals', 'guard_name' => $guardAdmin],
            ['name' => 'بحث الأضافى', 'category' => 'additionals', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة الأضافى', 'category' => 'additionals', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل الأضافى', 'category' => 'additionals', 'guard_name' => $guardAdmin],
            ['name' => 'حذف الأضافى', 'category' => 'additionals', 'guard_name' => $guardAdmin],
            ['name' => 'طباعه الأضافى', 'category' => 'additionals', 'guard_name' => $guardAdmin],

            //    الخصومات
            ['name' => 'الخصومات', 'category' => 'discounts', 'guard_name' => $guardAdmin],
            ['name' => 'عرض الخصومات', 'category' => 'discounts', 'guard_name' => $guardAdmin],
            ['name' => 'بحث الخصومات', 'category' => 'discounts', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة الخصومات', 'category' => 'discounts', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل الخصومات', 'category' => 'discounts', 'guard_name' => $guardAdmin],
            ['name' => 'حذف الخصومات', 'category' => 'discounts', 'guard_name' => $guardAdmin],
            ['name' => 'طباعه الخصومات', 'category' => 'discounts', 'guard_name' => $guardAdmin],

            //    المكافئات
            ['name' => 'المكافئات', 'category' => 'rewards', 'guard_name' => $guardAdmin],
            ['name' => 'عرض المكافئات', 'category' => 'rewards', 'guard_name' => $guardAdmin],
            ['name' => 'بحث المكافئات', 'category' => 'rewards', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة المكافئات', 'category' => 'rewards', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل المكافئات', 'category' => 'rewards', 'guard_name' => $guardAdmin],
            ['name' => 'حذف المكافئات', 'category' => 'rewards', 'guard_name' => $guardAdmin],
            ['name' => 'طباعه المكافئات', 'category' => 'rewards', 'guard_name' => $guardAdmin],

            //    البدلات المتغيرة
            ['name' => 'البدلات المتغيرة', 'category' => 'allowancesSalary', 'guard_name' => $guardAdmin],
            ['name' => 'عرض البدلات المتغيرة', 'category' => 'allowancesSalary', 'guard_name' => $guardAdmin],
            ['name' => 'بحث البدلات المتغيرة', 'category' => 'allowancesSalary', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة البدلات المتغيرة', 'category' => 'allowancesSalary', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل البدلات المتغيرة', 'category' => 'allowancesSalary', 'guard_name' => $guardAdmin],
            ['name' => 'حذف البدلات المتغيرة', 'category' => 'allowancesSalary', 'guard_name' => $guardAdmin],
            ['name' => 'طباعه البدلات المتغيرة', 'category' => 'allowancesSalary', 'guard_name' => $guardAdmin],

            //    السلف الشهرية
            ['name' => 'السلف الشهرية', 'category' => 'loans', 'guard_name' => $guardAdmin],
            ['name' => 'عرض السلف الشهرية', 'category' => 'loans', 'guard_name' => $guardAdmin],
            ['name' => 'بحث السلف الشهرية', 'category' => 'loans', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة السلف الشهرية', 'category' => 'loans', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل السلف الشهرية', 'category' => 'loans', 'guard_name' => $guardAdmin],
            ['name' => 'حذف السلف الشهرية', 'category' => 'loans', 'guard_name' => $guardAdmin],
            ['name' => 'طباعه السلف الشهرية', 'category' => 'loans', 'guard_name' => $guardAdmin],

            //    السلف المستديمة
            ['name' => 'السلف المستديمة', 'category' => 'permanentLoan', 'guard_name' => $guardAdmin],
            ['name' => 'بحث السلف المستديمة', 'category' => 'permanentLoan', 'guard_name' => $guardAdmin],
            ['name' => 'صرف السلف المستديمة', 'category' => 'permanentLoan', 'guard_name' => $guardAdmin],
            ['name' => 'الدفع كاش السلف المستديمة', 'category' => 'permanentLoan', 'guard_name' => $guardAdmin],
            ['name' => 'تفاصيل السلف المستديمة', 'category' => 'permanentLoan', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة السلف المستديمة', 'category' => 'permanentLoan', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل السلف المستديمة', 'category' => 'permanentLoan', 'guard_name' => $guardAdmin],
            ['name' => 'حذف السلف المستديمة', 'category' => 'permanentLoan', 'guard_name' => $guardAdmin],
            ['name' => 'طباعه السلف المستديمة', 'category' => 'permanentLoan', 'guard_name' => $guardAdmin],


            //    رواتب الموظفين المفصلة
            ['name' => 'رواتب الموظفين', 'category' => 'mainSalaryEmployees', 'guard_name' => $guardAdmin],
            ['name' => 'عرض رواتب الموظفين', 'category' => 'mainSalaryEmployees', 'guard_name' => $guardAdmin],
            ['name' => 'بحث رواتب الموظفين', 'category' => 'mainSalaryEmployees', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة مرتب يدوى', 'category' => 'mainSalaryEmployees', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة رواتب الموظفين', 'category' => 'mainSalaryEmployees', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل رواتب الموظفين', 'category' => 'mainSalaryEmployees', 'guard_name' => $guardAdmin],
            ['name' => 'حذف رواتب الموظفين', 'category' => 'mainSalaryEmployees', 'guard_name' => $guardAdmin],
            ['name' => 'بيانات الموظفين للرواتب', 'category' => 'mainSalaryEmployees', 'guard_name' => $guardAdmin],
            ['name' => 'طباعه رواتب الموظفين', 'category' => 'mainSalaryEmployees', 'guard_name' => $guardAdmin],
            ['name' => 'طباعه بحث تفصيلى للرواتب', 'category' => 'mainSalaryEmployees', 'guard_name' => $guardAdmin],
            ['name' => 'طباعه بحث اجمالى للرواتب', 'category' => 'mainSalaryEmployees', 'guard_name' => $guardAdmin],
            ['name' => 'طباعه مفردات المرتب', 'category' => 'mainSalaryEmployees', 'guard_name' => $guardAdmin],
            ['name' => 'ايقاف المرتب', 'category' => 'mainSalaryEmployees', 'guard_name' => $guardAdmin],
            ['name' => 'ارشفه المرتب يدوى', 'category' => 'mainSalaryEmployees', 'guard_name' => $guardAdmin],
            ['name' => 'حذف المرتب', 'category' => 'mainSalaryEmployees', 'guard_name' => $guardAdmin],



            // ###################################################################################################################
            // قائمة سجلات بصمة الموظفين

            ['name' => 'قائمة سجلات بصمة الموظفين', 'category' => 'attendanceDeparturesFP', 'guard_name' => $guardAdmin],

            ['name' => 'سجلات بصمة الموظفين', 'category' => 'attendanceDepartures', 'guard_name' => $guardAdmin],
            ['name' => 'عرض بصمة الموظفين', 'category' => 'attendanceDepartures', 'guard_name' => $guardAdmin],
            ['name' => 'بحث بصمة الموظفين', 'category' => 'attendanceDepartures', 'guard_name' => $guardAdmin],
            ['name' => 'إرفاق ملف البصمة مرتب يدوى', 'category' => 'attendanceDepartures', 'guard_name' => $guardAdmin],
            ['name' => 'عرض بصمات الموظفين', 'category' => 'attendanceDepartures', 'guard_name' => $guardAdmin],
            ['name' => 'تحميل بصمات الموظفين', 'category' => 'attendanceDepartures', 'guard_name' => $guardAdmin],
            ['name' => 'عرض سجل أرشيف بصمات الموظفين', 'category' => 'attendanceDepartures', 'guard_name' => $guardAdmin],
            ['name' => 'عرض حركات بصمات الموظفين', 'category' => 'attendanceDepartures', 'guard_name' => $guardAdmin],
            ['name' => 'تفاصيل أجازه الموظفين الموظفين', 'category' => 'attendanceDepartures', 'guard_name' => $guardAdmin],
            ['name' => 'طباعه بصمات الموظفين', 'category' => 'attendanceDepartures', 'guard_name' => $guardAdmin],
            ['name' => 'إعادة ضبط بصمات الموظفين', 'category' => 'attendanceDepartures', 'guard_name' => $guardAdmin],


            //    قائمة المستخدمين
            ['name' => 'قائمة المستخدمين', 'category' => 'UserList', 'guard_name' => $guardAdmin],



            // المستخدمين
            ['name' => 'المستخدمين', 'category' => 'users', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة المستخدمين', 'category' => 'users', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل المستخدمين', 'category' => 'users', 'guard_name' => $guardAdmin],
            ['name' => 'حذف المستخدمين', 'category' => 'users', 'guard_name' => $guardAdmin],



            // الصلاحيات
            ['name' => 'الصلاحيات', 'category' => 'roles', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة الصلاحيات', 'category' => 'roles', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل الصلاحيات', 'category' => 'roles', 'guard_name' => $guardAdmin],
            ['name' => 'حذف الصلاحيات', 'category' => 'roles', 'guard_name' => $guardAdmin],
            ['name' => 'إضافة وتعديل أذونات الصلاحية', 'category' => 'roles', 'guard_name' => $guardAdmin],


            // الأذونات
            ['name' => 'الأذونات', 'category' => 'permissions', 'guard_name' => $guardAdmin],
            ['name' => 'اضافة الأذونات', 'category' => 'permissions', 'guard_name' => $guardAdmin],
            ['name' => 'تعديل الأذونات', 'category' => 'permissions', 'guard_name' => $guardAdmin],
            ['name' => 'حذف الأذونات', 'category' => 'permissions', 'guard_name' => $guardAdmin],

        ];

        foreach ($permissions as $permission) {
            Permission::create($permission);
        }

        // Create Roles
        $superAdminRole = Role::create(['name' => 'super-admin', 'guard_name' => $guardAdmin]); //as super-admin
        $adminRole = Role::create(['name' => 'admin', 'guard_name' => $guardAdmin]);
        $staffRole = Role::create(['name' => 'staff', 'guard_name' => $guardAdmin]);
        $userRole = Role::create(['name' => 'user', 'guard_name' => $guardAdmin]);

        // Lets give all permission to super-admin role.
        $allPermissionNames = Permission::where('guard_name', $guardAdmin)->pluck('name')->toArray();
        $superAdminRole->givePermissionTo($allPermissionNames);

        // Let's give few permissions to admin role.
        $adminPermissions = [
            'create role',
            'view role',
            'update role',
            'create permission',
            'view permission',
            'create user',
            'view user',
            'update user',
        ];


        $adminRole->givePermissionTo($adminPermissions);

        // Let's Create User and assign Role to it.
        $superAdminUser = Admin::firstOrCreate([
            'username' => 'superadmin',
        ], [
            'name' => 'Super Admin',
            'username' => 'superadmin',
            'email' => 'superadmin@dt.com',
            'password' => Hash::make('12345678'),
            'created_by' => 1,
            'status' => 'active',
        ]);
        $superAdminUser->assignRole($superAdminRole);

        $superAdminUser2 = Admin::firstOrCreate([
            'username' => 'mosama',
        ], [
            'name' => 'محمد أسامه',
            'username' => 'mosama',
            'email' => 'mosama@dt.com',
            'password' => Hash::make('password'),
            'created_by' => 1,
            'com_code' => 1,
            'status' => 'active',
        ]);
        $superAdminUser2->assignRole($superAdminRole);

        $adminUser = Admin::firstOrCreate([
            'username' => 'admin'
        ], [
            'name' => 'Admin',
            'username' => 'admin',
            'email' => 'admin@dt.com',
            'password' => Hash::make('12345678'),
            'created_by' => 1,
            'com_code' => 1,
            'status' => 'active',
        ]);
        $adminUser->assignRole($adminRole);

        $staffUser = Admin::firstOrCreate([
            'username' => 'staff',
        ], [
            'name' => 'Staff',
            'username' => 'staff',
            'email' => 'staff@dt.com',
            'password' => Hash::make('12345678'),
            'created_by' => 1,
            'com_code' => 1,
            'status' => 'active',
        ]);
        $staffUser->assignRole($staffRole);
    }
}
