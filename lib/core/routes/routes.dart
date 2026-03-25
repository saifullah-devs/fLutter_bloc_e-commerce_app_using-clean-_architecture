import 'package:e_commerce_bloc/features/auth/data/models/user_creation_req.dart';
import 'package:flutter/material.dart';
import '../../features/view.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashPage());

      case RoutesName.homeScreen:
      case RoutesName.homeScreenAlt:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const HomeScreen(),
        );

      case RoutesName.signupScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SignUpPage(),
        );

      case RoutesName.ageGenderSelectionScreen:
        return MaterialPageRoute(
          builder: (context) {
            return GenderAndAgeSelectionPage(
              userCreationReq: settings.arguments as UserCreationReq,
            );
          },
        );

      case RoutesName.signinScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SigninPage(),
        );

      case RoutesName.enterPasswordScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) =>
              EnterPassword(email: settings.arguments as String? ?? ''),
        );

      case RoutesName.forgetPasswordScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ForgetPassword(),
        );

      case RoutesName.passwordResetEmail:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const PasswordResetEmailPage(),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text('No route defined'))),
    );
  }
}
