import 'package:flutter/material.dart';
import 'package:utavine/common/widgets/appbar/custom_app_bar.dart';
import 'package:utavine/common/widgets/button/basic_app_button.dart';
import 'package:utavine/core/configs/theme/app_colors.dart';
import 'package:utavine/data/models/auth/create_user_auth.dart';
import 'package:utavine/domain/usecases/auth/signup_usecase.dart';
import 'package:utavine/presentation/auth/pages/signin_page.dart';
import 'package:utavine/presentation/auth/widgets/user_auth/auth_label.dart';
import 'package:utavine/presentation/auth/widgets/user_auth/auth_title.dart';
import 'package:utavine/presentation/auth/widgets/user_auth/footer_navigation.dart';
import 'package:utavine/presentation/auth/widgets/user_auth/user_input.dart';
import 'package:utavine/service_locator.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: FooterNavigation(
        text: 'Do you have an account?',
        footerText: 'Sign In',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const SignIpPage(),
            ),
          );
        },
      ),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthTitle(title: 'Register'),
              const SizedBox(height: 40),

              AuthLabel(text: 'FULL NAME'),
              const SizedBox(height: 4),
              UserInput(),
              const SizedBox(height: 20),

              AuthLabel(text: 'EMAIL'),
              const SizedBox(height: 4),
              UserInput(),
              const SizedBox(height: 20),

              AuthLabel(text: 'PASSWORD'),
              const SizedBox(height: 4),
              UserInput(),
              const SizedBox(height: 40),

              BasicAppButton(
                onPressed: () async {
                  // var result = await sl<SignupUsecase>().call(
                  //   params: CreateUserAuth(
                  //     fullName: fullName,
                  //     email: email,
                  //     password: password,
                  //   ),
                  // );
                },
                title: 'Create Account',
                height: 60,
                bgColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
