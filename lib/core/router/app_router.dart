import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopfeeforemployee/core/common/models/order_type.dart';
import 'package:shopfeeforemployee/core/common/widgets/network_img_full_screen.dart';
import 'package:shopfeeforemployee/core/common/widgets/network_video_full_screen.dart';
import 'package:shopfeeforemployee/features/account/presentation/account.dart';
import 'package:shopfeeforemployee/features/change_password/presentation/change_password.dart';
import 'package:shopfeeforemployee/features/history/presentation/history.dart';
import 'package:shopfeeforemployee/features/home/presentation/home.dart';
import 'package:shopfeeforemployee/features/login/presentation/login.dart';
import 'package:shopfeeforemployee/features/notify_permission/presentation/notify_permission.dart';
import 'package:shopfeeforemployee/features/order_detail/presentation/order_detail.dart';
import 'package:shopfeeforemployee/features/orders/presentation/orders.dart';
import 'package:shopfeeforemployee/features/personal_information/presentation/personal_information.dart';
import 'package:shopfeeforemployee/features/pos/presentation/page/pos_page.dart';
import 'package:shopfeeforemployee/features/refund/presentation/refund.dart';

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
            builder: (context) => OrdersPage(
                  orderType: settings.arguments as OrderType,
                ));
      case OrderDetailPage.route:
        return MaterialPageRoute(
            builder: (context) =>
                OrderDetailPage(orderId: settings.arguments as String));
      case HistoryPage.route:
        return MaterialPageRoute(builder: (context) => const HistoryPage());
      case NetworkImageFullScreen.route:
        return PageTransition(
            child: NetworkImageFullScreen(
              url: settings.arguments as String,
            ),
            type: PageTransitionType.fade);
      case NetworkVideoFullScreen.route:
        return PageTransition(
            child: NetworkVideoFullScreen(
              url: settings.arguments as String,
            ),
            type: PageTransitionType.fade);
      case RefundPage.route:
        return PageTransition(
            child: RefundPage(
              orderId: settings.arguments as String,
            ),
            type: PageTransitionType.bottomToTop);
      case PosPage.route:
        return MaterialPageRoute(builder: (context) => const PosPage());
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
