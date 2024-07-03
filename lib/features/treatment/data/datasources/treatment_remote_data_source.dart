// import 'package:fpdart/fpdart.dart';
// import 'package:noviindus_machine_test/core/api/api_provider.dart';
// import 'package:noviindus_machine_test/core/api/endpoints.dart';
// import 'package:noviindus_machine_test/core/error/failure.dart';

// class TreatmentRemoteDataSource {
//   final ApiProvider apiProvider;

//   TreatmentRemoteDataSource(this.apiProvider);

//   // Get treatment list
//   Future<Either<Failure, List<Treatment>>> getTreatmentList() async {
//     try {
//       final response = await apiProvider.get(Endpoints.treatmentList);
//       if (response.statusCode == 200) {
//         return Right(response.data);
//       } else {
//         return Left(ServerFailure("Server error occurred"));
//       }
//     } catch (e) {
//       return Left(NetworkFailure("Server error occurred"));
//     }
//   }
// }
