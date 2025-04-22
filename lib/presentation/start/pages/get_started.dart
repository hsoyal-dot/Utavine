import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:utavine/common/basic_app_button.dart';
import 'package:utavine/core/configs/assets/app_images.dart';
import 'package:utavine/core/configs/assets/app_vectors.dart';
import 'package:utavine/core/configs/theme/app_colors.dart';
import 'package:utavine/presentation/choose_mode/pages/choose_mode_page.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.introBg),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(AppVectors.logo),
                ),
                const Spacer(),
                const Text(
                  'Welcome to Utavine',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 10),
                const Text(
                  'A new way to discover songs that match your vibe. Let tunes grow on you like a vine.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lgtGrey,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 25),
                BasicAppButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (BuildContext context) => const ChooseModePage(),
                      ),
                    );
                  },
                  title: 'Get Started',
                  height: 80,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
