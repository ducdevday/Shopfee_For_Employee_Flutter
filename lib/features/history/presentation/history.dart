library history;

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopfeeforemployee/core/common/extension/order_status_extension.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/core/common/widgets/my_error.dart';
import 'package:shopfeeforemployee/core/common/widgets/my_skeleton_circle.dart';
import 'package:shopfeeforemployee/core/common/widgets/my_skeleton_rectangle.dart';
import 'package:shopfeeforemployee/core/config/app_color.dart';
import 'package:shopfeeforemployee/core/config/app_dimen.dart';
import 'package:shopfeeforemployee/core/config/app_style.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/core/errors/failures.dart';
import 'package:shopfeeforemployee/core/router/app_router.dart';
import 'package:shopfeeforemployee/core/utils/exception_util.dart';
import 'package:shopfeeforemployee/core/utils/format_util.dart';
import 'package:shopfeeforemployee/features/history/domain/entities/history_entity.dart';
import 'package:shopfeeforemployee/features/history/domain/usecase/history_usecase.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/order_detail.dart';

part 'bloc/history_bloc.dart';
part 'bloc/history_event.dart';
part 'bloc/history_state.dart';
part 'page/history_page.dart';
part 'widgets/history_item.dart';
part 'widgets/history_listview.dart';
part 'widgets/history_skeleton_item.dart';
part 'widgets/history_skeleton_list.dart';