import 'dart:io';

import 'package:path_provider/path_provider.dart';
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

  static String? getBranchId() {
    return _pref.getString("branchId");
  }

  static void setBranchId(String branchId) {
    _pref.setString("branchId", branchId);
  }

  static void removeBranchId() {
    _pref.remove("branchId");
  }

  static String? getFCMTokenId(){
    return _pref.getString("fcmTokenId");
  }

  static void setFCMTokenId(String fcmTokenId) {
    _pref.setString("fcmTokenId", fcmTokenId);
  }

  static void removeFCMTokenId() {
    _pref.remove("fcmTokenId");
  }

  static void setToken(
      String employeeId, String accessToken, String branchId) {
    setEmployeeId(employeeId);
    setAccessToken(accessToken);
    setBranchId(branchId);
  }

  static void clearToken() {
    removeEmployeeId();
    removeAccessToken();
    removeBranchId();
  }

  static Future<void> initAppDocPath() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    SharedService.setAppDocPath(appDocPath);
  }
}
