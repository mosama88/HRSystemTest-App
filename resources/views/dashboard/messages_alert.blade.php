{{-- @if ($errors->any())
    @foreach ($errors->all() as $error)
        <div class="col-6 my-3">
            <div class="alert alert-danger bg-danger text-white mb-0 border-0" role="alert">
                <strong>{{ $error }}</strong>
            </div>
        </div>
    @endforeach
@endif --}}


@if (session()->has('success'))
    <script>
        window.onload = function() {
            var message = "{{ session('success') }}"; // Retrieve the value of the session variable
            notif({
                msg: message,
                type: "success"
            }); // Assuming notif is a function that displays a notification
        }
    </script>
@endif




@if (session('error'))
    <div class="col-6 alert alert-solid-danger mg-b-0 my-3" role="alert">
        <button aria-label="Close" class="close" data-dismiss="alert" type="button">
            <span aria-hidden="true">&times;</span></button>
        <strong>حدث خطأ!</strong> {{ session('error') }}
    </div>
@endif
