part of account;

class AccountPage extends StatelessWidget {
  static const String route = "/account";

  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Image.asset(AppPath.imgAccountBackground),
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
                BlocBuilder<EmployeeBloc, EmployeeState>(
                  builder: (context, state) {
                    if (state is EmployeeLoadSuccess) {
                      return Align(
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
                                        AppPath.imgDefaultAvatar,
                                      ))),
                            ),
                            Text(
                              state.employee.fullName,
                              style: AppStyle.largeTitleStyleDark
                                  .copyWith(height: 2),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Align(
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
                                        AppPath.imgDefaultAvatar,
                                      ))),
                            ),
                            Text(
                              "",
                              style: AppStyle.largeTitleStyleDark
                                  .copyWith(height: 2),
                            )
                          ],
                        ),
                      );
                    }
                  },
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
                                    PersonalInformationPage.route,
                                  );
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
                                  Navigator.pushNamed(
                                      context, ChangePasswordPage.route);
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Activity",
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
                                iconData: Icons.show_chart,
                                content: "Statistics",
                                callback: () {
                                  NavigationUtil.pushNamed(
                                      StatisticsPage.route);
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
                                showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) =>
                                        MyConfirmDialog(
                                          title: "Confirm",
                                          content: "Are you sure to Log out",
                                          callbackOK: () {
                                            context
                                                .read<EmployeeBloc>()
                                                .add(EmployeeLogout());
                                            NavigationUtil
                                                .pushNamedAndRemoveUntil(
                                                    LoginPage.route);
                                            // Navigator.pop(dialogContext);
                                          },
                                          callbackCancel: () {
                                            Navigator.pop(dialogContext);
                                          },
                                          confirmText: "Log out",
                                        ));
                              },
                              icon: const Icon(Icons.logout_rounded),
                              label: const Text("Log out"),
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 24),
                                  disabledBackgroundColor:
                                      const Color(0xffCACACA),
                                  disabledForegroundColor: AppColor.lightColor,
                                  textStyle: AppStyle.mediumTextStyleDark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
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
  }
}
