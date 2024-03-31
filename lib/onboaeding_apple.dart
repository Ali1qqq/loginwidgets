import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'onboarding_func.dart';


buildAppleButton(){

  return AppleAuthButton(

    onPressed: () async {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      print(credential);

    },
  );
}
Future<UserCredential> signInWithGithub() async {
  GithubAuthProvider githubAuthProvider = GithubAuthProvider();
  return await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
}