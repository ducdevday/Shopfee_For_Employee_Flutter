import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/base_service.dart';
import 'package:shopfeeforemployee/features/login/data/models/login_model.dart';


class LoginService extends BaseService{

  Future<Response> login(LoginModel loginModel) async{
      Map<String, dynamic> body ={
        "username": loginModel.account,
        "password": loginModel.password
      };
      final response = await dio.post("${BaseService.authPath}/employee/login", data: body);
      return response;
  }
}