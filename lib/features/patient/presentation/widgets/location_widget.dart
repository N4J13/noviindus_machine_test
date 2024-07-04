import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
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
                icon: const Icon(
                  Ionicons.chevron_down,
                  size: 18,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide:
                        BorderSide(color: Color.fromARGB(64, 217, 217, 217)),
                  ),
                ),
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
