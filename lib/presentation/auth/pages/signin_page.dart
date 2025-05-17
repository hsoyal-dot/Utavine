import 'package:flutter/material.dart';
import 'package:utavine/common/widgets/appbar/custom_app_bar.dart';
import 'package:utavine/common/widgets/button/basic_app_button.dart';
import 'package:utavine/core/configs/theme/app_colors.dart';
import 'package:utavine/presentation/auth/pages/signup_page.dart';
import 'package:utavine/presentation/auth/widgets/user_auth/auth_label.dart';
import 'package:utavine/presentation/auth/widgets/user_auth/auth_title.dart';
import 'package:utavine/presentation/auth/widgets/user_auth/footer_navigation.dart';
import 'package:utavine/presentation/auth/widgets/user_auth/user_input.dart';

class SignIpPage extends StatelessWidget {
  const SignIpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: FooterNavigation(
        text: 'Not having an account?',
        footerText: 'Register Now',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => SignUpPage()),
          );
        },
      ),
      appBar: CustomAppBar(
        // title: Image.asset(
        //   AppImages.logo,
        //   height: 100,
        //   width: 100,
        //   ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthTitle(title: 'Login'),
            const SizedBox(height: 40),

            AuthLabel(text: 'USERNAME, EMAIL OR PHONE'),
            const SizedBox(height: 4),
            UserInput(),
            const SizedBox(height: 20),

            AuthLabel(text: 'PASSWORD'),
            const SizedBox(height: 4),
            UserInput(),
            const SizedBox(height: 40),

            BasicAppButton(
              onPressed: () {},
              title: 'Login',
              height: 60,
              bgColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
