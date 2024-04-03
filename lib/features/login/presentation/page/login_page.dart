part of login;

class LoginPage extends StatefulWidget {
  static const String route = "/login";

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginCubit _cubit;
  late final TextEditingController accountTextController;
  late final TextEditingController passwordTextController;

  @override
  void initState() {
    super.initState();
    _cubit = ServiceLocator.sl<LoginCubit>();
    accountTextController = TextEditingController();
    passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _cubit.close();
    accountTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  String? getErrorText(
    String text,
    FieldType type,
  ) {
    if (type == FieldType.account && !ValidateFieldUtil.validateAccount(text)) {
      return "Account is not valid";
    } else if (type == FieldType.password &&
        !ValidateFieldUtil.validatePassword(text)) {
      return "Password must have greater or equal 6 digits";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              NavigationUtil.pushNamedAndRemoveUntil(HomePage.route);
            }
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(AppDimen.screenPadding),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        Image.asset(
                          AppPath.imgLogo1,
                          width: 219.5,
                          height: 200,
                        ),
                        AccountInputField(
                          title: "Account",
                          hint: "Input Your Account",
                          validateField: (String value) =>
                              getErrorText(value, FieldType.account),
                          controller: accountTextController,
                          useFocus: false,
                        ),
                        const SizedBox(
                          height: AppDimen.spacing,
                        ),
                        PasswordInputField(
                          title: "Password",
                          hint: "Input Your Password",
                          validateField: (String value) =>
                              getErrorText(value, FieldType.password),
                          controller: passwordTextController,
                          useFocus: false,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppDimen.mediumPadding,
                    ),
                    Container(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            formKey.currentState?.validate();
                            _cubit.doLogin(accountTextController.text,
                                passwordTextController.text);
                          },
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
            ),
          ),
        ),
      ),
    );
  }
}
