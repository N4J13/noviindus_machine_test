import 'package:flutter/material.dart';
import 'package:noviindus_machine_test/core/extensions/context_extension.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final TextInputType? keyboardType;
  final bool filled;
  final Widget? prefixIcon;
  final bool secondaryStyle;
  const AppTextFormField({
    super.key,
    required this.controller,
    this.label,
    this.filled = false,
    this.prefixIcon,
    this.hint,
    this.keyboardType,
    this.secondaryStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Text(
                label!,
                style: context.theme.textTheme.labelLarge,
              )
            : const SizedBox.shrink(),
        label != null ? const SizedBox(height: 8) : const SizedBox.shrink(),
        TextFormField(
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          controller: controller,
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: secondaryStyle
                  ? BorderSide(
                      color: Colors.grey.shade300,
                    )
                  : const BorderSide(
                      color: Color.fromARGB(64, 217, 217, 217),
                    ),
            ),
            filled: filled,
            hintText: hint,
            prefixIcon: prefixIcon,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return '$label cannot be empty';
            }
            return null;
          },
        ),
      ],
    );
  }
}
