import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nightlify/auth/bloc/auth_bloc.dart';
import 'package:nightlify/auth/login.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:nightlify/details/name/name.dart';
import 'package:nightlify/discover/discover.dart';
import 'package:nightlify/widgets/navigation.dart';

import '../firebase/data/firestoreRepository/firestore_repository.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureText = true;
  bool _checkBox = false;
  bool isChecked = false;

  final TextEditingController _passwordText = TextEditingController();
  final TextEditingController _emailText = TextEditingController();
  final TextEditingController _repeatPasswordText = TextEditingController();

  String? errorEmail;
  String? errorPassword;
  String? errorDidNotMatch;

  final FirestoreRepository firestoreRepository = FirestoreRepository();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  validatePassword(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      errorPassword = 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        errorPassword = 'Enter valid password';
      } else {
        errorPassword = null;
      }
    }
  }

  validateEmail(String value) {
    if (EmailValidator.validate(_emailText.text) == false) {
      errorEmail = "email not valid";
    } else {
      errorEmail = null;
    }
  }

  validateMatch() {
    if (_passwordText.text != _repeatPasswordText.text) {
      errorDidNotMatch = "Password did't match";
    } else {
      errorDidNotMatch = null;
    }
  }

  validateCheck() {
    if (_checkBox) {
      isChecked = false;
    } else {
      isChecked = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(begin: 0.0, end: 1.0, duration: 1000.ms),
        SlideEffect(
            begin: const Offset(0, 0.02),
            end: const Offset(0, 0.0),
            duration: 1000.ms)
      ],
      child: Scaffold(
        backgroundColor: Constants.appBlack,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Constants.h / 3,
                    width: Constants.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/nightlife.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                  ),
                  Gap(5),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Get started now",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Gap(1),
                        Text(
                          "Enter your email and password to register a new account",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Gap(20),
                        _buildTextField(
                            controller: _emailText,
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            errorText: errorEmail),
                        Gap(8),
                        Text(
                          "We will send a verification link",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Gap(8),
                        _buildTextField(
                            controller: _passwordText,
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            isPassword: true,
                            errorText: errorPassword),
                        Gap(8),
                        _buildTextField(
                            controller: _repeatPasswordText,
                            labelText: 'confirm Password',
                            hintText: 'retype password',
                            isPassword: true,
                            errorText: errorDidNotMatch),
                        Gap(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Retype to avoid misspells",
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          ],
                        ),
                        Gap(5),
                        Row(
                          children: [
                            Checkbox(
                              activeColor: Constants.appBlue,
                              isError: isChecked,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              onChanged: (value) {
                                if (_checkBox)
                                  _checkBox = false;
                                else
                                  _checkBox = true;
                                setState(() {});
                              },
                              value: _checkBox,
                            ),
                            Text(
                              "I agree with ",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              "Terms",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                    decorationThickness: 2,
                                  ),
                            ),
                            Text(
                              " and ",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              "Privacy Policy",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                    decorationThickness: 2,
                                  ),
                            ),
                          ],
                        ),
                        BlocListener<AuthBloc, AuthState>(
                          listenWhen: (previous, current) {
                            if (previous.runtimeType != current.runtimeType) {
                              return true;
                            } else {
                              return false;
                            }
                          },
                          listener: (context, state) async {
                            if (state is EmailPasswordRegisterFailedState) {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Constants.appBlack,
                                    title: Text(
                                      'Registration Failed',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    content: Text(
                                      state.error,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text(
                                          'OK',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (state
                                is EmailPasswordRegisterLoadingState) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      shadowColor: Colors.transparent,
                                      surfaceTintColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: Colors.transparent,
                                      content: Center(
                                        child: LoadingAnimationWidget
                                            .threeArchedCircle(
                                                color: Colors.white, size: 36),
                                      ));
                                },
                              );
                            } else if (state
                                is EmailPasswordRegisterSuccessState) {
                              Navigator.pop(context);
                              final uid = firebaseAuth.currentUser?.uid ?? "";
                              bool haveFilled = await firestoreRepository
                                  .hasUserAlreadyGivenTheDetails(uid);
                              Navigator.pop(context);
                              if (haveFilled) {
                                nextScreenReplace(context, Discover());
                              } else {
                                nextScreenReplace(context, NameEntry());
                              }
                            }
                          },
                          child: TextButton(
                              onPressed: () {
                                // validate first then register
                                validatePassword(_passwordText.text);
                                validateEmail(_emailText.text);
                                validateMatch();
                                validateCheck();

                                setState(() {});
                                if (errorEmail == null &&
                                    errorDidNotMatch == null &&
                                    errorPassword == null &&
                                    _checkBox) {
                                  context.read<AuthBloc>().add(
                                      EmailPasswordRegisterEvent(
                                          email: _emailText.text,
                                          password: _passwordText.text));
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: Constants.h / 12,
                                width: Constants.w,
                                child: Text(
                                  "Register",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(color: Colors.white),
                                ),
                                decoration: BoxDecoration(
                                    color: Constants.appBlue,
                                    borderRadius: BorderRadius.circular(10)),
                              )),
                        ),
                        Gap(4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "or continue with",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BlocListener<AuthBloc, AuthState>(
                              listener: (context, state) async {
                                switch (state.runtimeType) {
                                  case GoogleAuthSuccessState:
                                    Navigator.pop(context);
                                    final uid =
                                        firebaseAuth.currentUser?.uid ?? "";
                                    bool haveFilled = await firestoreRepository
                                        .hasUserAlreadyGivenTheDetails(uid);
                                    Navigator.pop(context);
                                    if (haveFilled) {
                                      nextScreenReplace(context, Discover());
                                    } else {
                                      nextScreenReplace(context, NameEntry());
                                    }
                                    return;

                                  case GoogleAuthLoadingState:
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            shadowColor: Colors.transparent,
                                            surfaceTintColor:
                                                Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor: Colors.transparent,
                                            content: Center(
                                              child: LoadingAnimationWidget
                                                  .threeArchedCircle(
                                                      color: Colors.white,
                                                      size: 36),
                                            ));
                                      },
                                    );
                                    return;

                                  case GoogleAuthFailedState:
                                    if (state is GoogleAuthFailedState) {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor: Constants.appBlack,
                                            title: Text(
                                              'GoogleAuth Failed',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            content: Text(
                                              state.error,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                                child: Text(
                                                  'OK',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }

                                  default:
                                    return;
                                }
                              },
                              child: TextButton(
                                  onPressed: () {
                                    context
                                        .read<AuthBloc>()
                                        .add(GoogleSignInEvent());
                                  },
                                  child: Container(
                                    height: Constants.h / 18,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.google,
                                            color: Colors.white,
                                          ),
                                          Gap(5),
                                          Text(
                                            "Google",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Container(
                                  height: Constants.h / 18,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.facebook,
                                          color: Colors.white,
                                        ),
                                        Gap(5),
                                        Text(
                                          "Facebook",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Gap(4),
                            GestureDetector(
                              onTap: () {
                                nextScreenReplace(context, Login());
                              },
                              child: Text(
                                "Login in",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required String? errorText,
    bool isPassword = false,
  }) {
    return TextField(
      obscureText: isPassword ? _obscureText : false,
      style: Theme.of(context).textTheme.titleSmall,
      cursorColor: Colors.white,
      controller: controller,
      cursorWidth: 1,
      decoration: InputDecoration(
        errorText: errorText,
        labelText: labelText,
        hintText: hintText,
        labelStyle: Theme.of(context).textTheme.titleSmall,
        hintStyle: Theme.of(context).textTheme.titleSmall,
        contentPadding: EdgeInsets.all(16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
