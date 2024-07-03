import 'package:flutter/material.dart';
import 'package:noviindus_machine_test/core/extensions/context_extension.dart';
import 'package:noviindus_machine_test/features/patient/presentation/providers/patient_provider.dart';
import 'package:provider/provider.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Location", style: context.theme.textTheme.labelLarge),
        const SizedBox(height: 8),
        Consumer<PatientProvider>(
          builder: (context, provider, child) {
            return DropdownButtonFormField(
                items: provider.locations
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: context.theme.textTheme.labelLarge,
                          ),
                        ))
                    .toList(),
                value: provider.selectedLocation,
                onChanged: (value) {
                  provider.selectLocation(value);
                });
          },
        ),
      ],
    );
  }
}
