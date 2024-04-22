// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailModel _$OrderDetailModelFromJson(Map<String, dynamic> json) =>
    OrderDetailModel(
      id: json['id'] as String?,
      note: json['note'] as String?,
      totalPayment: json['totalPayment'] as num?,
      shippingFee: json['shippingFee'] as num?,
      totalItemPrice: json['totalItemPrice'] as num?,
      orderType: $enumDecodeNullable(_$OrderTypeEnumMap, json['orderType']),
      receiverInformation: json['receiverInformation'] == null
          ? null
          : ReceiverInformationModel.fromJson(
              json['receiverInformation'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      itemList: (json['itemList'] as List<dynamic>?)
          ?.map((e) => OrderProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      transaction: json['transaction'] == null
          ? null
          : TransactionModel.fromJson(
              json['transaction'] as Map<String, dynamic>),
      branch: json['branch'] == null
          ? null
          : BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
      coin: json['coin'] as int?,
      refundRequestStatus: $enumDecodeNullable(
          _$RefundRequestStatusEnumMap, json['refundStatus']),
    )..discountInformation = json['rewardInformation'] == null
        ? null
        : DiscountInformationModel.fromJson(
            json['rewardInformation'] as Map<String, dynamic>);

Map<String, dynamic> _$OrderDetailModelToJson(OrderDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'note': instance.note,
      'totalPayment': instance.totalPayment,
      'shippingFee': instance.shippingFee,
      'totalItemPrice': instance.totalItemPrice,
      'orderType': instance.orderType,
      'receiverInformation': instance.receiverInformation,
      'createdAt': instance.createdAt?.toIso8601String(),
      'itemList': instance.itemList,
      'rewardInformation': instance.discountInformation,
      'transaction': instance.transaction,
      'branch': instance.branch,
      'coin': instance.coin,
      'refundStatus':
          _$RefundRequestStatusEnumMap[instance.refundRequestStatus],
    };

const _$OrderTypeEnumMap = {
  OrderType.SHIPPING: 'SHIPPING',
  OrderType.ONSITE: 'ONSITE',
};

const _$RefundRequestStatusEnumMap = {
  RefundRequestStatus.CAN_REFUND: 'CAN_REFUND',
  RefundRequestStatus.REFUNDED: 'REFUNDED',
  RefundRequestStatus.NOT_REFUND: 'NOT_REFUND',
};
