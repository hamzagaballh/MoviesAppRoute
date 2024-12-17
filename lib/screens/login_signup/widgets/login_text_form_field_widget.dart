import 'package:flutter/material.dart';
import 'package:movie_app/core/Colors.dart';

class LoginTextFormFieldWidget extends StatefulWidget {
  const LoginTextFormFieldWidget(
      {this.hintText,
      required this.controller,
      this.prefixIcon,
      this.suffixIcon,
      this.validator,
      this.keyboardType,
      this.password = false,
      super.key});
  final String? hintText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool password;
  @override
  State<LoginTextFormFieldWidget> createState() =>
      _LoginTextFormFieldWidgetState();
}

class _LoginTextFormFieldWidgetState extends State<LoginTextFormFieldWidget> {
  bool showPass = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: TextFormField(
        cursorColor: Colors.white,
        cursorErrorColor: Colors.white,
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        obscureText: widget.password && !showPass,
        style: const TextStyle(fontSize: 20, color: Colors.white),
        decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: AppColors.gold, width: 2)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: AppColors.gold, width: 2)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: AppColors.gold, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: AppColors.gold, width: 2)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red, width: 2)),
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.password == true
                ? IconButton(
                    onPressed: () {
                      showPass = !showPass;
                      setState(() {});
                    },
                    icon: Icon(
                      showPass == false
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.gold,
                      size: 30,
                    ))
                : widget.suffixIcon,
            errorStyle: const TextStyle(color: Colors.red),
            hintStyle: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.normal)),
      ),
    );
  }
}
