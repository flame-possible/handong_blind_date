import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_project/providers/matchingProvider.dart';
import 'package:final_project/screens/navigator/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:final_project/providers/bottombarProvider.dart';

import '../../providers/profileProvider.dart';
import 'matching_page.dart';

class HomePage extends StatelessWidget {
  late BottomBarProvider _bottomBarProvider;
  late ProfileProvider _profileProvider;

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _bottomBarProvider = Provider.of<BottomBarProvider>(context);
    _profileProvider = Provider.of<ProfileProvider>(context);

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * (2 / 100),
            ),
            // 내 프로필 표시를 위한 박스
            InkWell(
              onDoubleTap: () {
                _profileProvider.seeDetailProfile();
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
                  color: Color(0xFFF5F5F5),
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
                      height: MediaQuery.of(context).size.height * (4 / 100),
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
                        height: MediaQuery.of(context).size.width * (70 / 100),
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
                          MediaQuery.of(context).size.height * (1 / 100),
                          0,
                          MediaQuery.of(context).size.height * (1 / 100)),
                      child: Text(
                        _profileProvider.propertyGeneral[0]['answer'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //선택속성을 위한 칸
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _profileProvider.displayedChooseItemNum,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * (3 / 100),
                            child: Row(
                              children: [
                                Text(_profileProvider.propertyChoose[index]
                                    ['property']),
                                const Text("\t\t\t\t\t\t"),
                                Text(
                                  _profileProvider.propertyChoose[index]
                                      ['answer'],
                                  style: const TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Divider(
                      indent: MediaQuery.of(context).size.width * (30 / 100),
                      endIndent: MediaQuery.of(context).size.width * (30 / 100),
                      thickness: 1,
                      height: 32,
                      color: Colors.cyan,
                    ),
                    //단답속성을 위한 칸
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _profileProvider.displayedShortItemNum,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * (3 / 100),
                            child: Row(
                              children: [
                                Text(_profileProvider.propertyShort[index]
                                    ['property']),
                                const Text("\t\t\t\t\t\t"),
                                Text(
                                  _profileProvider.propertyShort[index]
                                      ['answer'],
                                  style: const TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Divider(
                      indent: MediaQuery.of(context).size.width * (30 / 100),
                      endIndent: MediaQuery.of(context).size.width * (30 / 100),
                      thickness: 1,
                      height: 32,
                      color: Colors.cyan,
                    ),
                    //서술속성을 위한 칸
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _profileProvider.displayedLongItemNum,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * (3 / 100),
                            child: Row(
                              children: [
                                Text(_profileProvider.propertyLong[index]
                                    ['property']),
                                const Text("\t\t\t\t\t\t"),
                                Text(
                                  _profileProvider.propertyLong[index]
                                      ['answer'],
                                  style: const TextStyle(color: Colors.blue),
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
          ],
        ),
      ),
    );
  }
}
