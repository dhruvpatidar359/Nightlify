import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nightlify/GeolocatorServices/geolocatioservices.dart';
import 'package:nightlify/details/interest/interest.dart';
import 'package:nightlify/details/media/bloc/media_bloc.dart';
import 'package:nightlify/discover/discover.dart';
import 'package:nightlify/widgets/navigation.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../constants/constants.dart';
import '../../firebase/data/firestoreRepository/firestore_repository.dart';

class MediaAdd extends StatefulWidget {
  const MediaAdd({super.key});

  @override
  State<MediaAdd> createState() => _MediaAddState();
}

class _MediaAddState extends State<MediaAdd> {
  final FirestoreRepository _firestoreRepository = FirestoreRepository();

  late VideoPlayerController _videoPlayerController;
  bool isVideoPlayerInit = false;
  bool primaryImage = false;

  bool secondaryImage = false;

  bool primaryVideo = false;
  double progress = 0.85;

  String primaryImageUrl = "";
  String secondaryImageUrl = "";
  String primaryVideoUrl = "";

  @override
  void dispose() {
    // TODO: implement dispose

    if (isVideoPlayerInit) _videoPlayerController.dispose();
    super.dispose();
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
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
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
                              BlocBuilder<MediaBloc, MediaState>(
                                buildWhen: (previous, current) {
                                  if (current is GotImageOneState ||
                                      current is GotImageTwoState ||
                                      current is GotVideoState) {
                                    progress += 0.05;
                                    return true;
                                  } else if (current is ImageOneRemoved ||
                                      current is ImageTwoRemoved ||
                                      current is VideoRemoved) {
                                    progress -= 0.05;
                                    return true;
                                  } else {
                                    return false;
                                  }
                                },
                                builder: (context, state) =>
                                    CircularPercentIndicator(
                                  radius: 30.0,
                                  lineWidth: 3.0,
                                  backgroundColor: Constants.appGrey,
                                  percent: progress,
                                  animateFromLastPercent: true,
                                  center: Text(
                                    "${100.0 * num.parse(progress.toStringAsFixed(2))}%",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  progressColor: Constants.appBlue,
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Give us your best media",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w700)),
                              Text(
                                  "You have to provide us at least one photo of yours!",
                                  style: Theme.of(context).textTheme.bodySmall),
                              Gap(5),
                              Text("Note!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white)),
                              Text(
                                  "Your Primary Image will be shown in the match profile!",
                                  style: Theme.of(context).textTheme.bodySmall),
                              Gap(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  BlocBuilder<MediaBloc, MediaState>(
                                    buildWhen: (previous, current) {
                                      if (current
                                              is ImageMediaOneUploadingState ||
                                          current
                                              is ImageMediaOneSuccessState ||
                                          current is NoMediaOneState) {
                                        return true;
                                      } else {
                                        return false;
                                      }
                                    },
                                    builder: (BuildContext context,
                                        MediaState state) {
                                      if (state is ImageMediaOneSuccessState) {
                                        primaryImage = true;
                                        primaryImageUrl = state.url;
                                        return SizedBox(
                                          height: Constants.h / 3,
                                          width: Constants.w / 2.2,
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: Constants.h / 3,
                                                width: Constants.w / 2.2,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: FileImage(
                                                            File(state.path)),
                                                        fit: BoxFit.cover)),
                                                child: DottedBorder(
                                                  color: Colors.white,
                                                  dashPattern: [Checkbox.width],
                                                  strokeWidth: 1,
                                                  child: Container(),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      } else if (state
                                          is ImageMediaOneUploadingState) {
                                        print("we are building this one ");
                                        return SizedBox(
                                          height: Constants.h / 3,
                                          width: Constants.w / 2.2,
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: Constants.h / 3,
                                                width: Constants.w / 2.2,
                                                child: DottedBorder(
                                                  color: Colors.white,
                                                  dashPattern: [Checkbox.width],
                                                  strokeWidth: 1,
                                                  child: Container(
                                                    child: Center(
                                                      child:
                                                          CircularPercentIndicator(
                                                        radius: 30.0,
                                                        lineWidth: 3.0,
                                                        backgroundColor:
                                                            Constants.appGrey,
                                                        percent: state.progress,
                                                        animateFromLastPercent:
                                                            true,
                                                        center: Text(
                                                          "${100.0 * num.parse(state.progress.toStringAsFixed(2))}%",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        ),
                                                        progressColor:
                                                            Constants.appBlue,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            context
                                                .read<MediaBloc>()
                                                .add(ImageMediaOnePick());
                                          },
                                          child: SizedBox(
                                            height: Constants.h / 3,
                                            width: Constants.w / 2.2,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: Constants.h / 3,
                                                  width: Constants.w / 2.2,
                                                  child: DottedBorder(
                                                    color: Colors.white,
                                                    dashPattern: [
                                                      Checkbox.width
                                                    ],
                                                    strokeWidth: 1,
                                                    child: Center(
                                                        child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CircleAvatar(
                                                            backgroundColor:
                                                                Constants
                                                                    .appBlue,
                                                            child: Icon(
                                                                Icons.image)),
                                                        Text(
                                                          "PrimaryImage",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                        )
                                                      ],
                                                    )),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  DottedLine(
                                    direction: Axis.horizontal,
                                    alignment: WrapAlignment.center,
                                    lineLength: Constants.w / 4,
                                    lineThickness: 1.0,
                                    dashLength: 20.0,
                                    dashColor: Colors.white,
                                    dashGapLength: 15.0,
                                    dashGapColor: Colors.transparent,
                                    dashGapRadius: 0.0,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        context.read<MediaBloc>().add(
                                            ImageMediaOneDelete(primaryImage));

                                        primaryImage = false;
                                        primaryImageUrl = "";
                                      },
                                      icon: Icon(Icons.delete,
                                          color: Constants.appBlue))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        if (isVideoPlayerInit)
                                          _videoPlayerController.dispose();
                                        context.read<MediaBloc>().add(
                                            VideoMediaDelete(primaryVideo));
                                        primaryVideo = false;
                                        primaryVideoUrl = "";
                                      },
                                      icon: Icon(Icons.delete,
                                          color: Constants.appBlue)),
                                  DottedLine(
                                    direction: Axis.horizontal,
                                    alignment: WrapAlignment.center,
                                    lineLength: Constants.w / 4,
                                    lineThickness: 1.0,
                                    dashLength: 20.0,
                                    dashColor: Colors.white,
                                    dashGapLength: 15.0,
                                    dashGapColor: Colors.transparent,
                                    dashGapRadius: 0.0,
                                  ),
                                  BlocBuilder<MediaBloc, MediaState>(buildWhen:
                                      (previous, current) {
                                    if (current is VideoMediaUploadingState ||
                                        current is VideoMediaSuccessState ||
                                        current is NoMediaThreeState) {
                                      return true;
                                    } else {
                                      return false;
                                    }
                                  }, builder:
                                      (BuildContext context, MediaState state) {
                                    void syncVideo() async {
                                      await _videoPlayerController.play();
                                      await _videoPlayerController
                                          .setLooping(true);
                                      isVideoPlayerInit = true;
                                    }

                                    if (state is VideoMediaSuccessState) {
                                      primaryVideo = true;
                                      primaryVideoUrl = state.url;
                                      _videoPlayerController =
                                          VideoPlayerController.file(
                                              File(state.path))
                                            ..initialize();
                                      syncVideo();

                                      return SizedBox(
                                        height: Constants.h / 3,
                                        width: Constants.w / 2.2,
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: Constants.h / 3,
                                              width: Constants.w / 2.2,
                                              child: DottedBorder(
                                                  color: Colors.white,
                                                  dashPattern: [Checkbox.width],
                                                  strokeWidth: 1,
                                                  child: VideoPlayer(
                                                      _videoPlayerController)),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (state
                                        is VideoMediaUploadingState) {
                                      return SizedBox(
                                        height: Constants.h / 3,
                                        width: Constants.w / 2.2,
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: Constants.h / 3,
                                              width: Constants.w / 2.2,
                                              child: DottedBorder(
                                                color: Colors.white,
                                                dashPattern: [Checkbox.width],
                                                strokeWidth: 1,
                                                child: Container(
                                                  child: Center(
                                                    child:
                                                        CircularPercentIndicator(
                                                      radius: 30.0,
                                                      lineWidth: 3.0,
                                                      backgroundColor:
                                                          Constants.appGrey,
                                                      percent: state.progress,
                                                      animateFromLastPercent:
                                                          true,
                                                      center: Text(
                                                        "${100.0 * num.parse(state.progress.toStringAsFixed(2))}%",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                      progressColor:
                                                          Constants.appBlue,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          context
                                              .read<MediaBloc>()
                                              .add(VideoMediaPick());
                                        },
                                        child: SizedBox(
                                          height: Constants.h / 3,
                                          width: Constants.w / 2.2,
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: Constants.h / 3,
                                                width: Constants.w / 2.2,
                                                child: DottedBorder(
                                                  color: Colors.white,
                                                  dashPattern: [Checkbox.width],
                                                  strokeWidth: 1,
                                                  child: Center(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircleAvatar(
                                                          backgroundColor:
                                                              Constants.appBlue,
                                                          child: Icon(Icons
                                                              .video_collection)),
                                                      Text(
                                                        "PrimaryVideo",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                      )
                                                    ],
                                                  )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  })
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  BlocBuilder<MediaBloc, MediaState>(
                                    buildWhen: (previous, current) {
                                      if (current
                                              is ImageMediaTwoUploadingState ||
                                          current
                                              is ImageMediaTwoSuccessState ||
                                          current is NoMediaTwoState) {
                                        return true;
                                      } else {
                                        return false;
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is ImageMediaTwoSuccessState) {
                                        secondaryImage = true;
                                        secondaryImageUrl = state.url;
                                        return SizedBox(
                                          height: Constants.h / 3,
                                          width: Constants.w / 2.2,
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: Constants.h / 3,
                                                width: Constants.w / 2.2,
                                                child: DottedBorder(
                                                    color: Colors.white,
                                                    dashPattern: [
                                                      Checkbox.width
                                                    ],
                                                    strokeWidth: 1,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: FileImage(
                                                                  File(state
                                                                      .path)),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    )),
                                              )
                                            ],
                                          ),
                                        );
                                      } else if (state
                                          is ImageMediaTwoUploadingState) {
                                        print("we are building this one ");
                                        return SizedBox(
                                          height: Constants.h / 3,
                                          width: Constants.w / 2.2,
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: Constants.h / 3,
                                                width: Constants.w / 2.2,
                                                child: DottedBorder(
                                                  color: Colors.white,
                                                  dashPattern: [Checkbox.width],
                                                  strokeWidth: 1,
                                                  child: Container(
                                                    child: Center(
                                                      child:
                                                          CircularPercentIndicator(
                                                        radius: 30.0,
                                                        lineWidth: 3.0,
                                                        backgroundColor:
                                                            Constants.appGrey,
                                                        percent: state.progress,
                                                        animateFromLastPercent:
                                                            true,
                                                        center: Text(
                                                          "${100.0 * num.parse(state.progress.toStringAsFixed(2))}%",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        ),
                                                        progressColor:
                                                            Constants.appBlue,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            context
                                                .read<MediaBloc>()
                                                .add(ImageMediaTwoPick());
                                          },
                                          child: SizedBox(
                                            height: Constants.h / 3,
                                            width: Constants.w / 2.2,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: Constants.h / 3,
                                                  width: Constants.w / 2.2,
                                                  child: DottedBorder(
                                                    color: Colors.white,
                                                    dashPattern: [
                                                      Checkbox.width
                                                    ],
                                                    strokeWidth: 1,
                                                    child: Center(
                                                        child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CircleAvatar(
                                                            backgroundColor:
                                                                Constants
                                                                    .appBlue,
                                                            child: Icon(
                                                                Icons.image)),
                                                        Text(
                                                          "SecondaryImage",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                        )
                                                      ],
                                                    )),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  DottedLine(
                                    direction: Axis.horizontal,
                                    alignment: WrapAlignment.center,
                                    lineLength: Constants.w / 4,
                                    lineThickness: 1.0,
                                    dashLength: 20.0,
                                    dashColor: Colors.white,
                                    dashGapLength: 15.0,
                                    dashGapColor: Colors.transparent,
                                    dashGapRadius: 0.0,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        context.read<MediaBloc>().add(
                                            ImageMediaTwoDelete(
                                                secondaryImage));
                                        secondaryImage = false;
                                        secondaryImageUrl = "";
                                      },
                                      icon: Icon(Icons.delete,
                                          color: Constants.appBlue))
                                ],
                              )
                            ],
                          ),
                          Gap(20),
                          GestureDetector(
                            onTap: () async {
                              if (primaryImage &&
                                  primaryVideo &&
                                  secondaryImage) {
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
                                                  color: Colors.white,
                                                  size: 36),
                                        ));
                                  },
                                );

                                FirebaseAuth _firebaseAuth =
                                    FirebaseAuth.instance;
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                String email =
                                    _firebaseAuth.currentUser?.email ?? "";
                                String name = prefs.getString('name') ?? "";
                                final interests = filters;
                                final geo = GeoFlutterFire();
                                final position = await determinePosition();
                                final myLocation = geo.point(
                                    latitude: position.latitude,
                                    longitude: position.longitude);
                                final primarypicurl = primaryImageUrl;
                                final secondarypicurl = secondaryImageUrl;
                                final videourl = primaryVideoUrl;
                                final partnerAge = prefs.getString('age') ?? "";
                                final username =
                                    prefs.getString("username") ?? "";

                                await _firestoreRepository.addUserToDb(
                                    email,
                                    name,
                                    interests,
                                    myLocation,
                                    partnerAge,
                                    username,
                                    primarypicurl,
                                    secondarypicurl,
                                    videourl);
                                await _firestoreRepository
                                    .addUsername(username);
                                Navigator.pop(context);
                                nextScreenReplace(context, Discover());
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: Constants.appBlack,
                                      title: Text(
                                        'Media Upload necessary!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      content: Text(
                                        "All media has to be uploaded",
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
                        ]),
                  )))),
    );
  }
}
