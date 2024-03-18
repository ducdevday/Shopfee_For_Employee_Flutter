import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/dio_service.dart';
import 'package:shopfeeforemployee/features/login/data/models/login_model.dart';

class LoginService {
  Future<Response> login(LoginModel loginModel) async {
    Map<String, dynamic> body = loginModel.toJson();
    final response =
        await DioService.instance.post("${DioService.authPath}/login", data: body);
    return response;
  }
}
