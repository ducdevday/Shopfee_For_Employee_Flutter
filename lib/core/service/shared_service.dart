import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static late SharedPreferences _pref;

  static init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static void setIsFirstTime(bool isFirstTime){
    _pref.setBool("isFirstTime", isFirstTime);
  }

  static void setEmployeeId(String employeeId){
    _pref.setString("employeeId", employeeId);
  }

  static void setAccessToken(String accessToken){
    _pref.setString("accessToken", accessToken);
  }

  static void setRefreshToken(String refreshToken){
    _pref.setString("refreshToken", refreshToken);
  }

  static bool? getIsFirstTime(){
    return _pref.getBool("isFirstTime");
  }

  static String? getEmployeeId(){
    return _pref.getString("employeeId");
  }

  static String? getAccessToken(){
    return _pref.getString("accessToken");
  }

  static String? getRefreshToken(){
    return _pref.getString("accessToken");
  }

  static void removeEmployeeId(){
    _pref.remove("employeeId");
  }

  static void removeAccessToken(){
    _pref.remove("accessToken");
  }

  static void removeRefreshToken(){
    _pref.remove("refreshToken");
  }
}