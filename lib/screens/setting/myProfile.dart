import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:final_project/providers/settingProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          children: [
            selectCard("나이", "나이를 선택해주세요", _settingProvider.ageList, _settingProvider.ageSet),
          ],
        ),
      ),
    );
  }

  Card selectCard(String propertyName, String hintText, List<String> propertyItemList, Function(String) functionName) =>
      Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  propertyName,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
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
                  offset: Offset(0,-4),
                  selectedItemHighlightColor: const Color(0x888f8f8f),
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

}
