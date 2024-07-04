import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noviindus_machine_test/core/services/storage_service.dart';
import 'package:noviindus_machine_test/di/locator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final storageService = getIt<StorageService>();

  Future<String?> getToken() async {
    return storageService.readToken();
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      getToken().then((token) {
        if (token != null) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Image.asset(
              "assets/images/logo.png",
              width: 150,
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}
