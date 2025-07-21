// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:utavine/common/widgets/appbar/custom_app_bar.dart';
import 'package:utavine/common/widgets/button/basic_app_button.dart';
import 'package:utavine/core/configs/theme/app_colors.dart';
import 'package:utavine/data/models/auth/login_user_req.dart';
import 'package:utavine/domain/usecases/auth/signin_usecase.dart';
import 'package:utavine/presentation/auth/pages/signup_page.dart';
import 'package:utavine/presentation/auth/widgets/user_auth/auth_label.dart';
import 'package:utavine/presentation/auth/widgets/user_auth/auth_title.dart';
import 'package:utavine/presentation/auth/widgets/user_auth/footer_navigation.dart';
import 'package:utavine/presentation/auth/widgets/user_auth/user_input.dart';
import 'package:utavine/presentation/root/root.dart';
import 'package:utavine/presentation/vine_sense/pages/vine_sense_screen.dart';
import 'package:utavine/service_locator.dart';

class SignIpPage extends StatefulWidget {
  const SignIpPage({super.key});

  @override
  State<SignIpPage> createState() => _SignIpPageState();
}

class _SignIpPageState extends State<SignIpPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

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
            MaterialPageRoute(builder: (_) => SignUpPage()),
          );
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthTitle(title: 'Login'),
              const SizedBox(height: 40),
              AuthLabel(text: 'EMAIL'),
              const SizedBox(height: 4),
              UserInput(contr: _email),
              const SizedBox(height: 20),
              AuthLabel(text: 'PASSWORD'),
              const SizedBox(height: 4),
              UserInput(contr: _password),
              const SizedBox(height: 20),
              BasicAppButton(
                onPressed: () async {
                  var result = await sl<SigninUsecase>().call(
                    LoginUserReq(
                      email: _email.text,
                      password: _password.text,
                    ),
                  );
                  if (!mounted) return;
                  result.fold(
                    (l) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            'Please check your email and password again.',
                            style: TextStyle(color: AppColors.white),
                          ),
                          backgroundColor: AppColors.danger,
                        ),
                      );
                    },
                    (r) async {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null && !user.emailVerified) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Email not verified"),
                            content: const Text(
                              "Please verify your email address before logging in.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  await user.sendEmailVerification();
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Verification email sent"),
                                      backgroundColor: AppColors.success,
                                    ),
                                  );
                                  await FirebaseAuth.instance.signOut();
                                },
                                child: const Text(
                                  "Resend email",
                                  style: TextStyle(color: AppColors.success),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: AppColors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (user != null && user.emailVerified) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const VineSenseScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                  );
                },
                title: 'Login',
                height: 60,
                bgColor: AppColors.primary,
              ),
              const SizedBox(height: 30),
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
                      "Security Notice",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.lgtGrey,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "• Make sure your credentials are correct before logging in.\n"
                      "• Verified email is mandatory for security access.\n"
                      "• All user data is securely stored following best practices.",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.lgtGrey,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}