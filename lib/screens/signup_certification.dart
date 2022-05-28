import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:final_project/providers/infoProvider.dart';
import 'package:final_project/providers/naviProvider.dart';

import 'navigator.dart';

class SignUp_certification extends StatelessWidget {
  late InfoProvider _infoProvider;
  late NaviProvider _naviProvider;

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
            Text('본인확인',
                style: TextStyle(
                  fontSize: 13.0,
                )),
            SizedBox(
                height: 44,
                child: DropdownButton<String>(
                  value: _infoProvider.validateValue,
                  onChanged: (newValue) {
                    _infoProvider.validateSelect(newValue.toString());
                  },
                  items: _infoProvider.validateList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
            SizedBox(height: 34),
            Row(children: <Widget>[
              SizedBox(
                height: 44,
                width: (MediaQuery.of(context).size.width) * 0.45,
                child: Text(_infoProvider.fileName),
              ),
              SizedBox(
                  height: 44,
                  width: (MediaQuery.of(context).size.width) * 0.3,
                  child: ElevatedButton(
                      onPressed: () => uploadFile(),
                      child: Text("Select File")))
            ]),
            SizedBox(height: 34),
            SizedBox(
              height: 44,
              width: (MediaQuery.of(context).size.width) * 0.9,
              child: ElevatedButton(
                  onPressed: () {

                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // 파라미터 todo로 tap된 index의 아이템을 전달
                        builder: (context) => Navi(),
                      ),
                    );
                  },
                  child: Text('완료')),
            ),
            SizedBox(height: 34),
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
