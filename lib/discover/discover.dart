import 'dart:ui';

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:nightlify/discover/twoDScrollableGrid.dart';
import 'package:nightlify/widgets/navigation.dart';
import 'package:random_avatar/random_avatar.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.appBlack,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Constants.appGrey),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(FontAwesomeIcons.heart),
                color: Colors.white,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.house),
                color: Colors.white,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.heart),
                color: Colors.white,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Discover",
                        style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 28)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            color: Colors.white,
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Constants.appLightGrey)),
                            onPressed: () {},
                            icon: Icon(
                              CupertinoIcons.bell,
                              color: Colors.white60,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        CircleAvatar(
                          radius: 25,
                          child: RandomAvatar("wwegf"),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
                  child: SearchBar(
                    onTap: () {},
                    textStyle: MaterialStatePropertyAll(
                      GoogleFonts.nunito(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.all(2),
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          CupertinoIcons.search,
                          color: Colors.white60,
                        ),
                      ),
                    ),
                    trailing: [
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ImageIcon(
                            AssetImage("assets/images/filter.png"),
                            size: 25,
                            color: Colors.white60,
                          ),
                        ),
                      )
                    ],
                    backgroundColor:
                        MaterialStatePropertyAll(Constants.appLightGrey),
                    // overlayColor: MaterialStatePropertyAll(Constants.appLightGrey),
                    surfaceTintColor:
                        MaterialStatePropertyAll(Constants.appLightGrey),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: StaggeredGrid.count(
                      axisDirection: AxisDirection.down,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 8,
                      children: [
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 2,
                          child: GestureDetector(
                            onTap: () {
                              nextScreen(context, MatrixMatch());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image:
                                          AssetImage("assets/images/woman.jpg"),
                                      fit: BoxFit.cover)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: Constants.h / 14,
                                    width: Constants.w,
                                    color: Constants.appBlack.withOpacity(0.8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Matrix Match",
                                            style: GoogleFonts.nunito(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/woman1.jpg"),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: Constants.h / 14,
                                  width: Constants.w,
                                  color: Constants.appBlack.withOpacity(0.8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Swipe Magicx",
                                          style: GoogleFonts.nunito(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/mapbackground.png"),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topCenter)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: Constants.h / 16,
                                    width: Constants.w,
                                    color: Constants.appBlack.withOpacity(0.8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 0, 0),
                                          child: Text(
                                            "Night Map",
                                            style: GoogleFonts.nunito(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                        StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/nightevent.jpg"),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: Constants.h / 16,
                                    width: Constants.w,
                                    color: Constants.appBlack.withOpacity(0.8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 0, 0),
                                          child: Text(
                                            "Night Event",
                                            style: GoogleFonts.nunito(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 4,
                          mainAxisCellCount: 2,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
