import 'package:e_commerce_bloc/features/auth/presentations/widgets/auth_text_form_field_widget.dart';
import 'package:e_commerce_bloc/features/auth/presentations/widgets/auth_title_widget.dart';
import 'package:e_commerce_bloc/features/auth/presentations/widgets/basic_app_button.dart';
import 'package:e_commerce_bloc/core/routes/routes_name.dart';
import 'package:e_commerce_bloc/core/utils/validations_mixin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              const SizedBox(height: 20),

              AuthTextFormFieldWidget(
                controller: _emailController,
                hintText: 'Enter email',
                validator: (value) => ValidationMixin.validateEmail(value),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: BasicAppButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(
                        context,
                        RoutesName.enterPasswordScreen,
                        arguments: _emailController.text.trim(),
                      );
                    }
                  },
                  title: 'Continue',
                ),
              ),
              const SizedBox(height: 20),

              _createAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createAccount(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,

        children: [
          const TextSpan(text: "Don't you have an Account? "),
          TextSpan(
            text: "Create one",
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushReplacementNamed(
                  context,
                  RoutesName.signupScreen,
                );
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
