import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/base_service.dart';


class TemplateService extends BaseService{

  Future<Response> doSomeThing(String query) async{
      final response = await dio.get("path");
      return response;
  }
}