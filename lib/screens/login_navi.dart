import 'package:final_project/providers/naviProvider.dart';
import 'package:final_project/screens/navigator.dart';
import 'package:final_project/screens/signup_certification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigator/home_page.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'package:final_project/home.dart';
import 'package:final_project/providers/naviProvider.dart';

class LoginNavi extends StatelessWidget {

  late NaviProvider _naviProvider;

  @override
  Widget build(BuildContext context) {
    _naviProvider = Provider.of<NaviProvider>(context);

    return Scaffold(
      body: _navigationBody(),

    );
  }

  Widget _navigationBody() {
    // switch를 통해 currentPage에 따라 네비게이션을 구동시킨다.
    switch (_naviProvider.selectedIndex) {
      case 0:
        return LoginPage();

      case 1:
        return SignUpPage();

      case 2:
        return SignUp_certification();

      case 3:
        return Navi();
    }
    return Container();
  }


}
