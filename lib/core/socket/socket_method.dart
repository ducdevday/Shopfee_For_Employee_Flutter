import 'package:socket_io_client/socket_io_client.dart';

import 'socket_client.dart';

class SocketMethod {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  //! emitter
  void joinBranch({required String branchId}) {
    _socketClient.emit(
      'joinBranch',
      branchId,
    );
  }

  void updateOrder({required String userId, required String orderId}) {
    _socketClient
        .emit('employee_update_order', {"userId": userId, "orderId": orderId});
  }

  void updateOrderSameBranch(
      {required String branchId, required String orderId}) {
    _socketClient.emit('employee_update_order_same_branch',
        {"branchId": branchId, "orderId": orderId});
  }

  //! listeners
  void userCreateOrderListener(Function(dynamic) callback) {
    _socketClient.on(
      'user_create_order',
      (data) {
        callback(data);
      },
    );
  }

  void userUpdateOrderListener(Function(dynamic) callback) {
    _socketClient.on(
      'user_update_order',
      (data) {
        callback(data);
      },
    );
  }

  void employeeUpdateOrderSameBranchListener(Function(dynamic) callback) {
    _socketClient.on('employee_update_order_same_branch', (data) {
      callback(data);
    });
  }
}
