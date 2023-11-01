import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/core/utils/exception_util.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_detail_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/usecase/order_detail_usecase.dart';

part 'order_detail_event.dart';

part 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final OrderDetailUseCase _orderDetailUseCase;

  OrderDetailBloc(this._orderDetailUseCase) : super(OrderDetailInitial()) {
    on<LoadOrderDetail>(_onLoadOrderDetail);
  }

  FutureOr<void> _onLoadOrderDetail(
      LoadOrderDetail event, Emitter<OrderDetailState> emit) async {
    emit(OrderDetailLoading());
    final response = await _orderDetailUseCase.getOrderDetail(event.id);
    response.fold((failure) {
      if (failure is ServerFailure) {
        emit(OrderDetailError());
        return;
      }
      ExceptionUtil.handle(failure);
    },
        (orderDetailEntity) =>
            emit(OrderDetailLoaded(orderDetailEntity: orderDetailEntity)));
  }
}
