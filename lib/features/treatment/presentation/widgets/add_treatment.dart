import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:noviindus_machine_test/core/extensions/context_extension.dart';
import 'package:noviindus_machine_test/core/theme/app_colors.dart';
import 'package:noviindus_machine_test/core/widgets/app_button.dart';
import 'package:noviindus_machine_test/features/treatment/domain/entity/treatment_data.dart';
import 'package:noviindus_machine_test/features/treatment/presentation/providers/treatment_provider.dart';
import 'package:provider/provider.dart';

class AddTreatmentWidget extends StatefulWidget {
  const AddTreatmentWidget({super.key});

  @override
  State<AddTreatmentWidget> createState() => _AddTreatmentWidgetState();
}

class _AddTreatmentWidgetState extends State<AddTreatmentWidget> {
  @override
  void initState() {
    super.initState();
    Provider.of<TreatmentProvider>(context, listen: false).getTreatments();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<TreatmentProvider>(context, listen: false).clearTreatment();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Treatment",
          style: context.theme.textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        Consumer<TreatmentProvider>(
          builder: (context, provider, child) {
            if (provider.state == TreatmentState.loading) {
              return const CircularProgressIndicator();
            } else if (provider.state == TreatmentState.error) {
              return const Text("Error");
            }
            return Column(
              children: [
                Column(
                  children: provider.treatmentData.asMap().entries.map((entry) {
                    int index = entry.key;
                    TreatmentData treatmentData = entry.value;

                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.grayFill,
                      ),
                      padding: const EdgeInsets.all(8), // Add padding if needed
                      margin: const EdgeInsets.symmetric(
                        vertical: 4,
                      ), // Add margin if needed
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${index + 1}.', // Display the index
                            style: context.theme.textTheme.labelLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: context.width * 0.03),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        treatmentData.treatment.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: context
                                            .theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        provider.removeTreatmentData(index);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: const Icon(
                                          Ionicons.close_outline,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(children: [
                                        Row(
                                          children: [
                                            Text("Male",
                                                style: context
                                                    .theme.textTheme.labelLarge
                                                    ?.copyWith(
                                                  color: AppColors.primaryColor,
                                                )),
                                            const SizedBox(width: 8),
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black26,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  treatmentData.noOfMalePatients
                                                      .toString(),
                                                  style: context.theme.textTheme
                                                      .labelLarge,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(width: context.width * 0.1),
                                        Row(
                                          children: [
                                            Text("Female",
                                                style: context
                                                    .theme.textTheme.labelLarge
                                                    ?.copyWith(
                                                  color: AppColors.primaryColor,
                                                )),
                                            const SizedBox(width: 8),
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black26,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  treatmentData
                                                      .noOfFemalePatients
                                                      .toString(),
                                                  style: context.theme.textTheme
                                                      .labelLarge,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ]),
                                    ),
                                    SizedBox(width: context.width * 0.1),
                                    GestureDetector(
                                      onTap: () {
                                        _showTreatmentPicker(
                                          context: context,
                                          treatmentData: treatmentData,
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: const Icon(
                                          Ionicons.pencil_outline,
                                          color: AppColors.primaryColor,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                AppButton(
                  text: "Add Treatment",
                  secondaryType: true,
                  onPressed: () {
                    _showTreatmentPicker(
                      context: context,
                    );
                  },
                ),
              ],
            );
          },
        )
      ],
    );
  }

  void _showTreatmentPicker({
    required BuildContext context,
    TreatmentData? treatmentData,
  }) {
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Consumer<TreatmentProvider>(
          builder: (context, provider, child) {
            return Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Choose Treatment",
                    style: context.theme.textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                            color: Color.fromARGB(64, 217, 217, 217)),
                      ),
                    ),
                    icon: const Icon(
                      Ionicons.chevron_down_outline,
                    ),
                    hint: Text(
                      treatmentData != null ? treatmentData.treatment.name : "",
                      style: context.theme.textTheme.labelLarge,
                    ),
                    items: provider.treatments.map((e) {
                      return DropdownMenuItem(
                        value:
                            treatmentData != null ? treatmentData.treatment : e,
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: context.width * 0.7),
                          child: Text(
                            e.name,
                            overflow: TextOverflow.ellipsis,
                            style: context.theme.textTheme.labelLarge,
                          ),
                        ),
                      );
                    }).toList(),
                    value: provider.selectedTreatment,
                    onChanged: (value) {
                      provider.selectTreatment(value!);
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Add Patients",
                    style: context.theme.textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  _buildPatientSelect(
                    context: context,
                    provider: provider,
                    treatmentData: treatmentData,
                    text: "Male",
                    value: treatmentData != null
                        ? treatmentData.noOfMalePatients
                        : provider.noOfMalePatients!,
                  ),
                  const SizedBox(height: 8),
                  _buildPatientSelect(
                    context: context,
                    provider: provider,
                    treatmentData: treatmentData,
                    text: "Female",
                    value: treatmentData != null
                        ? treatmentData.noOfFemalePatients
                        : provider.noOfFemalePatients!,
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    onPressed: () {
                      treatmentData == null
                          ? provider.addTreatmentData(
                              TreatmentData(
                                treatment: provider.selectedTreatment!,
                                noOfMalePatients: provider.noOfMalePatients!,
                                noOfFemalePatients:
                                    provider.noOfFemalePatients!,
                              ),
                            )
                          : provider.updateTreatmentData(
                              treatmentData,
                              provider.noOfMalePatients!,
                              provider.noOfFemalePatients!,
                              provider.treatmentData.indexWhere(
                                (element) =>
                                    element.treatment.id ==
                                    treatmentData.treatment.id,
                              ),
                            );
                      Navigator.pop(context);
                    },
                    text: "Add Treatment",
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPatientSelect({
    required BuildContext context,
    required String text,
    required int value,
    TreatmentData? treatmentData,
    required TreatmentProvider provider,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
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
            child: Center(
              child: Text(
                text,
                style: context.theme.textTheme.labelLarge,
              ),
            ),
          ),
        ),
        SizedBox(width: context.width * 0.1),
        // Increment and decrement buttons and value
        Row(
          children: [
            IconButton(
              color: Colors.white,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.primaryColor),
              ),
              onPressed: () {
                provider.updatePatientCount(
                  gender: text.toLowerCase(),
                  treatmentData: treatmentData,
                  type: Type.decrement,
                );
              },
              icon: const Icon(Icons.remove),
            ),
            const SizedBox(
              width: 8,
            ),
            _buildValueContainer(
              value: value,
            ),
            const SizedBox(
              width: 8,
            ),
            IconButton(
              color: Colors.white,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.primaryColor),
              ),
              onPressed: () {
                provider.updatePatientCount(
                  type: Type.increment,
                  treatmentData: treatmentData,
                  gender: text.toLowerCase(),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildValueContainer({
    required int value,
  }) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.solid,
          color: const Color.fromARGB(62, 78, 76, 76),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          value == 0 ? "" : value.toString(),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
