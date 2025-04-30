import 'package:flutter/material.dart';
import 'package:job_seeker/prsentation/auth/page/ragister_page.dart';
import 'package:job_seeker/prsentation/auth/provider/auth_provider.dart';
import 'package:job_seeker/prsentation/auth/widgets/auth_action_button.dart';
import 'package:job_seeker/prsentation/auth/widgets/auth_header_widget.dart';
import 'package:job_seeker/prsentation/auth/widgets/my_custom_input_filed.dart';
import 'package:job_seeker/prsentation/auth/widgets/prompt_login_sigup_widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.deepPurple,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            const AuthHeaderWidget(
              text: "Welcome back",
              title: "Login",
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: 900,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.deepPurple.shade100,
                                    blurRadius: 20,
                                    offset: const Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              MyCustomInputFiled(
                                text: "Email",
                                textEditingController: emailController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              MyCustomInputFiled(
                                text: "Password",
                                textEditingController: passwordController,
                                isPassword: true,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        AuthActionButton(
                          text: "Log In",
                          onPressed: () {
                            context.read<AuthProvider>().sigIn(
                                emailController.text.trim(),
                                passwordController.text);
                          },
                        ),
                        const SizedBox(height: 50),
                        PromptLoginSignUpWidget(
                          text: "Don't have an Account?",
                          promptText: "Ragister",
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RagisterPage()));
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
