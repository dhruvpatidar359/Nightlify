import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:nightlify/discover/discover.dart';
import 'package:nightlify/widgets/navigation.dart';

enum InterestArea {
  Photography,
  Gaming,
  Coding,
  Cudling,
  Playing,
  Football,
  Swimming
}

class InterestAreaModel {
  InterestAreaModel({required this.interest, required this.icon});

  String interest;
  Icon icon;
}

List<InterestAreaModel> interestList = [
  InterestAreaModel(
    interest: "Photography",
    icon: Icon(FontAwesomeIcons.camera),
  ),
  InterestAreaModel(
    interest: "Gaming",
    icon: Icon(FontAwesomeIcons.gamepad),
  ),
  InterestAreaModel(
    interest: "Coding",
    icon: Icon(FontAwesomeIcons.code),
  ),
  InterestAreaModel(
    interest: "Playing",
    icon: Icon(FontAwesomeIcons.play),
  ),
  InterestAreaModel(
    interest: "Football",
    icon: Icon(FontAwesomeIcons.football),
  ),
  InterestAreaModel(
    interest: "Swimming",
    icon: Icon(FontAwesomeIcons.personSwimming),
  ),
  InterestAreaModel(
    interest: "Cooking",
    icon: Icon(FontAwesomeIcons.utensils),
  ),
  InterestAreaModel(
    interest: "Music",
    icon: Icon(FontAwesomeIcons.music),
  ),
  InterestAreaModel(
    interest: "Reading",
    icon: Icon(FontAwesomeIcons.book),
  ),
  InterestAreaModel(
    interest: "Traveling",
    icon: Icon(FontAwesomeIcons.globe),
  ),
  InterestAreaModel(
    interest: "Art",
    icon: Icon(FontAwesomeIcons.paintBrush),
  ),
  InterestAreaModel(
    interest: "Science",
    icon: Icon(FontAwesomeIcons.microscope),
  ),
  InterestAreaModel(
    interest: "Dancing",
    icon: Icon(FontAwesomeIcons.drum),
  ),
  InterestAreaModel(
    interest: "Hiking",
    icon: Icon(FontAwesomeIcons.hiking),
  ),
  InterestAreaModel(
    interest: "Yoga",
    icon: Icon(FontAwesomeIcons.spa),
  ),
  InterestAreaModel(
    interest: "Movies",
    icon: Icon(FontAwesomeIcons.film),
  ),
  InterestAreaModel(
    interest: "Sports",
    icon: Icon(FontAwesomeIcons.footballBall),
  ),
  InterestAreaModel(
    interest: "Writing",
    icon: Icon(FontAwesomeIcons.pen),
  ),
  InterestAreaModel(
    interest: "Fishing",
    icon: Icon(FontAwesomeIcons.fish),
  ),
  InterestAreaModel(
    interest: "Shopping",
    icon: Icon(FontAwesomeIcons.shoppingBag),
  ),
];

List<String> filters = [];

class Interest extends StatefulWidget {
  const Interest({super.key});

  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.appBlack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            color: Constants.appBlack,
                            icon: Icon(Icons.chevron_left),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateColor.resolveWith((states) {
                                  return Colors.white;
                                }),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5), // Adjust the value to make it square
                                )))),
                        Text(
                          "skip",
                          style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Constants.h / 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your interests",
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                        Text(
                          "Select interest on the basis of which you will be gonna match",
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white70),
                        )
                      ],
                    ),
                  ],
                ),
              ),
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
                            interestList.length,
                            (index) => FilterChip(
                              avatar: interestList.elementAt(index).icon,
                              showCheckmark: false,
                              selectedColor: Constants.appBlue,
                              selected: filters.contains(
                                  interestList.elementAt(index).interest),
                              label:
                                  Text(interestList.elementAt(index).interest),
                              onSelected: (bool value) {
                                if (value) {
                                  filters.add(
                                      interestList.elementAt(index).interest);
                                } else {
                                  filters.remove(
                                      interestList.elementAt(index).interest);
                                }
                                setState(() {});
                              },
                            ).animate(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  nextScreenReplace(context, Discover());
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
    );
  }
}
