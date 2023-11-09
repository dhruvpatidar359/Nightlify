import 'package:flutter/material.dart';
import 'package:nightlify/constants/constants.dart';

class PairCard extends StatelessWidget {
  PairCard(
      {required this.url,
      required this.name,
      required this.age,
      required this.distance,
      required this.profession});

  final String url;
  final String name;
  final int age;
  final int distance;
  final String profession;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constants.h,
      width: Constants.w,
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:
                  DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Constants.appBlue.withOpacity(0.2)
                    ],
                    stops: [
                      0.6,
                      1.0
                    ])),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dhruv, 21",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.white),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "12km ,Student",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
