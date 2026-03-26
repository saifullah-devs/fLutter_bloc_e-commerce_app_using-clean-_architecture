import 'package:e_commerce_bloc/features/admin/presentaion/bloc/admin_bloc.dart';
import 'package:e_commerce_bloc/features/admin/presentaion/views/admin_bottom_navigation.dart';
import 'package:e_commerce_bloc/features/auth/data/models/user_creation_req.dart';
import 'package:e_commerce_bloc/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

      case RoutesName.admin:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return BlocProvider(
              create: (context) => sl<AdminBloc>(),
              child: const AdminBottomNavigation(),
            );
          },
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
