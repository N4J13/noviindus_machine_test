import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:noviindus_machine_test/core/widgets/app_button.dart';
import 'package:noviindus_machine_test/core/widgets/app_textformfield.dart';

class SearchTreatmentWidget extends StatelessWidget {
  const SearchTreatmentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: AppTextFormField(
            prefixIcon: const Icon(
              Ionicons.search_outline,
              color: Colors.black,
            ),
            secondaryStyle: true,
            controller: controller,
            hint: "Search for your treatment",
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AppButton(
            onPressed: () {},
            text: "Search",
          ),
        )
      ],
    );
  }
}
