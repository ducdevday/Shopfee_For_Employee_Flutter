part of 'change_password_cubit.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();
}

class ChangePasswordInitial extends ChangePasswordState {
  @override
  List<Object> get props => [];
}

class ChangePasswordLoaded extends ChangePasswordState {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  @override
  List<Object> get props => [oldPassword, newPassword, confirmPassword];

  const ChangePasswordLoaded({
    this.oldPassword = "",
    this.newPassword = "",
    this.confirmPassword = "",
  });

  bool get oldPasswordValid =>
      oldPassword.isNotEmpty && oldPassword.length >= 6;

  bool get newPasswordValid =>
      newPassword.isNotEmpty && newPassword.length >= 6;

  bool get confirmPasswordValid =>
      confirmPassword.isNotEmpty && confirmPassword.length >= 6;

  bool get changePasswordValid =>
      oldPasswordValid && newPasswordValid && confirmPasswordValid;

  ChangePasswordLoaded copyWith({
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
  }) {
    return ChangePasswordLoaded(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}

class ChangePasswordFinished extends ChangePasswordState {
  @override
  List<Object> get props => [];
}