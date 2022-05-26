import 'dart:core';
import 'package:flutter/material.dart';
import 'package:multiple_select/multiple_select.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MatchingInfo {
  final int id;
  final String name;

  MatchingInfo({
    required this.id,
    required this.name,
  });
}

class MatchingInfoProvider with ChangeNotifier {
  final _multiSelectKey = GlobalKey<FormFieldState>();

  //나이 (다중)
  static List<MatchingInfo> _age = [
    MatchingInfo(id: 1, name: "상관없음"),
    MatchingInfo(id: 2, name: "연하"),
    MatchingInfo(id: 3, name: "연상"),
  ];
  List<MatchingInfo> get age => _age;

  final _ageItems =
      _age.map((age) => MultiSelectItem<MatchingInfo>(age, age.name)).toList();
  get ageItems => _ageItems;


  List<Object?> _selectedAge = [];
  List<Object?> get selectedAge => _selectedAge;


  void ageSelect(List<Object?> selected) {
    _selectedAge = selected;
    notifyListeners();
  }

  //MBTI (다중)
  static List<MatchingInfo> _mbti = [
    MatchingInfo(id: 1, name: "상관없음"),
    MatchingInfo(id: 2, name: "ENFP"),
    MatchingInfo(id: 3, name: "ESFP",),
    MatchingInfo(id: 4, name: "ENTP",),
    MatchingInfo(id: 5, name: "ENFJ",),
    MatchingInfo(id: 6, name: "ESTP",),
    MatchingInfo(id: 7, name: "ESFJ",),
    MatchingInfo(id: 8, name: "ENTJ",),
    MatchingInfo(id: 9, name: "ESTJ",),
    MatchingInfo(id: 10, name: "INFP",),
    MatchingInfo(id: 11, name: "ISFP",),
    MatchingInfo(id: 12, name: "INTP",),
    MatchingInfo(id: 13, name: "INFJ",),
    MatchingInfo(id: 14, name: "ISTP",),
    MatchingInfo(id: 15, name: "ISFJ",),
    MatchingInfo(id: 16, name: "INTJ",),
    MatchingInfo(id: 16, name: "ISTJ",)
  ];
  List<MatchingInfo> get mbti => _mbti;
  final _mbtiItems =
  _mbti.map((mbti) => MultiSelectItem<MatchingInfo>(mbti, mbti.name)).toList();

  List<Object?> _selectedMbti = _mbti;
  List<Object?> get selectedMbti => _selectedMbti;

  get mbtiItems => _mbtiItems;

  void mbtiSelect(List<Object?> selected) {
    _selectedMbti = selected;
    notifyListeners();
  }

  //키 (다중)
  static List<MatchingInfo> _height = [
    MatchingInfo(id: 1, name: "상관없음"),
    MatchingInfo(id: 2, name: "~150"),
    MatchingInfo(id: 3, name: "150~155"),
    MatchingInfo(id: 4, name: "156~160"),
    MatchingInfo(id: 5, name: "161~165"),
    MatchingInfo(id: 6, name: "166~170"),
    MatchingInfo(id: 7, name: "171~175"),
    MatchingInfo(id: 8, name: "176~180"),
    MatchingInfo(id: 9, name: "181~185"),
    MatchingInfo(id: 10, name: "186~"),

  ];
  List<MatchingInfo> get height => _height;

  final _heightItems =
  _height.map((height) => MultiSelectItem<MatchingInfo>(height, height.name)).toList();

  List<Object?> _selectedHeight = _height;
  List<Object?> get selectedHeight => _selectedHeight;

  get heightItems => _heightItems;

  void heightSelect(List<Object?> selected) {
    _selectedHeight = selected;
    notifyListeners();
  }

  //종교 (다중)
  static List<MatchingInfo> _religion = [
    MatchingInfo(id: 1, name: "상관없음"),
    MatchingInfo(id: 2, name: "개신교"),
    MatchingInfo(id: 3, name: "불교"),
    MatchingInfo(id: 4, name: "천주교"),
    MatchingInfo(id: 5, name: "그 외"),
    MatchingInfo(id: 6, name: "무교"),
  ];
  List<MatchingInfo> get religion => _religion;

  final _religionItems =
  _religion.map((religion) => MultiSelectItem<MatchingInfo>(religion, religion.name)).toList();

  List<Object?> _selectedReligion = _religion;
  List<Object?> get selectedReligion => _selectedReligion;

  get religionItems => _religionItems;

  void religionSelect(List<Object?> selected) {
    _selectedReligion = selected;
    notifyListeners();
  }

  //흡연
  static List<MatchingInfo> _smoke = [
    MatchingInfo(id: 1, name: "상관없음"),
    MatchingInfo(id: 2, name: "좋아함"),
    MatchingInfo(id: 3, name: "가끔 마심"),
    MatchingInfo(id: 4, name: "안마심"),
  ];
  List<MatchingInfo> get smoke => _smoke;

  final _smokeItems =
  _smoke.map((smoke) => MultiSelectItem<MatchingInfo>(smoke, smoke.name)).toList();

  List<Object?> _selectedSmoke = _smoke;
  List<Object?> get selectedSmoke => _selectedSmoke;

  get smokeItems => _smokeItems;

  void smokeSelect(List<Object?> selected) {
    _selectedSmoke = selected;
    notifyListeners();
  }

  //술(다중)
  static List<MatchingInfo> _drink = [
    MatchingInfo(id: 1, name: "상관없음"),
    MatchingInfo(id: 2, name: "좋아함"),
    MatchingInfo(id: 3, name: "가끔 마심"),
    MatchingInfo(id: 4, name: "안마심"),
  ];
  List<MatchingInfo> get drink => _drink;

  final _drinkItems =
  _drink.map((drink) => MultiSelectItem<MatchingInfo>(drink, drink.name)).toList();

  List<Object?> _selectedDrink = _drink;
  List<Object?> get selectedDrink => _selectedDrink;

  get drinkItems => _drinkItems;

  void drinkSelect(List<Object?> selected) {
    _selectedDrink = selected;
    notifyListeners();
  }

  //군필
  static List<MatchingInfo> _military = [
    MatchingInfo(id: 1, name: "상관없음"),
    MatchingInfo(id: 2, name: "미필"),
    MatchingInfo(id: 3, name: "군필(면제)"),
    MatchingInfo(id: 3, name: "해당없음"),
  ];
  List<MatchingInfo> get military => _military;

  final _militaryItems =
  _military.map((military) => MultiSelectItem<MatchingInfo>(military, military.name)).toList();

  List<Object?> _selectedMilitary = _military;
  List<Object?> get selectedMilitary => _selectedMilitary;

  get militaryItems => _militaryItems;

  void militarySelect(List<Object?> selected) {
    _selectedMilitary = selected;
    notifyListeners();
  }

  //전공(다중)
  static List<MatchingInfo> _major = [
    MatchingInfo(id: 1, name: "상관없음"),
    MatchingInfo(id: 2, name: "GLS"),
    MatchingInfo(id: 3, name: "국제어문",),
    MatchingInfo(id: 4, name: "경영경제",),
    MatchingInfo(id: 5, name: "기계제어",),
    MatchingInfo(id: 6, name: "법",),
    MatchingInfo(id: 7, name: "커뮤니케이션",),
    MatchingInfo(id: 8, name: "상담심리사회복지",),
    MatchingInfo(id: 9, name: "생명과학",),
    MatchingInfo(id: 10, name: "공간환경시스템",),
    MatchingInfo(id: 11, name: "전산전자",),
    MatchingInfo(id: 12, name: "콘텐츠융합디자인",),
    MatchingInfo(id: 13, name: "ICT창업",),
    MatchingInfo(id: 14, name: "언어교육원",),
    MatchingInfo(id: 15, name: "창의융합 교육원",),
    MatchingInfo(id: 16, name: "AI융합교육원",),
  ];
  List<MatchingInfo> get major => _major;

  final _majorItems =
  _major.map((major) => MultiSelectItem<MatchingInfo>(major, major.name)).toList();

  List<Object?> _selectedMajor = _major;
  List<Object?> get selectedMajor => _selectedMajor;

  get majorItems => _majorItems;

  void majorSelect(List<Object?> selected) {
    _selectedMajor = selected;
    notifyListeners();
  }

  //RC (다중)
  static List<MatchingInfo> _rc = [
    MatchingInfo(id: 1, name: "상관없음"),
    MatchingInfo(id: 2, name: "카이퍼"),
    MatchingInfo(id: 3, name: "열송"),
    MatchingInfo(id: 4, name: "장기려"),
    MatchingInfo(id: 5, name: "카아이클"),
    MatchingInfo(id: 6, name: "손양원"),
    MatchingInfo(id: 7, name: "토레이"),
  ];
  List<MatchingInfo> get rc => _rc;

  final _rcItems =
  _rc.map((rc) => MultiSelectItem<MatchingInfo>(rc, rc.name)).toList();

  List<Object?> _selectedRc = _rc;
  List<Object?> get selectedRc => _selectedRc;

  get rcItems => _rcItems;

  void rcSelect(List<Object?> selected) {
    _selectedRc = selected;
    notifyListeners();
  }

  //재학상태 (다중)
  static List<MatchingInfo> _undergraduate = [
    MatchingInfo(id: 1, name: "상관없음"),
    MatchingInfo(id: 2, name: "재학생"),
    MatchingInfo(id: 3, name: "휴학생"),
    MatchingInfo(id: 4, name: "졸업생"),
  ];
  List<MatchingInfo> get undergraduate => _undergraduate;

  final _undergraduateItems =
  _undergraduate.map((undergraduate) => MultiSelectItem<MatchingInfo>(undergraduate, undergraduate.name)).toList();

  List<Object?> _selectedUndergraduate = _undergraduate;
  List<Object?> get selectedUndergraduate => _selectedUndergraduate;

  get undergraduateItems => _undergraduateItems;

  void undergradateSelect(List<Object?> selected) {
    _selectedUndergraduate = selected;
    notifyListeners();
  }

  //장거리 연애 선호
  static List<MatchingInfo> _longD = [
    MatchingInfo(id: 1, name: "상관없음"),
    MatchingInfo(id: 2, name: "선호"),
    MatchingInfo(id: 3, name: "비선호"),
  ];
  List<MatchingInfo> get longD => _longD;

  final _longDItems =
  _longD.map((longD) => MultiSelectItem<MatchingInfo>(longD, longD.name)).toList();

  List<Object?> _selectedLongD = _longD;
  List<Object?> get selectedLongD => _selectedLongD;

  get longDItems => _longDItems;

  void longDSelect(List<Object?> selected) {
    _selectedLongD = selected;
    notifyListeners();
  }

}
