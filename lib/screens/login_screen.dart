import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:news_app/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import '../helpers/colors.dart';
import '../helpers/field_styles.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  double screenHeight=0.0;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      color: bgColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: bgColor,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KLText(
                      sText: "MyNews",
                      textSize: 24.0,
                      textColor: kPrimaryColor,
                      textBold: 6,
                    ),
                    SizedBox(height: screenHeight / 7),
                    KLTextField(
                      hint: "Email",
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    KLTextField(
                      hint: "Password",
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight / 2.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200.0,
                          child: CupertinoButton(
                            color: kPrimaryColor,
                            child: KLText(
                              sText: "Login",
                              textSize: 18.0,
                              textColor: Colors.white,
                              textBold: 4,
                            ),
                            onPressed: () async {
                              if (formKey.currentState?.validate() ?? false) {

                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.loading,
                                  text: "Logging in, please wait...",
                                );

                                try {
                                  await authProvider.signIn(
                                      emailController.text,
                                      passwordController.text,
                                      context
                                  );

                                  Navigator.of(context).pop();

                                  MotionToast.success(
                                    description: Text("Login Successful."),
                                  ).show(context);

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomeScreen()),
                                  );
                                } catch (e) {
                                  Navigator.of(context).pop();

                                  MotionToast.error(
                                    description: Text("Error: $e"),
                                  ).show(context);
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KLText(
                          sText: "New here? ",
                          textSize: 17.0,
                          textColor: Colors.black,
                          textBold: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignupScreen()),
                            );
                          },
                          child: KLText(
                            sText: "Signup",
                            textSize: 17.0,
                            textColor: kPrimaryColor,
                            textBold: 6,
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
    );
  }
}
