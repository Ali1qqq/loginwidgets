import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sign_button/sign_button.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'onboarding_welcome.dart';


Future<UserCredential> signInWithFacebook() async {
  final LoginResult loginResult = await FacebookAuth.instance.login();
  final OAuthCredential facebookAuthCredential =
  FacebookAuthProvider.credential(loginResult.accessToken!.token);
  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}
buildFaceBookButton(){
  return FacebookAuthButton(

    onPressed: () async {
      try {
        final UserCredential userCredential = await signInWithFacebook();
        Get.to(Welcome(
          displayName: userCredential.user!.displayName!,
          photoURL: userCredential.user!.photoURL ?? "",
          email: userCredential.user!.email!,
        ));
      } catch (e) {

        Get.snackbar('User Authentication', e.toString());

      }
    },
  );
}