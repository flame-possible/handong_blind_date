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
  final List<String> _mbtiProfileList = ["", "ENFP", "ENFJ", "ENTP", "ENTJ", "ESFP", "ESFJ", "ESTP", "ESTJ", "INFP", "INFJ", "INTP", "INTJ", "ISFP", "ISFJ", "ISTP", "ISTJ"];

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
  final List<String> _cigaretteProfileList = ["", "예", "아니요"];

  //음주여부
  late String _drink;

  final List<String> _drinkProfileList = ["", "좋아해요", "가끔 마셔요", "안마셔요"];

  //재학상태 **
  late String _undergraduate;
  final List<String> _undergraduateProfileList = ["재학", "휴학", "졸업"];

  //군필여부 **
  late String _military;
  final List<String> _militarProfileList = ["미필", "군필(면제)", "해당 없음"];

  //학부
  late String _faculty;
  final List<String> _facultyProfileList = ["", "GLS", "국제어문", "경영경제", "기계제어", "법", "커뮤니케이션", "상담심리사회복지", "생명과학", "공간환경시스템", "전산전자", "콘텐츠융합디자인", "ICT창업", "언어교육원", "창의융합교육원", "AI융합교육원"];

  //RC
  late String _rc;
  final List<String> _rcProfileList = ["", "카이퍼", "열송", "장기려", "카마이클", "손양원", "토레이"];

  //취미
  late String _hobby;

  //공동체
  late String _group;

  //사랑의 언어
  late String _loveLang;
  final List<String> _loveLangProfilList = ["", "인정하는 말", "함께하는 시간", "선물", "봉사", "스킨십"];

  //그 외
    // 결혼관
    // 연애관

  late List<Function> _generalPropertyGetterList;

  late List<Function> _otherPropertyGetterList;

  final List<String> _generalPropertyList = [
    "닉네임",
    '나이',
    '성별',
    '장거리 연애',
    '종교',
    '키 (cm)',
    '학적',
    '군필 여부',
  ];

  final List<String> _otherPropertyList = [
    "MBTI",
    '사랑의 언어',
    '흡연 여부',
    '음주여부',
    '학부',
    'RC',
  ];

  SettingProvider(){
    //TODO 파이어베이스의 값을 받아서 초기화 시키기.
    _nickname = "기본닉네임";
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

    //home에서 내 프로필을 띄우기 위한 함수(Getter) 리스트
    _generalPropertyGetterList = [
      nickname,
      age,
      gender,
      longDate,
      religion,
      height,
      undergraduate,
      military,
    ];
    _otherPropertyGetterList = [
      mbti,
      loveLang,
      cigarette,
      drink,
      faculty,
      rc,
    ];
  }

  //Getter section
  String nickname() => _nickname;

  String age() => _age;

  List<String> ageList() => _ageList;

  String gender() => _gender;

  List<String> genderList() => _genderList;

  List<String> imageFile() => _imageFile;

  String longDate() => _longDate;

  List<String> longProfileDateList() => _longProfileDateList;

  String mbti() => _mbti;

  List<String> mbtiProfileList() => _mbtiProfileList;

  String character() => _character;

  String height() => _height;

  List<String> heightProfileList() => _heightProfileList;

  String religion() => _religion;

  List<String> religionProfileList() => _religionProfileList;

  String cigarette() => _cigarette;

  List<String> cigaretteProfileList() => _cigaretteProfileList;

  String drink() => _drink;

  List<String> drinkProfileList() => _drinkProfileList;

  String undergraduate() => _undergraduate;

  List<String> undergraduateProfileList() => _undergraduateProfileList;

  String military() => _military;

  List<String> militarProfileList() => _militarProfileList;

  String faculty() => _faculty;

  List<String> facultyProfileList() => _facultyProfileList;

  String rc() => _rc;

  List<String> rcProfileList() => _rcProfileList;

  String hobby() => _hobby;

  String group() => _group;

  String loveLang() => _loveLang;

  List<String> loveLangProfilList() => _loveLangProfilList;

  List<String> generalPropertyList() => _generalPropertyList;

  List<String> otherPropertyList() => _otherPropertyList;

  List<Function> generalPropertyGetterList() => _generalPropertyGetterList;

  List<Function> otherPropertyGetterList() => _otherPropertyGetterList;

  //Setter section

  void nicknameSet (String value) {
    _nickname = value;
    print(_nickname);
    notifyListeners();
  }

  void ageSet(String value) {
    _age = value;
    print(age);
    notifyListeners();
  }

  void genderSet(String value) {
    _gender = value;
    print(_gender);
    notifyListeners();
  }

  void imageFileSet(List<String> value) {
    _imageFile = value;
    print(_imageFile);
    notifyListeners();
  }

  void longDateSet(String value) {
    _longDate = value;
    print(_imageFile);
    notifyListeners();
  }

  void mbtiSet(String value) {
    _mbti = value;
    print(_mbti);
    notifyListeners();
  }

  void characterSet(String value) {
    _character = value;
    print(_character);
    notifyListeners();
  }

  void heightSet(String value) {
    _height = value;
    print(_height);
    notifyListeners();
  }

  void religionSet(String value) {
    _religion = value;
    print(_religion);
    notifyListeners();
  }


  void cigaretteSet(String value) {
    _cigarette = value;
    print(_cigarette);
    notifyListeners();
  }


  void drinkSet(String value) {
    _drink = value;
    print(_cigarette);
    notifyListeners();
  }

  void undergraduateSet(String value) {
    _undergraduate = value;
    print(_undergraduate);
    notifyListeners();
  }


  void militarySet(String value) {
    _military = value;
    print(_military);
    notifyListeners();
  }

  void facultySet(String value) {
    _faculty = value;
    print(_military);
    notifyListeners();
  }

  void rcSet(String value) {
    _rc = value;
    print(_rc);
    notifyListeners();
  }

  void hobbySet(String value) {
    _hobby = value;
    print(_hobby);
    notifyListeners();
  }

  void groupSet(String value) {
    _group = value;
    print(_group);
    notifyListeners();
  }

  void loveLangSet(String value) {
    _loveLang = value;
    print(_loveLang);
    notifyListeners();
  }

}