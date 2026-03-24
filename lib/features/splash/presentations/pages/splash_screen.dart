import 'package:e_commerce_bloc/core/config/assets/app_vectors.dart';
import 'package:e_commerce_bloc/core/config/color/colors.dart';
import 'package:e_commerce_bloc/core/routes/routes_name.dart';
import 'package:e_commerce_bloc/core/utils/gap.dart';
import 'package:e_commerce_bloc/core/utils/loading_widget.dart';
import 'package:e_commerce_bloc/features/splash/presentations/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(AppStartedEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.homeScreen,
              (route) => false,
            );
          }
          if (state is UnAuthenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.signinScreen,
              (route) => false,
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppVectors.appLogo),
                Gap.h12,
                LoadingWidget(size: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
