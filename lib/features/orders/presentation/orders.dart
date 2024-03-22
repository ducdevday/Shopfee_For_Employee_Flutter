library orders;

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopfeeforemployee/core/common/extension/order_status_extension.dart';
import 'package:shopfeeforemployee/core/common/models/order_status.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/core/common/widgets/my_error.dart';
import 'package:shopfeeforemployee/core/common/widgets/my_skeleton_circle.dart';
import 'package:shopfeeforemployee/core/common/widgets/my_skeleton_rectangle.dart';
import 'package:shopfeeforemployee/core/config/app_color.dart';
import 'package:shopfeeforemployee/core/config/app_dimen.dart';
import 'package:shopfeeforemployee/core/config/app_path.dart';
import 'package:shopfeeforemployee/core/config/app_style.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/core/utils/exception_util.dart';
import 'package:shopfeeforemployee/core/utils/format_util.dart';
import 'package:shopfeeforemployee/core/utils/navigation_util.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/order_detail.dart';
import 'package:shopfeeforemployee/features/orders/data/models/order_params_model.dart';
import 'package:shopfeeforemployee/features/orders/domain/entities/order_information_entity.dart';
import 'package:shopfeeforemployee/features/orders/domain/entities/order_params_entity.dart';
import 'package:shopfeeforemployee/features/orders/domain/usecase/orders_usecase.dart';

part 'bloc/orders_bloc.dart';
part 'bloc/orders_event.dart';
part 'bloc/orders_state.dart';
part 'page/orders_page.dart';
part 'widgets/order_information_item.dart';
part 'widgets/order_information_list.dart';
part 'widgets/order_skeleton_item.dart';
part 'widgets/order_skeleton_list.dart';
part 'widgets/order_tabbar.dart';