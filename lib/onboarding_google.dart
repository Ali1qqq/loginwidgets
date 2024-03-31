import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_button/sign_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:status_alert/status_alert.dart';
import 'firebase_options.dart';
import 'onboarding_welcome.dart';


buildGoogleButton(){return

  GoogleAuthButton(
    onPressed: () async {
      try {
        final UserCredential userCredential = await signInWithGoogle();


          Get.to(Welcome(
            displayName: userCredential.user!.displayName!,
            photoURL: userCredential.user!.photoURL ?? "",
            email: userCredential.user!.email!,
          ));


      } catch (e) {
        Get.snackbar("User Authentication", e.toString(),backgroundColor: Colors.redAccent);
      }
    },
  );

}

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn(
      clientId: (DefaultFirebaseOptions.currentPlatform ==
          DefaultFirebaseOptions.ios)
          ? DefaultFirebaseOptions.currentPlatform.iosClientId
          : DefaultFirebaseOptions.currentPlatform.androidClientId)
      .signIn();

  final GoogleSignInAuthentication? googleAuth =
  await googleUser?.authentication;

  final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
  return await FirebaseAuth.instance.signInWithCredential(credential);
}