import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/core/common/models/payment_status.dart';
import 'package:shopfeeforemployee/core/common/models/payment_type.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/transaction_entity.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel extends TransactionEntity {

  @override
  @JsonKey(name: "paymentType")
  final PaymentType type;
  TransactionModel({required String id,required PaymentStatus status,required this.type,required double totalPaid})
      : super(id: id, status: status, type: type, totalPaid: totalPaid);

  factory TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
