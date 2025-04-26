import 'package:flutter/material.dart';
import 'package:utavine/core/configs/theme/app_colors.dart';

class FooterNavigation extends StatelessWidget {
  final String text;
  final String footerText;
  final VoidCallback? onPressed;
  const FooterNavigation({
    super.key,
    required this.text,
    required this.footerText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.lgtGrey,
              ),
            ),
            TextButton(onPressed: onPressed, child: Text(footerText)),
          ],
        ),
      ),
    );
  }
}