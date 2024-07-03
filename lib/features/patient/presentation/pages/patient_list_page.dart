import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:noviindus_machine_test/core/extensions/context_extension.dart';
import 'package:noviindus_machine_test/core/theme/app_colors.dart';
import 'package:noviindus_machine_test/features/patient/presentation/providers/patient_provider.dart';
import 'package:noviindus_machine_test/features/patient/presentation/widgets/patient_card.dart';
import 'package:noviindus_machine_test/features/patient/presentation/widgets/search_treatment_widget.dart';
import 'package:noviindus_machine_test/features/patient/presentation/widgets/sort_widget.dart';
import 'package:provider/provider.dart';

class PatientListPage extends StatefulWidget {
  const PatientListPage({super.key});

  @override
  State<PatientListPage> createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<PatientProvider>(context, listen: false).getPatientList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  buildNotificationIcon(context),
                  const SizedBox(height: 20),
                  const SearchTreatmentWidget(),
                  const SizedBox(height: 20),
                  const SortWidget()
                ],
              ),
            ),
            const Divider(),
            Consumer<PatientProvider>(
              builder: (context, provider, child) {
                if (provider.state == PatientState.loading) {
                  return SizedBox(
                    height: context.height * 0.5,
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryColor),
                      ),
                    ),
                  );
                } else if (provider.state == PatientState.error) {
                  return Center(
                    child: Text(provider.errorMessage!),
                  );
                } else if (provider.patientList.isEmpty) {
                  return const Center(
                    child: Text("No patients found"),
                  );
                } else {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await provider.getPatientList();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: ListView.separated(
                            itemCount: provider.patientList.length,
                            itemBuilder: (context, index) {
                              final patient = provider.patientList[index];
                              return PatientCard(
                                index: index,
                                patient: patient,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                )),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: context.width * 0.9,
        child: FloatingActionButton.extended(
          label: const Text('Register Patient'),
          isExtended: true,
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Row buildNotificationIcon(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/login');
        },
        icon: Stack(
          children: [
            const Icon(
              Ionicons.notifications_outline,
              size: 30,
              color: Colors.black,
            ),
            Positioned(
              right: 5,
              top: 2,
              child: Container(
                height: 8,
                width: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
