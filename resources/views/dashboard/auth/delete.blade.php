<!-- End Modal effects-->
<div class="modal" id="modaldemo8">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content tx-size-sm">
            <div class="modal-body tx-center pd-y-20 pd-x-20">
                <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                        aria-hidden="true">&times;</span></button> <i
                    class="icon icon ion-ios-close-circle-outline tx-100 tx-danger lh-1 mg-t-20 d-inline-block"></i>
                <h4 class="tx-danger mg-b-20">هل انت متأكد انك تريد حذف حسابك؟</h4>
                <p>بمجرد حذف حسابك، سيتم حذف جميع موارده وبياناته نهائيًا. يرجى إدخال كلمة المرور الخاصة بك لتأكيد رغبتك
                    في حذف حسابك نهائيًا.</p>
                <form method="post" action="{{ route('dashboard.profile.destroy') }}">

                    {{ method_field('delete') }}
                    {{ csrf_field() }}
                    <div class="modal-body">
                        <input type="hidden" name="id" value="{{ $user->id }}">
                        <h5>{{ $user->name }}</h5>

                        {{--  Password Input --}}
                        <div class="control-group form-group">
                            <input type="password" name="password" class="form-control" placeholder="كلمة المرور"
                                required autofocus autocomplete="name">
                            <x-input-error :messages="$errors->updatePassword->get('password')" class="mt-2" />
                        </div>
                    </div>
                    <div class="modal-footer mx-auto">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">إغلاق</button>
                        <x-danger-button class="btn btn-danger">
                            {{ __('حذف الحساب') }}
                        </x-danger-button>


                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
