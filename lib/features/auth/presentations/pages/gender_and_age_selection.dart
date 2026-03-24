import 'package:e_commerce_bloc/common/bottomsheet/app_bottonsheet.dart';
import 'package:e_commerce_bloc/common/widgets/basic_app_bar.dart';
import 'package:e_commerce_bloc/common/widgets/basic_app_button.dart';
import 'package:e_commerce_bloc/core/config/color/colors.dart';
import 'package:e_commerce_bloc/core/routes/routes_name.dart';
import 'package:e_commerce_bloc/core/utils/enum.dart';
import 'package:e_commerce_bloc/core/utils/flash_bar_helper.dart';
import 'package:e_commerce_bloc/features/auth/data/models/user_creation_req.dart';
import 'package:e_commerce_bloc/features/auth/presentations/bloc/user_requirements/user_requirements_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../widgets/ages.dart';

class GenderAndAgeSelectionPage extends StatelessWidget {
  final UserCreationReq userCreationReq;
  const GenderAndAgeSelectionPage({required this.userCreationReq, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.signupResponse.status == FetchStatus.loading) {
          FlashBarHelper.flashBarErrorMessage(context, 'Creating Account...');
        }
        if (state.signupResponse.status == FetchStatus.complete) {
          FlashBarHelper.flashBarSuccessMessage(context, 'Account Created!');
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.homeScreen,
            (route) => false,
          );
        }
        if (state.signupResponse.status == FetchStatus.error) {
          FlashBarHelper.flashBarErrorMessage(
            context,
            state.signupResponse.message ?? 'Signup Failed',
          );
        }
      },
      child: Scaffold(
        appBar: const BasicAppbar(),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tell us about yourself',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _genderselection(),
                    const SizedBox(height: 30),
                    const Text(
                      'How old are you?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _ageselection(),
                  ],
                ),
              ),
            ),
            _finishButton(context),
          ],
        ),
      ),
    );
  }

  Widget _genderselection() {
    return BlocBuilder<UserRequirementsBloc, UserRequirementsState>(
      builder: (context, state) {
        return Row(
          children: [
            _genderTile(context, state.selectedGender, 1, 'Men'),
            const SizedBox(width: 20),
            _genderTile(context, state.selectedGender, 2, 'Women'),
          ],
        );
      },
    );
  }

  Widget _genderTile(
    BuildContext context,
    int selectedIndex,
    int index,
    String text,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () =>
            context.read<UserRequirementsBloc>().add(SelectGenderEvent(index)),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: selectedIndex == index
                ? AppColors.primaryColor
                : AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(child: Text(text)),
        ),
      ),
    );
  }

  Widget _ageselection() {
    return BlocBuilder<UserRequirementsBloc, UserRequirementsState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            AppBottomsheet.display(
              context,
              BlocProvider.value(
                value: context.read<UserRequirementsBloc>()
                  ..add(DisplayAgesEvent()),
                child: const Ages(),
              ),
            );
          },
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(state.selectedAge),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _finishButton(BuildContext context) {
    // 2. Watch the AuthBloc for the loading status to disable the button
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final isLoading =
            authState.signupResponse.status == FetchStatus.loading;

        return Container(
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: BasicAppButton(
              onPressed: isLoading
                  ? () {}
                  : () {
                      final requirements = context
                          .read<UserRequirementsBloc>()
                          .state;

                      // Update your request model
                      userCreationReq.gender = requirements.selectedGender;
                      userCreationReq.age = requirements.selectedAge;

                      // Trigger the actual signup
                      context.read<AuthBloc>().add(
                        SignupEvent(userCreationReq),
                      );
                    },
              title: isLoading ? 'Creating Account...' : 'Finish',
            ),
          ),
        );
      },
    );
  }
}
