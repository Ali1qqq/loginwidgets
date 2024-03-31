import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:local_auth/local_auth.dart';
import 'package:loginwidgets/onboaeding_apple.dart';
import 'onboarding_divider.dart';
import 'onboarding_facebook.dart';
import 'onboarding_func.dart';
import 'onboarding_github.dart';
import 'onboarding_google.dart';
import 'onboarding_password.dart';
import 'onboarding_signup.dart';
import 'onboarding_welcome.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with Func {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Ba3 Sign in",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Spacer(),
                  OutlinedButton(
                      onPressed: () {
                        Get.to(const SignUp());
                      },
                      style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white),
                      child: const Text("Sign up"))
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Text(
                  "Sign In",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              const Text("Sign in to join the team"),
              const PasswordAuthentication(),
              const CustomDivider(),
              AuthButtonGroup(
                  style: const AuthButtonStyle(
                    buttonType: AuthButtonType.icon,
                    margin: EdgeInsets.only(bottom: 10.0, top: 10),
                  ),
                  buttons: [
                    buildGoogleButton(),
                    buildAppleButton(),
                    buildFaceBookButton(),
                    buildGithubButton(),
                    EmailAuthButton(
                      onPressed: (){},
                    ),
                    HuaweiAuthButton(
                      onPressed: (){},
                    ),
                    MicrosoftAuthButton(
                      style: const AuthButtonStyle(
                        iconType: AuthIconType.secondary,
                        borderRadius: 5
                      ),
                      onPressed: (){},
                    ),
                    TwitterAuthButton(
                      onPressed: (){},
                    ),


                  ]),
              const CustomDivider(),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: Get.width * 0.7,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            shape: const StadiumBorder()),
                        onPressed: () async {
                          bool canAuthenticate = false;
                          bool didAuthenticate = false;
                          try {
                            final LocalAuthentication auth =
                                LocalAuthentication();
                            final bool canAuthenticateWithBiometrics =
                                await auth.canCheckBiometrics;

                            canAuthenticate = canAuthenticateWithBiometrics ||
                                await auth.isDeviceSupported();
                            if (!canAuthenticate) {
                              return;
                            }
                            setState(() {
                              canAuthenticate = canAuthenticate;
                            });
                            didAuthenticate = await auth.authenticate(
                                localizedReason:
                                    'Please authenticate to Goto Next Screen',
                                options: const AuthenticationOptions(
                                    biometricOnly: true));
                            setState(() {});
                            if (didAuthenticate) {
                              print("didAuthenticate");
                            }
                          } on PlatformException catch (e) {
                            print(e);
                          }
                        },
                        child: const Text(
                          "Use Biometric",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
