import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_button/sign_button.dart';

import 'onboarding_func.dart';
import 'onboarding_welcome.dart';


Future<UserCredential> signInWithGithub() async {
  GithubAuthProvider githubAuthProvider = GithubAuthProvider();
  return await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
}
buildGithubButton(){

  return  GithubAuthButton(

    onPressed: () async {
      try {
        UserCredential userCredential = await signInWithGithub();
        Get.to( Welcome(
          displayName: userCredential.user!.displayName!,
          photoURL: userCredential.user!.photoURL ?? "",
          email: userCredential.user!.email!,
        ));

      } catch (e) {
        Get.snackbar("Error", e.toString(),backgroundColor: Colors.redAccent);
      }
    },
  );
}