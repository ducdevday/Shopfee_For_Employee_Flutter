import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/dimens.dart';
import 'package:shopfeeforemployee/core/config/style.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/core/router/app_router.dart';
import 'package:shopfeeforemployee/features/account/presentation/bloc/account_bloc.dart';
import 'package:shopfeeforemployee/features/account/presentation/widgets/setting_item.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceLocator.sl<AccountBloc>()..add(LoadAccount()),
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoaded) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Theme.of(context).canvasColor,
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.asset("assets/images/img_profile_background.png"),
                        Positioned(
                          top: 30,
                          left: 20,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 200),
                                width: 110,
                                height: 110,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          "assets/images/img_default_user.png",
                                        ))),
                              ),
                              Text(
                                state.employeeEntity.fullName,
                                style: AppStyle.largeTitleStyleDark
                                    .copyWith(height: 2),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimen.screenPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Account",
                                  style: AppStyle.mediumTitleStyleDark,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Column(
                                    children: [
                                      SettingItem(
                                        iconData: Icons.account_circle_outlined,
                                        content: "Personal Information",
                                        callback: () {
                                          Navigator.pushNamed(
                                            context,
                                            AppRouter.personalInformationRoute,
                                          ).then((value) => context
                                              .read<AccountBloc>()
                                              .add(LoadAccount()));
                                        },
                                      ),
                                      const Divider(
                                        height: 1,
                                        indent: 8,
                                      ),
                                      SettingItem(
                                        iconData: Icons.vpn_key_outlined,
                                        content: "Change Password",
                                        callback: () {
                                          Navigator.pushNamed(context,
                                              AppRouter.changePasswordRoute);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Container(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        context
                                            .read<AccountBloc>()
                                            .add(LogoutAccount());
                                      },
                                      icon: const Icon(Icons.logout_rounded),
                                      label: const Text("Log out"),
                                      style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 24),
                                          disabledBackgroundColor:
                                              const Color(0xffCACACA),
                                          disabledForegroundColor:
                                              AppColor.lightColor,
                                          textStyle:
                                              AppStyle.mediumTextStyleDark,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          )),
                                    )))
                          ],
                        ),
                      ),
                    )
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
