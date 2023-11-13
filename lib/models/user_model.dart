import 'package:geoflutterfire2/geoflutterfire2.dart';

import '../user/profile/edit_profile.dart';

class UserModel {
  UserModel(
      {required this.name,
      required this.userName,
      required this.avatarString,
      required this.city,
      required this.country,
      required this.state,
      required this.location,
      required this.age,
      required this.partnerAge,
      required this.bio,
      required this.languages,
      required this.interests,
      required this.pimaryImage,
      required this.secondaryImage,
      required this.primaryVideo});

  String name;
  String userName;
  String avatarString;
  String city;
  String country;
  String state;
  GeoFirePoint location;
  int age;
  String partnerAge;
  String bio;
  List<LanguageModel> languages;
  List<String> interests;
  String pimaryImage;
  String secondaryImage;
  String primaryVideo;
}
