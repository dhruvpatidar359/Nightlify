import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nightlify/auth/bloc/auth_bloc.dart';
import 'package:nightlify/auth/login.dart';
import 'package:nightlify/constants/constants.dart';

import 'package:nightlify/details/name/Welcome.dart';
import 'package:nightlify/widgets/navigation.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../firebase/data/firestoreRepository/firestore_repository.dart';

class NameEntry extends StatefulWidget {
  const NameEntry({super.key});

  @override
  State<NameEntry> createState() => _NameEntryState();
}

class _NameEntryState extends State<NameEntry> {
  TextEditingController _nameText = TextEditingController();
  TextEditingController _userNameText = TextEditingController();
  final FirestoreRepository _firestoreRepository = FirestoreRepository();
  bool nameError = false;

  String userNameErrorText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants.appBlack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocListener<AuthBloc, AuthState>(
                    listenWhen: (previous, current) {
                      if (current is AuthLoadingState) {
                        return true;
                      } else if (current is UnAuthenticated)
                        return true;
                      else
                        return false;
                    },
                    listener: (BuildContext context, AuthState state) {
                      print(state);
                      if (state is UnAuthenticated) {
                        Navigator.pop(context);
                        nextScreenReplace(context, Login());
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                shadowColor: Colors.transparent,
                                surfaceTintColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Colors.transparent,
                                content: Center(
                                  child:
                                      LoadingAnimationWidget.threeArchedCircle(
                                          color: Colors.white, size: 36),
                                ));
                          },
                        );
                      }
                    },
                    child: IconButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(SignOutEvent());
                        },
                        tooltip: "logout",
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                        )),
                  ),
                  CircularPercentIndicator(
                    radius: 30.0,
                    lineWidth: 3.0,
                    backgroundColor: Constants.appGrey,
                    percent: 0.1,
                    animateFromLastPercent: true,
                    center: Text(
                      "10%",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    progressColor: Constants.appBlue,
                  )
                ],
              ),
              Text(
                "What's your\nname?",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Gap(10),
              TextField(
                style: Theme.of(context).textTheme.titleSmall,
                cursorColor: Colors.white,

                // controller: controller,

                cursorWidth: 1,

                controller: _nameText,
                decoration: InputDecoration(
                  errorText: nameError == true ? "name field is empty" : null,
                  filled: true,
                  fillColor: Constants.appGrey,
                  hintText: "Enter your name",
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  hintStyle: Theme.of(context).textTheme.titleSmall,
                  contentPadding: EdgeInsets.all(16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
              Gap(10),
              Text(
                "* This is how it will appear on your profile. Can't change it in the future.",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Gap(10),
              TextField(
                style: Theme.of(context).textTheme.titleSmall,
                cursorColor: Colors.white,

                // controller: controller,

                cursorWidth: 1,

                controller: _userNameText,
                decoration: InputDecoration(
                  errorText: userNameErrorText == "" ? null : userNameErrorText,
                  filled: true,
                  fillColor: Constants.appGrey,
                  hintText: "Enter your username",
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  hintStyle: Theme.of(context).textTheme.titleSmall,
                  contentPadding: EdgeInsets.all(16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
              Gap(10),
              Text(
                "* This must be unique",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            shadowColor: Colors.transparent,
                            surfaceTintColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.transparent,
                            content: Center(
                              child: LoadingAnimationWidget.threeArchedCircle(
                                  color: Colors.white, size: 36),
                            ));
                      },
                    );

                    bool alreadyTaken = await _firestoreRepository
                        .isUsernameAlreadyTaken(_userNameText.text);

                    Navigator.pop(context);

                    if (_nameText.text == "" || _userNameText.text == "") {
                      if (_nameText.text.isEmpty)
                        nameError = true;
                      else {
                        nameError = false;
                      }
                      if (_userNameText.text.isEmpty) {
                        userNameErrorText = "username field is empty";
                      } else {
                        userNameErrorText = "";
                      }
                    } else if (alreadyTaken) {
                      print("i am here and i know the cause");
                      nameError = false;

                      userNameErrorText = "username already taken";
                    } else {
                      userNameErrorText = "";
                      nameError = false;
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString("name", _nameText.text);
                      await prefs.setString("username", _userNameText.text);

                      nextScreen(context, Welcome());
                    }
                    setState(() {});
                  },
                  child: Container(
                    height: Constants.h / 12,
                    width: Constants.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Constants.appBlue),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          "Continue",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.white),
                        ))),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
