import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unsplash_client/unsplash_client.dart';

class FirestoreRepository {
  final db = FirebaseFirestore.instance;

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
      "Username": username
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
}
