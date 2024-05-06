import 'package:shopfeeforemployee/features/order_detail/data/models/discount_information_model.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/product_reward_entity.dart';

class DiscountInformationEntity {
  final double? orderDiscount;
  final double? shippingDiscount;
  final List<ProductRewardEntity>? productGiftList;

  const DiscountInformationEntity({
    this.orderDiscount,
    this.shippingDiscount,
    this.productGiftList,
  });

  factory DiscountInformationEntity.fromModel(DiscountInformationModel model) {
    return DiscountInformationEntity(
      orderDiscount: model.orderDiscount,
      shippingDiscount: model.shippingDiscount,
      productGiftList: model.productGiftList
          ?.map((e) => ProductRewardEntity.fromModel(e))
          .toList(),
    );
  }
}
