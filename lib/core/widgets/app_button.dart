import 'package:flutter/material.dart';
import 'package:noviindus_machine_test/core/theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  final double width;
  final bool secondaryType;
  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width = double.infinity,
    this.isLoading = false,
    this.secondaryType = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(Size(width, 50)),
        backgroundColor: MaterialStateProperty.all<Color>(
          secondaryType ? AppColors.primaryTint : AppColors.primaryColor,
        ),
      ),
      child: !isLoading
          ? Text(
              text,
              style: TextStyle(
                color: secondaryType ? Colors.black : Colors.white,
                fontWeight: FontWeight.w600,
              ),
            )
          : const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
    );
  }
}
