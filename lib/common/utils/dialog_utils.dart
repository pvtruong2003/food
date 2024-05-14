import 'package:flutter/material.dart';

import '../../features/authentication/login/login_screen.dart';
import '../../features/authentication/otp/otp_screen.dart';
import '../../features/authentication/personal_information/personal_information_screen.dart';

class DialogUtils {
  static void showModalBottomSheetLogin(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        builder: (_) {
          return LoginScreen(
            onPress: () {
              showModalBottomSheetOtp(context);
            },
          );
        },
        context: context);
  }

  static void showModalBottomSheetOtp(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        builder: (_) {
          return OtpScreen(
            onPress: () {
              showModalBottomSheetPersonalInformation(context);
            },
          );
        },
        context: context);
  }

  static void showModalBottomSheetPersonalInformation(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        builder: (BuildContext context) {
          return const PersonalInformationScreen();
        },
        context: context);
  }
}