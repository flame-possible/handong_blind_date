import 'dart:core';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MatchingInfoForm {
  final int id;
  final String name;

  MatchingInfoForm({
    required this.id,
    required this.name,
  });
}



/** TODO "내 매칭 정보" 페이지
 * @ 저장 버튼을 누를 경우 Toast나 배너로 "정보가 업데이트 되었습니다!" 뜰 수 있도록 해주세요
 *
 * @ 파이어베이스에 저장된 정보가 있을 경우 경우, 그 값들이 초기값으로 보여지도록 해주세요
 *
 * @ "상관 없음"을 누를 경우 다른 다른 선택들이 전부 사라지도록 해주세요
 */

class MatchingInfoProvider with ChangeNotifier {
  final _multiSelectKey = GlobalKey<FormFieldState>();

  //나이 (다중)
  static List<MatchingInfoForm> _age = [
    MatchingInfoForm(id: 1, name: "상관없음"),
    MatchingInfoForm(id: 2, name: "연하"),
    MatchingInfoForm(id: 3, name: "동갑"),
    MatchingInfoForm(id: 4, name: "연상"),
  ];
  List<MatchingInfoForm> get age => _age;

  final _ageItems =
      _age.map((age) => MultiSelectItem<MatchingInfoForm>(age, age.name)).toList();
  get ageItems => _ageItems;

  List<Object?> _selectedAge = [];
  List<String> _selectedAgeStr = [];
  List<Object?> get selectedAge => _selectedAge;
  List<String> get selectedAgeStr => _selectedAgeStr;

  void ageSelect(List<Object?> selected) {
    _selectedAge = selected;
    _selectedAgeStr.clear();
    _selectedAge.forEach((element) {
      _selectedAgeStr.add((element as MatchingInfoForm).name);
    });
    notifyListeners();
  }

  //MBTI (다중)
  static List<MatchingInfoForm> _mbti = [
    MatchingInfoForm(id: 1, name: "상관없음"),
    MatchingInfoForm(id: 2, name: "ENFP"),
    MatchingInfoForm(
      id: 3,
      name: "ESFP",
    ),
    MatchingInfoForm(
      id: 4,
      name: "ENTP",
    ),
    MatchingInfoForm(
      id: 5,
      name: "ENFJ",
    ),
    MatchingInfoForm(
      id: 6,
      name: "ESTP",
    ),
    MatchingInfoForm(
      id: 7,
      name: "ESFJ",
    ),
    MatchingInfoForm(
      id: 8,
      name: "ENTJ",
    ),
    MatchingInfoForm(
      id: 9,
      name: "ESTJ",
    ),
    MatchingInfoForm(
      id: 10,
      name: "INFP",
    ),
    MatchingInfoForm(
      id: 11,
      name: "ISFP",
    ),
    MatchingInfoForm(
      id: 12,
      name: "INTP",
    ),
    MatchingInfoForm(
      id: 13,
      name: "INFJ",
    ),
    MatchingInfoForm(
      id: 14,
      name: "ISTP",
    ),
    MatchingInfoForm(
      id: 15,
      name: "ISFJ",
    ),
    MatchingInfoForm(
      id: 16,
      name: "INTJ",
    ),
    MatchingInfoForm(
      id: 16,
      name: "ISTJ",
    )
  ];
  List<MatchingInfoForm> get mbti => _mbti;
  final _mbtiItems = _mbti
      .map((mbti) => MultiSelectItem<MatchingInfoForm>(mbti, mbti.name))
      .toList();

  List<Object?> _selectedMbti = _mbti;
  List<String> _selectedMbtiStr = [];
  List<Object?> get selectedMbti => _selectedMbti;
  List<String> get selectedMbtiStr => _selectedMbtiStr;

  get mbtiItems => _mbtiItems;

  void mbtiSelect(List<Object?> selected) {
    _selectedMbti = selected;
    _selectedMbtiStr.clear();
    _selectedMbti.forEach((element) {
      _selectedMbtiStr.add((element as MatchingInfoForm).name);
    });
    notifyListeners();
  }

  //키 (다중)
  static List<MatchingInfoForm> _height = [
    MatchingInfoForm(id: 1, name: "상관없음"),
    MatchingInfoForm(id: 2, name: "~150"),
    MatchingInfoForm(id: 3, name: "150~155"),
    MatchingInfoForm(id: 4, name: "156~160"),
    MatchingInfoForm(id: 5, name: "161~165"),
    MatchingInfoForm(id: 6, name: "166~170"),
    MatchingInfoForm(id: 7, name: "171~175"),
    MatchingInfoForm(id: 8, name: "176~180"),
    MatchingInfoForm(id: 9, name: "181~185"),
    MatchingInfoForm(id: 10, name: "186~"),
  ];
  List<MatchingInfoForm> get height => _height;

  final _heightItems = _height
      .map((height) => MultiSelectItem<MatchingInfoForm>(height, height.name))
      .toList();

  List<Object?> _selectedHeight = _height;
  List<String> _selectedHeightStr = [];
  List<Object?> get selectedHeight => _selectedHeight;
  List<String> get selectedHeightStr => _selectedHeightStr;

  get heightItems => _heightItems;

  void heightSelect(List<Object?> selected) {
    _selectedHeight = selected;
    _selectedHeightStr.clear();
    _selectedHeight.forEach((element) {
      _selectedHeightStr.add((element as MatchingInfoForm).name);
    });
    notifyListeners();
  }

  //종교 (다중)
  static List<MatchingInfoForm> _religion = [
    MatchingInfoForm(id: 1, name: "상관없음"),
    MatchingInfoForm(id: 2, name: "개신교"),
    MatchingInfoForm(id: 3, name: "불교"),
    MatchingInfoForm(id: 4, name: "천주교"),
    MatchingInfoForm(id: 5, name: "그 외"),
    MatchingInfoForm(id: 6, name: "무교"),
  ];
  List<MatchingInfoForm> get religion => _religion;

  final _religionItems = _religion
      .map((religion) => MultiSelectItem<MatchingInfoForm>(religion, religion.name))
      .toList();

  List<Object?> _selectedReligion = _religion;
  List<String> _selectedReligionStr = [];
  List<Object?> get selectedReligion => _selectedReligion;
  List<String> get selectedReligionStr => _selectedReligionStr;

  get religionItems => _religionItems;

  void religionSelect(List<Object?> selected) {
    _selectedReligion = selected;
    _selectedReligionStr.clear();
    _selectedReligion.forEach((element) {
      _selectedReligionStr.add((element as MatchingInfoForm).name);
    });
    notifyListeners();
  }

  //흡연
  static List<MatchingInfoForm> _smoke = [
    MatchingInfoForm(id: 1, name: "상관없음"),
    MatchingInfoForm(id: 2, name: "흡연"),
    MatchingInfoForm(id: 3, name: "비흡연"),
  ];
  List<MatchingInfoForm> get smoke => _smoke;

  final _smokeItems = _smoke
      .map((smoke) => MultiSelectItem<MatchingInfoForm>(smoke, smoke.name))
      .toList();

  List<Object?> _selectedSmoke = _smoke;
  List<String> _selectedSmokeStr = [];
  List<Object?> get selectedSmoke => _selectedSmoke;
  List<String> get selectedSmokeStr => _selectedSmokeStr;

  get smokeItems => _smokeItems;

  void smokeSelect(List<Object?> selected) {
    _selectedSmoke = selected;
    _selectedSmokeStr.clear();
    _selectedSmoke.forEach((element) {
      _selectedSmokeStr.add((element as MatchingInfoForm).name);
    });
    notifyListeners();
  }

  //술(다중)
  static List<MatchingInfoForm> _drink = [
    MatchingInfoForm(id: 1, name: "상관없음"),
    MatchingInfoForm(id: 2, name: "좋아함"),
    MatchingInfoForm(id: 3, name: "가끔 마심"),
    MatchingInfoForm(id: 4, name: "안마심"),
  ];
  List<MatchingInfoForm> get drink => _drink;

  final _drinkItems = _drink
      .map((drink) => MultiSelectItem<MatchingInfoForm>(drink, drink.name))
      .toList();

  List<Object?> _selectedDrink = _drink;
  List<String> _selectedDrinkStr = [];
  List<Object?> get selectedDrink => _selectedDrink;
  List<String> get selectedDrinkStr => _selectedDrinkStr;

  get drinkItems => _drinkItems;

  void drinkSelect(List<Object?> selected) {
    _selectedDrink = selected;
    _selectedDrinkStr.clear();
    _selectedDrink.forEach((element) {
      _selectedDrinkStr.add((element as MatchingInfoForm).name);
    });
    notifyListeners();
  }

  //군필
  static List<MatchingInfoForm> _military = [
    MatchingInfoForm(id: 1, name: "상관없음"),
    MatchingInfoForm(id: 2, name: "미필"),
    MatchingInfoForm(id: 3, name: "군필(면제)"),
    MatchingInfoForm(id: 3, name: "해당없음"),
  ];
  List<MatchingInfoForm> get military => _military;

  final _militaryItems = _military
      .map((military) => MultiSelectItem<MatchingInfoForm>(military, military.name))
      .toList();

  List<Object?> _selectedMilitary = _military;
  List<String> _selectedMilitaryStr = [];
  List<Object?> get selectedMilitary => _selectedMilitary;
  List<String> get selectedMilitaryStr => _selectedMilitaryStr;

  get militaryItems => _militaryItems;

  void militarySelect(List<Object?> selected) {
    _selectedMilitary = selected;
    _selectedMilitaryStr.clear();
    _selectedMilitary.forEach((element) {
      _selectedMilitaryStr.add((element as MatchingInfoForm).name);
    });
    notifyListeners();
  }

  //전공(다중)
  static List<MatchingInfoForm> _major = [
    MatchingInfoForm(id: 1, name: "상관없음"),
    MatchingInfoForm(id: 2, name: "GLS"),
    MatchingInfoForm(
      id: 3,
      name: "국제어문",
    ),
    MatchingInfoForm(
      id: 4,
      name: "경영경제",
    ),
    MatchingInfoForm(
      id: 5,
      name: "기계제어",
    ),
    MatchingInfoForm(
      id: 6,
      name: "법",
    ),
    MatchingInfoForm(
      id: 7,
      name: "커뮤니케이션",
    ),
    MatchingInfoForm(
      id: 8,
      name: "상담심리사회복지",
    ),
    MatchingInfoForm(
      id: 9,
      name: "생명과학",
    ),
    MatchingInfoForm(
      id: 10,
      name: "공간환경시스템",
    ),
    MatchingInfoForm(
      id: 11,
      name: "전산전자",
    ),
    MatchingInfoForm(
      id: 12,
      name: "콘텐츠융합디자인",
    ),
    MatchingInfoForm(
      id: 13,
      name: "ICT창업",
    ),
    MatchingInfoForm(
      id: 14,
      name: "언어교육원",
    ),
    MatchingInfoForm(
      id: 15,
      name: "창의융합 교육원",
    ),
    MatchingInfoForm(
      id: 16,
      name: "AI융합교육원",
    ),
  ];
  List<MatchingInfoForm> get major => _major;

  final _majorItems = _major
      .map((major) => MultiSelectItem<MatchingInfoForm>(major, major.name))
      .toList();

  List<Object?> _selectedMajor = _major;
  List<String> _selectedMajorStr = [];
  List<Object?> get selectedMajor => _selectedMajor;
  List<String> get selectedMajorStr => _selectedMajorStr;

  get majorItems => _majorItems;

  void majorSelect(List<Object?> selected) {
    _selectedMajor = selected;
    _selectedMajorStr.clear();
    _selectedMajor.forEach((element) {
      _selectedMajorStr.add((element as MatchingInfoForm).name);
    });
    notifyListeners();
  }

  //RC (다중)
  static List<MatchingInfoForm> _rc = [
    MatchingInfoForm(id: 1, name: "상관없음"),
    MatchingInfoForm(id: 2, name: "카이퍼"),
    MatchingInfoForm(id: 3, name: "열송"),
    MatchingInfoForm(id: 4, name: "장기려"),
    MatchingInfoForm(id: 5, name: "카아이클"),
    MatchingInfoForm(id: 6, name: "손양원"),
    MatchingInfoForm(id: 7, name: "토레이"),
  ];
  List<MatchingInfoForm> get rc => _rc;

  final _rcItems =
      _rc.map((rc) => MultiSelectItem<MatchingInfoForm>(rc, rc.name)).toList();

  List<Object?> _selectedRc = _rc;
  List<String> _selectedRcStr = [];
  List<Object?> get selectedRc => _selectedRc;
  List<String> get selectedRcStr => _selectedRcStr;

  get rcItems => _rcItems;

  void rcSelect(List<Object?> selected) {
    _selectedRc = selected;
    _selectedRcStr.clear();
    _selectedRc.forEach((element) {
      _selectedRcStr.add((element as MatchingInfoForm).name);
    });
    notifyListeners();
  }

  //재학상태 (다중)
  static List<MatchingInfoForm> _undergraduate = [
    MatchingInfoForm(id: 1, name: "상관없음"),
    MatchingInfoForm(id: 2, name: "재학생"),
    MatchingInfoForm(id: 3, name: "휴학생"),
    MatchingInfoForm(id: 4, name: "졸업생"),
  ];
  List<MatchingInfoForm> get undergraduate => _undergraduate;

  final _undergraduateItems = _undergraduate
      .map((undergraduate) =>
          MultiSelectItem<MatchingInfoForm>(undergraduate, undergraduate.name))
      .toList();

  List<Object?> _selectedUndergraduate = _undergraduate;
  List<String> _selectedUndergraduateStr = [];
  List<Object?> get selectedUndergraduate => _selectedUndergraduate;
  List<String> get selectedUndergraduateStr => _selectedUndergraduateStr;

  get undergraduateItems => _undergraduateItems;

  void undergradateSelect(List<Object?> selected) {
    _selectedUndergraduate = selected;

    _selectedUndergraduateStr.clear();
    _selectedUndergraduate.forEach((element) {
      _selectedUndergraduateStr.add((element as MatchingInfoForm).name);
    });

    print(_selectedUndergraduateStr);
    notifyListeners();
  }

  //장거리 연애 선호
  static List<MatchingInfoForm> _longD = [
    MatchingInfoForm(id: 1, name: "상관없음"),
    MatchingInfoForm(id: 2, name: "선호"),
    MatchingInfoForm(id: 3, name: "비선호"),
  ];
  List<MatchingInfoForm> get longD => _longD;

  final _longDItems = _longD
      .map((longD) => MultiSelectItem<MatchingInfoForm>(longD, longD.name))
      .toList();

  List<Object?> _selectedLongD = _longD;
  List<String> _selectedLongDStr = [];
  List<Object?> get selectedLongD => _selectedLongD;
  List<String> get selectedLongDStr => _selectedLongDStr;

  get longDItems => _longDItems;

  void longDSelect(List<Object?> selected) {
    _selectedLongD = selected;
    _selectedLongDStr.clear();
    _selectedLongD.forEach((element) {
      _selectedLongDStr.add((element as MatchingInfoForm).name);
    });
    notifyListeners();
  }
}
