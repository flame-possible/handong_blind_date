// import 'dart:html';
// import 'dart:async';
import 'dart:io';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:final_project/providers/profileInfoProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../login_page.dart';

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


class MyProfile extends StatefulWidget{
  @override
  _MyProfile createState() => _MyProfile();
}

class _MyProfile extends State<MyProfile> {


  late ProfileInfoProvider _profileInfoProvider;

  // pickImageFromGallery() async {
  //   PickedFile? imageFile = await _picker.getImage(
  //     source: ImageSource.gallery,
  //     maxHeight: 680,
  //     maxWidth: 970,
  //   );
  //   setState(() {
  //     this.file = imageFile;
  //   });
  // }

  List<String> pic_url = ['https://www.pngmart.com/files/21/Account-Avatar-Profile-PNG-Photo.png',
    'https://www.pngmart.com/files/21/Account-Avatar-Profile-PNG-Photo.png',
    'https://www.pngmart.com/files/21/Account-Avatar-Profile-PNG-Photo.png'];
  int pic_url_cnt = 0;

  List<dynamic> profile_image_url = ['https://www.pngmart.com/files/21/Account-Avatar-Profile-PNG-Photo.png',
    'https://www.pngmart.com/files/21/Account-Avatar-Profile-PNG-Photo.png',
    'https://www.pngmart.com/files/21/Account-Avatar-Profile-PNG-Photo.png'];
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    _profileInfoProvider = Provider.of<ProfileInfoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("내 프로필"),
        actions: [
          IconButton(
            onPressed: () {
              updateProfile();
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
                color: const Color(0xffF8F8F8),
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
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: ElevatedButton(
                            onPressed: (){
                              _getImage();
                            },
                            child: Image.network(profile_image_url[0], width: 80, height: 80,),

                          ),
                        ),
                        SizedBox(width: 20),
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: ElevatedButton(
                            onPressed: (){
                              _getImage();
                            },
                            child: Image.network(profile_image_url[1], width: 80, height: 80,),

                          ),
                        ),
                        SizedBox(width: 20),
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: ElevatedButton(
                            onPressed: (){
                              _getImage();
                            },
                            child: Image.network(profile_image_url[2], width: 80, height: 80,),

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
                  shortCard("닉네임", _profileInfoProvider.nickname(), "닉네임을 입력하세요",_profileInfoProvider.nicknameSet),
                  selectCard(
                      "나이",
                      _profileInfoProvider.age().isNotEmpty
                          ? _profileInfoProvider.age()
                          : '19',
                      1,
                      "나이를 선택해주세요",
                      _profileInfoProvider.ageList(),
                      _profileInfoProvider.ageSet
                  ),
                  selectCard(
                      "성별",
                      _profileInfoProvider.gender().isNotEmpty
                          ? _profileInfoProvider.gender()
                          : '남자',
                      1,
                      "성별을 선택해주세요",
                      _profileInfoProvider.genderList(),
                      _profileInfoProvider.genderSet
                  ),
                  selectCard(
                      "장거리 연애",
                      _profileInfoProvider.longDate().isNotEmpty
                          ? _profileInfoProvider.longDate()
                          : '가능해요',
                      1,
                      "장거리 연애 가능여부를\n선택해주세요",
                      _profileInfoProvider.longProfileDateList(),
                      _profileInfoProvider.longDateSet),
                  selectCard(
                      "종교",
                      _profileInfoProvider.religion().isNotEmpty
                          ? _profileInfoProvider.religion()
                          : '개신교',
                      1,
                      "종교를 선택해주세요",
                      _profileInfoProvider.religionProfileList(),
                      _profileInfoProvider.religionSet),
                  selectCard(
                      "키 (cm)",
                      _profileInfoProvider.height().isNotEmpty
                          ? _profileInfoProvider.height()
                          : '~150',
                      1,
                      "키를 선택해주세요",
                      _profileInfoProvider.heightProfileList(),
                      _profileInfoProvider.heightSet),
                  selectCard(
                      "학적",
                      _profileInfoProvider.undergraduate().isNotEmpty
                          ? _profileInfoProvider.undergraduate()
                          : '재학',
                      1,
                      "학적을 선택해주세요",
                      _profileInfoProvider.undergraduateProfileList(),
                      _profileInfoProvider.undergraduateSet),
                  selectCard(
                      "군필 여부",
                      _profileInfoProvider.military().isNotEmpty
                          ? _profileInfoProvider.military()
                          : '미필',
                      1,
                      "군필 여부를 선택해주세요",
                      _profileInfoProvider.militarProfileList(),
                      _profileInfoProvider.militarySet),
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
                  selectCard(
                      "MBTI",
                      _profileInfoProvider.mbti().isNotEmpty
                          ? _profileInfoProvider.mbti()
                          : '선택 안함',
                      0,
                      "MBTI를 선택해주세요",
                      _profileInfoProvider.mbtiProfileList(),
                      _profileInfoProvider.mbtiSet
                  ),
                  selectCard(
                      "사랑의 언어",
                      _profileInfoProvider.loveLang().isNotEmpty
                          ? _profileInfoProvider.loveLang()
                          : '선택 안함',
                      0,
                      "사랑의 언어를 선택해주세요",
                      _profileInfoProvider.loveLangProfilList(),
                      _profileInfoProvider.loveLangSet
                  ),
                  selectCard(
                      "흡연 여부",
                      _profileInfoProvider.cigarette().isNotEmpty
                          ? _profileInfoProvider.cigarette()
                          : '선택 안함',
                      0,
                      "흡연 여부를 선택해주세요",
                      _profileInfoProvider.cigaretteProfileList(),
                      _profileInfoProvider.cigaretteSet
                  ),
                  selectCard(
                      "음주 여부",
                      _profileInfoProvider.drink().isNotEmpty
                          ? _profileInfoProvider.drink()
                          : '선택 안함',
                      0,
                      "음주 여부를 선택해주세요",
                      _profileInfoProvider.drinkProfileList(),
                      _profileInfoProvider.drinkSet
                  ),
                  selectCard(
                      "학부",
                      _profileInfoProvider.faculty().isNotEmpty
                          ? _profileInfoProvider.faculty()
                          : '선택 안함',
                      0,
                      "소속 학부를 선택해주세요",
                      _profileInfoProvider.facultyProfileList(),
                      _profileInfoProvider.facultySet
                  ),
                  selectCard(
                      "RC",
                      _profileInfoProvider.rc().isNotEmpty
                          ? _profileInfoProvider.rc()
                          : '선택 안함',
                      0,
                      "소속 RC를 선택해주세요",
                      _profileInfoProvider.rcProfileList(),
                      _profileInfoProvider.rcSet
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Reusable Widget
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
  Card selectCard(String propertyName, String initialValue, int isNecessary, String hintText,
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
                  value: initialValue,
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
  Card shortCard(String propertyName, String initialText, String hintText, Function(String) functionName) =>
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
                    initialValue: initialText,
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

  late File _image;
  final picker = ImagePicker();

  // 갤러리에서 사진 가져오기
  Future _getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxWidth: 200, maxHeight: 100);
    _uploadFile();
    setState(() {
      String? temp = pickedFile?.path;
      _image = File(temp!);
    });

  }

  Future _uploadFile() async {
      // 스토리지에 업로드할 파일 경로
      final firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('post')   //'post'라는 folder를 만들고
          .child('${DateTime.now().millisecondsSinceEpoch}.png');

      // 파일 업로드
      final uploadTask = firebaseStorageRef.putFile(
          _image, SettableMetadata(contentType: 'image/png'));

      // 완료까지 기다림
      await uploadTask.whenComplete(() => null);

      // 업로드 완료 후 url
      final downloadUrl = await firebaseStorageRef.getDownloadURL();

      print(downloadUrl);
      pic_url![pic_url_cnt] = downloadUrl;
      profile_image_url![pic_url_cnt] = downloadUrl;
      pic_url_cnt++;
      print("123");
      print(pic_url![pic_url_cnt]);

  }

  Future<void> updateProfile() async {

    var data = {
      'Nickname': _profileInfoProvider.nickname(),
      'Age': _profileInfoProvider.age(),
      'Gender': _profileInfoProvider.gender(),
      'LongDate': _profileInfoProvider.longDate(),
      'Religion': _profileInfoProvider.religion(),
      'Height': _profileInfoProvider.height(),
      'Undergraduate': _profileInfoProvider.undergraduate(),
      'Military': _profileInfoProvider.military(),
      'Mbti': _profileInfoProvider.mbti(),
      'LoveLang': _profileInfoProvider.loveLang(),
      'Cigarette': _profileInfoProvider.cigarette(),
      'Drink': _profileInfoProvider.drink(),
      'Faculty': _profileInfoProvider.faculty(),
      'Rc': _profileInfoProvider.rc(),
      'Profile_Pic': pic_url,
    };
    print(_profileInfoProvider.nickname());
    DocumentReference docref = FirebaseFirestore.instance
        .collection('User_Data')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    docref.set(data, SetOptions(merge: true));
  }

}
