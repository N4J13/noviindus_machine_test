import 'package:flutter/material.dart';
import 'package:noviindus_machine_test/core/extensions/context_extension.dart';
import 'package:noviindus_machine_test/features/branch/domain/entity/branch.dart';
import 'package:noviindus_machine_test/features/branch/presentation/providers/branch_provider.dart';
import 'package:provider/provider.dart';

class SelectBranchWidget extends StatefulWidget {
  const SelectBranchWidget({super.key});

  @override
  State<SelectBranchWidget> createState() => _SelectBranchWidgetState();
}

class _SelectBranchWidgetState extends State<SelectBranchWidget> {
  @override
  void initState() {
    super.initState();
    Provider.of<BranchProvider>(context, listen: false).getBranches();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<BranchProvider>(context, listen: false).clearBranch();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Branch",
          style: context.theme.textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        Consumer<BranchProvider>(builder: (context, provider, child) {
          if (provider.state == BranchState.loading) {
            return const CircularProgressIndicator();
          } else if (provider.state == BranchState.error) {
            return const Text("Error");
          } else {
            return DropdownButtonFormField(
              value: provider.selectedBranch,
              onChanged: (Branch? value) {
                provider.selectBranch(value!);
              },
              items: provider.branches
                  .map((branch) => DropdownMenuItem(
                        value: branch,
                        child: Text(
                          branch.name,
                          style: context.theme.textTheme.labelLarge,
                        ),
                      ))
                  .toList(),
            );
          }
        })
      ],
    );
  }
}
