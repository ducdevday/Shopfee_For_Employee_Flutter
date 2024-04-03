import 'package:shopfeeforemployee/features/notify_permission/domain/repositories/notification_permission_repository.dart';

abstract class NotificationPermissionUseCase {
  Future<String> saveFCMTokenToDB(String? employeeId, String? fcmToken);
}

class NotificationPermissionUseCaseImpl extends NotificationPermissionUseCase {
  final NotificationPermissionRepository _notificationPermissionRepository;

  NotificationPermissionUseCaseImpl(this._notificationPermissionRepository);

  @override
  Future<String> saveFCMTokenToDB(String? employeeId, String? fcmToken) {
    return _notificationPermissionRepository.saveFCMTokenToDB(
        employeeId, fcmToken);
  }
}
