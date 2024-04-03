import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/core/common/extension/order_status_extension.dart';
import 'package:shopfeeforemployee/features/orders/domain/entities/order_params_entity.dart';

part 'order_params_model.g.dart';

@JsonSerializable()
class OrderParamsModel {
  final String orderType;
  final String orderStatus;
  final int page;
  final int size;

  const OrderParamsModel({
    required this.orderType,
    required this.orderStatus,
    required this.page,
    required this.size,
  });

  factory OrderParamsModel.fromEntity(OrderParamsEntity entity) {
    return OrderParamsModel(
        orderType: entity.orderType.name,
        orderStatus: entity.orderStatus.name,
        page: entity.page,
        size: entity.size);
  }

  factory OrderParamsModel.fromJson(Map<String, dynamic> json) {
    return _$OrderParamsModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderParamsModelToJson(this);
  }
}
