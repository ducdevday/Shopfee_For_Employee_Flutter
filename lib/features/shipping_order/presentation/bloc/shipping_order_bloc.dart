import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/core/utils/exception_util.dart';
import 'package:shopfeeforemployee/features/shipping_order/domain/entities/shipping_order_entity.dart';
import 'package:shopfeeforemployee/features/shipping_order/domain/usecase/shipping_order_usecase.dart';

part 'shipping_order_event.dart';

part 'shipping_order_state.dart';

class ShippingOrderBloc extends Bloc<ShippingOrderEvent, ShippingOrderState> {
  final ShippingOrderUseCase _shippingOrderUseCase;

  ShippingOrderBloc(this._shippingOrderUseCase)
      : super(ShippingOrderInitial()) {
    on<LoadShippingOrder>(_onLoadShippingOrder);
    on<LoadMoreShippingOrder>(_onLoadMoreShippingOrder);
  }

  FutureOr<void> _onLoadShippingOrder(
      LoadShippingOrder event, Emitter<ShippingOrderState> emit) async {
    emit(ShippingOrderLoading());
    int page = 1;
    int size = 5;
    List<ShippingOrderEntity> orderList = [];
    final response =  await _shippingOrderUseCase
        .getOrderListByStatus(OrderType.SHIPPING,event.orderStatus, page, size);

    response.fold(
        (failure) => {
              if (failure is ServerFailure)
                {emit(ShippingOrderError())}
              else
                ExceptionUtil.handle(failure)
            },
            (resultList) {
      orderList.addAll(resultList);
    });
    emit(ShippingOrderLoaded(orderList: orderList, page: page, size: size));
  }

  FutureOr<void> _onLoadMoreShippingOrder(LoadMoreShippingOrder event, Emitter<ShippingOrderState> emit) async{
    if (state is ShippingOrderLoaded) {
      final currentState = state as ShippingOrderLoaded;
      emit(currentState.copyWith(isLoadMore: true));
      await Future.delayed(Duration(milliseconds: 1000));
      final response = await _shippingOrderUseCase.getOrderListByStatus(
          OrderType.SHIPPING, event.orderStatus, currentState.page + 1, currentState.size);

      response.fold((failure) {
        if (failure is ServerFailure) {
          emit(ShippingOrderError());
        } else {
          ExceptionUtil.handle(failure);
        }
      }, (resultList) {
        if (resultList.isNotEmpty) {
          emit(currentState.copyWith(
              orderList: List.from(currentState.orderList)
                ..addAll(resultList),
              page: currentState.page + 1,
              isLoadMore: false));
        } else {
          emit(currentState.copyWith(cannotLoadMore: true));
        }
      });
    }
  }
}
