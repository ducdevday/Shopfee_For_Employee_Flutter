import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfeeforemployee/core/utils/exception_util.dart';
import 'package:shopfeeforemployee/core/utils/pdf_util.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_detail_entity.dart';
import 'package:shopfeeforemployee/features/pos/domain/entities/order_bill_entity.dart';
import 'package:shopfeeforemployee/features/pos/domain/usecase/pdf_generator.dart';

part 'pos_state.dart';

class PosCubit extends Cubit<PosState> {
  PosCubit() : super(PosInitial());

  void getOrderBillPdf(OrderDetailEntity orderDetail) async {
    try {
      EasyLoading.show();
      final orderBillEntity =
          OrderBillEntity.fromOrderDetailEntity(orderDetail);
      final orderBillPdf = await PdfGenerator.generate(orderBillEntity);
      emit(PosLoadSuccess(orderBillPdf: orderBillPdf));
      EasyLoading.dismiss();
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  void printOrderBillPdf() async {
    try {
      if (state is PosLoadSuccess) {
        final currentState = state as PosLoadSuccess;
        await PdfUtil.printDocument(file: currentState.orderBillPdf);
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

}
