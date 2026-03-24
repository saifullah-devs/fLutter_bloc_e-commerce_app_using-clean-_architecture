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
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; // Toggle the boolean
                  });
                },
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
