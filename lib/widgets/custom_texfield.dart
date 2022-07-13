import 'package:flutter/material.dart';

import './custom_text.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final double elevation;
  final String? labelText;
  final IconData? prefixIcon;
  final bool isPassword;
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.elevation = 1,
    this.labelText,
    this.prefixIcon,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.labelText == null ? 50 : 75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.labelText == null
              ? const SizedBox()
              : Column(
                  children: [
                    AppText(
                      text: widget.labelText!,
                      size: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
          Material(
            elevation: widget.elevation,
            color: Colors.white,
            child: TextField(
              controller: widget.controller,
              obscureText: isObscure,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.all(5),
                prefixIcon:
                    widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
                focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.purpleAccent, width: 1.5),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
                ),
                hintText: widget.hintText,
                hintStyle: const TextStyle(fontSize: 14),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        onPressed: () => setState(() => isObscure = !isObscure),
                        icon: isObscure
                            ? const Icon(Icons.remove_red_eye_outlined)
                            : const Icon(Icons.remove_red_eye_rounded))
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
