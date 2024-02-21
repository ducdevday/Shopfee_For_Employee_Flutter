library personal_information;

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfeeforemployee/core/common/enum/field_type.dart';
import 'package:shopfeeforemployee/core/common/models/gender.dart';
import 'package:shopfeeforemployee/core/common/widgets/account_input_field.dart';
import 'package:shopfeeforemployee/core/common/widgets/name_input_field.dart';
import 'package:shopfeeforemployee/core/config/app_color.dart';
import 'package:shopfeeforemployee/core/config/app_dimen.dart';
import 'package:shopfeeforemployee/core/config/app_style.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/core/service/shared_service.dart';
import 'package:shopfeeforemployee/core/utils/exception_util.dart';
import 'package:shopfeeforemployee/core/utils/format_util.dart';
import 'package:shopfeeforemployee/core/utils/navigation_util.dart';
import 'package:shopfeeforemployee/core/utils/validate_field_util.dart';
import 'package:shopfeeforemployee/features/employee/domain/entities/employee_entity.dart';
import 'package:shopfeeforemployee/features/employee/presentation/employee.dart';
import 'package:shopfeeforemployee/features/personal_information/domain/usecase/personnal_information_usecase.dart';
import 'package:shopfeeforemployee/features/personal_information/presentation/widgets/input_field.dart';

part 'cubit/personal_information_cubit.dart';
part 'cubit/personal_information_state.dart';
part 'page/personal_information_page.dart';