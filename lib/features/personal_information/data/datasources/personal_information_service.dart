import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/base/base_service.dart';
import 'package:shopfeeforemployee/core/global/global_data.dart';
import 'package:shopfeeforemployee/features/home/data/models/employee_model.dart';
import 'package:shopfeeforemployee/features/home/domain/entities/employee_entity.dart';


class PersonalInformationService extends BaseService{

  Future<Response> updateEmployee(String employeeId, EmployeeEntity employeeEntity) async{
    EmployeeModel employeeModel = EmployeeModel.fromEntity(employeeEntity);
    Map<String, dynamic> body = employeeModel.toJson();
    final response = await dio.put("${BaseService.employeePath}/$employeeId", data: body );
    return response;
  }
}