import 'package:flutter/material.dart';
import 'package:soqsoq/core/constants/app_colors.dart';
import 'package:soqsoq/core/models/user_info.dart';
import 'package:soqsoq/helpers/navigate_to_helper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final userInfo = arguments is UserInfo ? arguments : null;

    NavigationHelper.navigateTo(context, "/home", userInfo: userInfo);

    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primaryColor),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 400,),
            Text("Just a moment and it will be done..",style: TextStyle(color: AppColors.primaryColor,fontSize: 18),),
            SizedBox(height: 30,),
            CircularProgressIndicator(color: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }
}
