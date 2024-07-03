import 'package:flutter/cupertino.dart';
import 'package:noviindus_machine_test/features/branch/domain/entity/branch.dart';
import 'package:noviindus_machine_test/features/branch/domain/usecases/get_branch_list.dart';

class BranchProvider extends ChangeNotifier {
  final GetBranchList getBranchList;

  BranchProvider(this.getBranchList);

  List<Branch> _branches = [];

  BranchState _state = BranchState.initial;
  Branch? _selectedBranch;

  Future<void> getBranches() async {
    _state = BranchState.loading;
    notifyListeners();
    final result = await getBranchList.execute();
    result.fold(
      (failure) {
        _state = BranchState.error;
        notifyListeners();
      },
      (branches) {
        _branches = branches;
        _state = BranchState.loaded;
        notifyListeners();
      },
    );
    notifyListeners();
  }

  void selectBranch(Branch branch) {
    _selectedBranch = branch;
    notifyListeners();
  }

  void clearBranch() {
    _selectedBranch = null;
    notifyListeners();
  }

  List<Branch> get branches => _branches;
  BranchState get state => _state;
  Branch? get selectedBranch => _selectedBranch;
}

enum BranchState { initial, loading, loaded, error }
