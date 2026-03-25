import 'package:e_commerce_bloc/core/config/assets/app_vectors.dart';
import 'package:e_commerce_bloc/core/routes/routes_name.dart';
import 'package:e_commerce_bloc/core/utils/enum.dart';
import 'package:e_commerce_bloc/core/utils/flash_bar_helper.dart';
import 'package:e_commerce_bloc/features/auth/presentations/bloc/auth/auth_bloc.dart';
import 'package:e_commerce_bloc/features/home/presentation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(GetUserEvent());

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.signOutResponse.status == FetchStatus.loading) {
          FlashBarHelper.flashBarLoadingMessage(context, 'Logging out...');
        }
        if (state.signOutResponse.status == FetchStatus.complete) {
          FlashBarHelper.flashBarSuccessMessage(context, 'Succeed');

          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.signinScreen,
            (r) => false,
          );
        }
        if (state.getUserResponse.status == FetchStatus.error) {
          FlashBarHelper.flashBarErrorMessage(
            context,
            "Error fetching user: ${state.getUserResponse.message}",
          );
        }
      },
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text('Home'),
          actions: [SvgPicture.asset(AppVectors.appLogo)],
          leading: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: (state.user?.image.isNotEmpty ?? false)
                        ? NetworkImage(state.user!.image)
                        : null,
                    child:
                        (state.user?.image == null || state.user!.image.isEmpty)
                        ? const Icon(Icons.person)
                        : null,
                  ),
                ),
              );
            },
          ),
        ),
        body: const Center(child: Text("Welcome to the Store")),
      ),
    );
  }
}
