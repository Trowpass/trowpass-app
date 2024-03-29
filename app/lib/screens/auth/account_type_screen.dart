import 'package:app/screens/auth/sign_up_screen_individual.dart';
import 'package:app/shareds/utils/app_colors.dart';
import 'package:app/widgets/app_styles.dart';
import 'package:app/widgets/standard_button.dart';
import 'package:app/widgets/standard_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

import 'sign_up_screen_business.dart';

class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: background,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarBrightness: Brightness.light, // For iOS
          statusBarIconBrightness: Brightness.light, // For Android
          systemNavigationBarColor: navigationBarBackground,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        backgroundColor: background,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Get Started as a',
              style: appStyles(20, Colors.black, FontWeight.w500),
            ),
            const SizedBox(height: 30),
            StandardButton(
              text: 'Ride Manager [Passenger]',
              onPressed: () {
                Get.to(() => SignUpScreenIndividual());
              },
            ),
            const SizedBox(height: 18),
            StandardButtonOutline(
              color: primaryColor,
              text: 'Fleet Manager [Transporter]',
              onPressed: () {
                Get.to(() => SignUpScreenBusiness());
              },
            ),
          ],
        ),
      ),
    );
  }
}
