import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/providers/matchingProvider.dart';
import 'package:final_project/screens/navigator/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:final_project/providers/bottombarProvider.dart';

import '../../providers/bottombarProvider.dart';
import '../../providers/profileProvider.dart';
import '../../providers/profileInfoProvider.dart';
import '../login_page.dart';
import 'matching_page.dart';


/**
 * TODO
 * @ "홈 화면"의 내 프로필 섹션은 ProfileInfoProvider에서 정보를 불러옵니다.
 *   위 프로바이더에서 불러오는 정보 중 "필수 정보 (나이, 성별, 장거리 연애, 종교 ... )" 의 데이터가 비어 있을 경우
 *   팝업 알림이 뜨면서 "설정-내 프로필 설정" 으로 넘어가도록 해주세요.
 *
 * @ 닉네임이 사진 바로 밑에 center align 으로 뜨게 해주세요
 */
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
}
