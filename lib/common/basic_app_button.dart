import 'package:flutter/material.dart';
import 'package:utavine/core/configs/theme/app_colors.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color bgColor;
  final double? height;
  const BasicAppButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.height,
    required this.bgColor,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 80),
        backgroundColor: bgColor,
      ),
      child: Text(title, style: const TextStyle(color: AppColors.white)),
    );
  }
}
