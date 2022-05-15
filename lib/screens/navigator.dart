import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_page.dart';
import 'home_page.dart';
import 'matching_page.dart';
import 'notification_page.dart';
import 'package:final_project/providers/bottombar_provider.dart';

class Navi extends StatelessWidget {

  late BottomBarProvider _bottomBarProvider;

  @override
  Widget build(BuildContext context) {
    _bottomBarProvider = Provider.of<BottomBarProvider>(context);

    return Scaffold(
      body: _navigationBody(),
      bottomNavigationBar: _bottomNavigationBar(),

    );
  }

  Widget _navigationBody() {
    // switch를 통해 currentPage에 따라 네비게이션을 구동시킨다.
    switch (_bottomBarProvider.selectedIndex) {
      case 0:
        return NotiPage();

      case 1:
        return HomePage();

      case 2:
        return ChatPage();
    }
    return Container();
  }

  Widget _bottomNavigationBar(){
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _bottomBarProvider.selectedIndex,
      items: const [
        BottomNavigationBarItem(
          label: 'Notification',
          icon: Icon(Icons.notifications),
        ),
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home_rounded),
        ),
        BottomNavigationBarItem(
          label: 'Chat',
          icon: Icon(Icons.chat_rounded),
        ),
      ],
      onTap: (int index) => _bottomBarProvider.selectIndex(index),
    );
  }

}
