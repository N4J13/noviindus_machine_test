import 'package:flutter/material.dart';
import 'package:noviindus_machine_test/core/extensions/context_extension.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final TextInputType? keyboardType;
  const AppTextFormField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.theme.textTheme.labelLarge,
        ),
        const SizedBox(height: 10),
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
            hintText: hint,
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
