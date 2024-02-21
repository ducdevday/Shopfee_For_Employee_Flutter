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
  late final TextEditingController firstNameTextController;
  late final TextEditingController lastNameTextController;
  late final TextEditingController accountTextController;
  late final ValueNotifier<Gender?> genderListener;
  late final ValueNotifier<DateTime?> birthDayListener;

  @override
  void initState() {
    super.initState();
    _cubit = ServiceLocator.sl<PersonalInformationCubit>();

    final employeeState = context.read<EmployeeBloc>().state;
    if (employeeState is EmployeeLoadSuccess) {
      final employee = employeeState.employee;
      firstNameTextController = TextEditingController(text: employee.firstName);
      lastNameTextController = TextEditingController(text: employee.lastName);
      accountTextController = TextEditingController(text: employee.username);
      genderListener = ValueNotifier(employee.gender);
      birthDayListener = ValueNotifier(employee.birthDate);
    }
  }

  String? getErrorText(
    String text,
    FieldType type,
  ) {
    //Todo: Check All Field validator
    _cubit.checkValidField(
        firstName: firstNameTextController.text,
        lastName: lastNameTextController.text);
    if (type == FieldType.firstName && !ValidateFieldUtil.validateName(text)) {
      return "First name is not valid";
    } else if (type == FieldType.lastName &&
        !ValidateFieldUtil.validateName(text)) {
      return "Last name is not valid";
    }
    return null;
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
              padding: const EdgeInsets.all(AppDimen.screenPadding),
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
                        Container(
                            margin: const EdgeInsets.only(top: 85, left: 75),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.fromBorderSide(BorderSide(
                                    color: AppColor.nonactiveColor))),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 16,
                            )),
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
                  // const SizedBox(
                  //   height: AppDimen.spacing,
                  // ),
                  // InputField(
                  //     title: "Phone",
                  //     hint: state.user.phoneNumber != null
                  //         ? state.user.phoneNumber!
                  //         : "Input your Phone Number",
                  //     callback: (String phoneNumber) {
                  //       context
                  //           .read<PersonalInformationCubit>()
                  //           .updatePhoneNumber(phoneNumber);
                  //     }),
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  ValueListenableBuilder(
                    valueListenable: birthDayListener,
                    builder: (BuildContext context, DateTime? birthDate,
                        Widget? child) {
                      return Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Birthday",
                              style: AppStyle.normalTextStyle
                                  .copyWith(color: const Color(0xff3C3C3C)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () async {
                              // Capture the current context in a local variable
                              BuildContext currentContext = context;

                              DateTime initialDate =
                                  birthDate ?? DateTime.now();
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
                            },
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                label: Text(
                                    FormatUtil.formattedBirthDay(birthDate),
                                    style: AppStyle.normalTextStyle.copyWith(
                                        color: const Color(0xff3C3C3C))),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                suffixIcon:
                                    const Icon(Icons.calendar_month_outlined),
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
                    builder:
                        (BuildContext context, Gender? gender, Widget? child) {
                      return Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Gender",
                              style: AppStyle.normalTextStyle
                                  .copyWith(color: const Color(0xff3C3C3C)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext contextPopup) =>
                                      CupertinoActionSheet(
                                        title: const Text("Choose your gender"),
                                        actions: [
                                          CupertinoActionSheetAction(
                                            onPressed: () {
                                              genderListener.value =
                                                  Gender.MALE;
                                              Navigator.pop(contextPopup);
                                            },
                                            child: Text(
                                              'Male',
                                              style: TextStyle(
                                                  color: AppColor.info),
                                            ),
                                          ),
                                          CupertinoActionSheetAction(
                                            onPressed: () {
                                              genderListener.value =
                                                  Gender.FEMALE;
                                              Navigator.pop(contextPopup);
                                            },
                                            isDestructiveAction: true,
                                            child: Text(
                                              'Female',
                                              style: TextStyle(
                                                  color: AppColor.info),
                                            ),
                                          ),
                                          CupertinoActionSheetAction(
                                            onPressed: () {
                                              genderListener.value =
                                                  Gender.OTHER;
                                              Navigator.pop(contextPopup);
                                            },
                                            isDestructiveAction: true,
                                            child: Text(
                                              'Other',
                                              style: TextStyle(
                                                  color: AppColor.info),
                                            ),
                                          ),
                                        ],
                                        cancelButton:
                                            CupertinoActionSheetAction(
                                          onPressed: () {
                                            Navigator.pop(contextPopup);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                      ));
                            },
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                label: Text(gender?.name ?? "",
                                    style: AppStyle.normalTextStyle.copyWith(
                                        color: const Color(0xff3C3C3C))),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                                disabledBorder:
                                    AppStyle.outlineInputBorderDefault,
                                hintText: "Choose your gender",
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const Spacer(
                    flex: 1,
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
                                                firstName:
                                                    firstNameTextController.text
                                                        .trim(),
                                                lastName: lastNameTextController
                                                    .text
                                                    .trim(),
                                                gender: genderListener.value,
                                                birthDate:
                                                    birthDayListener.value));
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 24),
                                    disabledBackgroundColor:
                                        const Color(0xffCACACA),
                                    disabledForegroundColor:
                                        AppColor.lightColor,
                                    textStyle: AppStyle.mediumTextStyleDark,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
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
}
