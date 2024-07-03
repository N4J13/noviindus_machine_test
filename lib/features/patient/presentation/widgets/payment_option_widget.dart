import 'package:flutter/material.dart';
import 'package:noviindus_machine_test/core/extensions/context_extension.dart';
import 'package:noviindus_machine_test/features/patient/presentation/providers/patient_provider.dart';
import 'package:provider/provider.dart';

class PaymentOptionWidget extends StatelessWidget {
  const PaymentOptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Option",
          style: context.theme.textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        Consumer<PatientProvider>(
          builder: (context, provider, child) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: provider.paymentOptions
                  .map(
                    (option) => Expanded(
                      child: Row(
                        children: [
                          Radio(
                            value: option,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            groupValue: provider.selectedPaymentOption,
                            onChanged: (value) {
                              provider.selectPaymentOption(value);
                            },
                          ),
                          Text(
                            option,
                            style: context.theme.textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
