import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:nightlify/details/media/media.dart';
import 'package:nightlify/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unsplash_client/unsplash_client.dart';

import '../../../GeolocatorServices/geolocatioservices.dart';
import '../../../user/profile/edit_profile.dart';

class FirestoreRepository {
  final db = FirebaseFirestore.instance;
  final geo = GeoFlutterFire();

  final user = FirebaseAuth.instance.currentUser;
  final String userRef = "Users";
  final String usernameRef = "Username";

  Future<void> addUserToDb(
      String email,
      String name,
      List<String> interests,
      GeoFirePoint myLocation,
      String partnerAge,
      String username,
      String primarypicurl,
      String secondarypicurl,
      String videourl) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // others will be changed by the user later so that he can enter into the app first

    db.collection(userRef).doc(user?.uid).set({
      "Email": user?.email,
      "Name": prefs.getString("name") ?? "",
      "Interests": interests,
      "Location": myLocation.data,
      "PartnerAge": partnerAge,
      "Primarypicurl": primarypicurl,
      "Secondarypicurl": secondarypicurl,
      "Videourl": videourl,
      "Likedusers": [],
      "Username": [],
      "Gender": "",
      "Bio": "",
      "Age": -1,
      "Username": username,
      "Languages": [],
      "AvatarString": "",
      "City": "",
      "State": "",
      "Country": ""
    }).onError((error, stackTrace) => debugPrint(error.toString()));
  }

  Future<bool> isUsernameAlreadyTaken(String username) async {
    // Reference to the 'users' collection in Firestore
    CollectionReference ref = db.collection(usernameRef);

    // Query the collection for documents where 'username' field matches the provided username
    QuerySnapshot querySnapshot =
        await ref.where('Username', isEqualTo: username).get();

    // Check if any documents match the query
    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> addUsername(String username) async {
    CollectionReference ref = db.collection(usernameRef);
    await ref.doc().set({"Username": username});
  }

  Future<bool> hasUserAlreadyGivenTheDetails(String uid) async {
    CollectionReference ref = db.collection(userRef);
    final documentSnapShot = await ref.doc(uid).get();
    return documentSnapShot.exists;
  }

  Future<void> updateUserProfile(
      String avatarString,
      String name,
      String city,
      String country,
      String state,
      String partnerAge,
      List<LanguageModel> languages,
      int age,
      String bio) async {
    CollectionReference ref = db.collection(userRef);
    await ref.doc(user?.uid).update({
      "AvatarString": avatarString,
      "Name": name,
      "City": city,
      "Country": country,
      "State": state,
      "Age": age,
      "PartnerAge": partnerAge,
      "Bio": bio,
      "Languages": languages.toMap()
    });
  }

  Future<void> updateTempLocation() async {
    final position = await determinePosition();
    final curLocation =
        geo.point(latitude: position.latitude, longitude: position.longitude);

    CollectionReference ref = db.collection(userRef);
    await ref.doc(user?.uid).update({"Location": curLocation.data});
  }

  Future<UserModel> fetchUserDetails() async {
    CollectionReference ref = db.collection(userRef);
    final documentSnapShot = await ref.doc(user?.uid).get();
    final docuMap = documentSnapShot.data() as Map<String, dynamic>;
// print()
    return UserModel(
      name: docuMap["Name"] ?? "",
      userName: docuMap["Username"] ?? "",
      avatarString: docuMap["AvatarString"] ?? "",
      city: docuMap["City"] ?? "",
      country: docuMap["Country"] ?? "",
      state: docuMap["State"] ?? "",
      location: GeoFirePoint(
        docuMap['Location']['geopoint'].latitude,
        docuMap['Location']['geopoint'].longitude,
      ),
      age: docuMap["Age"] ?? 0,
      partnerAge: docuMap["PartnerAge"] ?? "40-80",
      bio: docuMap["Bio"] ?? "",
      languages: (docuMap["Languages"] as Map<String, dynamic>?) != null
          ? (docuMap["Languages"] as Map<String, dynamic>).toList()
          : [],
      interests: ((docuMap["Interests"] ?? <List<String>>[])).cast<String>(),
      pimaryImage: docuMap["Primarypicurl"] ?? "",
      secondaryImage: docuMap["Secondarypicurl"] ?? "",
      primaryVideo: docuMap["Videourl"] ?? "",
    );
  }
}

extension LanguageListExtension on List<LanguageModel> {
  Map<String, double> toMap() {
    return Map.fromEntries(map((languageModel) =>
        MapEntry(languageModel.label, languageModel.proficiency)));
  }
}

extension LanguageListExtensiontwo on Map<String, dynamic> {
  List<LanguageModel> toList() {
    List<LanguageModel> list = [];
    this.forEach((key, value) {
      list.add(LanguageModel(key, value));
    });
    return list;
  }
}
