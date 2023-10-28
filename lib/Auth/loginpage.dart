// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_authentication/Auth/signuppage.dart';
import 'package:email_authentication/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgotPassword_Screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var passwordVisible = true;
  final _loginKey = GlobalKey<FormState>();

  String email = "";

  String password = "";
  String token = "";

  showSnackBar(BuildContext context, String str, [Color clr = Colors.black]) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(str),
      backgroundColor: clr,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginKey,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 900,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset('assets/images/doc1.png'),
                  ),

                  const SizedBox(height: 40),
                  const Text(
                    'User Login',
                    style: TextStyle(
                        fontFamily: "Roboto_Condensed",
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    height: 60,
                    width: 500,
                    child: TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      // controller: emailController,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        }
                        return "Value Cannot be Empty";
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter your Email',
                      ),
                    ),
                  ),
                  // ----------- Password ----------------

                  SizedBox(
                    height: 60,
                    width: 500,
                    child: TextFormField(
                      obscureText: passwordVisible,
                      onChanged: (value) {
                        password = value;
                      },
                      // controller: passwordController,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        }
                        return "Value Cannot be Empty";
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.blue.shade900,
                          ),
                          onPressed: (() {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          }),
                          iconSize: 30,
                        ),
                        hintText: 'Enter your Password',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                          },
                          child: Text('Forgot Password ?')),
                    ],
                  ),



                  const SizedBox(height: 35),

                  InkWell(
                    onTap: (() async {
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email, password: password);
                        final SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.setString('email', email.toString());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => HomeScreen())));
                        DocumentReference users =  FirebaseFirestore.instance
                            .collection('Users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('Notifications')
                            .doc();
                        users.set({

                          'NotifiID':users.id,
                          'mgs':'Your account is logged in ',
                          'Date&Time':DateTime.now(),
                          'User': FirebaseAuth.instance.currentUser!.uid,

                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(
                              context, "Your email is not exist", Colors.red);
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(
                              context, "Your password is Wrong", Colors.red);
                          print('Wrong password provided for that user.');
                        }
                      }
                      if (_loginKey.currentState!.validate()) {}
                    }),
                    child: Container(
                      height: 50,
                      width: 500,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Center(
                          child: Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        // style: mainbuttontextstyle("Roboto_Condensed", 16.0),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "OR",
                    style: TextStyle(
                        fontFamily: "Roboto_Condensed",
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.blue.shade900),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: InkWell(
                        onTap: (() async {
                          FirebaseAuthen _auth = new FirebaseAuthen();
                          await _auth.signInWithGoogle(context);
                        }),
                        child: Container(
                          height: 50,
                          width: 500,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Center(
                            child: Text(
                              "Log in with Google",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  // TextButton(
                  //     onPressed: () {},
                  //     child: InkWell(
                  //       onTap: (() {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: ((context) => const LoginPage())));
                  //       }),
                  //       child: Container(
                  //         height: 50,
                  //         width: 500,
                  //         decoration: BoxDecoration(
                  //           color: Colors.blue.shade900,
                  //           borderRadius:
                  //               const BorderRadius.all(Radius.circular(8.0)),
                  //         ),
                  //         child: Center(
                  //           child: Text(
                  //             "Log in with Facebook",
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 18,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     )),
                  Text(
                    "New Member ?",
                    style: TextStyle(
                        fontFamily: "Roboto_Condensed",
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.blue.shade900),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const SignupPage())));
                        },
                        child: Container(
                          height: 50,
                          width: 500,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue.shade900,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Center(
                            child: const Text(
                              "Signup",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),

                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
final _authent = FirebaseAuth.instance;
class FirebaseAuthen {
  late final GoogleSignInAccount? googleSignInAccount;
  final _googleSignIn = GoogleSignIn();

  registerUser(
      String userid, String userMail, String photoUrl, String name) async {
    final _fireStore = FirebaseFirestore.instance;
    print('$userMail $userid $photoUrl $name');
    await _fireStore
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'fullName': name,
      'email': userMail,
      'UID': userid,
      'language':"",
      'hospital':"",
      'Experience':"",
      'profilePic':"",

    });
    print('uploaded-=-=-=-=-=-=-=-');
  }

  registerFBUser(String userid, String userMail, String photoUrl, String name,
      String dob, String gender) async {
    final _fireStore = FirebaseFirestore.instance;
  }

  signInWithGoogle(BuildContext context) async {
    try {
      googleSignInAccount =
      await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await _authent.signInWithCredential(authCredential);
        String userid = _authent.currentUser!.uid;
        String userMail = googleSignInAccount!.email;
        String userPhoto = googleSignInAccount!.photoUrl ?? '';
        String userName = googleSignInAccount!.displayName ?? '';

        FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then(((value) {
          if (!(value.exists)) {
            registerUser(userid, userMail, userPhoto, userName);

          }
        }));
        DocumentReference users =  FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('Notifications')
            .doc();
        users.set({

          'NotifiID':users.id,
          'mgs':'Your account is logged in ',
          'Date&Time':DateTime.now(),
          'User': FirebaseAuth.instance.currentUser!.uid,

        });
        // String token = "";
        // DocumentSnapshot data = await FirebaseFirestore.instance
        //     .collection('Users')
        //     .doc(FirebaseAuth.instance.currentUser!.uid)
        //     .get();
        //
        // token = data['token'];
        // sendPushMessage(
        //     'Account Login',
        //     'Your Account is logged In',
        //     token
        // );

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => HomeScreen())));
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      throw e;
    }
  }
}