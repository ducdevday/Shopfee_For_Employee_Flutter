library login;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfeeforemployee/core/common/enum/field_type.dart';
import 'package:shopfeeforemployee/core/common/widgets/account_input_field.dart';
import 'package:shopfeeforemployee/core/common/widgets/password_input_field.dart';
import 'package:shopfeeforemployee/core/config/app_color.dart';
import 'package:shopfeeforemployee/core/config/app_dimen.dart';
import 'package:shopfeeforemployee/core/config/app_path.dart';
import 'package:shopfeeforemployee/core/config/app_style.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/core/service/shared_service.dart';
import 'package:shopfeeforemployee/core/utils/exception_util.dart';
import 'package:shopfeeforemployee/core/utils/global_keys.dart';
import 'package:shopfeeforemployee/core/utils/navigation_util.dart';
import 'package:shopfeeforemployee/core/utils/validate_field_util.dart';
import 'package:shopfeeforemployee/features/home/presentation/home.dart';
import 'package:shopfeeforemployee/features/login/domain/entities/login_entity.dart';
import 'package:shopfeeforemployee/features/login/domain/usecase/login_usecase.dart';

part "cubit/login_cubit.dart";
part 'cubit/login_state.dart';
part 'page/login_page.dart';