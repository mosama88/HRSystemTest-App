$(document).ready(function () {
    $('#employeeForm').on('submit', function (e) {
        e.preventDefault(); // Prevent the default form submission

        // Hide all error messages initially
        $('.error-message').addClass('d-none').html('');

        // Hide success message initially
        $('#successMessage').addClass('d-none');

        var formData = new FormData(this);

        $.ajax({
            url: $(this).attr('action'), // Use the form's action attribute
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            success: function (response) {
                // Handle success response
                $('#employeeForm')[0].reset(); // Optionally, reset the form fields
                $('#output').attr('src', '').hide(); // Clear the selected image preview and hide it
                $('#successMessage').removeClass('d-none'); // Show success message

                // عرض الرسالة من اليمين إلى اليسار
                $('#successMessage').css({ 'right': '0', 'opacity': '1' });


                // Slowly fade out the success message after 1 second
                setTimeout(function () {
                    $('#successMessage').fadeOut('slow', function () {
                        window.location.href = "/employees";
                    });
                }, 1000); // 1000 milliseconds = 1 second
            },
            error: function (xhr) {
                console.log(xhr.responseJSON.errors); // للتحقق من الأخطاء الواردة
                var errors = xhr.responseJSON.errors;
                for (var field in errors) {
                    var errorMessage = errors[field].join('<br>');
                    $('#' + field + '-error').html(errorMessage).removeClass('d-none');
                }

            }
        });
    });
});


