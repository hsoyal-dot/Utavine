import 'package:flutter/material.dart';
import 'package:utavine/core/configs/theme/app_colors.dart';

class AuthLabel extends StatelessWidget {
  final String text;
  const AuthLabel({
    required this.text,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.lgtGrey,
      ),
      // textAlign: TextAlign.left,
    );
  }
}