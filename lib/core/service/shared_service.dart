import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static late SharedPreferences _pref;

  static init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static String getAppDocPath() {
    return _pref.getString("appDocPath") ?? "";
  }

  static void setAppDocPath(String appDocPath) {
    _pref.setString("appDocPath", appDocPath);
  }

  static bool getIsFirstTime() {
    return _pref.getBool("isFirstTime") ?? true;
  }

  static void setIsFirstTime(bool isFirstTime) {
    _pref.setBool("isFirstTime", isFirstTime);
  }

  static String? getEmployeeId() {
    return _pref.getString("employeeId");
  }

  static void setEmployeeId(String employeeId) {
    _pref.setString("employeeId", employeeId);
  }

  static void removeEmployeeId() {
    _pref.remove("employeeId");
  }

  static String? getAccessToken() {
    return _pref.getString("accessToken");
  }

  static void setAccessToken(String accessToken) {
    _pref.setString("accessToken", accessToken);
  }

  static void removeAccessToken() {
    _pref.remove("accessToken");
  }

  static void setToken(
      String employeeId, String accessToken, String refreshToken) {
    setEmployeeId(employeeId);
    setAccessToken(accessToken);
  }

  static void clearToken() {
    removeEmployeeId();
    removeAccessToken();
  }
}
