import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/providers/matchingProvider.dart';
import 'package:final_project/screens/navigator/setting_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:final_project/providers/bottombarProvider.dart';

import '../../providers/bottombarProvider.dart';
import '../../providers/profileProvider.dart';
import '../../providers/profileInfoProvider.dart';
import '../login_page.dart';
import 'matching_page.dart';

late List<String> allData;
List<List<dynamic>> partners_info = [['', '', '', ''], ['', '', '', ''], ['', '', '', ''], ['', '', '', ''], ['', '', '', '']];
List<dynamic> partners_pic = ['', '', '', '', ''];

class HomePage extends StatefulWidget {

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BottomBarProvider _bottomBarProvider;

  late ProfileProvider _profileProvider;

  late ProfileInfoProvider _settingProvider;


  @override
  Widget build(BuildContext context) {
    _bottomBarProvider = Provider.of<BottomBarProvider>(context);
    _profileProvider = Provider.of<ProfileProvider>(context);
    _settingProvider = Provider.of<ProfileInfoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("홈"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Setting()),
              );
            },
            icon: Icon(Icons.settings),
            color: Colors.black,
          )
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        reverse: false,
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * (2 / 100),
              ),
              // 내 프로필 표시를 위한 박스
              InkWell(
                onDoubleTap: () {
                  _settingProvider.seeDetailProfile();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * (90 / 100),
                  //height: MediaQuery.of(context).size.height * (50 / 100),
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * (8 / 100),
                      MediaQuery.of(context).size.width * (5 / 100),
                      MediaQuery.of(context).size.width * (8 / 100),
                      MediaQuery.of(context).size.width * (8 / 100)),
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
                    children: [
                      //컨테이너 title 내 프로필
                      SizedBox(
                        height: MediaQuery.of(context).size.height * (5 / 100),
                        child: const Text(
                          "내 프로필",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // profile image slider
                      CarouselSlider(
                        items: _profileProvider.profileImage.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.network(i),
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height:
                          MediaQuery.of(context).size.width * (70 / 100),
                          viewportFraction: 1,
                          initialPage: 0,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                        ),
                      ),
                      // Nick name section
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0,
                            MediaQuery.of(context).size.height * (2 / 100),
                            0,
                            MediaQuery.of(context).size.height * (2 / 100)),
                        child: Text(
                          (_settingProvider.generalPropertyGetterList())
                              .elementAt(0)(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //기본 정보를 위한 칸 (필수정보)
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _settingProvider.displayedGeneralItemNum,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                            child: Container(
                              height: MediaQuery.of(context).size.height *
                                  (3 / 100),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 3,
                                    fit: FlexFit.tight,
                                    child: Text(_settingProvider
                                        .generalPropertyList()[index + 1]),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      _settingProvider
                                          .generalPropertyGetterList()
                                          .elementAt(index + 1)(),
                                      style:
                                      const TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Divider(
                        indent: MediaQuery.of(context).size.width * (30 / 100),
                        endIndent:
                        MediaQuery.of(context).size.width * (30 / 100),
                        thickness: 1,
                        height: 32,
                        color: Colors.cyan,
                      ),
                      //선택 정보를 위한 칸 (비필수 정보)
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _settingProvider.displayedOthersItemNum,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                            child: Container(
                              height: MediaQuery.of(context).size.height *
                                  (3 / 100),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 3,
                                    fit: FlexFit.tight,
                                    child: Text(_settingProvider
                                        .otherPropertyList()[index]),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      _settingProvider
                                          .otherPropertyGetterList()
                                          .elementAt(index)(),
                                      style:
                                      const TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * (2 / 100),
              ),
              ElevatedButton(
                child: Text("매칭하기"),
                onPressed: () {
                  getDocs();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => ChangeNotifierProvider(
                        create: (context) => MatchingProvider(),
                        builder: (context, child) => MatchingPage(),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * (2 / 100),
              ),
            ],
          ),
        ],
      ),
    );
  }

  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('User_Data');


  Future getDocs() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    allData = querySnapshot.docs.map((doc) => doc.id).toList();
    for(int i = 0; i < allData.length; i++){
      if(allData[i] == uid){
        allData.removeAt(i);
        print(i);
        break;
      }
    }
    Check_matching_info();
  }

  Future Check_matching_info() async{

    List<List<dynamic>>? user_info = [[''], [''], [''], [''], [''], [''], [''], [''], [''], [''], ['']];

    DocumentReference docref =
    await FirebaseFirestore.instance.collection('Matching_Info').doc(FirebaseAuth.instance.currentUser?.uid);
    await docref.get().then((DocumentSnapshot documentSnapshot) {
      print("read");
      user_info[0] = documentSnapshot["Age"];
      user_info[1] = documentSnapshot["Drink"];
      user_info[2] = documentSnapshot["Height"];
      user_info[3] = documentSnapshot["LongD"];
      user_info[4] = documentSnapshot["Major"];
      user_info[5] = documentSnapshot["Mbti"];
      user_info[6] = documentSnapshot["Military"];
      user_info[7] = documentSnapshot["Rc"];
      user_info[8] = documentSnapshot["Religion"];
      user_info[9] = documentSnapshot["Smoke"];
      user_info[10] = documentSnapshot["Undergraduate"];
      print("suc");
      print(user_info);
    });


    for(int i = 0; i < allData.length; i++){

      List<String>? partner_info = ['', '', '', '', '', '', '', '', '', '', ''];

      DocumentReference docref =
      await FirebaseFirestore.instance.collection('User_Data').doc(allData[i]);
      await docref.get().then((DocumentSnapshot documentSnapshot) {
        print("read");
        partner_info[0] = documentSnapshot["Age"];
        partner_info[1] = documentSnapshot["Drink"];
        partner_info[2] = documentSnapshot["Height"];
        partner_info[3] = documentSnapshot["LongDate"];
        partner_info[4] = documentSnapshot["Faculty"];
        partner_info[5] = documentSnapshot["Mbti"];
        partner_info[6] = documentSnapshot["Military"];
        partner_info[7] = documentSnapshot["Rc"];
        partner_info[8] = documentSnapshot["Religion"];
        partner_info[9] = documentSnapshot["Cigarette"];
        partner_info[10] = documentSnapshot["Undergraduate"];
        print("suc");
        print(partner_info);
      });

      int temp_result = 0;

      for(int j = 0; j < partner_info.length; j++){
        if(user_info[j].contains("상관없음")){
          temp_result++;
          continue;
        }
        if(partner_info[j].contains("선택 안함")){
          continue;
        }


        if(user_info[j].contains(partner_info[j])){
          temp_result++;
        }
      }

      if(temp_result < 1){
        print("delete");
        print(i);
        allData.removeAt(i);
        i--;
      }

    }

    print('final');

    for(int i = 0; i < allData.length; i++){
      if(allData[i] == uid){
        await allData.removeAt(i);
        print(i);
        break;
      }
    }

    print(allData);

    for(int i = 0; i < allData.length; i++){

      DocumentReference docref =
      await FirebaseFirestore.instance.collection('User_Data').doc(allData[i]);
      await docref.get().then((DocumentSnapshot documentSnapshot) {
        print("read");
        partners_info[i][0] = documentSnapshot["Age"];
        partners_info[i][1] = documentSnapshot["Height"];
        partners_info[i][2] = documentSnapshot["Undergraduate"];
        partners_info[i][3] = documentSnapshot["Nickname"];
        partners_pic[i] = documentSnapshot.exists ? documentSnapshot["Profile_Pic"][0] : '';
        print("suc");
        print(partners_info);
      });
    }


  }

}
