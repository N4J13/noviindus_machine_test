import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:noviindus_machine_test/core/extensions/context_extension.dart';

class SortWidget extends StatelessWidget {
  const SortWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        flex: 3,
        child: Text(
          "Sort by:",
          style: context.theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: DropdownButtonFormField<String>(
          value: "Date",
          icon: const Icon(
            Ionicons.chevron_down_outline,
            size: 18,
          ),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            filled: false,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          onChanged: (String? newValue) {},
          items: <String>['Name', 'Treatment', 'Date']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    ]);
  }
}
