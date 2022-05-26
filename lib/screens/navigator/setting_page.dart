import 'package:final_project/screens/setting/matchingInfo.dart';
import 'package:final_project/screens/setting/myProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:final_project/providers/bottombarProvider.dart';
import '../login_page.dart';
import '../setting/notiSetting.dart';
import 'matching_page.dart';


class Setting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("설정"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),

          SizedBox(
            width: (MediaQuery.of(context).size.width) * 0.7,
            child: ElevatedButton(
              child: Text('내 프로필'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProfile()),
                );
              },
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * (4 / 100)),
          SizedBox(
            width: (MediaQuery.of(context).size.width) * 0.7,
            child: ElevatedButton(
              child: Text('내 매칭 정보'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchingInfo(),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * (4 / 100)),
          SizedBox(
            width: (MediaQuery.of(context).size.width) * 0.7,
            child: ElevatedButton(
              child: Text('알림 설정'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotiSetting()),
                );
              },
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * (35 / 100),),
          SizedBox(
            width: (MediaQuery.of(context).size.width) * 0.7,
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

