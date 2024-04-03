import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/result.dart';
import 'package:shopfeeforemployee/core/common/models/result_list.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/features/history/data/datasources/history_service.dart';
import 'package:shopfeeforemployee/features/history/data/models/history_model.dart';
import 'package:shopfeeforemployee/features/history/data/models/history_params.dart';
import 'package:shopfeeforemployee/features/history/domain/entities/history_entity.dart';
import 'package:shopfeeforemployee/features/history/domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryService _historyService;

  HistoryRepositoryImpl(this._historyService);

  @override
  Future<List<HistoryEntity>> getHistoryByStatus(
      HistoryParams params, OrderStatus status) async {
    final response = await _historyService.getHistoryStatus(params, status);
    final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"]);
    final historyJsonList = result.data!["orderList"] as List<dynamic>;
    List<HistoryModel> historyModelList =
        historyJsonList.map((e) => HistoryModel.fromJson(e)).toList();
    List<HistoryEntity> historyEntityList =
        historyModelList.map((e) => HistoryEntity.fromModel(e)).toList();
    return historyEntityList;
  }
}
