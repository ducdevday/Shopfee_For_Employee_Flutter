import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/dimens.dart';
import 'package:shopfeeforemployee/core/config/style.dart';
import 'package:shopfeeforemployee/core/router/app_router.dart';
import 'package:shopfeeforemployee/core/service/shared_service.dart';

class NotifyPermissionPage extends StatefulWidget {
  const NotifyPermissionPage({Key? key}) : super(key: key);

  @override
  State<NotifyPermissionPage> createState() => _NotifyPermissionPageState();
}

class _NotifyPermissionPageState extends State<NotifyPermissionPage> {
  late String fcmToken;

  @override
  void initState() {
    super.initState();
    getToken();
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) => {
          setState(() {
            fcmToken = token!;
          }),
          print("FCM Token:" + token!)
        });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("User granted permission");
      SharedService.setIsFirstTime(false);
      Navigator.pushNamed(context, AppRouter.loginRoute);
    } else {
      print("User denied permission");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/ic_notification.svg",
                  width: 250,
                  height: 250,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Notify",
                  style: AppStyle.largeTitleStyleDark,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Text(
                    "Please turn on notifications on the app to receive notifications",
                    style: AppStyle.mediumTextStyleDark,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(AppDimen.screenPadding),
              child: ElevatedButton(
                onPressed: () {
                  requestPermission();
                },
                child: const Text("Turn on"),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    disabledBackgroundColor: const Color(0xffCACACA),
                    disabledForegroundColor: AppColor.lightColor,
                    textStyle: AppStyle.mediumTextStyleDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
