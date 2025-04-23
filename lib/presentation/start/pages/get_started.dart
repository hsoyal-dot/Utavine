import 'dart:async';

import 'package:flutter/material.dart';
import 'package:utavine/common/basic_app_button.dart';
import 'package:utavine/core/configs/assets/app_images.dart';
import 'package:utavine/core/configs/theme/app_colors.dart';
import 'package:utavine/presentation/choose_mode/pages/choose_mode_page.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  String _utaText = 'Uta';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _utaText = _utaText == 'Uta' ? '  歌' : 'Uta';
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
                // Align(
                //   alignment: Alignment.topCenter,
                //   child: Image.asset(AppImages.logo, width: 200, height: 200),
                // ),
                const Spacer(),
                Row(
                  children: [
                    const Text(
                      'Welcome to ',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      transitionBuilder: (
                        Widget child,
                        Animation<double> animation,
                      ) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 1.0),
                            end: const Offset(0.0, 0.0),
                          ).animate(animation),
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        _utaText,
                        key: ValueKey(_utaText),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    Text(
                      'vine',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
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
