
import 'package:final_project/login.dart';
import 'package:final_project/providers/bottombarProvider.dart';
import 'package:final_project/providers/infoProvider.dart';
import 'package:final_project/providers/matchingInfoProvider.dart';
import 'package:final_project/providers/naviProvider.dart';
import 'package:final_project/providers/profileProvider.dart';
import 'package:final_project/providers/profileInfoProvider.dart';
import 'package:final_project/screens/navigator.dart';
import 'package:final_project/screens/navigator/chatScreen/CreateChatPage.dart';
import 'package:final_project/screens/navigator/setting_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:final_project/screens/login_navi.dart';

import 'package:final_project/screens/login_page.dart';
import 'package:final_project/screens/signup_page.dart';

import 'screens/navigator/chatScreen/ChatListPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<InfoProvider>(create: (_) => InfoProvider()),
        ChangeNotifierProvider<NaviProvider>(create: (_) => NaviProvider()),
        ChangeNotifierProvider<BottomBarProvider>(create: (_) => BottomBarProvider()),
        ChangeNotifierProvider<ProfileInfoProvider>(create: (_) => ProfileInfoProvider()),
        ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider()),
        ChangeNotifierProvider<MatchingInfoProvider>(create: (_) => MatchingInfoProvider()),
      ],
      child: new MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
      ],
    );
    //안드로이드 버전에서 상단바 색을 투명하게 만들어줌. 아이폰의 경우 자동으로 투명함.
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/chat_list': (context) => ChatListPage(),
        '/create_chat': (context) => CreateChatPage(),
      },

      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xffff8383),
          elevation: 0,
          selectedIconTheme: IconThemeData(
            color: Colors.black,
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.white38,
          ),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          titleSpacing: 30, //앱바 타이틀 들여쓰기
          titleTextStyle: TextStyle(
            color: Color(0xffff8383),
            fontSize: 33,
            fontWeight: FontWeight.normal,
          ),
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xffff8383),
            onPrimary: const Color(0xffffffff),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            minimumSize: const Size(180, 52),
            textStyle: const TextStyle(
              fontSize: 13,
              color: Colors.blue,
              fontWeight: FontWeight.w900,
              height: 1.15,
            ),
          ),
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 3,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
      home: new LoginPage(),
    );
  }
}
