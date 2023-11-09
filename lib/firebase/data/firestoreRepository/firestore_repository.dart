import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreRepository {
  final db = FirebaseFirestore.instance;

  final user = FirebaseAuth.instance.currentUser;
  final String userRef = "Users";

  Future<void> addUserToDb(
      String email,
      String name,
      List<int> interests,
      GeoFirePoint myLocation,
      String primarypicurl,
      String secondarypicurl,
      String videourl) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    db.collection(userRef).doc(user?.uid).set({
      "Email": user?.email,
      "Name": prefs.getString("name") ?? "",
      "Interests": prefs.getStringList("interests"),
      "Location": myLocation.data,
      "Primarypicurl": primarypicurl,
      "Secondarypicurl": secondarypicurl,
      "Videourl": videourl
    }).onError((error, stackTrace) => debugPrint(error.toString()));
  }
}
