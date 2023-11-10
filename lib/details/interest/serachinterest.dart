import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nightlify/constants/constants.dart';

import 'interest.dart';

class SearchInterest extends StatefulWidget {
  const SearchInterest({super.key});

  @override
  State<SearchInterest> createState() => _SearchInterestState();
}

List<String> filteredList = interestList;

class _SearchInterestState extends State<SearchInterest> {
  String input = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredList = interestList;
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      TextField(
                        autofocus: true,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        cursorColor: Constants.appBlue,
                        onChanged: (value) {
                          input = value;
                          setState(() {
                            filteredList = filterInterest(value);
                          });
                        },
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter a interest name eg. football',
                          hintStyle: Theme.of(context).textTheme.bodyMedium,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.all(8),
                          fillColor: Constants.appGrey,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                if (filteredList.isNotEmpty)
                                  Wrap(
                                    spacing: 15,
                                    runSpacing: 15,
                                    children: List.generate(
                                      filteredList.length,
                                      (index) => FilterChip(
                                        showCheckmark: false,
                                        selectedColor: Constants.appBlue,
                                        selected: filters.contains(
                                            filteredList.elementAt(index)),
                                        label:
                                            Text(filteredList.elementAt(index)),
                                        onSelected: (bool value) {
                                          if (value) {
                                            filters.add(
                                                filteredList.elementAt(index));
                                          } else {
                                            filters.remove(
                                                filteredList.elementAt(index));
                                          }
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  )
                                else
                                  TextButton(
                                      onPressed: () {
                                        if (filters.contains(input)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar((SnackBar(
                                            duration: 1000.ms,
                                            content: Text("already added"),
                                          )));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar((SnackBar(
                                            duration: 1000.ms,
                                            content: Text("added"),
                                          )));
                                          filters.add(input);
                                        }
                                      },
                                      style: ButtonStyle(
                                          splashFactory:
                                              NoSplash.splashFactory),
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Constants.appGrey,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "Add interest",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(color: Colors.white),
                                        ),
                                      ))
                              ],
                            ),
                          ),
                        ),
                      )
                    ])))));
  }
}

List<String> filterInterest(String input) {
  if (input == "") {
    return interestList;
  } else {
    List<String> temp = interestList.where((element) {
      if (element.toLowerCase().contains(input)) {
        return true;
      } else {
        return false;
      }
    }).toList();
    return temp;
  }
}
