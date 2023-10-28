import 'dart:developer';

import 'package:devathon_project/resources/Color.dart';
import 'package:devathon_project/view/SignUpScreen.dart';
import 'package:devathon_project/viewmodel/LoginViewModel.dart';
import 'package:devathon_project/widgets/CustomButton.dart';
import 'package:devathon_project/widgets/CustomInputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/Image.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  LoginViewModel loginViewModel = LoginViewModel();
  final key = GlobalKey<FormState>();
  bool? isObsecure;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SvgPicture.asset(
                  AppImages.logo,
                  height: 300,
                  width: 300,
                ),
                const Text(
                  "LOGIN",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                Form(
                    key: key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Username:',
                            style: TextStyle(
                                fontSize: 17,
                                color: AppColors.silverTextsubtitle,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500)),
                        CustomInputField(
                            hint: "Enter your name",
                            controller: loginViewModel.emailController,
                            obscureText: false,
                            // focusNode: loginViewModel.emailFocusNode,
                            // focusNexNode: loginViewModel.passwordFocusNode,
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 108, 171, 238),
                              ),
                              onPressed: () {},
                            ),
                            validatorComment: 'Please enter your username'),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Password:',
                            style: TextStyle(
                                fontSize: 17,
                                color: AppColors.silverTextsubtitle,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500)),
                        CustomInputField(
                            hint: "***********",
                            controller: loginViewModel.passwordController,
                            obscureText: isObsecure ?? true,
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.lock,
                                color: Color.fromARGB(255, 108, 171, 238),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (isObsecure == null) {
                                    isObsecure = true;
                                  }
                                  isObsecure = !isObsecure!;
                                });
                              },
                            ),
                            validatorComment: 'Please enter your username'),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
                CustomButton(
                    onTap: () async {
                      log('Button Pressed');
                      if (key.currentState!.validate()) {
                        setState(() {
                          log('reloaded');

                          loading = true;
                        });
                        await loginViewModel.loginAuth(context).then((value) {
                          setState(() {
                            loading = false;
                          });
                        });
                      }
                    },
                    title: "LOGIN",
                    loading: loading),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 2,
                        color: AppColors.lightBlue,
                      ),
                    ),
                    const Text(
                      " or  ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: AppColors.lightBlue,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 2,
                        color: AppColors.lightBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    title: "SIGN UP",
                    loading: false)
              ],
            ),
          ),
        ));
  }
}
