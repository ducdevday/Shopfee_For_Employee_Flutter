import 'package:shopfeeforemployee/core/common/models/payment_status.dart';
import 'package:shopfeeforemployee/core/common/models/payment_type.dart';

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
}
