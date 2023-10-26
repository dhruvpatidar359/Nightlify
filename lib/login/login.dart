import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:nightlify/details/profileMini.dart';
import 'package:nightlify/widgets/navigation.dart';
import 'package:nightlify/widgets/shapes.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:vector_math/vector_math.dart' show radians;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ButtonState _buttonStateEmail = ButtonState.idle;
  ButtonState _buttonStatePhone = ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.appBlack,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Constants.h / 20,
                  width: Constants.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 15,
                            color: Colors.blueAccent,
                            spreadRadius: 1)
                      ],
                      color: Constants.appBlue),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FaIcon(
                          FontAwesomeIcons.sun,
                          color: Colors.yellowAccent,
                        ),
                      ),
                      Text(
                        "5 hour remaining",
                        style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      )
                    ],
                  ),
                ).animate(effects: [
                  FadeEffect(),
                  SlideEffect(
                      duration: Duration(seconds: 1),
                      begin: Offset(0.0, -0.2),
                      end: Offset(0.0, 0.0))
                ]),
                CircleAvatar(
                  radius: 50,
                ),
                Text(
                  "Sign Up To Continue",
                  style: GoogleFonts.nunito(fontSize: 15, color: Colors.white),
                ),
                Column(
                  children: [
                    ProgressButton(
                      progressIndicatorAlignment: MainAxisAlignment.center,
                      progressIndicator: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      height: Constants.h / 12,
                      maxWidth: Constants.w / 1.2,
                      minWidth: Constants.w / 6,
                      stateWidgets: {
                        ButtonState.idle: Container(
                          height: Constants.h / 12,
                          width: Constants.w / 1.2,
                          decoration: BoxDecoration(
                              color: Constants.appBlue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Continue With Email",
                              style: GoogleFonts.nunito(
                                  fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ),
                        ButtonState.loading: Row(),
                        ButtonState.fail: Text(
                          "Fail",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        ButtonState.success: Text(
                          "Success",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        )
                      },
                      stateColors: {
                        ButtonState.idle: Colors.transparent,
                        ButtonState.loading: Constants.appBlue,
                        ButtonState.fail: Colors.red.shade300,
                        ButtonState.success: Colors.green.shade400,
                      },
                      onPressed: () {
                        if (_buttonStateEmail == ButtonState.loading) {
                          _buttonStateEmail = ButtonState.idle;
                        } else {
                          _buttonStateEmail = ButtonState.loading;
                        }
                        nextScreen(context, ProfileMiniDetails());
                        setState(() {});
                      },
                      state: _buttonStateEmail,
                    ),
                    SizedBox(height: 10),
                    ProgressButton(
                      height: Constants.h / 12,
                      maxWidth: Constants.w / 1.2,
                      progressIndicatorAlignment: MainAxisAlignment.center,
                      progressIndicator: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      minWidth: Constants.w / 6,
                      stateWidgets: {
                        ButtonState.idle: Container(
                          height: Constants.h / 12,
                          width: Constants.w / 1.2,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Continue With Phone",
                              style: GoogleFonts.nunito(
                                  fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ),
                        ButtonState.loading: Column(),
                        ButtonState.fail: CircleAvatar(
                          child: Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                        ),
                        ButtonState.success: Text(
                          "Success",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        )
                      },
                      stateColors: {
                        ButtonState.idle: Colors.transparent,
                        ButtonState.loading: Colors.transparent,
                        ButtonState.fail: Colors.transparent,
                        ButtonState.success: Colors.green.shade400,
                      },
                      onPressed: () {
                        if (_buttonStatePhone == ButtonState.fail) {
                          _buttonStatePhone = ButtonState.idle;
                        } else {
                          _buttonStatePhone = ButtonState.fail;
                        }

                        setState(() {});
                      },
                      state: _buttonStatePhone,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 2,
                      width: Constants.w / 4,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Or Sign Up",
                      style:
                          GoogleFonts.nunito(fontSize: 15, color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 2,
                      width: Constants.w / 4,
                      color: Colors.white,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LinearMenu().animate(effects: [
                      ShimmerEffect(duration: Duration(seconds: 2))
                    ])
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Terms Of Use",
                      style:
                          GoogleFonts.nunito(fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      "Privacy Policy",
                      style:
                          GoogleFonts.nunito(fontSize: 15, color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class LinearMenu extends StatefulWidget {
  createState() => _LinearMenuState();
}

class _LinearMenuState extends State<LinearMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 999), vsync: this);
    // ..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return LinearAnimation(controller: controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class LinearAnimation extends StatefulWidget {
  LinearAnimation({required this.controller});

  AnimationController controller;

  @override
  State<LinearAnimation> createState() => _LinearAnimationState();
}

class _LinearAnimationState extends State<LinearAnimation> {
  late final Animation<double> translation;
  late final Animation<double> scale;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    translation = Tween<double>(
      begin: 0.0,
      end: 100.0,
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: Curves.elasticOut),
    );

    scale = Tween<double>(
      begin: 1.5,
      end: 0.0,
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: Curves.fastOutSlowIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.controller,
        builder: (context, widget) {
          return Stack(alignment: Alignment.center, children: <Widget>[
            _buildButton(0, "4",
                color: Colors.white, icon: FontAwesomeIcons.facebook),
            _buildButton(180, "5",
                color: Colors.white, icon: FontAwesomeIcons.apple),
            Transform.rotate(
              angle: 180,
              child: Transform.scale(
                  scale: scale.value - 1,
                  child: FloatingActionButton(
                      heroTag: "1",
                      onPressed: _close,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.google,
                            color: Colors.black,
                          ),
                        ],
                      ))),
            ),
            Transform.scale(
                scale: scale.value,
                child: Container(
                  width: Constants.w / 3,
                  child: FloatingActionButton(
                    heroTag: "2",
                    onPressed: _open,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.apple,
                          ),
                          Text("."),
                          Icon(FontAwesomeIcons.facebook),
                          Text("."),
                          Icon(
                            FontAwesomeIcons.google,
                          ),
                        ]),
                  ),
                ))
          ]);
        });
  }

  _open() {
    widget.controller.forward();
  }

  _close() {
    widget.controller.reverse();
  }

  _buildButton(double angle, String tag,
      {required Color color, required IconData icon}) {
    final double rad = radians(angle);
    return Transform(
        transform: Matrix4.identity()
          ..translate(
              (translation.value) * cos(rad), (translation.value) * sin(rad)),
        child: FloatingActionButton(
            heroTag: tag,
            child: Icon(icon),
            backgroundColor: color,
            onPressed: _close,
            elevation: 0));
  }
}
