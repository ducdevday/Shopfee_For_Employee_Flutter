import 'package:json_annotation/json_annotation.dart';
import 'package:shopfeeforemployee/features/login/domain/entities/login_entity.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends LoginEntity {
  const LoginModel({
    account,
    password,
  }) : super(
    account: account,
    password: password
  );

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return _$LoginModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginModelToJson(this);
  }
  factory LoginModel.fromEntity(LoginEntity loginEntity) {
    return LoginModel(
      account: loginEntity.account,
      password: loginEntity.password
    );
  }

}