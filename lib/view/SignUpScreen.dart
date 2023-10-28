import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/Color.dart';
import '../resources/Image.dart';
import '../viewmodel/SignUpViewModel.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomInputField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  SignUpViewModel signUpViewModel = SignUpViewModel();
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
                  "REGESTRATION",
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
                        const Text('Name:',
                            style: TextStyle(
                                fontSize: 17,
                                color: AppColors.silverTextsubtitle,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500)),
                        CustomInputField(
                            hint: "Enter your name",
                            controller: signUpViewModel.nameController,
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
                            validatorComment: 'Please enter your Name'),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Email:',
                            style: TextStyle(
                                fontSize: 17,
                                color: AppColors.silverTextsubtitle,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500)),
                        CustomInputField(
                            hint: "Enter your name",
                            controller: signUpViewModel.emailController,
                            obscureText: false,
                            // focusNode: loginViewModel.emailFocusNode,
                            // focusNexNode: loginViewModel.passwordFocusNode,
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.email,
                                color: Color.fromARGB(255, 108, 171, 238),
                              ),
                              onPressed: () {},
                            ),
                            validatorComment: 'Please enter your Email'),
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
                            controller: signUpViewModel.passwordController,
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
                            validatorComment: 'Please enter your Password'),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
                Row(
                  children: [
                    Radio(
                        value: true,
                        groupValue: signUpViewModel.isPatient,
                        onChanged: (value) {
                          signUpViewModel.changeUserType(value!);
                          setState(() {});
                        }),
                    const Text("Patient"),
                    Radio(
                        value: false,
                        groupValue: signUpViewModel.isPatient,
                        onChanged: (value) {
                          signUpViewModel.changeUserType(value!);
                          setState(() {});
                        }),
                    const Text("Doctor")
                  ],
                ),
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
                    onTap: () async {
                      if (key.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        await signUpViewModel.signUpAuth(context).then((value) {
                          setState(() {
                            loading = false;
                          });
                        });
                      }
                    },
                    title: "Create an Account",
                    loading: loading),
              ],
            ),
          ),
        ));
  }
}
