import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_authentication/Auth/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


String _userName = "";
void getData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var profile = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      _userName = profile.data()?['PataitImage'];


    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Home Screen',style: TextStyle(color: Colors.black),),
        actions: [
          InkWell(
            onTap: (){
              FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            },
            child: Icon(Icons.logout,color: Colors.red,)),
          SizedBox(width: 20,)
        ],
      ),

      body: Center(child: Text('Welcome $_userName')),
    );
  }
}