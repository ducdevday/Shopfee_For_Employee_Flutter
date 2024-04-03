import 'package:flutter/material.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/features/account/presentation/account.dart';
import 'package:shopfeeforemployee/features/change_password/presentation/change_password.dart';
import 'package:shopfeeforemployee/features/history/presentation/history.dart';
import 'package:shopfeeforemployee/features/home/presentation/home.dart';
import 'package:shopfeeforemployee/features/login/presentation/login.dart';
import 'package:shopfeeforemployee/features/notify_permission/presentation/notify_permission.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/order_detail.dart';
import 'package:shopfeeforemployee/features/orders/presentation/orders.dart';
import 'package:shopfeeforemployee/features/personal_information/presentation/personal_information.dart';

class AppRouter {
  static onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NotifyPermissionPage.route:
        return MaterialPageRoute(
            builder: (context) => const NotifyPermissionPage());
      case LoginPage.route:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case HomePage.route:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case AccountPage.route:
        return MaterialPageRoute(builder: (context) => const AccountPage());
      case PersonalInformationPage.route:
        return MaterialPageRoute(
            builder: (context) => const PersonalInformationPage());
      case ChangePasswordPage.route:
        return MaterialPageRoute(
            builder: (context) => const ChangePasswordPage());
      case OrdersPage.route:
        return MaterialPageRoute(
            builder: (context) => OrdersPage(orderType: settings.arguments as OrderType,));
      case OrderDetailPage.route:
        return MaterialPageRoute(
            builder: (context) =>
                OrderDetailPage(orderId: settings.arguments as String));
      case HistoryPage.route:
        return MaterialPageRoute(builder: (context) => const HistoryPage());
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text("No Exist Page"),
              ),
            ));
  }
}
