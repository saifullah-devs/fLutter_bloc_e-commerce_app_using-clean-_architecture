import 'package:e_commerce_bloc/common/widgets/auth_text_form_field_widget.dart';
import 'package:e_commerce_bloc/common/widgets/auth_title_widget.dart';
import 'package:e_commerce_bloc/common/widgets/basic_app_bar.dart';
import 'package:e_commerce_bloc/common/widgets/basic_app_button.dart';
import 'package:e_commerce_bloc/common/widgets/validation_guide.dart';
import 'package:e_commerce_bloc/core/routes/routes_name.dart';
import 'package:e_commerce_bloc/core/utils/enum.dart';
import 'package:e_commerce_bloc/core/utils/flash_bar_helper.dart';
import 'package:e_commerce_bloc/core/utils/gap.dart';
import 'package:e_commerce_bloc/core/utils/validations_mixin.dart';
import 'package:e_commerce_bloc/features/auth/data/models/user_login.dart';
import 'package:e_commerce_bloc/features/auth/presentations/bloc/auth/auth_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterPassword extends StatefulWidget {
  final dynamic email;
  const EnterPassword({super.key, required this.email});

  @override
  State<EnterPassword> createState() => _EnterPasswordState();
}

class _EnterPasswordState extends State<EnterPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.signOutResponse.status == FetchStatus.loading) {
            FlashBarHelper.flashBarLoadingMessage(context, 'Logging In...');
          }
          if (state.signinResponse.status == FetchStatus.complete) {
            FlashBarHelper.flashBarSuccessMessage(
              context,
              'Signed In successfully',
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.homeScreen,
              (route) => false,
            );
          }

          if (state.signinResponse.status == FetchStatus.error) {
            FlashBarHelper.flashBarErrorMessage(
              context,
              state.signinResponse.message ?? "Signin Failed",
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 80,
            bottom: 10,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthTitleWidget(title: 'Sign in'),
                Gap.h20,
                AuthTextFormFieldWidget(
                  controller: _passwordController,
                  hintText: 'Enter Password',
                  isPassword: true,
                  validator: (value) => ValidationMixin.validatePassword(value),
                ),
                Gap.h20,
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return BasicAppButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _handleSignin(context);
                          }
                        },
                        title: 'Sign In',
                      );
                    },
                  ),
                ),
                Gap.h20,
                _forgetpassword(context),
                Gap.h24,
                const ValidationGuide(
                  requirements: [
                    "At least 8 characters long",
                    "Contains Uppercase & Lowercase letters",
                    "Contains at least one number",
                    "Contains a special character (!@#\$&*)",
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignin(BuildContext context) {
    final password = _passwordController.text.trim();

    // CASE 1: Returning User (Simple Email String)
    if (widget.email is String) {
      context.read<AuthBloc>().add(
        SigninEvent(email: widget.email as String, password: password),
      );
    }
    // CASE 2: Returning User (Structured Signin Request)
    else if (widget.email is UserSigninReq) {
      final loginReq = widget.email as UserSigninReq;
      loginReq.password =
          password; // Update the object with the entered password

      context.read<AuthBloc>().add(
        SigninEvent(email: loginReq.email!, password: loginReq.password!),
      );
    }
  }

  Widget _forgetpassword(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          const TextSpan(text: "Forgot Password? "),
          TextSpan(
            text: "Reset",
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, RoutesName.forgetPasswordScreen);
              },
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
