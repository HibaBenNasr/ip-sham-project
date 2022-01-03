import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FireStorageService extends ChangeNotifier{
  FireStorageService();
  static Future<String> loadImage (String Image) async{
    String downloadUrl= await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
    return downloadUrl;
  }
}

class AuthHelper {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  static Future<dynamic> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // static Future<void> resetPassword(String email) async {
  //   await _firebaseAuth.sendPasswordResetEmail(email: email);
  // }

  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static User? currentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
