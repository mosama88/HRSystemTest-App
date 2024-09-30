<!-- End Modal effects-->
<div class="modal" id="editIsClose{{ $info->id }}">

    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content tx-size-sm">
            <div class="modal-body tx-center pd-y-20 pd-x-20">
                <button aria-label="Close" class="close" data-dismiss="modal" type="button"><span
                        aria-hidden="true">&times;</span></button> <i
                    class="icon icon ion-ios-close-circle-outline tx-100 tx-danger lh-1 mg-t-20 d-inline-block"></i>
                <h4 class="tx-danger mg-b-20">إحذر: ستقوم بأرشفة الشهر الحالى <span class="text-primary">( {{ $info->month->name ?? 'غير محدد' }} )</span> 
                    !</h4>


                <h5 class="col-12 text-right mb-3" style="line-height:1.5;"><i
                        class="fas fa-exclamation-triangle text-warning"></i> ملحوظه: لا يمكن حذف او تعديل او فتح مرتبات
                    بعد غلق الشهر المالى</h5>
                <h4 class="tx-danger mg-b-20">هل تريد غلق وأرشفه الشهر المالى الأن !</h4>

                <form action="{{ route('dashboard.salaryRecords.editIsClose', $info->id) }}" method="POST">
                    @csrf
                    @method('PUT')
                    <div class="modal-body">
                        <input type="hidden" name="id" value="{{ $info->id }}">

                        <div class="table-responsive mt-3">
                            <table class="table table-bordered table-striped table-hover">
                                <thead class="thead-light">
                                    <tr>
                                        <th>اسم الشهر </th>
                                        <th>سنة</th>
                                        <th>تاريخ البداية</th>
                                        <th>تاريخ النهاية</th>
                                        <th>عدد الأيام</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>{{ $info->month->name ?? 'غير محدد' }}</td>
                                        <td>{{ $info->finance_yr ?? 'غير محدد' }}</td>
                                        <td>{{ $info->start_date_m ?? 'غير محدد' }}</td>
                                        <td>{{ $info->end_date_m ?? 'غير محدد' }}</td>
                                        <td>{{ $info->number_of_days ?? 'غير محدد' }}</td>
                                    </tr>

                                </tbody>
                            </table>

                        </div>



                    </div>
                    <div class="modal-footer mx-auto">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">إغلاق</button>
                        <button type="submit" class="btn btn-danger">تأكيد الآرشفه</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
