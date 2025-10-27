import 'package:flutter/material.dart';
import 'package:soqsoq/core/constants/app_colors.dart';
import 'package:soqsoq/core/models/user_info.dart';
import 'package:soqsoq/core/viewmodels/auth_vm.dart';
import '../components/app_textformField.dart';
import 'package:soqsoq/helpers/navigate_to_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  UserInfo userInfo = UserInfo();
  bool _hidePwd = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.backgroundColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => NavigationHelper.navigateTo(context, "/home"),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.9, end: 1),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              builder: (context, scale, child) =>
                  Transform.scale(scale: scale, child: child),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 24,
                        spreadRadius: 0,
                        offset: const Offset(0, 10),
                        color: Colors.black.withOpacity(.08),
                      ),
                    ],
                  ),
                  child: Form(
                    child: Column(
                      children: [
                        Text(
                          "Welcome Back👋",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Login to your account...",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                          ),
                        ),
                        SizedBox(height: 40),
                        AppTextformfield(
                          controller: _emailController,
                          label: "Email",
                        ),
                        SizedBox(height: 10),
                        AppTextformfield(
                          controller: _pwdController,
                          label: "Password",
                          isPwd: true,
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: () async {
                            AuthVM auth = AuthVM();
                            dynamic response = await auth.login(
                              email: _emailController.text,
                              password: _pwdController.text,
                            );
                            if(response is String){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  errorSnackBar(response)
                              );
                            }
                            // if (_emailController.text.trim().isEmpty) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(
                            //       showCloseIcon: true,
                            //       content: Text("Please enter your email ^_^"),
                            //     ),
                            //   );
                            //   return;
                            // } else {
                            //   userInfo.userEmail = _emailController.text.trim();
                            //   NavigationHelper.navigateTo(
                            //     context,
                            //     '/splash',
                            //     userInfo: userInfo,
                            //   );
                            //   // navigateTo(context, "/splash", userEmail: userEmail);
                            // }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: AppColors.backgroundColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          icon: const Icon(Icons.login_outlined),
                          label: const Text("Login"),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                NavigationHelper.navigateTo(
                                  context,
                                  '/registration',
                                );
                                // navigateTo(context, "/registration");
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

errorSnackBar(String response){
  return SnackBar(
    content: Text("$response",
      style: const TextStyle(
        color: Color(0xFFB00020),
        fontWeight: FontWeight.w600,
      ),
    ),
    showCloseIcon: true,
    backgroundColor: const Color(0xFFFFEBEE),
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(
        color: Color(0xFFB00020),
        width: 1.3,
      ),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    duration: const Duration(seconds: 3),
  );
}