import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/core/utils/exception_util.dart';
import 'package:shopfeeforemployee/features/history/domain/entities/history_entity.dart';
import 'package:shopfeeforemployee/features/history/domain/usecase/history_usecase.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryUseCase _historyUseCase;

  HistoryBloc(this._historyUseCase) : super(HistoryInitial()) {
    on<InitHistory>(_onInitHistory);
    on<LoadHistorySucceed>(_onLoadHistorySucceed);
    on<LoadHistoryCanceled>(_onLoadHistoryCanceled);
  }

  FutureOr<void> _onInitHistory(
      InitHistory event, Emitter<HistoryState> emit) async {
    int pageSuccessInit = 1;
    int pageCancelInit = 1;
    int size = 5;
    emit(HistoryLoading());
    final responseHistorySuccess = await _historyUseCase.getHistoryByStatus(
        pageSuccessInit, size, OrderStatus.SUCCEED);

    final responseHistoryCancel = await _historyUseCase.getHistoryByStatus(
        pageCancelInit, size, OrderStatus.CANCELED);

    List<HistoryEntity> historiesSucceed = [];
    List<HistoryEntity> historiesCanceled = [];

    responseHistorySuccess.fold((failure) {
      if (failure is ServerFailure) {
        emit(HistoryError());
      } else {
        ExceptionUtil.handle(failure);
      }
    }, (historyList) {
      historiesSucceed = historyList;
    });

    responseHistoryCancel.fold((failure) {
      if (failure is ServerFailure) {
        emit(HistoryError());
      } else {
        ExceptionUtil.handle(failure);
      }
    }, (historyList) {
      historiesCanceled = historyList;
    });

    emit(HistoryLoaded(
        historiesSucceed: historiesSucceed,
        historiesCanceled: historiesCanceled,
        pageSucceed: pageSuccessInit,
        pageCanceled: pageCancelInit,
        size: size));
  }

  FutureOr<void> _onLoadHistorySucceed(
      LoadHistorySucceed event, Emitter<HistoryState> emit) async {
    if (state is HistoryLoaded) {
      final currentState = state as HistoryLoaded;
      emit(currentState.copyWith(isSucceedLoadMore: true));
      await Future.delayed(Duration(milliseconds: 1000));
      final response = await _historyUseCase.getHistoryByStatus(
          currentState.pageSucceed + 1, currentState.size, OrderStatus.SUCCEED);

      response.fold((failure) {
        if (failure is ServerFailure) {
          emit(HistoryError());
        } else {
          ExceptionUtil.handle(failure);
        }
      }, (historyList) {
        if (historyList.isNotEmpty) {
          emit(currentState.copyWith(
              historiesSucceed: List.from(currentState.historiesSucceed)
                ..addAll(historyList),
              pageSucceed: currentState.pageSucceed + 1,
              isSucceedLoadMore: false));
        } else {
          emit(currentState.copyWith(cannotSucceedLoadMore: true));
        }
      });
    }
  }

  FutureOr<void> _onLoadHistoryCanceled(
      LoadHistoryCanceled event, Emitter<HistoryState> emit) async {
    if (state is HistoryLoaded) {
      final currentState = state as HistoryLoaded;
      emit(currentState.copyWith(isCanceledLoadMore: true));
      await Future.delayed(Duration(milliseconds: 1000));
      final response = await _historyUseCase.getHistoryByStatus(
          currentState.pageCanceled + 1,
          currentState.size,
          OrderStatus.CANCELED);

      response.fold((failure) {
        if (failure is ServerFailure) {
          emit(HistoryError());
        } else {
          ExceptionUtil.handle(failure);
        }
      }, (historyList) {
        if (historyList.isNotEmpty) {
          emit(currentState.copyWith(
              historiesCanceled: List.from(currentState.historiesCanceled)
                ..addAll(historyList),
              pageCanceled: currentState.pageCanceled + 1,
              isCanceledLoadMore: false));
        } else {
          emit(currentState.copyWith(cannotCanceledLoadMore: true));
        }
      });
    }
  }
}
