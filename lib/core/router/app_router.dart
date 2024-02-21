import 'package:flutter/material.dart';
import 'package:shopfeeforemployee/features/account/presentation/account.dart';
import 'package:shopfeeforemployee/features/change_password/presentation/change_password.dart';
import 'package:shopfeeforemployee/features/history/presentation/history.dart';
import 'package:shopfeeforemployee/features/home/presentation/home.dart';
import 'package:shopfeeforemployee/features/login/presentation/login.dart';
import 'package:shopfeeforemployee/features/notification_permission/notify_permission_page.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/order_detail.dart';
import 'package:shopfeeforemployee/features/personal_information/presentation/personal_information.dart';
import 'package:shopfeeforemployee/features/shipping_order/presentation/shipping_order.dart';

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
      case ShippingOrderPage.route:
        return MaterialPageRoute(
            builder: (context) => const ShippingOrderPage());
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
