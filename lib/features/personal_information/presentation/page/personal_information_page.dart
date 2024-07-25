part of personal_information;

class PersonalInformationPage extends StatefulWidget {
  static const String route = "/personal_information";

  const PersonalInformationPage({Key? key}) : super(key: key);

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  late final PersonalInformationCubit _cubit;
  late final TextEditingController storeNameTextController;
  late final TextEditingController firstNameTextController;
  late final TextEditingController lastNameTextController;
  late final TextEditingController accountTextController;
  late final TextEditingController emailTextController;
  late final TextEditingController phoneTextController;
  late final ValueNotifier<Gender?> genderListener;
  late final ValueNotifier<DateTime?> birthDayListener;
  late final EmployeeStatus? employeeStatus;
  @override
  void initState() {
    super.initState();
    _cubit = ServiceLocator.sl<PersonalInformationCubit>();

    final employeeState = context.read<EmployeeBloc>().state;
    if (employeeState is EmployeeLoadSuccess) {
      final employee = employeeState.employee;
      storeNameTextController =
          TextEditingController(text: employee.branchName);
      firstNameTextController = TextEditingController(text: employee.firstName);
      lastNameTextController = TextEditingController(text: employee.lastName);
      accountTextController = TextEditingController(text: employee.username);
      emailTextController = TextEditingController(text: employee.email);
      phoneTextController = TextEditingController(text: employee.phoneNumber);
      genderListener = ValueNotifier(employee.gender);
      birthDayListener = ValueNotifier(employee.birthDate);
      employeeStatus = employee.status;
    }
  }

  String? getErrorText(
    String text,
    FieldType type,
  ) {
    checkAllField();
    if (type == FieldType.firstName && !ValidateFieldUtil.validateName(text)) {
      return "First name is not valid";
    } else if (type == FieldType.lastName &&
        !ValidateFieldUtil.validateName(text)) {
      return "Last name is not valid";
    } else if (type == FieldType.phone &&
        !ValidateFieldUtil.validatePhone(text)) {
      return "Phone number is not valid";
    }
    return null;
  }

  void checkAllField(){
    _cubit.checkValidField(
        firstName: firstNameTextController.text,
        lastName: lastNameTextController.text,
        phoneNumber: phoneTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocConsumer<PersonalInformationCubit, PersonalInformationState>(
        listener: (context, state) {
          if (state is PersonalInformationFinished) {
            context.read<EmployeeBloc>().add(EmployeeLoadInformation());
            NavigationUtil.pop();
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text("Update Information"),
              centerTitle: true,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: Divider(height: 1),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimen.screenPadding,
                  vertical: AppDimen.spacing),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                Container(
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
                                // Container(
                                //     margin: const EdgeInsets.only(
                                //         top: 85, left: 75),
                                //     padding: const EdgeInsets.all(4),
                                //     decoration: BoxDecoration(
                                //         color: Colors.white,
                                //         shape: BoxShape.circle,
                                //         border: Border.fromBorderSide(
                                //             BorderSide(
                                //                 color:
                                //                     AppColor.nonactiveColor))),
                                //     child: const Icon(
                                //       Icons.camera_alt,
                                //       size: 16,
                                //     )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: NameInputField(
                                  title: "First Name",
                                  hint: "Input Your First Name",
                                  validateField: (String value) =>
                                      getErrorText(value, FieldType.firstName),
                                  controller: firstNameTextController,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: NameInputField(
                                  title: "Last Name",
                                  hint: "Input Your Last Name",
                                  validateField: (String value) =>
                                      getErrorText(value, FieldType.lastName),
                                  controller: lastNameTextController,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: AppDimen.spacing,
                          ),
                          AccountInputField(
                            title: "Account",
                            hint: "Input Your Account",
                            validateField: (String value) =>
                                getErrorText(value, FieldType.account),
                            controller: accountTextController,
                            isEnable: false,
                          ),
                          const SizedBox(
                            height: AppDimen.spacing,
                          ),
                          EmailInputField(
                            title: "Email",
                            hint: "Input Your Email",
                            validateField: (String value) =>
                                getErrorText(value, FieldType.email),
                            controller: emailTextController,
                            isEnable: false,
                          ),
                          const SizedBox(
                            height: AppDimen.spacing,
                          ),
                          PhoneInputField(
                            title: "Phone Number",
                            hint: "Input Your Phone Number",
                            validateField: (String value) =>
                                getErrorText(value, FieldType.phone),
                            controller: phoneTextController,
                          ),
                          const SizedBox(
                            height: AppDimen.spacing,
                          ),
                          TextInputField(
                            title: "Store",
                            hint: "Input Your Store",
                            validateField: (String value) =>
                                getErrorText(value, FieldType.address),
                            controller: storeNameTextController,
                            isEnable: false,
                          ),
                          const SizedBox(
                            height: AppDimen.spacing,
                          ),
                          ValueListenableBuilder(
                            valueListenable: birthDayListener,
                            builder: (BuildContext context, DateTime? birthDate,
                                Widget? child) {
                              checkAllField();
                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Birthday",
                                      style: AppStyle.normalTextStyle.copyWith(
                                          color: const Color(0xff3C3C3C)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () async {
                                      buildBirthDayPicker(birthDate);
                                    },
                                    child: TextField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        label: Text(
                                            FormatUtil.formatBirthDay(
                                                birthDate),
                                            style: AppStyle.normalTextStyle
                                                .copyWith(
                                                    color: const Color(
                                                        0xff3C3C3C))),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 12),
                                        suffixIcon: const Icon(
                                            Icons.calendar_month_outlined),
                                        disabledBorder:
                                            AppStyle.outlineInputBorderDefault,
                                        hintText: "Choose your birthday",
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(
                            height: AppDimen.spacing,
                          ),
                          ValueListenableBuilder(
                            valueListenable: genderListener,
                            builder: (BuildContext context, Gender? gender,
                                Widget? child) {
                              checkAllField();
                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Gender",
                                      style: AppStyle.normalTextStyle.copyWith(
                                          color: const Color(0xff3C3C3C)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      buildGenderPopup(context);
                                    },
                                    child: TextField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        label: Text(gender?.name ?? "",
                                            style: AppStyle.normalTextStyle
                                                .copyWith(
                                                    color: const Color(
                                                        0xff3C3C3C))),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 12),
                                        suffixIcon:
                                            const Icon(Icons.arrow_drop_down),
                                        disabledBorder:
                                            AppStyle.outlineInputBorderDefault,
                                        hintText: "Choose your gender",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                          width: double.infinity,
                          child: BlocBuilder<PersonalInformationCubit,
                              PersonalInformationState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: state is! PersonalInformationInitial
                                    ? () {
                                        context
                                            .read<PersonalInformationCubit>()
                                            .updateEmployee(EmployeeEntity(
                                                username: accountTextController
                                                    .text
                                                    .trim(),
                                                firstName: firstNameTextController
                                                    .text
                                                    .trim(),
                                                lastName: lastNameTextController
                                                    .text
                                                    .trim(),
                                                email: emailTextController.text
                                                    .trim(),
                                                phoneNumber: FormatUtil
                                                    .formatOriginalPhone(
                                                        phoneTextController.text
                                                            .trim()),
                                                branchName:
                                                    storeNameTextController
                                                        .text,
                                                gender: genderListener.value,
                                                birthDate:
                                                    birthDayListener.value,
                                                status: employeeStatus
                                        ));
                                      }
                                    : null,
                                style: AppStyle.elevatedButtonStylePrimary,
                                child: const Text("Update"),
                              );
                            },
                          )))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> buildGenderPopup(BuildContext context) {
    return showCupertinoModalPopup(
        context: context,
        builder: (BuildContext contextPopup) => CupertinoActionSheet(
              title: const Text("Choose your gender"),
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    genderListener.value = Gender.MALE;
                    Navigator.pop(contextPopup);
                  },
                  child: Text(
                    'Male',
                    style: TextStyle(color: AppColor.info),
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    genderListener.value = Gender.FEMALE;
                    Navigator.pop(contextPopup);
                  },
                  isDestructiveAction: true,
                  child: Text(
                    'Female',
                    style: TextStyle(color: AppColor.info),
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    genderListener.value = Gender.OTHER;
                    Navigator.pop(contextPopup);
                  },
                  isDestructiveAction: true,
                  child: Text(
                    'Other',
                    style: TextStyle(color: AppColor.info),
                  ),
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(contextPopup);
                },
                child: const Text('Cancel'),
              ),
            ));
  }

  Future<void> buildBirthDayPicker(DateTime? birthDate) async {
    // Capture the current context in a local variable
    BuildContext currentContext = context;

    DateTime initialDate = birthDate ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: currentContext,
      // Use the local variable here
      initialDate: initialDate,
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != initialDate) {
      birthDayListener.value = picked;
    }
  }
}
