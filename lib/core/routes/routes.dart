import 'package:e_commerce_bloc/features/auth/data/models/user_creation_req.dart';
import 'package:e_commerce_bloc/features/auth/presentations/bloc/user_requirements/user_requirements_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'routes_name.dart';
import '../../features/view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '');

    switch (uri.path) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashPage(),
        );
      case RoutesName.homeScreen:
      case RoutesName.homeScreenAlt:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => const HomeScreen(),
        );
      case RoutesName.signupScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => const SignUpPage(),
        );
      case RoutesName.ageGenderSelectionScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final userReq = args['userReq'] as UserCreationReq;
        final requirementsBloc = args['bloc'] as UserRequirementsBloc;

        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: requirementsBloc,
            child: GenderAndAgeSelectionPage(userCreationReq: userReq),
          ),
        );
      case RoutesName.signinScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => const SigninPage(),
        );

      case RoutesName.enterPasswordScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) =>
              EnterPassword(email: settings.arguments),
        );

      case RoutesName.passwordResetEmail:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => PasswordResetEmailPage(),
        );
      case RoutesName.forgetPasswordScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => const ForgetPassword(),
        );

      // case RoutesName.moviesScreen:
      //   // 3. Extract the variables safely from the URL!
      //   // If they aren't in the URL, provide safe default values.
      //   final sortParam = uri.queryParameters['sort'] ?? 'popular';
      //   final pageParam = uri.queryParameters['page'] ?? '1';

      //   // Convert the string page number to an integer safely
      //   final int pageNumber = int.tryParse(pageParam) ?? 1;

      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (BuildContext context) =>
      //         MovieScreen(sortMode: sortParam, initialPage: pageNumber),
      //   );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const Scaffold(
              body: Center(child: Text('No route defined')),
            );
          },
        );
    }
  }
}
