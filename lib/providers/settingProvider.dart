import 'dart:core';

import 'package:flutter/material.dart';

class SettingProvider with ChangeNotifier {
  //닉네임 **
  late String _nickname;

  //나이 **
  late String _age;
  final List<String> _ageList = ['19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35'];

  //성별 **
  late String _gender;
  final List<String> _genderList = ["남자", "여자"];

  //거주지역 **

  //사진 **
  late List<String> _imageFile;
  // 장거리 연애 가능 여부 **
  late String _longDate;


  final List<String> _longProfileDateList = ["가능해요", "힘들어요"];
  //MBTI
  late String _mbti;
  final List<String> _mbtiProfileList = ["ENFP", "ENFJ", "ENTP", "ENTJ", "ESFP", "ESFJ", "ESTP", "ESTJ", "INFP", "INFJ", "INTP", "INTJ", "ISFP", "ISFJ", "ISTP", "ISTJ"];

  //성격 **
  late String _character;

  //키 **
  late String _height;
  final List<String> _heightProfileList = ["~150", "150~155", "156~160", "161~165", "166~170", "171~175", "176~180", "181~185", "186~"];

  //종교 **
  late String _religion;
  final List<String> _religionProfileList = ["개신교", "불교", "천주교", "그 외", "없음"];

  //흡연여부
  late String _cigarette;
  final List<String> _cigaretteProfileList = ["예", "아니요", ""];

  //음주여부
  late String _drink;

  final List<String> _drinkProfileList = ["좋아해요", "가끔 마셔요", "안마셔요"];

  //재학상태 **
  late String _undergraduate;
  final List<String> _undergraduateProfileList = ["재학", "휴학", "졸업"];

  //군필여부 **
  late String _military;
  final List<String> _militarProfileList = ["미필", "군필(면제)"];

  //학부
  late String _faculty;
  final List<String> _facultyProfileList = ["GLS", "국제어문", "경영경제", "기계제어", "법", "커뮤니케이션", "상담심리사회복지", "생명과학", "공간환경시스템", "전산전자", "콘텐츠융합디자인", "ICT창업", "언어교육원", "창의융합교육원", "AI융합교육원", ""];

  //RC
  late String _rc;
  final List<String> _rcProfileList = ["카이퍼", "열송", "장기려", "카마이클", "손양원", "토레이", ""];

  //취미
  late String _hobby;

  //공동체
  late String _group;

  //사랑의 언어
  late String _loveLang;
  final List<String> _loveLangProfilList = ["인정하는 말", "함께하는 시간", "선물", "봉사", "스킨십", ""];

  //그 외
    // 결혼관
    // 연애관

  SettingProvider(){
    //TODO 파이어베이스의 값을 받아서 초기화 시키기.
    _age = "20" ;
    _gender = "남자" ;
    _imageFile = ["", "", ""];
    _longDate = "가능해요" ;
    _mbti = "ENFP";
    _character = "";
    _height = "176~180";
    _religion = "개신교";
    _cigarette = "";
    _drink = "";
    _undergraduate = "재학";
    _military = "미필";
    _faculty = "";
    _rc = "";
    _hobby = "";
    _group = "";
    _loveLang = "";
  }

  //Getter section
  String get nickname => _nickname;

  String get age => _age;

  List<String> get ageList => _ageList;

  String get gender => _gender;

  List<String> get genderList => _genderList;

  List<String> get imageFile => _imageFile;

  String get longDate => _longDate;

  List<String> get longProfileDateList => _longProfileDateList;

  String get mbti => _mbti;

  List<String> get mbtiProfileList => _mbtiProfileList;

  String get character => _character;

  String get height => _height;

  List<String> get heightProfileList => _heightProfileList;

  String get religion => _religion;

  List<String> get religionProfileList => _religionProfileList;

  String get cigarette => _cigarette;

  List<String> get cigaretteProfileList => _cigaretteProfileList;

  String get drink => _drink;

  List<String> get drinkProfileList => _drinkProfileList;

  String get undergraduate => _undergraduate;

  List<String> get undergraduateProfileList => _undergraduateProfileList;

  String get military => _military;

  List<String> get militarProfileList => _militarProfileList;

  String get faculty => _faculty;

  List<String> get facultyProfileList => _facultyProfileList;

  String get rc => _rc;

  List<String> get rcProfileList => _rcProfileList;

  String get hobby => _hobby;

  String get group => _group;

  String get loveLang => _loveLang;

  List<String> get loveLangProfilList => _loveLangProfilList;

  //Setter section

  void nicknameSet (String value) {
    _nickname = value;
  }

  void ageSet(String value) {
    _age = value;
    print(age);
    notifyListeners();
  }

  void genderSet(String value) {
    _gender = value;
    notifyListeners();
  }

  void imageFileSet(List<String> value) {
    _imageFile = value;
    notifyListeners();
  }

  void longDateSet(String value) {
    _longDate = value;
    notifyListeners();
  }

  void mbtiSet(String value) {
    _mbti = value;
    notifyListeners();
  }

  void characterSet(String value) {
    _character = value;
    notifyListeners();
  }

  void heightSet(String value) {
    _height = value;
    notifyListeners();
  }

  void religionSet(String value) {
    _religion = value;
    notifyListeners();
  }


  void cigaretteSet(String value) {
    _cigarette = value;
    notifyListeners();
  }


  void drinkSet(String value) {
    _drink = value;
    notifyListeners();
  }

  void undergraduateSet(String value) {
    _undergraduate = value;
    notifyListeners();
  }


  void militarySet(String value) {
    _military = value;
    notifyListeners();
  }

  void facultySet(String value) {
    _faculty = value;
    notifyListeners();
  }

  void rcSet(String value) {
    _rc = value;
    notifyListeners();
  }

  void hobbySet(String value) {
    _hobby = value;
    notifyListeners();
  }

  void groupSet(String value) {
    _group = value;
    notifyListeners();
  }

  void loveLangSet(String value) {
    _loveLang = value;
    notifyListeners();
  }

}