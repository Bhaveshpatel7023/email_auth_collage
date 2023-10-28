
import 'package:email_authentication/Auth/signuppage.dart';
import 'package:email_authentication/contant.dart';
import 'package:email_authentication/theam/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'loginpage.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: primarytheme,
                        )),
                  ],
                ),
              ),
             SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Reset Password',
                        style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: Text(
                          'We’ll send you an OTP on your registered email id.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.6)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    CustomTextFieldWidget(
                      labelText: 'Email Address',
                      controller: _controller,
                    ),
                    SizedBox(height: 20,),
                    // addVerticalSpace(6),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => SignupPage())));
                          },
                          child: Text(
                            'Sign up with new email id?',
                            style: TextStyle(
                              fontSize: 13,
                                color: Colors.black.withOpacity(0.5)
                            ),
                          )),
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.09),
                    CustomButton(
                        name: 'Send',
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: ((context) => CreateNewPassword())));

                          //Send-Password-Reset-Link//
                          if (_controller.text == null) {
                            Fluttertoast.showToast(
                                msg: "Please enter email address");
                          }
                          FirebaseServices()
                              .passwordReset(_controller.text, context);
                        })
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await _auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      throw e;
    }
  }

  //getting UID
  Future<String> getCurrentUID() async {
    return (await _auth.currentUser!).uid;
  }

  // signInWithFacebook() async {
  //   try {
  //     final LoginResult loginResult = await FacebookAuth.instance.login();
  //     final OAuthCredential facebookAuthCredential =
  //     FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //     await _auth.signInWithCredential(facebookAuthCredential);
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //     throw e;
  //   }
  // }
  // signOUt()async{
  //  await _auth.signOut();
  //  await _googleSignIn.signOut();
  // }

  //-----Password-Reset-----//

  Future<void> passwordReset(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Reset Password"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              actionsAlignment: MainAxisAlignment.center,
              actionsPadding: const EdgeInsets.all(2),
              content: const Text(
                  "Hey! A password reset link has been sent to your email. Please check your inbox and use the link to reset your password. Once you have reset your password, you can log in to your account with your new credentials."),
              actions: <Widget>[
                Padding(
                  padding:
                  const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: primarytheme),
                    child: Container(
                      height: 50,
                      width: width(context),
                      child: const Center(
                        child: Text(
                          "OK",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => LoginPage()));
                    },
                  ),
                ),
              ],
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }
}

