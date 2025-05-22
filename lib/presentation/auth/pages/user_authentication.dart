import 'package:flutter/material.dart';
import 'package:utavine/common/widgets/appbar/custom_app_bar.dart';
import 'package:utavine/common/widgets/button/basic_app_button.dart';
import 'package:utavine/core/configs/assets/app_images.dart';
import 'package:utavine/core/configs/theme/app_colors.dart';
import 'package:utavine/presentation/auth/pages/signin_page.dart';
import 'package:utavine/presentation/auth/pages/signup_page.dart';

class UserAuthentication extends StatelessWidget {
  const UserAuthentication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Back Button
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logo, width: 180, height: 180),
                  const SizedBox(height: 50),
                  Text(
                    'Join the Vibe.',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Create an account or sign in to explore a world of music that will calm your mind.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.drkGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: BasicAppButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => SignUpPage(),
                              ),
                            );
                          },
                          title: 'Register',
                          height: 60,
                          bgColor: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: BasicAppButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => SignIpPage(),
                              ),
                            );
                          },
                          title: 'Login',
                          height: 60,
                          bgColor: AppColors.lgtGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
