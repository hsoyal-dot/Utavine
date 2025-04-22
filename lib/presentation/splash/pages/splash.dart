import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:utavine/core/configs/assets/app_vectors.dart';
import 'package:utavine/presentation/start/pages/get_started.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(children: [SvgPicture.asset(AppVectors.logo)]),
      duration: 3000,
      splashTransition: SplashTransition.decoratedBoxTransition,
      nextScreen: GetStarted(),
    );
  }
}
