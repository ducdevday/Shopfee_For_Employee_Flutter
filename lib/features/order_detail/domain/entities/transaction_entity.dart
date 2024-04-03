import 'package:shopfeeforemployee/core/common/models/payment_status.dart';
import 'package:shopfeeforemployee/core/common/models/payment_type.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/transaction_model.dart';

class TransactionEntity {
  final String? id;
  final PaymentStatus? status;
  final PaymentType? type;
  final double? totalPaid;

  const TransactionEntity({
    required this.id,
    required this.status,
    required this.type,
    required this.totalPaid,
  });

  TransactionEntity copyWith({
    String? id,
    PaymentStatus? status,
    PaymentType? type,
    double? totalPaid,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      status: status ?? this.status,
      type: type ?? this.type,
      totalPaid: totalPaid ?? this.totalPaid,
    );
  }

  factory TransactionEntity.fromModel(TransactionModel model) {
    return TransactionEntity(
        id: model.id,
        status: model.status,
        type: model.paymentType,
        totalPaid: model.totalPaid);
  }
}
