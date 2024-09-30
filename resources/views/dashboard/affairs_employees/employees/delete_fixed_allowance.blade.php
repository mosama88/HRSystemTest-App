<!-- End Modal effects-->
<div class="modal DeleteAllownce" id="delete{{ $info->id }}">

    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content tx-size-sm">
            <div class="modal-body tx-center pd-y-20 pd-x-20">
                <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                        aria-hidden="true">&times;</span></button> <i
                    class="icon icon ion-ios-close-circle-outline tx-100 tx-danger lh-1 mg-t-20 d-inline-block"></i>
                <h4 class="tx-danger mg-b-20">إحذر: ستقوم بحذف العملية !</h4>


                <div class="col-10">
                    <h5>
                         <span style="color: blue">أسم الموظف: </span> {{ $info->employee->name }}
                    </h5>

                    <span class="text-right" style="color: blue">أسم البدل الثابت</span>
                    <span class="text-right">{{ $info->allowance?->name }}</span><br>
                    <span class="text-right" style="color: blue">قيمة البدل</span>


                    <span class="text-right">{{ $info->value }}</span>
                </div>

            </div>
            <form action="{{ route('dashboard.employees.destroy_allowance', $info->id) }}" method="POST">
                {{ method_field('delete') }}
                {{ csrf_field() }}

                <div class="form-group">
                    <input type="hidden" name="page_id" value="1" class="form-control" id="recipient-name">
                    <div class="modal-body">
                        <input type="hidden" name="id" value="{{ $info->id }}">
                        <div class="modal-footer mx-auto">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">إغلاق</button>
                            <button type="submit" class="btn btn-danger">تأكيد الحذف</button>
                        </div>
            </form>
        </div>
    </div>
</div>
</div>
