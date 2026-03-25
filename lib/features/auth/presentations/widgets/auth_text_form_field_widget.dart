import 'package:flutter/material.dart';

class AuthTextFormFieldWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final String? Function(String?)? validator;

  const AuthTextFormFieldWidget({
    super.key,
    required this.hintText,
    this.controller,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<AuthTextFormFieldWidget> createState() =>
      _AuthTextFormFieldWidgetState();
}

class _AuthTextFormFieldWidgetState extends State<AuthTextFormFieldWidget> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color:
                      theme.inputDecorationTheme.hintStyle?.color ??
                      Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
