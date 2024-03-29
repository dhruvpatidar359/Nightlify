import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nightlify/auth/login.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:nightlify/widgets/navigation.dart';
import 'package:nightlify/widgets/shapes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

int state = 0;

class InitClass extends StatefulWidget {
  const InitClass({super.key});

  @override
  State<InitClass> createState() => _InitClassState();
}

class _InitClassState extends State<InitClass> {
  SfRangeValues _values = SfRangeValues(40.0, 80.0);

  double starDx = 0;
  double starDy = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressDown: (details) {
        final Offset det = details.globalPosition;

        starDx = det.dx / Constants.w;
        starDy = det.dy / Constants.h;
        setState(() {});
      },
      child: Animate(
        effects: [
          FadeEffect(begin: 0.0, end: 1.0, duration: 1000.ms),
          SlideEffect(
              begin: Offset(0, 0.02), end: Offset(0, 0.0), duration: 1000.ms)
        ],
        child: Scaffold(
            backgroundColor: Constants.appBlack,
            body: SafeArea(
                child: Container(
              height: Constants.h,
              width: Constants.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 8, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        animatedStars(starDx, starDy),
                        Text(
                          "Opens At Night",
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        Text(
                          "Find Your Dream\nPerson.",
                          style: GoogleFonts.nunito(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "I Am Interest In",
                        style: GoogleFonts.nunito(
                            fontSize: 15, color: Colors.white60),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GenderSelectionButton(),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Age Of My Partner",
                        style: GoogleFonts.nunito(
                            fontSize: 15, color: Colors.white60),
                      ),
                      Text(
                        "${(_values.start).round()} - ${_values.end.round()}",
                        style: GoogleFonts.nunito(
                            fontSize: 15, color: Colors.white60),
                      ),
                      SfRangeSlider(
                        min: 0.0,
                        max: 99.0,
                        values: _values,
                        interval: 1,
                        stepSize: 1,
                        tooltipShape: SfRectangularTooltipShape(),
                        showTicks: true,
                        activeColor: Colors.white,
                        enableTooltip: true,
                        inactiveColor: Constants.appGrey,
                        minorTicksPerInterval: 1,
                        onChanged: (SfRangeValues values) {
                          setState(() {
                            _values = values;
                          });
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: GestureDetector(
                      onTap: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString('gender', state == 0 ? 'm' : "f");
                        await prefs.setString('age',
                            "${(_values.start).round()}-${_values.end.round()}");

                        nextScreenReplace(context, Login());
                      },
                      child: Container(
                        height: Constants.h / 12,
                        width: Constants.w / 1.2,
                        child: Center(
                            child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white70),
                        )),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))),
      ),
    );
  }
}

class GenderSelectionButton extends StatefulWidget {
  const GenderSelectionButton({super.key});

  @override
  State<GenderSelectionButton> createState() => _GenderSelectionButtonState();
}

class _GenderSelectionButtonState extends State<GenderSelectionButton> {
  // default MEN;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              state = 0;
              setState(() {});
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              child: Container(
                height: Constants.h / 12,
                width: Constants.w / 2.5,
                child: Center(
                    child: Text(
                  "MEN",
                  style: TextStyle(color: Colors.white70),
                )),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: state == 0
                      ? Constants.appBlue
                      : Constants.appLightGrey.withOpacity(0.2),
                ),
              ),
            ),
          ),
          Gap(5),
          GestureDetector(
            onTap: () {
              state = 1;
              setState(() {});
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              child: Container(
                height: Constants.h / 12,
                width: Constants.w / 2.5,
                child: Center(
                    child: Text(
                  "WOMEN",
                  style: TextStyle(color: Colors.white70),
                )),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: state == 1
                      ? Constants.appBlue
                      : Constants.appLightGrey.withOpacity(0.2),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
