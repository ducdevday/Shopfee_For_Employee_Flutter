import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
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
  }

  FutureOr<void> _onLoadShippingOrder(
      LoadShippingOrder event, Emitter<ShippingOrderState> emit) async {
    emit(ShippingOrderLoading());
    List<ShippingOrderEntity> createdOrderList = [];
    List<ShippingOrderEntity> acceptedOrderList = [];
    List<ShippingOrderEntity> deliveringOrderList = [];
    // List<ShippingOrderEntity> succeedOrderList = [];
    // List<ShippingOrderEntity> canceledOrderList = [];

    final createdListResponse = await _shippingOrderUseCase
        .getOrderListByStatus(OrderType.SHIPPING, OrderStatus.CREATED);
    final acceptedListResponse = await _shippingOrderUseCase
        .getOrderListByStatus(OrderType.SHIPPING, OrderStatus.ACCEPTED);
    final deliveringListResponse = await _shippingOrderUseCase
        .getOrderListByStatus(OrderType.SHIPPING, OrderStatus.DELIVERING);
    // final succeedListResponse = await _shippingOrderUseCase
    //     .getOrderListByStatus(OrderType.SHIPPING, OrderStatus.SUCCEED);
    // final canceledListResponse = await _shippingOrderUseCase
    //     .getOrderListByStatus(OrderType.SHIPPING, OrderStatus.CANCELED);

    createdListResponse.fold((failure) => ExceptionUtil.handle(failure),
        (orderList) {
      createdOrderList.addAll(orderList);
    });

    acceptedListResponse.fold((failure) => ExceptionUtil.handle(failure),
        (orderList) {
      acceptedOrderList.addAll(orderList);
    });

    deliveringListResponse.fold((failure) => ExceptionUtil.handle(failure),
        (orderList) {
      deliveringOrderList.addAll(orderList);
    });

    // succeedListResponse.fold((failure) => ExceptionUtil.handle(failure),
    //     (orderList) {
    //   succeedOrderList.addAll(orderList);
    // });
    //
    // canceledListResponse.fold((failure) => ExceptionUtil.handle(failure),
    //     (orderList) {
    //   canceledOrderList.addAll(orderList);
    // });

    emit(ShippingOrderLoaded(
        createdOrderList: createdOrderList,
        acceptedOrderList: acceptedOrderList,
        deliveringOrderList: deliveringOrderList,
        // succeedOrderList: succeedOrderList,
        // canceledOrderList: canceledOrderList
    ));
  }
}
