import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfeeforemployee/core/config/dimens.dart';
import 'package:shopfeeforemployee/core/config/style.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/features/change_password/presentation/cubit/change_password_cubit.dart';
import 'package:shopfeeforemployee/features/change_password/presentation/widgets/password_field.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.close_rounded),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            ServiceLocator.sl<ChangePasswordCubit>()..initPassword(),
        child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordFinished) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is ChangePasswordLoaded) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: AppDimen.screenPadding,
                    right: AppDimen.screenPadding,
                    bottom: AppDimen.screenPadding),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Change Password",
                          style: AppStyle.largeTitleStyleDark,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "*Password must have greater or equal 6 characters",
                          style: AppStyle.smallTextStyleDark,
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    PasswordField(
                      title: 'Current Password',
                      callback: (String value) {
                        context.read<ChangePasswordCubit>().enterOldPassword(value);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PasswordField(
                      title: 'New Password',
                      callback: (String value) {
                        context.read<ChangePasswordCubit>().enterNewPassword(value);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PasswordField(
                      title: 'Confirm New Password',
                      callback: (String value) {
                        context
                            .read<ChangePasswordCubit>()
                            .enterConfirmPassword(value);
                      },
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimen.screenPadding),
                      child: ElevatedButton(
                        onPressed: state.changePasswordValid
                            ? () {
                                context.read<ChangePasswordCubit>().changePassword();
                              }
                            : null,
                        style: AppStyle.elevatedButtonStylePrimary,
                        child: const Text("Change Password"),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
