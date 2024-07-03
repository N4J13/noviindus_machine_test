import 'package:get_it/get_it.dart';
import 'package:noviindus_machine_test/core/api/api_provider.dart';
import 'package:noviindus_machine_test/core/services/storage_service.dart';
import 'package:noviindus_machine_test/features/auth/data/data.dart';
import 'package:noviindus_machine_test/features/auth/domain/domain.dart';
import 'package:noviindus_machine_test/features/auth/presentation/providers/auth_provider.dart';
import 'package:noviindus_machine_test/features/branch/data/datasources/branch_remote_datasource.dart';
import 'package:noviindus_machine_test/features/branch/data/repositories/branch_repository_impl.dart';
import 'package:noviindus_machine_test/features/branch/domain/repositories/branch_repository.dart';
import 'package:noviindus_machine_test/features/branch/domain/usecases/get_branch_list.dart';
import 'package:noviindus_machine_test/features/branch/presentation/providers/branch_provider.dart';
import 'package:noviindus_machine_test/features/patient/data/datasources/patient_remote_datasource.dart';
import 'package:noviindus_machine_test/features/patient/data/repositories/patient_repository_impl.dart';
import 'package:noviindus_machine_test/features/patient/domain/repositories/patient_repository.dart';
import 'package:noviindus_machine_test/features/patient/domain/usecases/get_patient_list.dart';
import 'package:noviindus_machine_test/features/patient/domain/usecases/register_patient.dart';
import 'package:noviindus_machine_test/features/patient/presentation/providers/patient_provider.dart';
import 'package:noviindus_machine_test/features/treatment/data/datasources/treatment_remote_data_source.dart';
import 'package:noviindus_machine_test/features/treatment/data/repositories/treatment_repository_impl.dart';
import 'package:noviindus_machine_test/features/treatment/domain/repositories/treatment_repository.dart';
import 'package:noviindus_machine_test/features/treatment/domain/usecases/get_treatment_list.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Register services
  getIt
    ..registerSingleton<StorageService>(StorageService())
    ..registerSingleton<ApiProvider>(ApiProvider());

  _registerUseCases();
  _registerRepositories();
  _registerDataSources();
  _registerProviders();
}

// Register use cases
void _registerUseCases() {
  getIt
    ..registerFactory<LoginUseCase>(() => LoginUseCase(getIt()))
    ..registerFactory<GetBranchList>(() => GetBranchList(getIt()))
    // ..registerFactory<GetTreatmentList>(() => GetTreatmentList(getIt()))
    ..registerFactory<GetPatientListUseCase>(
        () => GetPatientListUseCase(getIt()));
  // ..registerFactory<RegisterPatient>(() => RegisterPatient(getIt()));
}

// Register repositories
void _registerRepositories() {
  getIt
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(getIt()))
    ..registerFactory<BranchRepository>(() => BranchRepositoryImpl(getIt()))
    // ..registerFactory<TreatmentRepository>(
    //     () => TreatmentRepositoryImpl(getIt()))
    ..registerFactory<PatientRepository>(() => PatientRepositoryImpl(getIt()));
}

// Register data sources
void _registerDataSources() {
  getIt
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSource(getIt(), getIt()))
    ..registerFactory<BranchRemoteDataSource>(
        () => BranchRemoteDataSource(getIt()))
    // ..registerFactory<TreatmentRemoteDataSource>(
    //     () => TreatmentRemoteDataSource(getIt()))
    ..registerFactory<PatientRemoteDataSource>(
        () => PatientRemoteDataSource(getIt()));
}

// Register providers
void _registerProviders() {
  getIt
    ..registerFactory<AuthProvider>(() => AuthProvider(getIt()))
    ..registerFactory<BranchProvider>(() => BranchProvider(getIt()))
    // ..registerFactory<TreatmentRepository>(
    //     () => TreatmentRepositoryImpl(getIt()))
    ..registerFactory<PatientProvider>(() => PatientProvider(getIt()));
}
