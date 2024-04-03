library notify_permission;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfeeforemployee/core/config/app_dimen.dart';
import 'package:shopfeeforemployee/core/config/app_path.dart';
import 'package:shopfeeforemployee/core/config/app_style.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/core/service/push_noticication_service.dart';
import 'package:shopfeeforemployee/core/service/shared_service.dart';
import 'package:shopfeeforemployee/core/utils/alert_util.dart';
import 'package:shopfeeforemployee/core/utils/exception_util.dart';
import 'package:shopfeeforemployee/core/utils/navigation_util.dart';
import 'package:shopfeeforemployee/features/login/presentation/login.dart';
import 'package:shopfeeforemployee/features/notify_permission/domain/usecase/notification_permission_usecase.dart';

part 'cubit/notification_permission_cubit.dart';
part 'cubit/notification_permission_state.dart';
part 'page/notify_permission_page.dart';