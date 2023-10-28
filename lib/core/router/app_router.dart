import 'package:flutter/material.dart';
import 'package:shopfeeforemployee/features/account/presentation/page/account_page.dart';
import 'package:shopfeeforemployee/features/change_password/presentation/page/change_password_page.dart';
import 'package:shopfeeforemployee/features/home/presentation/page/home_page.dart';
import 'package:shopfeeforemployee/features/login/presentation/page/login_page.dart';
import 'package:shopfeeforemployee/features/personal_information/presentation/page/personal_information_page.dart';
import 'package:shopfeeforemployee/features/shipping_order/presentation/page/shipping_order_page.dart';

class AppRouter {
  static const String loginRoute = "/login";
  static const String homeRoute = "/home";
  static const String accountRoute = "/account";
  static const String personalInformationRoute = "/personal_information";
  static const String changePasswordRoute = "/change_account";
  static const String shippingOrder = "/shipping_order";
  static const String takeawayOrder = "/takeaway_order";

  static onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case homeRoute:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case accountRoute:
        return MaterialPageRoute(builder: (context) => const AccountPage());
      case personalInformationRoute:
        return MaterialPageRoute(builder: (context) => const PersonalInformationPage());
      case changePasswordRoute:
        return MaterialPageRoute(builder: (context) => const ChangePasswordPage());
      case shippingOrder:
        return MaterialPageRoute(builder: (context) => const ShippingOrderPage());
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
