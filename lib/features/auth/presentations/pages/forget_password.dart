import 'package:e_commerce_bloc/common/widgets/auth_text_form_field_widget.dart';
import 'package:e_commerce_bloc/common/widgets/auth_title_widget.dart';
import 'package:e_commerce_bloc/common/widgets/basic_app_bar.dart';
import 'package:e_commerce_bloc/common/widgets/basic_app_button.dart';
import 'package:e_commerce_bloc/core/routes/routes_name.dart';
import 'package:e_commerce_bloc/core/utils/enum.dart';
import 'package:e_commerce_bloc/core/utils/flash_bar_helper.dart';
import 'package:e_commerce_bloc/core/utils/validations_mixin.dart';
import 'package:e_commerce_bloc/features/auth/presentations/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.passwordResetResponse.status == FetchStatus.complete) {
            FlashBarHelper.flashBarSuccessMessage(
              context,
              'Reset link sent! Check your email.',
            );
            Navigator.pushNamed(context, RoutesName.passwordResetEmail);
          }

          if (state.passwordResetResponse.status == FetchStatus.error) {
            FlashBarHelper.flashBarErrorMessage(
              context,
              state.passwordResetResponse.message ??
                  'Failed to send reset email',
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthTitleWidget(title: 'Forget Password'),
                const SizedBox(height: 20),

                AuthTextFormFieldWidget(
                  controller: _emailController,
                  hintText: 'Enter email',
                  validator: (value) => ValidationMixin.validateEmail(value),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  // 3. Wrap button with BlocBuilder for loading state
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading =
                          state.passwordResetResponse.status ==
                          FetchStatus.loading;

                      return BasicAppButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              SendPasswordResetEmailEvent(
                                email: _emailController.text.trim(),
                              ),
                            );
                          }
                        },
                        title: isLoading ? 'Sending...' : 'Continue',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
