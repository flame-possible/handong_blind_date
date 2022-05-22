import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:final_project/providers/naviProvider.dart';


String? user_data = "";
late User? user;

class LoginPage extends StatelessWidget {
  late NaviProvider _naviProvider;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _IDController = TextEditingController();
  final TextEditingController _PWController = TextEditingController();

  // String? user_data = "";
  // late User? user;

  Future<int?> findUserByUid(String uid) async {
    // users collection에 있는 모든 user들을 users에 담음.
    CollectionReference users = FirebaseFirestore.instance.collection("User_Data");
    // users collection에서 현재 firebaseUser.uid인 user만 가져와서 이를 data에 옮김
    QuerySnapshot data = await users.where('Uid', isEqualTo: uid).get();
    // 여기서 data.size가 0이면 결국 같은 uid를 가진 user가 없다는 뜻.
    if (data.size == 0) {
      return 0;
    }
    else {
      return 1;
    }
  }

  Future<String?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    UserCredential userCredential;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    user = userCredential.user;

    String? user_id = user?.uid;

    final userCollectionReference = FirebaseFirestore.instance.collection("User_Data").doc(user?.uid);

    int? existDoc = await findUserByUid(user_id!) as int?;

    print("123");
    print(existDoc);
    print("456");

    if(existDoc == 0){
      _naviProvider.selectIndex(1);
    }
    else{
      _naviProvider.selectIndex(3);
    }


    // if()
    //_naviProvider.selectIndex(1);


    // if(useremail != null && useremail.contains('handong.ac.kr')){
    //   print(useremail);

    // }
    // else{
    //   GoogleSignIn _googleSignIn = GoogleSignIn();
    //   await _googleSignIn.disconnect();
    //   await FirebaseAuth.instance.signOut();
    //   print('fail to login');
    //   scaffoldKey.currentState?.showSnackBar(SnackBar(
    //     content: Text('Please sign in handong email'),
    //   ));
    // }

    return user_id;
  }

  @override
  Widget build(BuildContext context) {
    _naviProvider = Provider.of<NaviProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[
          SizedBox(height: (MediaQuery.of(context).size.height) * 0.25,),
          SizedBox(
            height: 44,
            width: (MediaQuery.of(context).size.width) * 0.9,
            child: ElevatedButton(
              child: Text('Sign In With Google'),
              onPressed: () {

                signInWithGoogle();
              },
            ),
          ),
          // SizedBox(height: 50),
          // Row(
          //   children: <Widget>[
          //     SizedBox(
          //       width: (MediaQuery.of(context).size.width) * 0.3,
          //     ),
          //     Text('혹시 회원이 아니신가요?',
          //         style: TextStyle(
          //           fontSize: 13.0,
          //         )),
          //   ],
          // ),
          //
          // SizedBox(height: 20),
          // Row(
          //   children: <Widget> [
          //     SizedBox(width: (MediaQuery.of(context).size.width) * 0.3,),
          //     SizedBox(
          //       width: (MediaQuery.of(context).size.width) * 0.35,
          //       child: ElevatedButton.icon(
          //
          //         onPressed: () {
          //           _naviProvider.selectIndex(1);
          //         },
          //         label: Text('회원가입 '),
          //         icon: Icon(Icons.favorite),
          //         // Image.asset('image/google.png',width:10, height:10),
          //       ),
          //
          //     )
          //   ],
          // ),
          //
          // SizedBox(height: 10)
        ],
      ),
    );
  }


}
