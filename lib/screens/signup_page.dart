import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/screens/login_page.dart';
import 'package:final_project/screens/signup_certification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:final_project/providers/infoProvider.dart';
import 'package:final_project/providers/naviProvider.dart';

import 'navigator.dart';

class SignUpPage extends StatelessWidget {
  late InfoProvider _infoProvider;
  late NaviProvider _naviProvider;

  String? gender_data = "";

  @override
  Widget build(BuildContext context) {
    _infoProvider = Provider.of<InfoProvider>(context);
    _naviProvider = Provider.of<NaviProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: <Widget>[
            SizedBox(height: 20),
            Text('이름',
                style: TextStyle(
                  fontSize: 13.0,
                )),
            SizedBox(
              height: 44,
              child: TextField(
                  controller: _infoProvider.nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    ),
                  )),
            ),
            SizedBox(height: 34),
            Text('닉네임',
                style: TextStyle(
                  fontSize: 13.0,
                )),
            SizedBox(
                height: 44,
                width: (MediaQuery.of(context).size.width) * 0.65,
                child: TextField(
                  controller: _infoProvider.nickController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    ),
                  ),
                )),
            SizedBox(height: 34),
            Text('생년월일',
                style: TextStyle(
                  fontSize: 13.0,
                )),
            SizedBox(height: 20),
            Row(children: <Widget>[
              SizedBox(
                height: 44,
                width: (MediaQuery.of(context).size.width) * 0.45,
                child: Text(_infoProvider.birthday,
                    style: TextStyle(
                      fontSize: 20,

                    )),
              ),
              SizedBox(
                  height: 44,
                  width: (MediaQuery.of(context).size.width) * 0.3,
                  child: ElevatedButton(
                      onPressed: () => pickDate(context),
                      child: Text("Select Date")))
            ]),
            SizedBox(height: 34),
            Text('학번',
                style: TextStyle(
                  fontSize: 13.0,
                )),
            SizedBox(
                height: 44,
                child: TextField(
                  controller: _infoProvider.StudentIDController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    ),
                  ),
                )),
            SizedBox(height: 34),
            Text('성별',
                style: TextStyle(
                  fontSize: 13.0,
                )),
            SizedBox(
                height: 44,
                child: DropdownButton<String>(
                  value: _infoProvider.genderValue,
                  onChanged: (newValue) {
                    _infoProvider.genderSelect(newValue.toString());
                    gender_data = _infoProvider.genderValue;
                  },
                  items: _infoProvider.genderList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
            SizedBox(height: 34),
            Text('휴대폰 번호',
                style: TextStyle(
                  fontSize: 13.0,
                )),
            SizedBox(
                height: 44,
                child: TextField(
                  controller: _infoProvider.phoneNumController,
                  decoration: InputDecoration(
                    hintText: "01012345678",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    ),
                  ),
                )),
            SizedBox(height: 34),
            Text('재학상태',
                style: TextStyle(
                  fontSize: 13.0,
                )),
            SizedBox(
                height: 44,
                child: DropdownButton<String>(
                  value: _infoProvider.stateValue,
                  onChanged: (newValue) {
                    _infoProvider.stateSelect(newValue.toString());
                  },
                  items: _infoProvider.stateList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
            // SizedBox(height: 34),
            SizedBox(
              height: 44,
              width: (MediaQuery.of(context).size.width) * 0.9,
              child: ElevatedButton(
                  onPressed: () {

                    String? useremail = user_?.email;
                    final userCollectionReference =
                    FirebaseFirestore.instance.collection("User_Data").doc(user_?.uid);

                    var timeZoneOffset = DateTime.now().timeZoneOffset.inMilliseconds;
                    var localTimestamp = (DateTime.now().millisecondsSinceEpoch + timeZoneOffset);

                    userCollectionReference.set({
                      "Uid": user_?.uid,
                      "Name":  _infoProvider.nameController.text,
                      "Nickname": _infoProvider.nickController.text,
                      "Birth_date": _infoProvider.birthday,
                      "Student_number": _infoProvider.StudentIDController.text,
                      "Sex": _infoProvider.genderValue,
                      "Phone_num": _infoProvider.phoneNumController.text,
                      "Status": _infoProvider.stateValue,
                      "Timestamp": localTimestamp
                    });

                    if(useremail != null && useremail.contains('handong.ac.kr')){
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // 파라미터 todo로 tap된 index의 아이템을 전달
                          builder: (context) => Navi(),
                        ),
                      );
                    }
                    else{
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // 파라미터 todo로 tap된 index의 아이템을 전달
                          builder: (context) => SignUp_certification(),
                        ),
                      );
                    }

                  },
                  child: Text('완료')),
            ),
            SizedBox(height: 104),
          ]),
    );
  }

  Future<void> uploadFile() async {
    // file picker를 통해 파일 선택
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      _infoProvider.FileSelect(result.files.single.name.toString());
      final filePath = result.files.single.path;
      // 파일 경로를 통해 formData 생성
      var dio = Dio();
      var formData =
      FormData.fromMap({'file': await MultipartFile.fromFile(filePath!)});
      // 업로드 요청
      final response = await dio.post('/upload', data: formData);
    } else {
      // 아무런 파일도 선택되지 않음.
    }
  }

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 40),
      lastDate: DateTime(DateTime.now().year),
    );
    if (newDate == null)
      print("error");
    else
      _infoProvider.bdaySelect(newDate);
  }
}
