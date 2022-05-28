import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/providers/matchingInfoProvider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../login_page.dart';
import 'package:toast/toast.dart';


class MatchingInfo extends StatelessWidget {
  MatchingInfo({Key? key}) : super(key: key);
  late MatchingInfoProvider _matchingInfoProvider;
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _matchingInfoProvider = Provider.of<MatchingInfoProvider>(context);
    ToastContext().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("내 매칭 정보"),
        actions: [
          IconButton(
            onPressed: () {
              updateMatchingInfo();
              Toast.show("정보가 업데이트 되었습니다!", duration: Toast.lengthShort, gravity:  Toast.bottom);
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
                  sectionTitle("매칭 정보"),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      "이상형의 정보를 입력해 주세요 - 복수 선택 가능",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  selectCard(
                      "나이",
                      _matchingInfoProvider.selectedAge,
                      _matchingInfoProvider.selectedAgeStr,
                      _matchingInfoProvider.age,
                      _matchingInfoProvider.ageItems,
                      _matchingInfoProvider.ageSelect),
                  selectCard(
                      "키 (cm)",
                      _matchingInfoProvider.selectedHeight,
                      _matchingInfoProvider.selectedHeightStr,
                      _matchingInfoProvider.height,
                      _matchingInfoProvider.heightItems,
                      _matchingInfoProvider.heightSelect),
                  selectCard(
                      "MBTI",
                      _matchingInfoProvider.selectedMbti,
                      _matchingInfoProvider.selectedMbtiStr,
                      _matchingInfoProvider.mbti,
                      _matchingInfoProvider.mbtiItems,
                      _matchingInfoProvider.mbtiSelect),
                  selectCard(
                      "학적",
                      _matchingInfoProvider.selectedUndergraduate,
                      _matchingInfoProvider.selectedUndergraduateStr,
                      _matchingInfoProvider.undergraduate,
                      _matchingInfoProvider.undergraduateItems,
                      _matchingInfoProvider.undergradateSelect),
                  selectCard(
                      "군필 여부",
                      _matchingInfoProvider.selectedMilitary,
                      _matchingInfoProvider.selectedMilitaryStr,
                      _matchingInfoProvider.military,
                      _matchingInfoProvider.militaryItems,
                      _matchingInfoProvider.militarySelect),
                  selectCard(
                      "장거리 선호 여부",
                      _matchingInfoProvider.selectedLongD,
                      _matchingInfoProvider.selectedLongDStr,
                      _matchingInfoProvider.longD,
                      _matchingInfoProvider.longDItems,
                      _matchingInfoProvider.longDSelect),
                  selectCard(
                      "종교",
                      _matchingInfoProvider.selectedReligion,
                      _matchingInfoProvider.selectedReligionStr,
                      _matchingInfoProvider.religion,
                      _matchingInfoProvider.religionItems,
                      _matchingInfoProvider.religionSelect),

                  selectCard(
                      "흡연 여부",
                      _matchingInfoProvider.selectedSmoke,
                      _matchingInfoProvider.selectedSmokeStr,
                      _matchingInfoProvider.smoke,
                      _matchingInfoProvider.smokeItems,
                      _matchingInfoProvider.smokeSelect),
                  selectCard(
                      "음주 여부",
                      _matchingInfoProvider.selectedDrink,
                      _matchingInfoProvider.selectedDrinkStr,
                      _matchingInfoProvider.drink,
                      _matchingInfoProvider.drinkItems,
                      _matchingInfoProvider.drinkSelect),
                  selectCard(
                      "전공",
                      _matchingInfoProvider.selectedMajor,
                      _matchingInfoProvider.selectedMajorStr,
                      _matchingInfoProvider.major,
                      _matchingInfoProvider.majorItems,
                      _matchingInfoProvider.majorSelect),
                  selectCard(
                      "RC",
                      _matchingInfoProvider.selectedRc,
                      _matchingInfoProvider.selectedRcStr,
                      _matchingInfoProvider.rc,
                      _matchingInfoProvider.rcItems,
                      _matchingInfoProvider.rcSelect),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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

  Card selectCard(
      String propertyName,
      List initialList,
      List selectedValue,
      List itemList,
      List<MultiSelectItem<Object?>> propertyItemList,
      Function(List<Object?>) functionName) =>
      Card(
        elevation: 0,
        color: Color(0xffF8F8F8),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  flex: 5,
                  child: MultiSelectChipField(
                      initialValue: initialList.isEmpty
                          ? [itemList[0]]
                          : initialList,
                      scroll: false,
                      title: Text(
                        propertyName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      headerColor: const Color(0x6dff8383),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                        borderRadius: const BorderRadius. only(
                          topLeft: Radius.zero,
                          topRight: Radius.zero,
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      items: propertyItemList,
                      selectedChipColor: const Color(0x6dff8383),
                      onTap: (List<Object?> values) {
                        if (values.isEmpty) {
                          values.add(itemList[0]);
                        }
                        else if (values.last == itemList[0]) {
                          values.clear();
                          values.add(itemList[0]);
                        }
                        else if (values.length > 1 && values.first == itemList[0]) {
                          values.removeAt(0);
                        }
                        functionName(values);
                      })),
            ],
          ),
        ),
      );

  void updateMatchingInfo() {
    var data = {
      'Age': _matchingInfoProvider.selectedAgeStr,
      'Height': _matchingInfoProvider.selectedHeightStr,
      'Mbti': _matchingInfoProvider.selectedMbtiStr,
      'Undergraduate': _matchingInfoProvider.selectedUndergraduateStr,
      'Military': _matchingInfoProvider.selectedMilitaryStr,
      'LongD': _matchingInfoProvider.selectedLongDStr,
      'Religion': _matchingInfoProvider.selectedReligionStr,
      'Smoke': _matchingInfoProvider.selectedSmokeStr,
      'Drink': _matchingInfoProvider.selectedDrinkStr,
      'Major': _matchingInfoProvider.selectedMajorStr,
      'Rc': _matchingInfoProvider.selectedRcStr,
    };

    DocumentReference docref = FirebaseFirestore.instance
        .collection('Matching_Info')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    docref.set(data, SetOptions(merge: true));
  }
}
