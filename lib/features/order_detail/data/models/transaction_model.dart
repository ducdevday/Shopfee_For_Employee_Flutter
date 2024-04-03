import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/core/common/models/payment_status.dart';
import 'package:shopfeeforemployee/core/common/models/payment_type.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/transaction_entity.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  final String? id;
  final PaymentStatus? status;
  final PaymentType? paymentType;
  final double? totalPaid;

  const TransactionModel({
    this.id,
    this.status,
    this.paymentType,
    this.totalPaid,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
