import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:utavine/common/helpers/is_dark_mode.dart';
import 'package:utavine/core/configs/assets/app_images.dart';
import 'package:utavine/core/configs/theme/app_theme.dart';
import 'package:utavine/presentation/start/pages/get_started.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: context.isDarkMode
          ? AppTheme.darkTheme.scaffoldBackgroundColor
          : AppTheme.lightTheme.scaffoldBackgroundColor,
      splash: Center(
        child: Image.asset(AppImages.logo, width: 200, height: 200),
      ),
      duration: 3000,
      splashTransition: SplashTransition.scaleTransition,
      nextScreen: const GetStarted(),
    );
  }
}