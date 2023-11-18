import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/payment_status.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/core/utils/exception_util.dart';
import 'package:shopfeeforemployee/core/utils/navigation_util.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/event_log_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_detail_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/usecase/order_detail_usecase.dart';

part 'order_detail_event.dart';

part 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final OrderDetailUseCase _orderDetailUseCase;

  OrderDetailBloc(this._orderDetailUseCase) : super(OrderDetailInitial()) {
    on<LoadOrderDetail>(_onLoadOrderDetail);
    on<AddEventLog>(_onAddEventLogs);
    on<ChooseReasonCancel>(_onChooseReasonCancel);
  }

  FutureOr<void> _onLoadOrderDetail(
      LoadOrderDetail event, Emitter<OrderDetailState> emit) async {
    emit(OrderDetailLoading());
    late OrderDetailEntity orderDetail;
    late List<EventLogEntity> eventLogs;

    final responseOrderDetail =
        await _orderDetailUseCase.getOrderDetail(event.id);
    final responseEventLogs = await _orderDetailUseCase.getEventLogs(event.id);

    responseOrderDetail.fold((failure) {
      if (failure is ServerFailure) {
        emit(OrderDetailError());
        return;
      }
      ExceptionUtil.handle(failure);
    }, (orderDetailEntity) {
      orderDetail = orderDetailEntity;
    });

    responseEventLogs.fold((failure) {
      if (failure is ServerFailure) {
        emit(OrderDetailError());
        return;
      }
      ExceptionUtil.handle(failure);
    }, (eventLogList) {
      eventLogs = eventLogList;
    });

    emit(OrderDetailLoaded(orderDetail: orderDetail, eventLogs: eventLogs));
  }

  FutureOr<void> _onAddEventLogs(
      AddEventLog event, Emitter<OrderDetailState> emit) async {
    if (state is OrderDetailLoaded) {
      final currentState = state as OrderDetailLoaded;
      String fcmToken = "";
      EasyLoading.show();

      final responseFCM = await _orderDetailUseCase
          .getFCMToken(currentState.orderDetail.userId!);
      responseFCM.fold((failure) => ExceptionUtil.handle(failure), (value) {
        fcmToken = value;
      });

      final response =
          await _orderDetailUseCase.addEventLog(event.id, event.eventLog);
      EasyLoading.dismiss();

      response.fold((failure) => ExceptionUtil.handle(failure), (_) {
        emit(currentState.copyWith(
            eventLogs: List.from(currentState.eventLogs)..add(event.eventLog)));
        if (event.eventLog.orderStatus != OrderStatus.CANCELED) {
          EasyLoading.showSuccess("Success",
              duration: Duration(milliseconds: 2000));
        } else {
          EasyLoading.showSuccess("Canceled",
              duration: Duration(milliseconds: 2000));
        }
      });

      final responseNotify = await _orderDetailUseCase.sendOrderMessage(
          event.eventLog.orderStatus, event.id, fcmToken);

      responseNotify.fold((failure) => ExceptionUtil.handle(failure), (_) {});

      if (event.eventLog.orderStatus == OrderStatus.SUCCEED &&
          currentState.orderDetail.transaction!.status ==
              PaymentStatus.UNPAID) {
        final responseTransaction = await _orderDetailUseCase
            .completeTransaction(currentState.orderDetail.transaction!.id!);
        responseTransaction.fold(
            (failure) => ExceptionUtil.handle(failure), (_) {});
      }
    }
  }

  FutureOr<void> _onChooseReasonCancel(
      ChooseReasonCancel event, Emitter<OrderDetailState> emit) {
    if (state is OrderDetailLoaded) {
      final currentState = state as OrderDetailLoaded;
      emit(currentState.copyWith(reasonCancel: event.reason));
    }
  }
}
