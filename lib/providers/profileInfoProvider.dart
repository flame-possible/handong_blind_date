import 'package:flutter/material.dart';
import 'dart:core';

class ProfileInfoProvider with ChangeNotifier {
  //닉네임 **
  late String _nickname;

  //나이 **
  late String _age;
  late List<String> _ageMatching;
  final List<String> _ageList = ['19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35'];
  final List<String> _ageMatchingList = ['연하', '동갑', '연상'];

  //성별 **
  late String _gender;
  final List<String> _genderList = ["남자", "여자"];

  //거주지역 **

  //사진 **
  late List<String> _imageFile;

  // 장거리 연애 가능 여부 **
  late String _longDate;
  late String _longDateMatching;
  final List<String> _longDateProfileList = ["가능해요", "힘들어요"];
  final List<String> _longdateMatchigList = ["가능한 상대만"];

  //MBTI
  late String _mbti;
  late List<String> _mbtiMacthing;
  final List<String> _mbtiProfileList = ["선택 안함", "ENFP", "ENFJ", "ENTP", "ENTJ", "ESFP", "ESFJ", "ESTP", "ESTJ", "INFP", "INFJ", "INTP", "INTJ", "ISFP", "ISFJ", "ISTP", "ISTJ"];
  final List<String> _mbtiMatchingList = ["ENFP", "ENFJ", "ENTP", "ENTJ", "ESFP", "ESFJ", "ESTP", "ESTJ", "INFP", "INFJ", "INTP", "INTJ", "ISFP", "ISFJ", "ISTP", "ISTJ"];

  //성격 **
  late String _character;

  //키 **
  late String _height;
  late List<String> _heightMatching;
  final List<String> _heightProfileList = ["~150", "150~155", "156~160", "161~165", "166~170", "171~175", "176~180", "181~185", "186~"];
  final List<String> _heightMatchingList = ["~150", "150~155", "156~160", "161~165", "166~170", "171~175", "176~180", "181~185", "186~"];

  //종교 **
  late String _religion;
  late List<String> _religionMatching;
  final List<String> _religionProfileList = ["개신교", "불교", "천주교", "그 외", "무교"];
  final List<String> _religionMatchingList = ["개신교", "불교", "천주교", "그 외", "무교"];
  //흡연여부
  late String _cigarette;
  late List<String> _cigaretteMatching;
  final List<String> _cigaretteProfileList = ["선택 안함", "흡연", "비흡연"];
  final List<String> _cigaretteMatchingList = ['흡연', '비흡연'];

  //음주여부
  late String _drink;
  late List<String> _drinkMatching;
  final List<String> _drinkProfileList = ["선택 안함", "좋아해요", "가끔 마셔요", "안마셔요"];
  final List<String> _drinkMatchingList = ["가끔 마셔요", "좋아해요", "안마셔요"];

  //학정상태 **
  late String _undergraduate;
  late List<String> _undergraduateMatching;
  final List<String> _undergraduateProfileList = ["재학", "휴학", "졸업"];
  final List<String> _undergraduateMatchingList = ["재학", "휴학", "졸업"];

  //군필여부 **
  late String _military;
  late String _militaryMatching;
  final List<String> _militarProfileList = ["미필", "군필(면제)", "해당 없음"];
  final List<String> _militaryMatchingList = ["군필인 상대만"]; //남자인경우 체크 해제하도록

  //학부
  late String _faculty;
  late List<String> _facultyMatching;
  final List<String> _facultyProfileList = ["선택 안함", "GLS", "국제어문", "경영경제", "기계제어", "법", "커뮤니케이션", "상담심리사회복지", "생명과학", "공간환경시스템", "전산전자", "콘텐츠융합디자인", "ICT창업", "언어교육원", "창의융합교육원", "AI융합교육원"];
  final List<String> _facultyMatchingList = ["GLS", "국제어문", "경영경제", "기계제어", "법", "커뮤니케이션", "상담심리사회복지", "생명과학", "공간환경시스템", "전산전자", "콘텐츠융합디자인", "ICT창업", "언어교육원", "창의융합교육원", "AI융합교육원"];

  //RC
  late String _rc;
  late List<String> _rcMatching;
  final List<String> _rcProfileList = ["선택 안함", "카이퍼", "열송", "장기려", "카마이클", "손양원", "토레이"];
  final List<String> _rcMatchingList = ["카이퍼", "열송", "장기려", "카마이클", "손양원", "토레이"];

  //취미
  late String _hobby;

  //공동체
  late String _group;

  //사랑의 언어
  late String _loveLang;
  final List<String> _loveLangProfilList = ["선택 안함", "인정하는 말", "함께하는 시간", "선물", "봉사", "스킨십"];

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

  ProfileInfoProvider(){
    //TODO 파이어베이스의 값을 받아서 초기화 시키기.
    // 내 정보 섹션
    _nickname = "기본닉네임";
    _age = "20" ;
    _gender = "남자" ;
    _imageFile = ["", "", ""];
    _longDate = "가능해요" ;
    _mbti = "ENFP";
    _character = "입력 안함";
    _height = "176~180";
    _religion = "개신교";
    _cigarette = "선택 안함";
    _drink = "선택 안함";
    _undergraduate = "재학";
    _military = "미필";
    _faculty = "선택 안함";
    _rc = "선택 안함";
    _hobby = "입력 안함";
    _group = "입력 안함";
    _loveLang = "선택 안함";

    // 매칭 정보 섹션
    _ageMatching = ['연하', '동갑', '연상'];
    _longDateMatching = "";
    _mbtiMacthing = ["ENFP", "ENFJ", "ENTP", "ENTJ", "ESFP", "ESFJ", "ESTP", "ESTJ", "INFP", "INFJ", "INTP", "INTJ", "ISFP", "ISFJ", "ISTP", "ISTJ"];
    _heightMatching = ["~150", "150~155", "156~160", "161~165", "166~170", "171~175", "176~180", "181~185", "186~"];
    _religionMatching = ["개신교", "불교", "천주교", "그 외", "무교"];
    _cigaretteMatching = ['흡연', '비흡연'];
    _drinkMatching = ["가끔 마셔요", "좋아해요", "안마셔요"];
    _undergraduateMatching  = ["재학", "휴학", "졸업"];
    _militaryMatching = ""; //남자인경우 체크 해제하도록
    _facultyMatching  = ["GLS", "국제어문", "경영경제", "기계제어", "법", "커뮤니케이션", "상담심리사회복지", "생명과학", "공간환경시스템", "전산전자", "콘텐츠융합디자인", "ICT창업", "언어교육원", "창의융합교육원", "AI융합교육원"];
    _rcMatching = ["카이퍼", "열송", "장기려", "카마이클", "손양원", "토레이"];

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

  List<String> longProfileDateList() => _longDateProfileList;

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

  /******** 홈 - 내프로필 섹션을 위한 변수 *********/
  bool _seeDetailProfile = false;
  int _displayedGeneralItemNum = 2;
  int _displayedOthersItemNum = 2;

  int get displayedGeneralItemNum =>  _displayedGeneralItemNum;
  int get displayedOthersItemNum =>  _displayedOthersItemNum;

  void seeDetailProfile() {
    _seeDetailProfile = !(_seeDetailProfile);

    if (_seeDetailProfile == false) {
      _displayedGeneralItemNum = 2;
      _displayedOthersItemNum = 2;
    } else {
      _displayedGeneralItemNum = _generalPropertyList.length -1; // 닉네임을 제하고 보여주므로
      _displayedOthersItemNum = _otherPropertyList.length;
    }
    notifyListeners();
  }

}