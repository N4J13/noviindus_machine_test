// import 'package:fpdart/fpdart.dart';
// import 'package:noviindus_machine_test/core/api/api_provider.dart';
// import 'package:noviindus_machine_test/core/api/endpoints.dart';
// import 'package:noviindus_machine_test/core/error/failure.dart';

// class BranchRemoteDataSource {
//   final ApiProvider apiProvider;

//   BranchRemoteDataSource(this.apiProvider);

//   // Get branch list
//   Future<Either<Failure, List<Branch>>> getBranchList() async {
//     try {
//       final response = await apiProvider.get(Endpoints.branchList);
//       if (response.statusCode == 200) {
//         return Right(response.data);
//       } else {
//         return Left(ServerFailure("Server error occurred"));
//       }
//     } catch (e) {
//       return Left(ServerFailure("Server error occurred"));
//     }
//   }
// }
