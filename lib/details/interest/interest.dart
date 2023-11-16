import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:nightlify/details/interest/serachinterest.dart';
import 'package:nightlify/details/media/media.dart';
import 'package:nightlify/widgets/navigation.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

List<String> filters = [];

class Interest extends StatefulWidget {
  const Interest({super.key});

  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {});
        print("will popo worinig");
        return true;
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
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          tooltip: "logout",
                          icon: Icon(
                            CupertinoIcons.arrow_left,
                            color: Colors.white,
                          )),
                      CircularPercentIndicator(
                        radius: 30.0,
                        lineWidth: 3.0,
                        backgroundColor: Constants.appGrey,
                        percent: 0.4,
                        animateFromLastPercent: true,
                        center: Text(
                          "40%",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        progressColor: Constants.appBlue,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Your interests",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700)),
                            Text(
                                "Select interest on the basis of which you will be gonna match",
                                style: Theme.of(context).textTheme.bodySmall)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchInterest()),
                      ).then((value) => setState(() {}));
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Constants.appGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Search...",
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    ),
                  ),
                  if (filters.isNotEmpty)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              Wrap(
                                spacing: 15,
                                runSpacing: 15,
                                children: List.generate(
                                  filters.length,
                                  (index) => FilterChip(
                                    showCheckmark: false,
                                    selectedColor: Constants.appBlue,
                                    selected: true,
                                    label: Text(filters.elementAt(index)),
                                    onSelected: (bool value) {
                                      filters.removeAt(index);
                                      setState(() {});
                                    },
                                  ).animate(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: Center(
                        child: Text(
                          "no interest selected",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  GestureDetector(
                    onTap: () {
                      nextScreen(context, MediaAdd());
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
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ))),
                    )
                        .animate()
                        .fadeIn(curve: Curves.easeOut, duration: 1000.ms)
                        .slideY(duration: 1000.ms, begin: 0.5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
