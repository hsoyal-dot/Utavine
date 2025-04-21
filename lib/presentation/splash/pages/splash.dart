import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:utavine/core/configs/assets/app_vectors.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:utavine/core/configs/theme/app_colors.dart';
import 'package:utavine/presentation/start/pages/get_started.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(children: [SvgPicture.asset(AppVectors.logo)]),
      backgroundColor: AppColors.darkBg,
      duration: 3000,
      splashTransition: SplashTransition.slideTransition,
      nextScreen: GetStarted(),
    );
  }
}
