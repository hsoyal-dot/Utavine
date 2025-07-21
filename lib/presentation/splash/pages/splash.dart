import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:utavine/common/widgets/loader/custom_loader.dart';
import 'package:utavine/presentation/start/pages/get_started.dart';
import 'package:utavine/presentation/vine_sense/pages/vine_sense_screen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  Future<bool> checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await user.reload();
        final refreshedUser = FirebaseAuth.instance.currentUser;
        return refreshedUser != null;
      } catch (e) {
        print('Error checking auth status, debugging: $e');
        return false;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkAuthStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == true) {
            return const VineSenseScreen();
          } else {
            return const GetStarted();
          }
        } else {
          return const Scaffold(
            body: CustomLoader(),
          );
        }
      },
    );
  }
}