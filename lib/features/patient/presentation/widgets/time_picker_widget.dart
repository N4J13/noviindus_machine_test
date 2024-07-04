import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
import 'package:noviindus_machine_test/core/extensions/context_extension.dart';
import 'package:noviindus_machine_test/core/theme/app_colors.dart';
import 'package:noviindus_machine_test/features/patient/presentation/providers/patient_provider.dart';
import 'package:provider/provider.dart';

class TimePickerWidget extends StatelessWidget {
  const TimePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Time",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        const SizedBox(height: 8),
        Consumer<PatientProvider>(builder: (context, provider, child) {
          return Row(
            children: [
              Expanded(
                child: _buildTimePicker(
                  provider: provider,
                  context: context,
                  text: provider.selectedHour ?? "Hour",
                  onTap: () => _showHourPicker(context, provider),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTimePicker(
                  provider: provider,
                  context: context,
                  text: provider.selectedMinute ?? "Minutes",
                  onTap: () => _showMinutePicker(context, provider),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildTimePicker({
    required PatientProvider provider,
    required BuildContext context,
    required String text,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: context.theme.textTheme.labelLarge,
            ),
            const Icon(
              Ionicons.chevron_down_outline,
              size: 18,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  void _showHourPicker(BuildContext context, PatientProvider provider) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      enableDrag: true,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppBar(
              title: Text(
                'Select Hour',
                style: context.theme.textTheme.titleSmall,
              ),
              automaticallyImplyLeading: false,
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Ionicons.checkmark,
                      color: AppColors.primaryColor,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                height: 200,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                          initialItem:
                              _getInitialHourItem(provider.selectedHour),
                        ),
                        itemExtent: 32.0,
                        onSelectedItemChanged: (int value) {
                          provider.setSelectedHour(_formatHour(value + 1));
                        },
                        children: List<Widget>.generate(12, (int index) {
                          return Center(
                            child: Text(
                              (index + 1).toString().padLeft(2, '0'),
                              style: const TextStyle(fontSize: 20),
                            ),
                          );
                        }),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                          initialItem:
                              _getInitialAMPMItem(provider.selectedHour),
                        ),
                        itemExtent: 32.0,
                        onSelectedItemChanged: (int value) {
                          provider.setSelectedHour(_updateAMPM(
                              provider.selectedHour, value == 0 ? 'AM' : 'PM'));
                        },
                        children: ['AM', 'PM'].map((String amPm) {
                          return Center(
                            child: Text(
                              amPm,
                              style: const TextStyle(fontSize: 20),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  int _getInitialHourItem(String? selectedHour) {
    if (selectedHour == null) return 0;
    int hour = int.parse(selectedHour.split(' ')[0]);
    return (hour % 12 == 0 ? 11 : hour % 12 - 1);
  }

  int _getInitialAMPMItem(String? selectedHour) {
    if (selectedHour == null) return 0;
    return selectedHour.endsWith('PM') ? 1 : 0;
  }

  String _formatHour(int hour) {
    String amPm = hour >= 12 ? 'PM' : 'AM';
    int formattedHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '${formattedHour.toString().padLeft(2, '0')} $amPm';
  }

  String _updateAMPM(String? currentHour, String newAMPM) {
    if (currentHour == null) return '12 $newAMPM';
    return '${currentHour.split(' ')[0]} $newAMPM';
  }

  void _showMinutePicker(BuildContext context, PatientProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      enableDrag: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppBar(
              title: Text(
                'Select Minute',
                style: context.theme.textTheme.titleSmall,
              ),
              automaticallyImplyLeading: false,
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Ionicons.checkmark,
                    color: AppColors.primaryColor,
                  ),
                )
              ],
            ),
            Container(
              color: Colors.white,
              height: 200,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                  initialItem:
                      int.tryParse(provider.selectedMinute ?? "0") ?? 0,
                ),
                itemExtent: 32.0,
                onSelectedItemChanged: (int value) {
                  provider.setSelectedMinute(value.toString().padLeft(2, '0'));
                },
                children: List<Widget>.generate(60, (int index) {
                  return Center(
                    child: Text(
                      index.toString().padLeft(2, '0'),
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }
}
