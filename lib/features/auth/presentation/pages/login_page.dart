import 'package:flutter/material.dart';
import 'package:noviindus_machine_test/core/extensions/context_extension.dart';
import 'package:noviindus_machine_test/core/widgets/app_button.dart';
import 'package:noviindus_machine_test/core/widgets/app_textformfield.dart';
import 'package:noviindus_machine_test/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: context.height * 0.23,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/banner.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                SizedBox(height: context.height * 0.03),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login Or Register To Book Your Appointments',
                        style: context.theme.textTheme.bodyLarge,
                      ),
                      SizedBox(height: context.height * 0.04),
                      AppTextFormField(
                        controller: emailController,
                        label: 'Email',
                        filled: true,
                        hint: 'Enter your email',
                      ),
                      const SizedBox(height: 30),
                      AppTextFormField(
                        controller: passwordController,
                        label: 'Password',
                        filled: true,
                        hint: 'Enter your password',
                      ),
                      SizedBox(height: context.height * 0.05),
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          return AppButton(
                            isLoading:
                                authProvider.status == AuthStatus.loading,
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) return;

                              await authProvider.login(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              if (authProvider.status ==
                                  AuthStatus.authenticated) {
                                Navigator.pushReplacementNamed(
                                    context, '/home');
                              } else if (authProvider.status ==
                                  AuthStatus.error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      authProvider.errorMessage ??
                                          'An error occurred',
                                    ),
                                  ),
                                );
                              }
                            },
                            text: 'Login',
                          );
                        },
                      ),
                      SizedBox(height: context.height * 0.18),
                      Center(
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                text:
                                    'By creating or logging into an account you are agreeing with our',
                                style: context.theme.textTheme.bodySmall,
                              ),
                              TextSpan(
                                text: ' Terms and Conditions',
                                style:
                                    context.theme.textTheme.bodySmall?.copyWith(
                                  color: context.theme.colorScheme.tertiary,
                                ),
                              ),
                              TextSpan(
                                text: ' and',
                                style: context.theme.textTheme.bodySmall,
                              ),
                              TextSpan(
                                text: ' Privacy Policy',
                                style:
                                    context.theme.textTheme.bodySmall?.copyWith(
                                  color: context.theme.colorScheme.tertiary,
                                ),
                              ),
                            ])),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
