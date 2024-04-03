abstract class NotificationPermissionRepository {
  Future<String> saveFCMTokenToDB(String? employeeId, String? fcmToken);
}