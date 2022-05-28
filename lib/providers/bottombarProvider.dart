import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/login_page.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart' as sb;

class BottomBarProvider with ChangeNotifier{
  int _selectedIndex = 1;
  int get selectedIndex => _selectedIndex;

  Future<String> loadAppId() async {
    return await rootBundle.loadString('assets/sendbird-id.txt');
  }
  Future<void> selectIndex(int index) async {

    _selectedIndex = index;

    print(selectedIndex);
    notifyListeners();
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