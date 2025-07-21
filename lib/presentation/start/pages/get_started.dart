import 'dart:async';

import 'package:flutter/material.dart';
import 'package:utavine/common/widgets/button/basic_app_button.dart';
import 'package:utavine/core/configs/theme/app_colors.dart';
import 'package:utavine/presentation/auth/pages/user_authentication.dart';
import 'package:video_player/video_player.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  late VideoPlayerController _videoPlayerController;
  String _utaText = 'Utavine';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(
        'assets/videos/intro_bg.mp4',
      )
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
        _videoPlayerController.setVolume(0);
        _videoPlayerController.setLooping(true);
      });

    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _utaText = _utaText == 'Utavine' ? '歌vine' : 'Utavine';
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _videoPlayerController.value.isInitialized
              ? SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _videoPlayerController.value.size.width,
                    height: _videoPlayerController.value.size.height,
                    child: VideoPlayer(_videoPlayerController),
                  ),
                ),
              )
              : Container(color: Colors.black),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            color: AppColors.darkBg.withValues(alpha: 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Column(
                  children: [
                    const Text(
                      'Welcome to ',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    final inAnimation = Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation);

                    final outAnimation = Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(0.0, 0.0),
                    ).animate(animation);

                    return AnimatedBuilder(
                      animation: animation,
                      builder: (context, childWidget) {
                        final isIncoming = child.key == ValueKey(_utaText);
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: isIncoming ? inAnimation : outAnimation,
                            child: childWidget,
                          ),
                        );
                      },
                      child: child,
                    );
                  },
                  child: Text(
                    _utaText,
                    key: ValueKey(_utaText),
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
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
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 400),
                        pageBuilder: (_, __, ___) => const UserAuthentication(),
                        transitionsBuilder: (_, animation, __, child) {
                          final offsetAnimation = Tween<Offset>(
                            begin: const Offset(
                              1.0,
                              0.0,
                            ),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOut,
                            ),
                          );
                          final fadeAnimation = Tween<double>(
                            begin: 0.0,
                            end: 1.0,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeIn,
                            ),
                          );
                          return SlideTransition(
                            position: offsetAnimation,
                            child: FadeTransition(
                              opacity: fadeAnimation,
                              child: child,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  title: 'Get Started',
                  height: 80,
                  bgColor: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}