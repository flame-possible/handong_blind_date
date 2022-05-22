import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:final_project/providers/bottombar_provider.dart';
import 'login_page.dart';
import 'matching_page.dart';


class Setting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("설정"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          )
        ],
      ),
      body: ListView(
        children: [

          SizedBox(height: 34),
          SizedBox(
            height: 44,
            width: (MediaQuery.of(context).size.width) * 0.9,
            child: ElevatedButton(
              child: Text('나의 정보'),
              onPressed: () {

              },
            ),
          ),

          SizedBox(height: 34),
          SizedBox(
            height: 44,
            width: (MediaQuery.of(context).size.width) * 0.9,
            child: ElevatedButton(
              child: Text('나의 선호도'),
              onPressed: () {

              },
            ),
          ),

          SizedBox(height: 150),
          SizedBox(
            height: 44,
            width: (MediaQuery.of(context).size.width) * 0.9,
            child: ElevatedButton(
              child: Text('로그아웃'),
              onPressed: () {
                LoginPageState.storage.delete(key: "login");
                signOut();
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
                        (route) => false);

              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signOut() async {
    await Firebase.initializeApp();

    try {

      GoogleSignIn _googleSignIn = GoogleSignIn();
      await _googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      print("Success");
    } catch (e) {
      print(e.toString());
    }
  }
}

