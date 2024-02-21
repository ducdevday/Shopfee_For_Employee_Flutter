import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/features/history/data/models/history_model.dart';

class HistoryEntity {
  final String id;
  final double total;
  final String customerName;
  final String phoneNumber;
  final String productName;
  final int productQuantity;
  final String thumbnailUrl;
  final OrderType orderType;
  final OrderStatus statusLastEvent;
  final DateTime timeLastEvent;

  const HistoryEntity({
    required this.id,
    required this.total,
    required this.customerName,
    required this.phoneNumber,
    required this.productName,
    required this.productQuantity,
    required this.thumbnailUrl,
    required this.orderType,
    required this.statusLastEvent,
    required this.timeLastEvent,
  });

  factory HistoryEntity.fromModel(HistoryModel model) {
    return HistoryEntity(
        id: model.id,
        total: model.total,
        customerName: model.customerName,
        phoneNumber: model.phoneNumber,
        productName: model.productName,
        productQuantity: model.productQuantity,
        thumbnailUrl: model.thumbnailUrl,
        orderType: model.orderType,
        statusLastEvent: model.statusLastEvent,
        timeLastEvent: model.timeLastEvent);
  }
}
