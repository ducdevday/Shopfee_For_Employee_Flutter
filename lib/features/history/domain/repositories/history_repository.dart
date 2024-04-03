import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/features/history/data/models/history_params.dart';
import 'package:shopfeeforemployee/features/history/domain/entities/history_entity.dart';

abstract class HistoryRepository {
  Future<List<HistoryEntity>> getHistoryByStatus(
      HistoryParams params, OrderStatus status);
}
