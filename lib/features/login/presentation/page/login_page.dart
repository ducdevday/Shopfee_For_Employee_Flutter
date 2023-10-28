import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/dimens.dart';
import 'package:shopfeeforemployee/core/config/style.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/features/login/presentation/cubit/login_cubit.dart';
import 'package:shopfeeforemployee/features/login/presentation/widgets/login_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceLocator.sl<LoginCubit>()..initField(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFinished) {
            Navigator.pushNamedAndRemoveUntil(
                context, "/home", (route) => false);
          }
        },
        builder: (context, state) {
          if (state is LoginLoaded) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                padding: const EdgeInsets.all(AppDimen.screenPadding),
                child: Column(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        Image.asset(
                          "assets/images/img_logo_one.png",
                          width: 219.5,
                          height: 200,
                        ),
                        InputField(
                          title: "Account",
                          hint: "Input Your account",
                          callback: (String value) {
                            context.read<LoginCubit>().enterAccount(value);
                          },
                        ),
                        const SizedBox(
                          height: AppDimen.spacing,
                        ),
                        InputField(
                          title: "Password",
                          hint: "Input Your Password",
                          isPassword: true,
                          callback: (String value) {
                            context.read<LoginCubit>().enterPassword(value);
                          },
                        ),
                      ],
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Container(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state.isValid()
                              ? () {
                                  context.read<LoginCubit>().doLogin();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                              disabledBackgroundColor: const Color(0xffCACACA),
                              disabledForegroundColor: AppColor.lightColor,
                              textStyle: AppStyle.mediumTextStyleDark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              )),
                          child: const Text("Login"),
                        )),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
