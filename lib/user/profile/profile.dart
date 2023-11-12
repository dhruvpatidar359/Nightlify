import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:nightlify/auth/bloc/auth_bloc.dart';
import 'package:nightlify/auth/login.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:nightlify/user/profile/edit_profile.dart';
import 'package:nightlify/widgets/navigation.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool ageEnable = false;
  bool bioEnable = false;

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
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight:
                    400, // Set the height of the header when expanded
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      // Add the background image
                      FlutterCarousel(
                          options: CarouselOptions(
                            indicatorMargin: 10,
                            viewportFraction: 1.0,
                            height: 500.0,
                            enableInfiniteScroll: true,
                            showIndicator: true,
                            autoPlay: true,
                            slideIndicator: CircularWaveSlideIndicator(
                                alignment: Alignment.bottomLeft,
                                currentIndicatorColor: Constants.appBlue,
                                indicatorRadius: 5,
                                indicatorBackgroundColor: Constants.appBlack,
                                itemSpacing: 15,
                                padding: EdgeInsets.fromLTRB(25, 0, 0, 10)),
                          ),
                          items: [
                            Stack(fit: StackFit.expand, children: [
                              Container(
                                color: Colors.transparent,
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1469474968028-56623f02e42e?q=40',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 32, 32),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    child: Icon(
                                      CupertinoIcons.camera,
                                      color: Constants.appBlue,
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.7)),
                                  ),
                                ),
                              )
                            ]),
                            Stack(fit: StackFit.expand, children: [
                              Container(
                                color: Colors.transparent,
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1469474968028-56623f02e42e?q=40',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 32, 32),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    child: Icon(
                                      CupertinoIcons.video_camera,
                                      size: 30,
                                      color: Constants.appBlue,
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.7)),
                                  ),
                                ),
                              )
                            ]),
                            Stack(fit: StackFit.expand, children: [
                              Container(
                                color: Colors.transparent,
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1469474968028-56623f02e42e?q=40',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 32, 32),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    child: Icon(
                                      CupertinoIcons.camera,
                                      color: Constants.appBlue,
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.7)),
                                  ),
                                ),
                              )
                            ]),
                          ]),
                    ],
                  ),
                ),
                // Other properties like pinned, floating, elevation, etc.
                // can be customized as needed
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Container(
                          height: Constants.h / 5,
                          width: Constants.w,
                          decoration: BoxDecoration(
                              color: Constants.appGrey,
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0.0, 12, 12, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        nextScreen(context, EditUserProfile());
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.solidPenToSquare,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: Constants.h / 10,
                                      width: Constants.w / 4,
                                      color: Colors.transparent,
                                      child: RandomAvatar(
                                        "thi5jhgfd",
                                      ),
                                    ),
                                    Gap(20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Dhruv",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "@dhr_iss",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(),
                                        ),
                                        Text(
                                          "Madhya Pradesh , India",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Gap(10),
                        Container(
                          width: Constants.w,
                          decoration: BoxDecoration(
                              color: Constants.appGrey,
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Age",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "19",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(10),
                        Container(
                          width: Constants.w,
                          decoration: BoxDecoration(
                              color: Constants.appGrey,
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "PartnerAge",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "19",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(10),
                        Container(
                          width: Constants.w,
                          decoration: BoxDecoration(
                              color: Constants.appGrey,
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bio",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "Hello everyone my name is dhruv...i am the cutest guy in the world No one can stop us , but oit maasf",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(10),
                        Container(
                          width: Constants.w,
                          decoration: BoxDecoration(
                              color: Constants.appGrey,
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Language",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "English",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                    ),
                                    SfSlider(
                                        min: 0.0,
                                        max: 100.0,
                                        value: 10,
                                        interval: 1,
                                        activeColor: Constants.appBlue,
                                        inactiveColor: Constants.appLightGrey,
                                        minorTicksPerInterval: 1,
                                        onChanged: (dynamic value) {}),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Russian",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                    ),
                                    SfSlider(
                                        min: 0.0,
                                        max: 100.0,
                                        value: 10,
                                        interval: 1,
                                        activeColor: Constants.appBlue,
                                        inactiveColor: Constants.appLightGrey,
                                        minorTicksPerInterval: 1,
                                        onChanged: (dynamic value) {}),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(10),
                        Container(
                          width: Constants.w,
                          decoration: BoxDecoration(
                              color: Constants.appGrey,
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Interests",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "Hello everyone my name is dhruv...i am the cutest guy in the world No one can stop us , but oit maasf",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(10),
                        Gap(10),
                        GestureDetector(
                          onTap: () {
                            context.read<AuthBloc>().add(SignOutEvent());
                            nextScreenReplace(context, Login());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: Constants.w,
                            decoration: BoxDecoration(
                                color: Constants.appGrey,
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "Logout",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
