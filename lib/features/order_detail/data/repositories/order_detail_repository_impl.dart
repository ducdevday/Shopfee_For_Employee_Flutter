import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/common/models/no_response.dart';
import 'package:shopfeeforemployee/core/common/models/result.dart';
import 'package:shopfeeforemployee/core/common/models/result_list.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/features/order_detail/data/datasources/order_detail_service.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/event_log_model.dart';
import 'package:shopfeeforemployee/features/order_detail/data/models/order_detail_model.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/entities/event_log_entity.dart';
import 'package:shopfeeforemployee/features/order_detail/domain/repositories/order_detail_repository.dart';

class OrderDetailRepositoryImpl implements OrderDetailRepository {
  final OrderDetailService _orderDetailService;

  OrderDetailRepositoryImpl(this._orderDetailService);

  @override
  Future<Either<Failure, OrderDetailModel>> getOrderDetail(String orderId) async {
    try {
      final response = await _orderDetailService.getOrderDetail(orderId);
      final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"]
      );
      if (result.success) {
        final orderDetailModel = OrderDetailModel.fromJson(result.data!);
        return Right(orderDetailModel);
      }
      return Left(ServerFailure(isNotLoaded: true));
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionError) {
          return Left(NetworkFailure());
        }
        return Left(UnknownFailure());
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<EventLogEntity>>> getEventLogs(String orderId) async{
    try {
      final response = await _orderDetailService.getEventLogs(orderId);
      final result = ResultList(
          success: response.data["success"],
          message: response.data["message"],
          data: response.data["data"]
      );
      if (result.success) {
        final eventLogs = result.data!.map((e) => EventLogModel.fromJson(e)).toList();
        return Right(eventLogs);
      }
      return Left(ServerFailure(isNotLoaded: true));
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionError) {
          return Left(NetworkFailure());
        }
        return Left(UnknownFailure());
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, NoResponse>> addEventLog(String orderId, EventLogEntity eventLog) async {
    try {
      final response = await _orderDetailService.addEventLog(orderId, EventLogModel.fromEntity(eventLog));
      final result = Result(
          success: response.data["success"],
          message: response.data["message"],
      );
      if (result.success) {
        return Right(NoResponse());
      }
      return Left(ServerFailure());
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionError) {
          return Left(NetworkFailure());
        }
        return Left(UnknownFailure());
      }
      return Left(UnknownFailure());
    }
  }

}
