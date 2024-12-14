<form wire:submit.prevent="submit">
    @csrf

    <!-- Email Input -->
    <div class="mb-3">
        <label class="form-label" for="username">أسم المستخدم</label>
        <input type="text" wire:model="username" class="form-control" id="username" placeholder="أدخل أسم المستخدم">
        @error('username')
            <div class="alert alert-danger mt-2">{{ $message }}</div>
        @enderror
    </div>

    <!-- Password Input -->
    <div class="mb-3">
        <label class="form-label" for="userpassword">كلمة المرور</label>
        <input type="password" wire:model="password" class="form-control" id="userpassword" placeholder="xxxxxxxxx">
        @error('password')
            <div class="alert alert-danger mt-2">{{ $message }}</div>
        @enderror
    </div>

    <div class="mb-3 row">
        <div class="col-sm-12">
            <div class="form-check">
                <input type="checkbox" wire:model="remember" class="form-check-input" id="customControlInline">
                <label class="form-check-label mx-3" for="customControlInline">تذكرنى</label>
            </div>
        </div>
        <div class="my-2 col-4 mx-auto">
            <button class="btn btn-block btn-md btn-dark  d-grid w-100 d-flex align-items-center justify-content-center"
                type="submit">
                <div wire:loading.remove>
                    <span>دخول</span>
                </div>
                <div class="spinner-border text-secondary" wire:loading wire:target="submit" role="status">
                    <span class="sr-only">تحميل...</span>
                </div>
            </button>
        </div>
    </div>


</form>
