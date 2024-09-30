

// الحالة الأجتماعية
$('#children_number_hideandshow').hide();

$('select[name="social_status"]').change(function () {
    var selectOption = $(this).val();
    if (selectOption === "Single") {
        $('#children_number_hideandshow').hide();
    } else {
        $('#children_number_hideandshow').show();
    }
})

// ###########################################################################################################


$(document).ready(function () {
    // إخفاء حقول الخدمة العسكرية بشكل مبدئي
    $('#military_date_from_hideandshow').hide();
    $('#military_date_to_hideandshow').hide();
    $('#military_wepon_hideandshow').hide();
    $('#military_exemption_date_hideandshow').hide();
    $('#military_exemption_reason_hideandshow').hide();
    $('#military_postponement_reason_hideandshow').hide();

    // إظهار/إخفاء الحقول بناءً على نوع الخدمة العسكرية المختار
    $('select[name="military"]').change(function () {
        var selectedOption = $(this).val();
        if (selectedOption === 'Complete') {
            $('#military_date_from_hideandshow').show();
            $('#military_date_to_hideandshow').show();
            $('#military_wepon_hideandshow').show();
            $('#military_exemption_date_hideandshow').hide();
            $('#military_exemption_reason_hideandshow').hide();
            $('#military_postponement_reason_hideandshow').hide();
        } else if (selectedOption === 'Exemption_Temporary') {
            $('#military_date_from_hideandshow').hide();
            $('#military_date_to_hideandshow').hide();
            $('#military_wepon_hideandshow').hide();
            $('#military_exemption_reason_hideandshow').hide();
            $('#military_exemption_date_hideandshow').show();
            $('#military_postponement_reason_hideandshow').show();
        } else if (selectedOption === 'Exemption') {
            $('#military_date_from_hideandshow').hide();
            $('#military_date_to_hideandshow').hide();
            $('#military_wepon_hideandshow').hide();
            $('#military_exemption_date_hideandshow').show();
            $('#military_exemption_reason_hideandshow').show();
            $('#military_postponement_reason_hideandshow').hide();
        } else {
            $('#military_date_from_hideandshow').hide();
            $('#military_date_to_hideandshow').hide();
            $('#military_wepon_hideandshow').hide();
            $('#military_exemption_date_hideandshow').hide();
            $('#military_exemption_reason_hideandshow').hide();
            $('#military_postponement_reason_hideandshow').hide();
        }
    });
});




// ###########################################################################################################

// رقم رخصة القيادة
$('#driving_License_id_hideandshow').hide();
// نوع رخصة القيادة
$('#driving_license_type_hideandshow').hide();

$('select[name="driving_license"]').change(function () {
    var selectedOption = $(this).val();
    if (selectedOption === "Yes") {
        $('#driving_License_id_hideandshow').show();
        $('#driving_license_type_hideandshow').show();
    } else {
        $('#driving_License_id_hideandshow').hide();
        $('#driving_license_type_hideandshow').hide();
    }
})

// ###########################################################################################################

// تفاصيل الاقارب
$('#relatives_details_hideandshow').hide();

$('select[name="has_relatives"]').change(function () {
    var selectOption = $(this).val();
    if (selectOption === "Yes") {
        $('#relatives_details_hideandshow').show();
    } else {
        $('#relatives_details_hideandshow').hide();
    }
})

// ###########################################################################################################

// تفاصيل الاعاقة / عمليات سابقة
$('#disabilities_type_hideandshow').hide();

$('select[name="disabilities"]').change(function () {
    var selectOption = $(this).val();
    if (selectOption === "Yes") {
        $('#disabilities_type_hideandshow').show();
    } else {
        $('#disabilities_type_hideandshow').hide();
    }
})

// ###########################################################################################################

// هل له شفت ثابت
$(document).ready(function () {
    // Function to handle visibility of shift_types_id field
    function toggleShiftField() {
        var selectOption = $('#has_fixed_shift').val();
        if (selectOption === "Yes") {
            $('#relatedfixced_shift_hideandshow').show();
        } else {
            $('#relatedfixced_shift_hideandshow').hide();
            // تصفير حقل shift_types_id عند اختيار "لا"
            $('#shift_types_id').val('');
        }
    }

    // Call the function when the page loads to set the correct initial state
    toggleShiftField();

    // Call the function when the select box value changes
    $('#has_fixed_shift').change(function () {
        toggleShiftField();
    });
});



// ###########################################################################################################

// هل له حافز ثابت
$('#MotivationDIV_hideandshow').hide();

$('select[name="motivation_type"]').change(function () {
    var selectOption = $(this).val();
    if (selectOption === "Fixed") {
        $('#MotivationDIV_hideandshow').show();
    } else {
        $('#MotivationDIV_hideandshow').hide();
    }
})

// ###########################################################################################################

// هل له تأمين أجتماعى
$('#social_insurance_cut_monthelyDIV_hideandshow').hide();
$('#social_insurance_numberDIV_hideandshow').hide();

$('select[name="social_insurance"]').change(function () {
    var selectOption = $(this).val();
    if (selectOption === "Yes") {
        $('#social_insurance_cut_monthelyDIV_hideandshow').show();
        $('#social_insurance_numberDIV_hideandshow').show();
    } else {
        $('#social_insurance_cut_monthelyDIV_hideandshow').hide();
        $('#social_insurance_numberDIV_hideandshow').hide();
    }
})


// ###########################################################################################################

// هل له تأمين طبى
$('#medicalinsurancecutmonthelyDIV_hideandshow').hide();
$('#medicalinsuranceNumberDIV_hideandshow').hide();

$('select[name="medical_insurance"]').change(function () {
    var selectOption = $(this).val();
    if (selectOption === "Yes") {
        $('#medicalinsurancecutmonthelyDIV_hideandshow').show();
        $('#medicalinsuranceNumberDIV_hideandshow').show();
    } else {
        $('#medicalinsurancecutmonthelyDIV_hideandshow').hide();
        $('#medicalinsuranceNumberDIV_hideandshow').hide();
    }
})


