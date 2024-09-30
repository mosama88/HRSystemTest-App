<!-- End Modal effects-->
<div class="modal" id="disbursed_done_now{{ $info->id }}">

    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content tx-size-sm">
            <div class="modal-body tx-center pd-y-20 pd-x-20">
                <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                        aria-hidden="true">&times;</span></button>

                <!--Page Widget Error-->
                <div class="card bd-0 mg-b-20">
                    <div class="card-body text-info">
                        <div class="main-error-wrapper">
                            <i class="si si-info mg-b-20 tx-50"></i>
                            <h3 class="mg-b-20">تحذير</h3>
                            <h2 class="text-dark">هل تريد فتح الصرف الأن</h2>
                        </div>
                        <h5 class="col-12"> <span style="color: blue">أسم الموظف: </span>
                            {{ $info->employee->name }}
                        </h5>
                            <div class="table-responsive">
                                <table class="table table-bordered mg-b-0 text-md-nowrap">
                                    <thead>
                                        <tr>
                                            <th>قيمة السلفة</th>
                                            <th>عدد شهور الأقساط</th>
                                            <th>قيمة القسط</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th>{{ $info->total *1}}</th>
                                            <td>{{ $info->month_number_installment }}</td>
                                            <td>{{ $info->month_installment_value *1}}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                    </div>
                    <h4 class="text-danger text-right" style="text-decoration: underline;">ملحوظة:</h4>
                    <h5 class="text-danger text-right"> إذا قمت بفتح صرف السلفه . لا يمكن الحذف أو التعديل</h5>

                </div>
                <!--Page Widget Error-->

                <form action="{{ route('dashboard.permanentLoan.disbursed_done_now', $info->id) }}" method="POST">
                    {{ csrf_field() }}
                    @method('PUT')
                    <div class="modal-body">
                        <input type="hidden" name="id" value="{{ $info->id }}">
                    </div>
                    <div class="modal-footer mx-auto">
                        <button type="submit" class="btn btn-outline-info">نعم</button>
                        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">لا</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
