import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nightlify/PartnerDetail/partnerdetails.dart';
import 'package:nightlify/user/profile/profile.dart';
import 'package:nightlify/widgets/card.dart';
import 'package:nightlify/widgets/navigation.dart';
import 'package:random_avatar/random_avatar.dart';

import '../constants/constants.dart';

class SwipeMatch extends StatefulWidget {
  const SwipeMatch({super.key});

  @override
  State<SwipeMatch> createState() => _SwipeMatchState();
}

class _SwipeMatchState extends State<SwipeMatch> {
  final CardSwiperController controller = CardSwiperController();

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.appBlack,
        body: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.map,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.emoji_events,
                        color: Colors.white,
                      )),
                  GestureDetector(
                    onTap: () {
                      nextScreen(context, UserProfile());
                    },
                    child: CircleAvatar(
                      radius: 20,
                      child: Container(),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: CardSwiper(
                controller: controller,
                cardsCount: 10,
                onSwipe: (previousIndex, currentIndex, direction) {
                  return true;
                },
                onUndo: (previousIndex, currentIndex, direction) {
                  return true;
                },
                numberOfCardsDisplayed: 3,
                backCardOffset: const Offset(40, 40),
                padding: const EdgeInsets.all(24.0),
                cardBuilder: (
                  context,
                  index,
                  horizontalThresholdPercentage,
                  verticalThresholdPercentage,
                ) =>
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(
                                    milliseconds: 1000), // Delay of 1000ms
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return PartnerDetail();
                                },
                              ));
                        },
                        child: PartnerCard()),
              ),
            ),
          ],
        )));
  }
}
