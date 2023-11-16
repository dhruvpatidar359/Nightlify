import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nightlify/constants/constants.dart';
import 'package:nightlify/firebase/data/firestoreRepository/firestore_repository.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class LanguageModel {
  LanguageModel(this.label, this.proficiency);

  String label;
  double proficiency;
}

List<LanguageModel> languages = [];

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  TextEditingController _avatarTextField = TextEditingController();
  TextEditingController _ageTextField = TextEditingController();
  TextEditingController _bioTextField = TextEditingController();
  TextEditingController _nameTextField = TextEditingController();
  TextEditingController _partnerAgeTextField = TextEditingController();

  String country = "";
  String state = "";
  String city = "";

  String defaultAvatarString = 'a';
  String avatarText = "";

  final FirestoreRepository firestoreRepository = FirestoreRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dummy the avatar string from the database
    String online = "pdk";
    if (online.isEmpty) {
      avatarText = defaultAvatarString;
    } else {
      avatarText = online;
      _avatarTextField.text = online;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.appBlack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Edit Profile",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                Gap(10),
                Container(
                  width: Constants.w,
                  decoration: BoxDecoration(
                      color: Constants.appGrey,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Avatar",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RandomAvatar(avatarText,
                                height: Constants.h / 6,
                                width: Constants.h / 6),
                          ],
                        ),
                        Gap(5),
                        TextField(
                          style: Theme.of(context).textTheme.titleSmall,
                          cursorColor: Colors.white,

                          // controller: controller,

                          cursorWidth: 1,
                          onChanged: (value) {
                            if (_avatarTextField.text.isEmpty) {
                              avatarText = defaultAvatarString;
                            } else {
                              avatarText = _avatarTextField.text;
                            }
                            setState(() {});
                          },
                          controller: _avatarTextField,
                          decoration: InputDecoration(
                            // errorText: nameError == true ? "name field is empty" : null,
                            filled: true,
                            fillColor: Constants.appBlack,

                            hintText: "Avatar string",
                            labelStyle: Theme.of(context).textTheme.titleSmall,
                            hintStyle: Theme.of(context).textTheme.titleSmall,
                            contentPadding: EdgeInsets.all(16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
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
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                        ),
                        Gap(10),
                        TextField(
                          style: Theme.of(context).textTheme.titleSmall,
                          cursorColor: Colors.white,

                          // controller: controller,

                          cursorWidth: 1,
                          onChanged: (value) {
                            if (_avatarTextField.text.isEmpty) {
                              avatarText = defaultAvatarString;
                            } else {
                              avatarText = _avatarTextField.text;
                            }
                            setState(() {});
                          },
                          controller: _nameTextField,
                          decoration: InputDecoration(
                            // errorText: nameError == true ? "name field is empty" : null,
                            filled: true,
                            fillColor: Constants.appBlack,

                            hintText: "name",
                            labelStyle: Theme.of(context).textTheme.titleSmall,
                            hintStyle: Theme.of(context).textTheme.titleSmall,
                            contentPadding: EdgeInsets.all(16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
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
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Location",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: [
                            Text(
                              "Update temporary location",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Constants.appBlack,
                                        surfaceTintColor: Constants.appBlack,
                                        title: Text(
                                          'Info',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        content: Text(
                                          "This is your longitude and latitude location that is used for getting the distances between two users .",
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
                                },
                                icon: Icon(
                                  CupertinoIcons.info,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        TextButton(
                          onPressed: () async {
                            await firestoreRepository.updateTempLocation();
                          },
                          style: ButtonStyle(),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Constants.appBlue),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 4, 8, 4),
                              child: Text(
                                "update",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                        Gap(10),
                        Text(
                          "Update permanent location",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Gap(10),
                        CSCPicker(
                          countryFilter: const [CscCountry.India],
                          disabledDropdownDecoration: BoxDecoration(
                              color: Constants.appLightGrey,
                              borderRadius: BorderRadius.circular(15)),
                          dropdownDecoration: BoxDecoration(
                              color: Constants.appBlack,
                              borderRadius: BorderRadius.circular(15)),
                          dropdownItemStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Constants.appBlack),
                          dropdownHeadingStyle:
                              Theme.of(context).textTheme.bodyMedium,
                          onCountryChanged: (value) {
                            setState(() {
                              // countryValue = value;
                              country = value;
                            });
                          },
                          onStateChanged: (value) {
                            setState(() {
                              // stateValue = value;
                              state = value ?? "";
                            });
                          },
                          onCityChanged: (value) {
                            setState(() {
                              // cityValue = value;
                              city = value ?? "";
                            });
                          },
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
                    padding: const EdgeInsets.all(16),
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
                        Gap(10),
                        TextField(
                          style: Theme.of(context).textTheme.titleSmall,
                          cursorColor: Colors.white,

                          // controller: controller,

                          cursorWidth: 1,
                          onChanged: (value) {
                            if (_avatarTextField.text.isEmpty) {
                              avatarText = defaultAvatarString;
                            } else {
                              avatarText = _avatarTextField.text;
                            }
                            setState(() {});
                          },
                          controller: _ageTextField,
                          decoration: InputDecoration(
                            // errorText: nameError == true ? "name field is empty" : null,
                            filled: true,
                            fillColor: Constants.appBlack,

                            hintText: "age",
                            labelStyle: Theme.of(context).textTheme.titleSmall,
                            hintStyle: Theme.of(context).textTheme.titleSmall,
                            contentPadding: EdgeInsets.all(16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
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
                    padding: const EdgeInsets.all(16),
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
                        Gap(10),
                        TextField(
                          style: Theme.of(context).textTheme.titleSmall,
                          cursorColor: Colors.white,

                          // controller: controller,

                          cursorWidth: 1,
                          onChanged: (value) {
                            if (_avatarTextField.text.isEmpty) {
                              avatarText = defaultAvatarString;
                            } else {
                              avatarText = _avatarTextField.text;
                            }
                            setState(() {});
                          },
                          controller: _partnerAgeTextField,
                          decoration: InputDecoration(
                            // errorText: nameError == true ? "name field is empty" : null,
                            filled: true,
                            fillColor: Constants.appBlack,

                            hintText: "partner age",
                            labelStyle: Theme.of(context).textTheme.titleSmall,
                            hintStyle: Theme.of(context).textTheme.titleSmall,
                            contentPadding: EdgeInsets.all(16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
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
                    padding: const EdgeInsets.all(16),
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
                        Gap(10),
                        TextField(
                          maxLength: 200,
                          maxLines: 6,

                          style: Theme.of(context).textTheme.titleSmall,
                          cursorColor: Colors.white,

                          // controller: controller,

                          cursorWidth: 1,
                          onChanged: (value) {
                            if (_avatarTextField.text.isEmpty) {
                              avatarText = defaultAvatarString;
                            } else {
                              avatarText = _avatarTextField.text;
                            }
                            setState(() {});
                          },
                          controller: _bioTextField,
                          decoration: InputDecoration(
                            // errorText: nameError == true ? "name field is empty" : null,
                            filled: true,
                            fillColor: Constants.appBlack,
                            counterStyle:
                                Theme.of(context).textTheme.bodyMedium,

                            hintText: "bio",
                            labelStyle: Theme.of(context).textTheme.titleSmall,
                            hintStyle: Theme.of(context).textTheme.titleSmall,
                            contentPadding: EdgeInsets.all(16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
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
                          "Languages",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                        ),
                        Column(
                          children: List.generate(languages.length, (index) {
                            return LanguageWidget(
                              index: index,
                              label: languages.elementAt(index).label,
                              callBack: () {
                                languages.removeAt(index);

                                setState(() {});
                              },
                            );
                          }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  String pickedLang = "English";

                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        surfaceTintColor: Constants.appBlack,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Constants.appBlack,
                                        content: StatefulBuilder(
                                          builder: (BuildContext context,
                                                  StateSetter dropDownState) =>
                                              DropdownButton(
                                            // Initial Value
                                            dropdownColor: Constants.appBlack,
                                            value: pickedLang,

                                            // Down Arrow Icon
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),

                                            // Array list of items
                                            items: items.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(
                                                  items,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              );
                                            }).toList(),

                                            onChanged: (String? newValue) {
                                              dropDownState(() {
                                                pickedLang = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              bool isAlreadyChosen = languages
                                                  .where((element) =>
                                                      element.label ==
                                                      pickedLang)
                                                  .isEmpty;
                                              Navigator.of(context).pop();
                                              if (isAlreadyChosen) {
                                                languages.add(LanguageModel(
                                                    pickedLang, 10));
                                                setState(() {});
                                              }
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
                                },
                                style: ButtonStyle(
                                    splashFactory: NoSplash.splashFactory),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Constants.appBlack,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Add langauge",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Gap(10),
                GestureDetector(
                  onTap: () async {
                    String avatarString = _avatarTextField.text;
                    String name = _nameTextField.text;
                    int age = int.parse(_ageTextField.text);
                    String bio = _bioTextField.text;
                    String partnerAge = _partnerAgeTextField.text;

                    await firestoreRepository.updateUserProfile(
                        avatarString,
                        name,
                        city,
                        country,
                        state,
                        partnerAge,
                        languages,
                        age,
                        bio);
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
                        "Save",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Constants.appBlue,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
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

class LanguageWidget extends StatefulWidget {
  LanguageWidget(
      {required this.index, required this.label, required this.callBack});

  int index;
  String label;
  VoidCallback callBack;

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  double _currentValue = 20.0;

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
            IconButton(
                onPressed: () {
                  widget.callBack();
                },
                icon: Icon(
                  CupertinoIcons.delete,
                  color: Constants.appBlue,
                ))
          ],
        ),
        SfSlider(
            min: 0.0,
            max: 100.0,
            value: _currentValue,
            interval: 1,
            activeColor: Constants.appBlue,
            inactiveColor: Constants.appLightGrey,
            minorTicksPerInterval: 1,
            onChangeEnd: (value) {
              languages.elementAt(widget.index).proficiency = value;
            },
            onChanged: (dynamic value) {
              setState(() {
                _currentValue = value;
              });
            }),
      ],
    );
  }
}
