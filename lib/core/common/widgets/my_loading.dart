import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopfeeforemployee/core/config/color.dart';
import 'package:shopfeeforemployee/core/config/style.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Lottie.asset("assets/images/lottie_coffee_pro.json", width: 200, height: 200),
                Positioned(bottom: 10,right: 0, left: 10,child: Center(child: Text("Loading...", style: AppStyle.mediumTextStyleDark.copyWith(color: AppColor.primaryColor),)))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
