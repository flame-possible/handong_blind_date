import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:final_project/providers/settingProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// TODO
/// image picker 사용하여 사진 받아오는 것 구현하기
///   (휴대폰에서 사진 선택 -> 플러터 내에서 imagefile 변수에 저장 -> 사용자가 저장 버튼 누를 시 firebaseStarage에 저장)
///   (firebase starage에서 image url 획득 -> 프로바이더에 초기화에 사용)
/// 내 프로필의 "서술형 또는 단답형 정보" 필요하다면 구현하기.
///   위젯은 구현되어 있으나, 우선순위는 아닌 것 같아 UI상 만들진 않았음
/// 저장 버튼을 누를 경우 firebase에 정보 저장하기 (이것은 settingProvider 프로바이더 상에서 구현할것)
/// 앱 최초 실행시 홈 화면에서 settingProvider를 사용하여 화면을 구성하는데
///   이때, 필수인 정보가 입력되지 않았다면 (settingProvider 내에 값이 null 인지 확인)
///   설정 페이지로 이동해 정보를 입력하도록 한다.

class MyProfile extends StatelessWidget {
  MyProfile({Key? key}) : super(key: key);

  late SettingProvider _settingProvider;

  @override
  Widget build(BuildContext context) {
    _settingProvider = Provider.of<SettingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("내 프로필"),
        actions: [
          IconButton(
            onPressed: () {
              print("저장되었습니다");
            },
            icon: const Icon(Icons.save),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * (5 / 100),
            MediaQuery.of(context).size.width * (5 / 100),
            MediaQuery.of(context).size.width * (5 / 100),
            MediaQuery.of(context).size.width * (5 / 100)),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * (2 / 100),
                  MediaQuery.of(context).size.width * (5 / 100),
                  MediaQuery.of(context).size.width * (2 / 100),
                  MediaQuery.of(context).size.width * (5 / 100)),
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              width: MediaQuery.of(context).size.width * (85 / 100),
              decoration: BoxDecoration(
                color: Color(0xffF8F8F8),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 4)),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle("사진"),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * (2 / 100),
                  MediaQuery.of(context).size.width * (5 / 100),
                  MediaQuery.of(context).size.width * (2 / 100),
                  MediaQuery.of(context).size.width * (5 / 100)),
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              width: MediaQuery.of(context).size.width * (85 / 100),
              decoration: BoxDecoration(
                color: Color(0xffF8F8F8),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 4)),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle("기본정보"),
                  shortCard("닉네임", "닉네임을 입력하세요",_settingProvider.nicknameSet),
                  selectCard("나이", 1, "나이를 선택해주세요", _settingProvider.ageList,
                      _settingProvider.ageSet),
                  selectCard("성별", 1, "성별을 선택해주세요", _settingProvider.genderList,
                      _settingProvider.genderSet),
                  selectCard(
                      "장거리 연애",
                      1,
                      "장거리 연애 가능여부를\n선택해주세요",
                      _settingProvider.longProfileDateList,
                      _settingProvider.longDateSet),
                  selectCard(
                      "종교",
                      1,
                      "종교를 선택해주세요",
                      _settingProvider.religionProfileList,
                      _settingProvider.religionSet),
                  selectCard(
                      "키 (cm)",
                      1,
                      "키를 선택해주세요",
                      _settingProvider.heightProfileList,
                      _settingProvider.heightSet),
                  selectCard(
                      "학적",
                      1,
                      "학적을 선택해주세요",
                      _settingProvider.undergraduateProfileList,
                      _settingProvider.undergraduateSet),
                  selectCard(
                      "군필 여부",
                      1,
                      "군필 여부를 선택해주세요",
                      _settingProvider.militarProfileList,
                      _settingProvider.militarySet),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * (2 / 100),
                  MediaQuery.of(context).size.width * (5 / 100),
                  MediaQuery.of(context).size.width * (2 / 100),
                  MediaQuery.of(context).size.width * (5 / 100)),
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              width: MediaQuery.of(context).size.width * (85 / 100),
              decoration: BoxDecoration(
                color: Color(0xffF8F8F8),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 4)),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle("기타 정보"),
                  selectCard("MBTI", 0, "MBTI를 선택해주세요", _settingProvider.mbtiProfileList, _settingProvider.mbtiSet),
                  selectCard("사랑의 언어", 0, "사랑의 언어를 선택해주세요", _settingProvider.loveLangProfilList, _settingProvider.loveLangSet),
                  selectCard("흡연 여부", 0, "흡연 여부를 선택해주세요", _settingProvider.cigaretteProfileList, _settingProvider.characterSet),
                  selectCard("음주 여부", 0, "음주 여부를 선택해주세요", _settingProvider.drinkProfileList, _settingProvider.drinkSet),
                  selectCard("학부", 0, "소속 학부를 선택해주세요", _settingProvider.facultyProfileList, _settingProvider.facultySet),
                  selectCard("RC", 0, "소속 RC를 선택해주세요", _settingProvider.rcProfileList, _settingProvider.rcSet),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Reusable Widget
  // 섹션 타이틀을 위한 위젯
  Padding sectionTitle(String title) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 15),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  // 선택형 속성을 위한 카드.
  // 속성 이름 / 필수 여부 / 힌트텍스트 / 선택지 리스트 / 세터함수이름
  Card selectCard(String propertyName, int isNecessary, String hintText,
          List<String> propertyItemList, Function(String) functionName) =>
      Card(
        elevation: 0,
        color: Color(0xffF8F8F8),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Text(
                  propertyName,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 5,
                child: DropdownButtonFormField2(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  scrollbarAlwaysShow: false,
                  scrollbarRadius: const Radius.circular(10),
                  dropdownElevation: 4,
                  offset: const Offset(0, -4),
                  selectedItemHighlightColor: const Color(0x308f8f8f),
                  isExpanded: true,
                  hint: Text(
                    hintText,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 50,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  dropdownMaxHeight: 300,
                  items: propertyItemList
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    functionName(value!);
                  },
                ),
              ),
            ],
          ),
        ),
      );

  // 서술형 정보 입력을 위한 위젯
  Card writeCard(String propertyName, String hintText,
          List<String> propertyItemList, Function(String) functionName) =>
      Card(
        color: const Color(0xffF8F8F8),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Text(
                  propertyName,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 5,
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      hintText: hintText,
                      hintStyle: const TextStyle(
                        fontSize: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    minLines: 6,
                    maxLines: 6,
                  )),
            ],
          ),
        ),
      );

  // 단답형 정보 입력을 위한 위젯
  Card shortCard(String propertyName, String hintText, Function(String) functionName) =>
      Card(
        color: const Color(0xffF8F8F8),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Text(
                  propertyName,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 5,
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      hintText: hintText,
                      hintStyle: const TextStyle(
                        fontSize: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    minLines: 1,
                    maxLines: 1,
                    maxLength: 10,
                    onFieldSubmitted: (String? value){
                      functionName(value!);
                    },
                  ),),
            ],
          ),
        ),
      );
}
