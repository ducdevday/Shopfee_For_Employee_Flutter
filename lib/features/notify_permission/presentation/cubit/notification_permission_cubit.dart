part of notify_permission;

class NotificationPermissionCubit extends Cubit<NotificationPermissionState> {
  final NotificationPermissionUseCase _notificationPermissionUseCase;

  NotificationPermissionCubit(this._notificationPermissionUseCase)
      : super(NotificationPermissionInitial());

  Future<void> saveFCMTokenToDB() async {
    try {
      final employeeId = SharedService.getEmployeeId();
      final fcmToken = await PushNotificationService.getFCMToken();
      final fcmTokenId = await _notificationPermissionUseCase.saveFCMTokenToDB(
          employeeId, fcmToken);
      SharedService.setFCMTokenId(fcmTokenId);
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
