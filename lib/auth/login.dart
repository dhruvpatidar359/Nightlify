import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nightlify/auth/bloc/auth_bloc.dart';
import 'package:nightlify/auth/register.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:nightlify/details/Welcome.dart';
import 'package:nightlify/details/interest.dart';
import 'package:nightlify/details/name.dart';

import 'package:nightlify/widgets/navigation.dart';

TextEditingController _passwordText = TextEditingController();
TextEditingController _emailText = TextEditingController();

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(begin: 0.0, end: 1.0, duration: 1000.ms),
        SlideEffect(
            begin: Offset(0, 0.02), end: Offset(0, 0.0), duration: 1000.ms)
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
                          "Welcome",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Gap(1),
                        Text(
                          "Please login to access your account",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Gap(20),
                        _buildTextField(
                          controller: _emailText,
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          isPassword: false,
                        ),
                        Gap(8),
                        _buildTextField(
                          controller: _passwordText,
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          isPassword: true,
                        ),
                        Gap(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Forget your password?",
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          ],
                        ),
                        Gap(10),
                        BlocListener<AuthBloc, AuthState>(
                          listenWhen: (previous, current) {
                            if (previous.runtimeType != current.runtimeType)
                              return true;
                            return false;
                          },
                          listener: (BuildContext context, AuthState state) {
                            if (state is EmailPasswordLoginLoadingState) {
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
                                is EmailPasswordLoginSuccessState) {
                              Navigator.pop(context);
                              nextScreenReplace(context, Welcome());
                            } else if (state is EmailPasswordLoginFailedState) {
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
                                      'Login Failed',
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
                          },
                          child: TextButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                    EmailPasswordLoginEvent(
                                        email: _emailText.text,
                                        password: _passwordText.text));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: Constants.h / 12,
                                width: Constants.w,
                                child: Text(
                                  "Login",
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
                              listenWhen: (previous, current) {
                                if (current is GoogleAuthFailedState ||
                                    current is GoogleAuthSuccessState ||
                                    current is GoogleAuthLoadingState) {
                                  return true;
                                } else {
                                  return false;
                                }
                              },
                              listener: (context, state) {
                                print(state);
                                switch (state.runtimeType) {
                                  case GoogleAuthSuccessState:
                                    Navigator.pop(context);
                                    nextScreenReplace(context, NameEntry());
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
                              "not a member?",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Gap(4),
                            GestureDetector(
                              onTap: () {
                                nextScreenReplace(context, Register());
                              },
                              child: Text(
                                "Register now",
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
    bool isPassword = false,
  }) {
    return TextField(
      obscureText: isPassword ? _obscureText : false,
      style: Theme.of(context).textTheme.titleSmall,
      cursorColor: Colors.white,
      controller: controller,
      cursorWidth: 1,
      decoration: InputDecoration(
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
