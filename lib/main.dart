import 'package:flutter/material.dart';
import 'package:noviindus_machine_test/core/pages/splash_page.dart';
import 'package:noviindus_machine_test/core/theme/app_theme.dart';
import 'package:noviindus_machine_test/di/locator.dart';
import 'package:noviindus_machine_test/features/auth/presentation/pages/login_page.dart';
import 'package:noviindus_machine_test/features/auth/presentation/providers/auth_provider.dart';
import 'package:noviindus_machine_test/features/branch/presentation/providers/branch_provider.dart';
import 'package:noviindus_machine_test/features/patient/presentation/pages/patient_list_page.dart';
import 'package:noviindus_machine_test/features/patient/presentation/pages/patient_register_page.dart';
import 'package:noviindus_machine_test/features/patient/presentation/providers/patient_provider.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => getIt<AuthProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<PatientProvider>()),
      ChangeNotifierProvider(create: (_) => getIt<BranchProvider>())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const SplashPage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => const PatientListPage(),
        '/login': (BuildContext context) => const LoginPage(),
        "/register": (context) => const PatientRegisterPage(),
      },
    );
  }
}
