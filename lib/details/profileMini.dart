import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:nightlify/details/interest.dart';
import 'package:nightlify/widgets/navigation.dart';
import 'package:random_avatar/random_avatar.dart';

class ProfileMiniDetails extends StatefulWidget {
  const ProfileMiniDetails({super.key});

  @override
  State<ProfileMiniDetails> createState() => _ProfileMiniDetailsState();
}

class _ProfileMiniDetailsState extends State<ProfileMiniDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController petName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.appBlack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "skip",
                        style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      )
                    ],
                  ),
                ),
                Container(
                  height: Constants.h / 4,
                  width: Constants.w / 2,
                  child: Stack(
                    children: [
                      Container(
                        height: Constants.h / 4,
                        width: Constants.w / 2,
                        color: Colors.transparent,
                        child: RandomAvatar(
                          'saytodfgsonz',
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Positioned(
                          right: 1,
                          bottom: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              FontAwesomeIcons.camera,
                              color: Constants.appBlack,
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: Constants.h / 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Constants.appGrey),
                  child: TextField(
                    controller: nameController,
                    cursorColor: Constants.appLightGrey,
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: InputDecoration(
                        focusColor: Colors.transparent,
                        fillColor: Constants.appGrey,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Name",
                        hintStyle: GoogleFonts.nunito(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: Constants.h / 80,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Constants.appGrey),
                  child: TextField(
                    controller: petName,
                    cursorColor: Constants.appLightGrey,
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: InputDecoration(
                        focusColor: Colors.transparent,
                        fillColor: Constants.appGrey,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Your Pet Name",
                        hintStyle: GoogleFonts.nunito(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: Constants.h / 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "like honey,baby..",
                      style: GoogleFonts.nunito(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: Constants.h / 15,
                ),
                GestureDetector(
                  onTap: () async {
                    BottomPicker.date(
                      backgroundColor: Constants.appGrey,
                      closeIconColor: Colors.white,
                      bottomPickerTheme: BottomPickerTheme.morningSalad,
                      buttonWidth: Constants.w / 2,
                      buttonSingleColor: Colors.white,
                      iconColor: Constants.appBlack,
                      pickerTextStyle: GoogleFonts.nunito(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.white),
                      title: "Set your Birthday",
                      titleStyle: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white),
                      onChange: (index) {
                        // print(index);
                      },
                      onSubmit: (index) {
                        // print(index);
                      },
                    ).show(context);
                  },
                  child: Container(
                    height: Constants.h / 12,
                    width: Constants.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Constants.appBlue),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            FontAwesomeIcons.calendar,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Choose Birthday Date",
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Constants.h / 15,
                ),
                GestureDetector(
                  onTap: () {
                    nextScreen(context, Interest());
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
                          "Confirm",
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
