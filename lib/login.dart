import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart' as sb;

class Login extends StatelessWidget {
  var uid;
  String? nickname;

  Future<String> loadAppId() async {
    return await rootBundle.loadString('assets/sendbird-id.txt');
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

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
        title: const Text("SNS Login"),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () async {
              var credential = signInWithGoogle();
              uid = await credential.then((value) => value.user?.uid);
              nickname = await credential.then((value) => value.user?.displayName);
              if (uid != null) {
                //Navigator.pushReplacementNamed(context, '/main');
              }
            },
            child: const Text("Google Login"),
          ),
          TextButton(
            onPressed: () async {
              await GoogleSignIn().disconnect();
              await FirebaseAuth.instance.signOut();
            },
            child: const Text("Google Sign out"),
          ),
          TextButton(
            onPressed: () {
              connect(uid).then((user) {
                Navigator.pushNamed(context, '/chat_list');
              }).catchError((error) {
                print('login_view: _signInButton: ERROR: $error');
              });
            },
            child: const Text("Continue to chatroom list page"),
          )
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

//   @override
//   void dispose() {
//     idTextController.dispose();
//     passwordTextController.dispose();
//     super.dispose();
//   }

// }

