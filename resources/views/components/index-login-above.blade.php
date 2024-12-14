<div class="mb-5 d-flex"> <a href="{{ url('/' . ($page = 'index')) }}">
    @if ($data['image'])
        <img class="img-thumbnail rounded me-2 mt-2" alt="200x200"
            style="width: 100px; height:100"
            src="{{ asset('dashboard/assets/uploads/admin_setting/' . $data['image']) }}"
            data-holder-rendered="true">
    @else
        <img class="img-thumbnail rounded me-2 mt-2" alt="200x200"
            style="width: 100px; height:100"
            src="{{ asset('dashboard/assets/img/default-logo.png') }}"
            data-holder-rendered="true">
    @endif

</a>
<h1 class="main-logo1 ml-1 mr-0 my-auto tx-28"><span class="mr-4"
        style="color: #0262AC;">{{ $data['company_name'] }}</span></h1>
</div>