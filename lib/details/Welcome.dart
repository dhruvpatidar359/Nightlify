import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:nightlify/details/interest.dart';
import 'package:nightlify/widgets/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String name = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadName();
  }

  void loadName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name") ?? "";
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    loadName();
    print(" i am working ");
  }

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
          child: Stack(
            children: [
              Container(
                height: Constants.h,
                width: Constants.w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/welcome.jpg"))),
              ),
              ClipRRect(
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      height: Constants.h,
                      width: Constants.w,
                      color: Colors.black.withOpacity(0.2),
                    )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                  child: Container(
                    height: Constants.h / 2.2,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                height: Constants.h,
                                width: Constants.w,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.8),
                                    style: BorderStyle.solid,
                                  ),
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Constants.appBlue.withOpacity(0.4),
                                  radius: 48,
                                ),
                                CircleAvatar(
                                  backgroundColor:
                                      Constants.appBlue.withOpacity(0.7),
                                  radius: 44,
                                ),
                                CircleAvatar(
                                  backgroundColor: Constants.appBlue,
                                  radius: 40,
                                ),
                                Icon(
                                  Icons.waving_hand,
                                  color: Colors.white,
                                  size: 40,
                                )
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  "Welcome ${name.split(" ").first}",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  "There is lot of to discover ahead ,but before that let's set up the profile",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: Constants.h / 18,
                                    width: Constants.w / 2.7,
                                    child: Text(
                                      "Edit name",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color:
                                                Colors.white.withOpacity(0.8))),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    nextScreen(context, Interest());
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: Constants.h / 18,
                                      width: Constants.w / 2.7,
                                      child: Text(
                                        "Let's go",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.white),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Constants.appBlue,
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
