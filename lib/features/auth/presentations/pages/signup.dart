import 'package:e_commerce_bloc/features/auth/presentations/widgets/auth_text_form_field_widget.dart';
import 'package:e_commerce_bloc/features/auth/presentations/widgets/auth_title_widget.dart';
import 'package:e_commerce_bloc/features/auth/presentations/widgets/basic_app_button.dart';
import 'package:e_commerce_bloc/features/auth/presentations/widgets/validation_guide.dart';
import 'package:e_commerce_bloc/core/routes/routes_name.dart';
import 'package:e_commerce_bloc/core/utils/gap.dart';
import 'package:e_commerce_bloc/core/utils/validations_mixin.dart';
import 'package:e_commerce_bloc/features/auth/data/models/user_creation_req.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // 1. Create Controllers to capture the text
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
              AuthTitleWidget(title: 'Sign Up'),
              Gap.h20,

              AuthTextFormFieldWidget(
                hintText: 'First Name',
                controller: _firstNameController,
                validator: (value) =>
                    ValidationMixin.validateRequired(value, 'First Name'),
              ),
              Gap.h20,

              AuthTextFormFieldWidget(
                hintText: 'Last Name',
                controller: _lastNameController,

                validator: (value) =>
                    ValidationMixin.validateRequired(value, 'Last Name'),
              ),
              Gap.h20,

              AuthTextFormFieldWidget(
                hintText: 'Enter email',
                controller: _emailController,

                validator: (value) => ValidationMixin.validateEmail(value),
              ),
              Gap.h20,

              AuthTextFormFieldWidget(
                hintText: 'Enter Password',
                controller: _passwordController,
                isPassword: true,
                validator: (value) => ValidationMixin.validatePassword(value),
              ),
              Gap.h20,

              SizedBox(
                width: double.infinity,
                child: BasicAppButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final requestData = UserCreationReq(
                        firstName: _firstNameController.text.trim(),
                        lastName: _lastNameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                        gender: null, // Will fill this on the next page
                        age: null, // Will fill this on the next page
                      );
                      Navigator.pushNamed(
                        context,
                        RoutesName.ageGenderSelectionScreen,
                        arguments: requestData,
                      );
                    }
                  },
                  title: 'Contine',
                ),
              ),
              Gap.h20,

              _createAccount(context),
              Gap.h24,
              ValidationGuide(
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
    );
  }

  Widget _createAccount(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(text: "Already have an account? "),
          TextSpan(
            text: "Sign in",
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushReplacementNamed(
                  context,
                  RoutesName.signinScreen,
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
