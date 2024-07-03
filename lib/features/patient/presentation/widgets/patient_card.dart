import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:noviindus_machine_test/core/extensions/context_extension.dart';
import 'package:noviindus_machine_test/core/theme/app_colors.dart';
import 'package:noviindus_machine_test/features/patient/domain/entity/patient_entity.dart';

class PatientCard extends StatelessWidget {
  final int index;
  final Patient patient;
  const PatientCard({
    super.key,
    required this.index,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.grayFill,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${(index + 1).toString()}.',
                  style: context.theme.textTheme.titleSmall,
                ),
                SizedBox(width: context.width * 0.05),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient.name ?? "No name found",
                        style: context.theme.textTheme.titleSmall,
                      ),
                      SizedBox(height: context.height * 0.005),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              patient.treatmentName ?? "No treatment found",
                              overflow: TextOverflow.ellipsis,
                              style:
                                  context.theme.textTheme.labelMedium?.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.height * 0.01),
                      Row(
                        children: [
                          buildStats(
                            context: context,
                            icon: Ionicons.calendar_outline,
                            text: patient.formattedDate,
                          ),
                          SizedBox(width: context.width * 0.05),
                          buildStats(
                            context: context,
                            icon: Ionicons.people_outline,
                            text: patient.user!.isEmpty
                                ? "Jithesh"
                                : patient.user ?? "No user found",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: EdgeInsets.only(
              left: context.width * 0.1,
              top: context.height * 0.005,
              bottom: context.height * 0.012,
              right: context.width * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("View Booking Details",
                    style: context.theme.textTheme.bodySmall?.copyWith(
                      color: Colors.black,
                    )),
                const Icon(
                  Ionicons.chevron_forward_outline,
                  color: AppColors.primaryColor,
                  size: 18,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Row buildStats({
    required BuildContext context,
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.errorColor,
          size: 18,
        ),
        SizedBox(width: context.width * 0.02),
        Text(
          text,
          style: context.theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
