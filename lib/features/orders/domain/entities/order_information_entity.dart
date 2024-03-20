import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/features/orders/data/models/order_information_model.dart';

class OrderInformationEntity {
  final String id;
  final num total;
  final String customerName;
  final String phoneNumber;
  final String productName;
  final int productQuantity;
  final String thumbnailUrl;
  final OrderStatus statusLastEvent;
  final DateTime timeLastEvent;
  final DateTime? receiveTime;

  const OrderInformationEntity(
      {required this.id,
      required this.total,
      required this.customerName,
      required this.phoneNumber,
      required this.productName,
      required this.productQuantity,
      required this.thumbnailUrl,
      required this.statusLastEvent,
      required this.timeLastEvent,
      this.receiveTime});

  factory OrderInformationEntity.fromModel(OrderInformationModel model) {
    return OrderInformationEntity(
        id: model.id,
        total: model.total,
        customerName: model.customerName,
        phoneNumber: model.phoneNumber,
        productName: model.productName,
        productQuantity: model.productQuantity,
        thumbnailUrl: model.thumbnailUrl,
        statusLastEvent: model.statusLastEvent,
        timeLastEvent: model.timeLastEvent,
        receiveTime: model.receiveTime);
  }
}
