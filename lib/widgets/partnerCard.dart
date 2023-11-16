import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nightlify/PartnerDetail/focusvideo.dart';
import 'package:nightlify/constants/constants.dart';

class PartnerCard extends StatefulWidget {
  PartnerCard({super.key});

  @override
  State<PartnerCard> createState() => _PartnerCardState();
}

class _PartnerCardState extends State<PartnerCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: Constants.h,
          width: Constants.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: Colors.white),
          child: Stack(children: [
            Container(
              height: Constants.h,
              width: Constants.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                    imageUrl:
                        'https://firebasestorage.googleapis.com/v0/b/whatsappclone-588c8.appspot.com/o/profile_pic%2Fpexels-athena-1758144.jpg?alt=media&token=9ca51a83-3b63-4235-a547-2d45d8cbde29',
                    fit: BoxFit.cover),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                        height: Constants.h / 7,
                        width: Constants.w,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.black,
                                Colors.black.withOpacity(0.9),
                                Colors.transparent
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white.withOpacity(0.8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: Constants.h,
                                width: Constants.w / 5,
                                child: Stack(children: [
                                  SizedBox(
                                    height: Constants.h,
                                    width: Constants.w / 5,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              'https://firebasestorage.googleapis.com/v0/b/whatsappclone-588c8.appspot.com/o/profile_pic%2Fpexels-athena-1758144.jpg?alt=media&token=9ca51a83-3b63-4235-a547-2d45d8cbde29',
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                transitionDuration: Duration(
                                                    milliseconds: 1000),
                                                reverseTransitionDuration: Duration(
                                                    milliseconds:
                                                        1000), // Delay of 1000ms
                                                pageBuilder: (context,
                                                    animation,
                                                    secondaryAnimation) {
                                                  return FocusVideo();
                                                },
                                              ));
                                        },
                                        icon: Icon(Icons.play_arrow),
                                        style: ButtonStyle(
                                            iconSize: MaterialStatePropertyAll(
                                                Constants.w / 20),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white),
                                            shape: MaterialStatePropertyAll(
                                                CircleBorder(eccentricity: 1))),
                                      )),
                                ]),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(3.0, 8, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Deensha Patel,24 ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(color: Colors.white)),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          4.0, 0, 2, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                CupertinoIcons.location,
                                                color: Colors.white60,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: Constants.w / 20,
                                              ),
                                              Text("India ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(
                                                CupertinoIcons.bag,
                                                color: Colors.white60,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: Constants.w / 20,
                                              ),
                                              Text("Model ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall)
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ),
            ),
          ])),
    );
  }
}
