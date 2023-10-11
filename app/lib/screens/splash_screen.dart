// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:app/screens/navigation_menus/home_landing_tab_screen.dart';
import 'package:app/screens/onboarding/onboarding_screen.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/shareds/utils/images.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/shareds/managers/get_session_manager.dart';
import 'package:app/shareds/resources/routes/app_routes.dart';
import 'package:app/screens/auth/login.dart';

class SplashScreen extends StatelessWidget {
  final store = GetSessionManager();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () {
      String initialRoute = getInitialPage();
      navigateToInitialRoute(initialRoute);
    });

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(trowpassLogo, width: 200, height: 200),
                    SizedBox(height: 10), 
                    Text("Your No.1 travel partner", style: appStyles(26, background, FontWeight.w400),  textAlign: TextAlign.center,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getInitialPage() {
    String route = '';
    final isUserOnBoarded = store.readIsUserOnBoarded();
    final isUserLoggedIn = store.readIsUserLoggedIn();
    final isTokenExpired = store.readIsTokenExpired();
    final rememberMe = store.readShouldRememberMe();

    if (!isUserOnBoarded) {
      route = AppRoutes.onboarding;
    } else {
      if (!isUserLoggedIn) {
        route = AppRoutes.login;
      } else if (isUserLoggedIn && rememberMe && isTokenExpired) {
        route = AppRoutes.dashboard;
      } else if (isUserLoggedIn && !rememberMe && isTokenExpired) {
        route = AppRoutes.login;
      } else {
        route = AppRoutes.dashboard;
      }
    }
    return route;
  }

  void navigateToInitialRoute(String route) {
    switch (route) {
      case AppRoutes.onboarding:
        Get.offAll(() => OnBoardingScreen());
        break;
      case AppRoutes.login:
        Get.offAll(() => LoginScreen());
        break;
      case AppRoutes.dashboard:
        Get.offAll(() => HomeLandingTabScreen());
        break;
    }
  }
}