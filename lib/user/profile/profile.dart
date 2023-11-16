import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nightlify/auth/bloc/auth_bloc.dart';
import 'package:nightlify/auth/login.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import 'package:nightlify/user/profile/edit_profile.dart';
import 'package:nightlify/user/profilebloc/profile_bloc.dart';
import 'package:nightlify/widgets/navigation.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:video_player/video_player.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late ProfileBloc _profileBloc;
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();

    _profileBloc = context.read<ProfileBloc>();
    context.read<ProfileBloc>().add(ProfileFetchEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _profileBloc.add(ProfileResetEvent());
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileSuccessfullyLoaded) {
        final userModel = state.userModel;
        flickManager = FlickManager(
            videoPlayerController: VideoPlayerController.networkUrl(
                Uri.parse(userModel.primaryVideo)));

        return Scaffold(
            backgroundColor: Constants.appBlack,
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Constants.appBlack,
                    systemOverlayStyle: SystemUiOverlayStyle.light,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    leading: IconButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white),
                            shape: MaterialStatePropertyAll(CircleBorder())),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          CupertinoIcons.arrow_left,
                          color: Constants.appBlack,
                        )),

                    expandedHeight: Constants.h / 1.2,
                    // Set the height of the header when expanded
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Add the background image
                          FlutterCarousel(
                              options: CarouselOptions(
                                indicatorMargin: 10,
                                viewportFraction: 1.0,
                                height: Constants.h / 1.2,
                                enableInfiniteScroll: true,
                                showIndicator: true,
                                autoPlay: true,
                                slideIndicator: CircularWaveSlideIndicator(
                                    alignment: Alignment.bottomLeft,
                                    currentIndicatorColor: Colors.white,
                                    indicatorRadius: 5,
                                    indicatorBackgroundColor:
                                        Constants.appBlack,
                                    itemSpacing: 15,
                                    padding: EdgeInsets.fromLTRB(25, 0, 0, 10)),
                              ),
                              items: [
                                Stack(fit: StackFit.expand, children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) {
                                        return LoadingAnimationWidget
                                            .threeArchedCircle(
                                                color: Colors.white, size: 36);
                                      },
                                      imageUrl: userModel.pimaryImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 32, 32),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        child: Icon(
                                          CupertinoIcons.camera,
                                          color: Constants.appBlack,
                                        ),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Colors.white.withOpacity(0.7)),
                                      ),
                                    ),
                                  )
                                ]),
                                Stack(fit: StackFit.expand, children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) {
                                        return LoadingAnimationWidget
                                            .threeArchedCircle(
                                                color: Colors.white, size: 36);
                                      },
                                      imageUrl: userModel.secondaryImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 32, 32),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        child: Icon(
                                          CupertinoIcons.camera,
                                          color: Constants.appBlack,
                                        ),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Colors.white.withOpacity(0.7)),
                                      ),
                                    ),
                                  )
                                ]),
                                Stack(fit: StackFit.expand, children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: FlickVideoPlayer(
                                        flickManager: flickManager),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 32, 32),
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
                                            color:
                                                Colors.white.withOpacity(0.7)),
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
                              height: Constants.h / 4.8,
                              width: Constants.w,
                              decoration: BoxDecoration(
                                  color: Constants.appGrey,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 12, 12, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            context
                                                .read<ProfileBloc>()
                                                .add(ProfileResetEvent());
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditUserProfile()),
                                            ).then((value) => context
                                                .read<ProfileBloc>()
                                                .add(ProfileFetchEvent()));
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: Constants.h / 10,
                                          width: Constants.w / 4,
                                          color: Colors.transparent,
                                          child: RandomAvatar(
                                            userModel.avatarString,
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
                                              userModel.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            Text(
                                              "@${userModel.userName}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(),
                                            ),
                                            Text(
                                              userModel.city,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            Text(
                                              userModel.state,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                            Text(
                                              userModel.country,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
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
                                      "${userModel.age}",
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
                                      "${userModel.partnerAge}",
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
                                      userModel.bio,
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
                                      children: List.generate(
                                          userModel.languages.length, (index) {
                                        return LanguageWidgetShowcase(
                                          label: userModel.languages
                                              .elementAt(index)
                                              .label,
                                          value: userModel.languages
                                              .elementAt(index)
                                              .proficiency,
                                        );
                                      }),
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
                                    Wrap(
                                      spacing: 15,
                                      runSpacing: 15,
                                      children: List.generate(
                                          userModel.interests.length, (index) {
                                        return Container(
                                          child: Text(
                                              userModel.interests
                                                  .elementAt(index),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                        );
                                      }),
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
              ),
            ));
      } else {
        return Container(
          child: LoadingAnimationWidget.threeArchedCircle(
              color: Colors.white, size: 36),
        );
      }
    });
  }
}

class LanguageWidgetShowcase extends StatefulWidget {
  LanguageWidgetShowcase({required this.label, required this.value});

  String label;
  double value;

  @override
  State<LanguageWidgetShowcase> createState() => _LanguageWidgetShowcaseState();
}

class _LanguageWidgetShowcaseState extends State<LanguageWidgetShowcase> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        SfSlider(
          min: 0.0,
          max: 100.0,
          value: widget.value,
          interval: 1,
          activeColor: Constants.appBlue,
          inactiveColor: Constants.appLightGrey,
          minorTicksPerInterval: 1,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
