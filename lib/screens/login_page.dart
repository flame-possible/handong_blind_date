import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/screens/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:final_project/providers/naviProvider.dart';

import 'navigator.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart' as sb;


String? user_data = "";
late User? user_;

var uid;
String? nickname;

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  late NaviProvider _naviProvider;

  String userInfo = "";
  static final storage =
  new FlutterSecureStorage();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _IDController = TextEditingController();
  final TextEditingController _PWController = TextEditingController();

  // String? user_data = "";
  // late User? user;

  @override
  void initState() {
    super.initState();

    //비동기로 flutter secure storage 정보를 불러오는 작업.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  Future<String> loadAppId() async {
    return await rootBundle.loadString('assets/sendbird-id.txt');
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    userInfo = (await storage.read(key: "login"))!;
    print(userInfo);

    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (userInfo != null) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          // 파라미터 todo로 tap된 index의 아이템을 전달
          builder: (context) => Navi(),
        ),
      );
    }
  }

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
    user_ = userCredential.user;

    String? user_id = user_?.uid;
    String? useremail = user_?.email;

    final userCollectionReference = FirebaseFirestore.instance.collection("User_Data").doc(user_?.uid);

    int? existDoc = await findUserByUid(user_id!) as int?;

    print("123");
    print(existDoc);
    print("456");

    await storage.write(
        key: "login",
        value: "id " +
            useremail!);


    if(existDoc == 0){

      Route route = MaterialPageRoute(builder: (context) => SignUpPage());
      connect(user_id).then((user) {
        Navigator.pushReplacement(context, route);
      }).catchError((error) {
        print('login_view: _signInButton: ERROR: $error');
      });
    }
    else{
      Route route = MaterialPageRoute(builder: (context) => Navi());
      connect(user_id).then((user) {
        Navigator.pushReplacement(context, route);
        }).catchError((error) {
          print('login_view: _signInButton: ERROR: $error');
      });
      // Navigator.pop(context);
      // Navigator.Replace(
      //   context,
      //   MaterialPageRoute(
      //     // 파라미터 todo로 tap된 index의 아이템을 전달
      //     builder: (context) => Navi(),
      //   ),
      // );
    // connect(user_id).then((user) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       // 파라미터 todo로 tap된 index의 아이템을 전달
    //       builder: (context) => Navi(),
    //     ),
    //   );
    // }).catchError((error) {
    //   print('login_view: _signInButton: ERROR: $error');
    // });

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
          SizedBox(height: (MediaQuery.of(context).size.height) * 0.05,),
          Image(image: AssetImage("assets/LookForSignIn.png")),
          SizedBox(height: (MediaQuery.of(context).size.height) * 0.05,),
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


  Future<sb.User> connect(String userId) async {
    // Init Sendbird SDK and connect with current user id
    try {
      final sendbird =
      sb.SendbirdSdk(appId: await loadAppId());
      final user = await sendbird.connect(userId);
      return user;
    } catch (e) {
      print('login_view: connect: ERROR: $e');
      rethrow;
    }
  }

}
