// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      id: json['id'] as String,
      status: $enumDecode(_$PaymentStatusEnumMap, json['status']),
      type: $enumDecode(_$PaymentTypeEnumMap, json['paymentType']),
      totalPaid: (json['totalPaid'] as num).toDouble(),
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'totalPaid': instance.totalPaid,
      'paymentType': instance.type,
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.PAID: 'PAID',
  PaymentStatus.UNPAID: 'UNPAID',
  PaymentStatus.REFUNDED: 'REFUNDED',
};

const _$PaymentTypeEnumMap = {
  PaymentType.CASHING: 'CASHING',
  PaymentType.BANKING: 'BANKING',
};
