import 'package:shopfeeforemployee/features/order_detail/domain/entities/order_product_detail_entity.dart';

class OrderItemEntity{
  String productId;
  String name;
  OrderProductDetailEntity itemDetail;

  OrderItemEntity({
    required this.productId,
    required this.name,
    required this.itemDetail,
  });
}