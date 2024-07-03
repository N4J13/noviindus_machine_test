import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:noviindus_machine_test/core/extensions/context_extension.dart';
import 'package:noviindus_machine_test/core/theme/app_colors.dart';
import 'package:noviindus_machine_test/features/patient/presentation/providers/patient_provider.dart';
import 'package:provider/provider.dart';

class DateSelectWidget extends StatelessWidget {
  const DateSelectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Date",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            Provider.of<PatientProvider>(context, listen: false)
                .selectDate(context);
          },
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color.fromARGB(64, 217, 217, 217),
              ),
              color: AppColors.grayFill,
            ),
            child: Consumer<PatientProvider>(
              builder: (context, provider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.formattedDate ?? "",
                      style: context.theme.textTheme.labelLarge,
                    ),
                    const Icon(
                      Ionicons.calendar_outline,
                      color: AppColors.primaryColor,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
