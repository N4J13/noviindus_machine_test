import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:noviindus_machine_test/core/extensions/context_extension.dart';
import 'package:noviindus_machine_test/core/widgets/app_button.dart';
import 'package:noviindus_machine_test/core/widgets/app_textformfield.dart';
import 'package:noviindus_machine_test/features/branch/presentation/providers/branch_provider.dart';
import 'package:noviindus_machine_test/features/branch/presentation/widgets/select_branch_widget.dart';
import 'package:noviindus_machine_test/features/patient/presentation/pages/patient_list_page.dart';
import 'package:noviindus_machine_test/features/patient/presentation/providers/patient_provider.dart';
import 'package:noviindus_machine_test/features/patient/presentation/widgets/date_select_widget.dart';
import 'package:noviindus_machine_test/features/patient/presentation/widgets/location_widget.dart';
import 'package:noviindus_machine_test/features/patient/presentation/widgets/payment_option_widget.dart';
import 'package:noviindus_machine_test/features/patient/presentation/widgets/time_picker_widget.dart';
import 'package:noviindus_machine_test/features/treatment/presentation/providers/treatment_provider.dart';
import 'package:noviindus_machine_test/features/treatment/presentation/widgets/add_treatment.dart';
import 'package:provider/provider.dart';

class PatientRegisterPage extends StatefulWidget {
  const PatientRegisterPage({super.key});

  @override
  State<PatientRegisterPage> createState() => _PatientRegisterPageState();
}

class _PatientRegisterPageState extends State<PatientRegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController whatsappNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController discountAmountController = TextEditingController();
  TextEditingController advanceAmountController = TextEditingController();
  TextEditingController balanceAmountController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    whatsappNameController.dispose();
    addressController.dispose();
    totalAmountController.dispose();
    discountAmountController.dispose();
    advanceAmountController.dispose();
    balanceAmountController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<PatientProvider>(context, listen: false).clearDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                  bottom: 0,
                ),
                child: _buildHeader(context),
              ),
              const Divider(),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      AppTextFormField(
                        controller: nameController,
                        label: "Name",
                        filled: true,
                        hint: 'Enter your Name',
                      ),
                      SizedBox(
                        height: context.height * 0.025,
                      ),
                      AppTextFormField(
                        controller: whatsappNameController,
                        label: "Whatsapp Number",
                        keyboardType: TextInputType.phone,
                        hint: 'Enter your Whatsapp Number',
                      ),
                      SizedBox(
                        height: context.height * 0.025,
                      ),
                      AppTextFormField(
                        controller: addressController,
                        label: "Address",
                        hint: 'Enter your Address',
                      ),
                      SizedBox(
                        height: context.height * 0.025,
                      ),
                      AppTextFormField(
                        controller: totalAmountController,
                        label: "Total Amount",
                        keyboardType: TextInputType.number,
                        hint: 'Enter your Total Amount',
                      ),
                      SizedBox(
                        height: context.height * 0.025,
                      ),
                      AppTextFormField(
                        controller: discountAmountController,
                        label: "Discount Amount",
                        keyboardType: TextInputType.number,
                        hint: 'Enter your Discount Amount',
                      ),
                      SizedBox(
                        height: context.height * 0.025,
                      ),
                      AppTextFormField(
                        controller: advanceAmountController,
                        keyboardType: TextInputType.number,
                        label: "Advance Amount",
                        hint: 'Enter your Advance Amount',
                      ),
                      SizedBox(
                        height: context.height * 0.025,
                      ),
                      const LocationWidget(),
                      SizedBox(
                        height: context.height * 0.025,
                      ),
                      const SelectBranchWidget(),
                      SizedBox(
                        height: context.height * 0.025,
                      ),
                      const AddTreatmentWidget(),
                      SizedBox(
                        height: context.height * 0.025,
                      ),
                      AppTextFormField(
                        controller: balanceAmountController,
                        keyboardType: TextInputType.number,
                        label: "Balance Amount",
                        hint: 'Enter your Balance Amount',
                      ),
                      SizedBox(
                        height: context.height * 0.025,
                      ),
                      const PaymentOptionWidget(),
                      SizedBox(
                        height: context.height * 0.025,
                      ),
                      const DateSelectWidget(),
                      SizedBox(
                        height: context.height * 0.025,
                      ),
                      const TimePickerWidget(),
                      SizedBox(
                        height: context.height * 0.05,
                      ),
                      Consumer<PatientProvider>(
                        builder: (context, provider, child) {
                          return AppButton(
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) return;
                              await provider.registerPatient(
                                name: nameController.text,
                                whatsappNumber: whatsappNameController.text,
                                address: addressController.text,
                                totalAmount: totalAmountController.text,
                                discountAmount: discountAmountController.text,
                                treatmentData: Provider.of<TreatmentProvider>(
                                        context,
                                        listen: false)
                                    .treatmentData,
                                advanceAmount: advanceAmountController.text,
                                balanceAmount: balanceAmountController.text,
                                branchId: Provider.of<BranchProvider>(context,
                                        listen: false)
                                    .selectedBranch!
                                    .id
                                    .toString(),
                              );

                              if (provider.state == PatientState.registered) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PatientListPage()));
                                return;
                              }

                              if (provider.state == PatientState.error) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(provider.errorMessage!),
                                ));
                              }
                            },
                            text: 'Register Patient',
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const PatientListPage()));
              },
              child: const Icon(
                Ionicons.arrow_back,
                size: 25,
              ),
            ),
            buildNotificationIcon(context)
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Register',
          style: context.theme.textTheme.bodyLarge,
        ),
      ],
    );
  }
}
