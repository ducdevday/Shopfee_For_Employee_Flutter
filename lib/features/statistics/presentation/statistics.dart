library statistics;

import 'dart:async';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shopfeeforemployee/core/common/enum/my_container.dart';
import 'package:shopfeeforemployee/core/config/app_color.dart';
import 'package:shopfeeforemployee/core/config/app_dimen.dart';
import 'package:shopfeeforemployee/core/config/app_path.dart';
import 'package:shopfeeforemployee/core/config/app_style.dart';
import 'package:shopfeeforemployee/core/di/service_locator.dart';
import 'package:shopfeeforemployee/core/service/shared_service.dart';
import 'package:shopfeeforemployee/core/utils/calendar_util.dart';
import 'package:shopfeeforemployee/core/utils/exception_util.dart';
import 'package:shopfeeforemployee/core/utils/format_util.dart';
import 'package:shopfeeforemployee/features/statistics/domain/entities/chart_line_data.dart';
import 'package:shopfeeforemployee/features/statistics/domain/entities/sale_data.dart';
import 'package:shopfeeforemployee/features/statistics/domain/usecase/statistics_usecase.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

part 'bloc/statistic_bloc.dart';

part 'bloc/statistic_event.dart';

part 'bloc/statistic_state.dart';

part 'page/statistics_page.dart';
