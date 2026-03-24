import 'package:e_commerce_bloc/core/routes/routes_name.dart';
import 'package:e_commerce_bloc/core/utils/enum.dart';
import 'package:e_commerce_bloc/core/utils/flash_bar_helper.dart';
import 'package:e_commerce_bloc/features/auth/presentations/bloc/auth/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              // Check signOutResponse instead of signupResponse
              if (state.signOutResponse.status == FetchStatus.loading) {
                FlashBarHelper.flashBarLoadingMessage(
                  context,
                  'Logging out...',
                );
              }

              if (state.signOutResponse.status == FetchStatus.complete) {
                final user = FirebaseAuth.instance.currentUser;
                print("Splash Check - User: ${user?.email}");
                FlashBarHelper.flashBarSuccessMessage(
                  context,
                  'Signed out successfully',
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesName.signinScreen,
                  (route) => false,
                );
              }

              if (state.signOutResponse.status == FetchStatus.error) {
                FlashBarHelper.flashBarErrorMessage(
                  context,
                  state.signOutResponse.message ?? 'Logout failed',
                );
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state.signOutResponse.status == FetchStatus.loading) {
                  return const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                return IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(SignOutEvent());
                  },
                  icon: const Icon(Icons.logout),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
