import 'package:flutter/material.dart';
import 'package:utavine/common/widgets/appbar/custom_app_bar.dart';
import 'package:utavine/common/widgets/button/basic_app_button.dart';
import 'package:utavine/core/configs/theme/app_colors.dart';
import 'package:utavine/data/models/auth/create_user_req.dart';
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
            MaterialPageRoute(builder: (_) => const SignIpPage()),
          );
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthTitle(title: 'Register'),
              const SizedBox(height: 40),

              AuthLabel(text: 'FULL NAME'),
              const SizedBox(height: 4),
              UserInput(contr: _fullName),
              const SizedBox(height: 20),

              AuthLabel(text: 'EMAIL'),
              const SizedBox(height: 4),
              UserInput(contr: _email),
              const SizedBox(height: 20),

              AuthLabel(text: 'PASSWORD (8+ characters)'),
              const SizedBox(height: 4),
              UserInput(contr: _password),
              const SizedBox(height: 40),

              BasicAppButton(
                onPressed: () async {
                  var result = await sl<SignupUsecase>().call(
                    CreateUserReq(
                      fullName: _fullName.text.trim(),
                      email: _email.text.trim(),
                      password: _password.text,
                    ),
                  );
                  result.fold(
                    (l) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'Kindly provide valid credentials.',
                            style: TextStyle(color: AppColors.white),
                          ),
                          backgroundColor: AppColors.danger,
                        ),
                      );
                    },
                    (r) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Verification email sent. Please check your inbox.',
                          ),
                          duration: Duration(seconds: 4),
                          backgroundColor: AppColors.success,
                        ),
                      );
                      Future.delayed(const Duration(seconds: 4), () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignIpPage(),
                          ),
                          (route) => false,
                        );
                      });
                    },
                  );
                },
                title: 'Create Account',
                height: 60,
                bgColor: AppColors.primary,
              ),

              const SizedBox(height: 30),

              // Security Notice Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.darkBg.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    width: 1.2,
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Registration Policy",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.lgtGrey,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "• By registering, you agree to our Terms and Privacy Policy.\n"
                      "• We comply with data protection regulations.\n"
                      "• No personal data is shared with third-party services.\n"
                      "• You can delete your account anytime from settings.",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.lgtGrey,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}