import 'dart:async';

import 'package:email_authentication/Auth/loginpage.dart';
import 'package:email_authentication/home/home_screen.dart';
import 'package:email_authentication/theam/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).height,
        child: 
            Text('WelCome Our App',style: TextStyle(color: Colors.pink,fontSize: 20),),
         
      ),
    );
  }
}

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).height,
        child: 
            Text('WelCome Our App',style: TextStyle(color: Colors.pink,fontSize: 20),),
         
      ),
    );
  }
}