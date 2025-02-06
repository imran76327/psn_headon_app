import 'package:flutter/material.dart';

import '../entry/entry_point.dart';

class Routes {
  static const String myHomePage = 'my_home_page';
  static const String login = 'login';
  static const String signup = 'signup';
  static const String calendar = 'calendar';
  static const String attendancehome = 'attendancehome';
  static const String leavehome = 'leavehome';
  static const String applyLeave = 'applyLeave';
  static const String earlyLeave = 'earlyLeave';
  static const String overtime = 'overtime';
  static const String markAttendance = 'markAttendance';
  static const String correctIntime = 'correctIntime';
  static const String correctOuttime = 'correctOuttime';
  static const String onBoardingScreen = 'onBoardingScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case myHomePage:
        final Widget body = settings.arguments as Widget;
        return MaterialPageRoute(
          builder: (context) => EntryScreen(
            body: body,
          ),
        );

      // case verification:
      //   final Map args = settings.arguments as Map;
      //   return MaterialPageRoute(
      //     builder: (context) => VerificationPage(
      //       smsCodeId: args['smsCodeId'],
      //       phoneNumber: args['phoneNumber'],
      //     ),
      //   );

      // case profile:
      //   final UserModel user = settings.arguments as UserModel;
      //   return PageTransition(
      //     child: ProfilePage(user: user),
      //     type: PageTransitionType.fade,
      //     duration: const Duration(milliseconds: 800),
      //   );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: Text('No Page Route Provided'),
              ),
            );
          },
        );
    }
  }
}
