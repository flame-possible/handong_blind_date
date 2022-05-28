import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';

class MatchingProvider with ChangeNotifier{
  final List<String> _lottieAssets = [
    "assets/alert_lottie/1.json",
    "assets/alert_lottie/2.json",
    "assets/alert_lottie/3.json",
    "assets/alert_lottie/4.json",
    "assets/alert_lottie/5.json",
    "assets/alert_lottie/6.json",
    "assets/alert_lottie/7.json",
    "assets/alert_lottie/8.json",
    "assets/alert_lottie/9.json",
    "assets/alert_lottie/10.json",
    "assets/alert_lottie/11.json",
    "assets/alert_lottie/12.json",
    "assets/alert_lottie/13.json",
  ];
  late String _lottieAsset;
  String get lottieAsset => _lottieAsset;

  MatchingProvider(){
    int rand = Random().nextInt(12)+1;
    _lottieAsset = _lottieAssets[rand];
  }

  void matchingResult(int index, SwipeDirection direction,String partners_uid, List<String> Likeusers, List<String> Dislikeusers){

    if(direction == SwipeDirection.right) {

      Likeusers.add(partners_uid);

      print("$index 번째 상대 매칭 결과: 좋아요");
    }else if(direction == SwipeDirection.left) {
      Dislikeusers.add(partners_uid);
      print("$index 번째 상대 매칭 결과: 관심없어요");
    }

  }

}