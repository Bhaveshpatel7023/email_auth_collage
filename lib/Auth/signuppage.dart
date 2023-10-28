import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_authentication/Auth/loginpage.dart';
import 'package:email_authentication/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var passwordVisible = true;
  final _signupKey = GlobalKey<FormState>(debugLabel: '_signupkey');
  registerUser() async {
    final _fireStore = FirebaseFirestore.instance;
    await _fireStore
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'age': ageController.text,
      'profilePic': "",
      "hospital": "",
      'fullName': firstNameController.text + " " + lastNameController.text,
      'email': emailController.text,
      'UID': FirebaseAuth.instance.currentUser!.uid,
      'password': passwordController.text,
    });
  }

  // var passwordVisible = true;
  // final _signupKey = GlobalKey<FormState>(debugLabel: '_signupkey');
  // Future signup() async {
  //   Map signupdata = {
  //     'firstname': firstNameController.text,
  //     'lastname': lastNameController.text,
  //     'age': ageController.text,
  //     'mobilenumber': emailController.text,
  //     // 'password': passwordController.text
  //   };

  //   try {
  //     Response response = await http.post(
  //         Uri.parse('https://noobro.000webhostapp.com/signup.php'),
  //         body: signupdata);

  //     var decodesignupdata = await json.decode(json.encode(response.body));
  //     if (response.statusCode == 200) {
  //       Fluttertoast.showToast(
  //           msg: "Signup Successfull",
  //           toastLength: Toast.LENGTH_SHORT,
  //           backgroundColor: const Color.fromARGB(255, 139, 25, 210),
  //           textColor: Colors.white,
  //           fontSize: 18,
  //           gravity: ToastGravity.BOTTOM);

  //       print(decodesignupdata);
  //     } else {
  //       print("Error");
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(
  //         msg: e.toString(),
  //         toastLength: Toast.LENGTH_SHORT,
  //         backgroundColor: const Color.fromARGB(255, 139, 25, 210),
  //         textColor: Colors.white,
  //         fontSize: 18,
  //         gravity: ToastGravity.BOTTOM);
  //     print(e.toString());
  //   }
  // }

  showSnackBar(BuildContext context, String str, [Color clr = Colors.black]) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(str),
      backgroundColor: clr,
    ));
  }

  String email = "";

  String password = "";

  bool isButtonActive = true;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    firstNameController.addListener(() {
      final isButtonActive = firstNameController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
    lastNameController = TextEditingController();
    lastNameController.addListener(() {
      final isButtonActive = lastNameController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
    ageController = TextEditingController();
    ageController.addListener(() {
      final isButtonActive = ageController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
    emailController = TextEditingController();
    emailController.addListener(() {
      final isButtonActive = emailController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
    passwordController = TextEditingController();
    passwordController.addListener(() {
      final isButtonActive = passwordController.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signupKey,
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
                    child: Image.asset(
                      'assets/images/medical.png',
                      height: 200,
                      width: 250,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Signup',
                    style: TextStyle(
                        fontFamily: "Roboto_Condensed",
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 20),

                  // ----------- First name ----------------
                  SizedBox(
                    height: 60,
                    width: 500,
                    child: TextFormField(
                      controller: firstNameController,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        }
                        return "Value Cannot be Empty";
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter your First Name',
                      ),
                    ),
                  ),

                  // ----------- Last name ----------------
                  SizedBox(
                    height: 60,
                    width: 500,
                    child: TextFormField(
                      controller: lastNameController,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        }
                        return "Value Cannot be Empty";
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter your Last Name',
                      ),
                    ),
                  ),

                  //  Age is removed from the page
                  // ----------- Age ----------------

                  // SizedBox(
                  //   height: 60,
                  //   width: 500,
                  //   child: TextFormField(
                  //     controller: ageController,
                  //     validator: (value) {
                  //       if (value!.isNotEmpty) {
                  //         return null;
                  //       }
                  //       return "Value Cannot be Empty";
                  //     },
                  //     maxLength: 3,
                  //     keyboardType: TextInputType.number,
                  //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  //     decoration: const InputDecoration(
                  //       hintText: 'Enter your Age',
                  //     ),
                  //   ),
                  // ),

                  // ----------- Email ----------------

                  SizedBox(
                    height: 60,
                    width: 500,
                    child: TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      controller: emailController,
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
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        }
                        return "Value Cannot be Empty";
                      },
                      // Bhavslasdfjlsadf
                      //sadlfkjsadl;f j
                      //laskjdfl;asj h 
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

                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () async {
                      try {
                        UserCredential credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        registerUser();
                        showSnackBar(context, "Signed Up",
                            Color.fromARGB(255, 139, 25, 210));
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
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(
                              context,
                              "The account already exists for that email.",
                              Color.fromARGB(255, 139, 25, 210));
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 500,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: const Center(
                          child: Text(
                        "Signup",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  const Text(
                    "OR",
                    style: TextStyle(
                        fontFamily: "Roboto_Condensed",
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color.fromARGB(255, 10, 52, 87)),
                  ),
                  const SizedBox(
                    height: 5,
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
                              "Sign up with Google",
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
                  //         // Navigator.push(
                  //         //     context,
                  //         //     MaterialPageRoute(
                  //         //         builder: ((context) => const LoginPage())));
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
                  //             "Sign up with Facebook",
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
                    "Already a member? ",
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
                                  builder: ((context) => const LoginPage())));
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
                              "Log In",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      )),
                  // addVerticalSpace(20),
                  // InkWell(
                  //     onTap: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => GoogleLens()));
                  //     },
                  //     child: Text(
                  //       'Bhavesh',
                  //       style: TextStyle(fontSize: 15),
                  //     )),
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

// class GoogleLensScreen extends StatefulWidget {
//   @override
//   _GoogleLensScreenState createState() => _GoogleLensScreenState();
// }
//
// class _GoogleLensScreenState extends State<GoogleLensScreen> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> _captureImage() async {
//     final image = await _picker.getImage(source: ImageSource.camera);
//     if (image != null) {
//       setState(() {
//         _image = File(image.path);
//       });
//
//       final visionImage = FirebaseVisionImage.fromFile(_image!);
//       final textRecognizer = FirebaseVision.instance.textRecognizer();
//       final visionText = await textRecognizer.processImage(visionImage);
//
//       for (final block in visionText.blocks) {
//         for (final line in block.lines) {
//           for (final element in line.elements) {
//             print(element.text);
//           }
//         }
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Lens'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (_image != null) Image.file(_image!, height: 200),
//             ElevatedButton(
//               onPressed: _captureImage,
//               child: Text('Capture Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

