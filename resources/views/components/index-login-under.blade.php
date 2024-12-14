<div class="col-md-6 col-lg-6 col-xl-7 d-none d-md-flex"
style="background-color: #014051; height: 100vh; padding: 0;">
<div class="row" style="width: 100%; height: 100%; margin: 0;">
    <div class="col-12 my-auto" style="width: 100vw; height: 100%; padding: 0;">
        @if ($data['photo_cover'])
            <img style="width: 100%; height: 100%; object-fit: cover;"
                src="{{ asset('dashboard/assets/uploads/company/photo/' . $data['photo_cover']) }}"
                data-holder-rendered="true">
        @else
            <img src="{{ URL::asset('dashboard/assets/img/media/hr-system.jpg') }}"
                style="width: 100%; height: 100%; object-fit: cover;" alt="logo">
        @endif
    </div>
</div>
</div>