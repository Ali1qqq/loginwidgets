import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'onboarding_func.dart';
import 'onboarding_welcome.dart';

class PasswordAuthentication extends StatefulWidget {
  const PasswordAuthentication({super.key});

  @override
  State<PasswordAuthentication> createState() => _PasswordAuthenticationState();
}

class _PasswordAuthenticationState extends State<PasswordAuthentication>
    with Func {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all( 8.0,),
          child: Text(
            "Password Authentication",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(hintText: "Enter email address"),
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(hintText: "Enter password"),
          obscureText: true,
        ),
        const SizedBox(height: 10,),
        Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                onPressed: () async {
                  try {
                    final UserCredential userCredential =
                        await signInWithEmailAndPassword(
                            emailController.text, passwordController.text);

                    if (context.mounted) {
                      Get.to(Welcome(
                        displayName:
                        userCredential.user!.displayName ?? "",
                        photoURL:
                        userCredential.user!.photoURL ?? "",
                        email: userCredential.user!.email!,
                      ));
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      Get.snackbar("Error", "No user found for that email",backgroundColor: Colors.redAccent);

                    } else if (e.code == 'wrong-password') {
                      Get.snackbar("Error", "Wrong password provided for that user",backgroundColor: Colors.redAccent);

                    }
                  } catch (e) {
                    Get.snackbar("Error",e.toString(),backgroundColor: Colors.redAccent);                  }
                },
                child: const Text("Sign in")))
      ],
    );
  }
}
