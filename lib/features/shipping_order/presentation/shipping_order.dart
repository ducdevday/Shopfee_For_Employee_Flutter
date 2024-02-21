library shipping_order;

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
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
import 'package:shopfeeforemployee/core/utils/navigation_util.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/order_detail.dart';
import 'package:shopfeeforemployee/features/shipping_order/domain/entities/shipping_order_entity.dart';
import 'package:shopfeeforemployee/features/shipping_order/domain/usecase/shipping_order_usecase.dart';

part 'bloc/shipping_order_bloc.dart';
part 'bloc/shipping_order_event.dart';
part 'bloc/shipping_order_state.dart';
part 'page/shipping_order_page.dart';
part 'widgets/shipping_order_item.dart';
part 'widgets/shipping_order_list.dart';
part 'widgets/shipping_order_skeleton.dart';
part 'widgets/shipping_order_tabbar.dart';
part 'widgets/shipping_skeleton_item.dart';