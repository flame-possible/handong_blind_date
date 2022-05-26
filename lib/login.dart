import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatelessWidget {

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SNS Login"),
      ),
      body: Column(
        children: [
          TextButton(
            child: Text("Google Login"),
            onPressed: signInWithGoogle,
          ),
        ],
      ),
    );
  }
}

//
// class LoginPage extends StatefulWidget {
//   LoginPage({Key? key}) : super(key: key);
//
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final idTextController = TextEditingController();
//   final passwordTextController = TextEditingController();
//
//   FocusNode idFocus = FocusNode();
//   FocusNode passwordFocus = FocusNode();
//
//
//   Future<UserCredential> signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//
//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );
//
//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("SNS Login"),
//       ),
//       body: Center(
//         child: ListView(
//           shrinkWrap: true,
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           children: <Widget>[
//             logo(),
//             id(),
//             password(),
//             SizedBox(height: 50),
//             button(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     idFocus.requestFocus();
//   }
//
//   Widget logo() => Container(
//     child: Image.asset(
//       'assets/logo.png',
//       width: 96,
//       height: 47,
//     ),
//   );
//
//   Widget id() => Container(
//     margin: EdgeInsets.only(top: 70),
//     height: 53,
//     child: TextField(
//       controller: idTextController,
//       onSubmitted: (_) {
//         passwordFocus.requestFocus();
//       },
//       focusNode: idFocus,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         labelText: '아이디',
//       ),
//     ),
//   );
//
//   Widget password() => Container(
//     margin: EdgeInsets.only(top: 15),
//     height: 53,
//     child: TextField(
//       controller: passwordTextController,
//       focusNode: passwordFocus,
//       obscureText: true,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         labelText: '비밀번호',
//       ),
//     ),
//   );
//
//   Widget button() => Container(
//     margin: EdgeInsets.only(top: 15),
//     height: 53,
//     child: ElevatedButton(
//       onPressed: signInWithGoogle,
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(
//           Color(0xFF2C75F5),
//         ),
//       ),
//       child: Text(
//         "로그인",
//         style: TextStyle(
//           fontSize: 14,
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ),
//   );
//
//   @override
//   void dispose() {
//     idTextController.dispose();
//     passwordTextController.dispose();
//     super.dispose();
//   }

// }

