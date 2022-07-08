import 'package:flutter/material.dart';

import './custom_text.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final double elevation;
  final String? labelText;
  final IconData? prefixIcon;
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.elevation = 1,
    this.labelText,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: labelText == null ? 50 : 75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelText == null
              ? const SizedBox()
              : Column(
                  children: [
                    AppText(
                      text: labelText!,
                      size: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
          Material(
            elevation: elevation,
            color: Colors.white,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.all(5),
                prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
                focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.purpleAccent, width: 1.5),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
                ),
                hintText: hintText,
                hintStyle: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
