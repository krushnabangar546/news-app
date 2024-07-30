import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:news_app/helpers/colors.dart';
import 'package:news_app/helpers/field_styles.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  double screenHeight=0.0;

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
                    SizedBox(height: screenHeight / 9),
                    KLTextField(
                      hint: "Username",
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
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
                          return 'Password must be at least 6 characters long';
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
                              sText: "Signup",
                              textSize: 18.0,
                              textColor: Colors.white,
                              textBold: 4,
                            ),

                            onPressed: () async {
                              if (formKey.currentState?.validate() ?? false) {

                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.loading,
                                  text: "Creating account, Please wait!!",
                                );

                                try {
                                  await authProvider.signUp(
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text,
                                  );

                                  Navigator.of(context).pop();

                                  MotionToast.success(
                                    description: Text("Account Successfully created."),
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
                          sText: "Already have an account? ",
                          textSize: 17.0,
                          textColor: Colors.black,
                          textBold: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          child: KLText(
                            sText: "Login",
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
