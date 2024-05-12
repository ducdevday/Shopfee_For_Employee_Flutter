import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfeeforemployee/core/utils/exception_util.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_detail_entity.dart';
import 'package:shopfeeforemployee/features/pos/domain/entities/order_bill_entity.dart';
import 'package:shopfeeforemployee/features/pos/domain/usecase/pdf_generator.dart';

part 'pos_state.dart';

class PosCubit extends Cubit<PosState> {
  PosCubit() : super(PosInitial());


  void getOrderBillPdf(OrderDetailEntity orderDetail) async{
    try{
      final orderBillEntity = OrderBillEntity.fromOrderDetailEntity(orderDetail);
      final orderBillPdf = await PdfGenerator.generate(orderBillEntity);
      emit(PosLoadSuccess(orderBillPdf: orderBillPdf));
    }
    catch(e){
      ExceptionUtil.handle(e);
    }
  }
}
