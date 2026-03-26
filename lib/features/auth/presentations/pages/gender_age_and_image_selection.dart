import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:e_commerce_bloc/common/bottomsheet/app_bottonsheet.dart';
import 'package:e_commerce_bloc/features/auth/presentations/widgets/basic_app_bar.dart';
import 'package:e_commerce_bloc/features/auth/presentations/widgets/basic_app_button.dart';
import 'package:e_commerce_bloc/core/config/color/colors.dart';
import 'package:e_commerce_bloc/core/routes/routes_name.dart';
import 'package:e_commerce_bloc/core/utils/enum.dart';
import 'package:e_commerce_bloc/core/utils/flash_bar_helper.dart';
import 'package:e_commerce_bloc/features/auth/data/models/user_creation_req.dart';
import 'package:e_commerce_bloc/features/auth/presentations/bloc/user_requirements/user_requirements_bloc.dart';
import 'package:e_commerce_bloc/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../widgets/ages.dart';

class GenderAndAgeSelectionPage extends StatelessWidget {
  final UserCreationReq userCreationReq;
  const GenderAndAgeSelectionPage({required this.userCreationReq, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserRequirementsBloc>(),
      child: Builder(
        builder: (innerContext) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.signupResponse.status == FetchStatus.loading) {
                FlashBarHelper.flashBarLoadingMessage(
                  context,
                  'Creating Account...',
                );
              }
              if (state.signupResponse.status == FetchStatus.complete) {
                FlashBarHelper.flashBarSuccessMessage(
                  context,
                  'Account Created!',
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesName.splashScreen,
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
                          if (!kIsWeb) ...[
                            _imageSelection(innerContext),
                            const SizedBox(height: 30),
                          ],

                          const SizedBox(height: 30),
                          _genderSelection(innerContext),
                          const SizedBox(height: 30),
                          const Text(
                            'How old are you?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 30),
                          _ageselection(innerContext),
                        ],
                      ),
                    ),
                  ),
                  _finishButton(innerContext),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _genderSelection(BuildContext context) {
    return BlocBuilder<UserRequirementsBloc, UserRequirementsState>(
      builder: (context, state) {
        return Row(
          children: [
            _genderTile(context, state.selectedGender, 'Men', 'Men'),
            const SizedBox(width: 20),
            _genderTile(context, state.selectedGender, 'Women', 'Women'),
          ],
        );
      },
    );
  }

  Widget _genderTile(
    BuildContext context,
    String selectedIndex,
    String index,
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

  Widget _ageselection(BuildContext context) {
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

  Widget _imageSelection(BuildContext context) {
    return BlocBuilder<UserRequirementsBloc, UserRequirementsState>(
      builder: (context, state) {
        return Center(
          child: GestureDetector(
            onTap: () {
              // Open the bottom sheet instead of firing an event directly
              _showImageSourceActionSheet(context, state);
            },
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.secondaryColor,
                  backgroundImage: state.imagePath?.isNotEmpty ?? false
                      ? FileImage(File(state.imagePath!))
                      : null,
                  child: (state.imagePath?.isEmpty ?? true)
                      ? const Icon(Icons.person, size: 50, color: Colors.white)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.primaryColor,
                    child: const Icon(
                      Icons.edit,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper method to show the options
  void _showImageSourceActionSheet(
    BuildContext context,
    UserRequirementsState state,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Profile Photo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  // 1. Fire Gallery Event
                  context.read<UserRequirementsBloc>().add(GalleryImageEvent());
                  Navigator.pop(bottomSheetContext); // Close sheet
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  // 2. Fire Camera Event
                  context.read<UserRequirementsBloc>().add(CameraImageEvent());
                  Navigator.pop(bottomSheetContext); // Close sheet
                },
              ),
              // 3. Fire Remove Event (Only show if an image actually exists!)
              if (state.imagePath != null && state.imagePath!.isNotEmpty)
                ListTile(
                  leading: const Icon(Icons.delete_outline, color: Colors.red),
                  title: const Text(
                    'Remove Photo',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    context.read<UserRequirementsBloc>().add(
                      RemoveImageEvent(),
                    );
                    Navigator.pop(bottomSheetContext); // Close sheet
                  },
                ),
            ],
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
                      userCreationReq.image = requirements.imagePath;

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
