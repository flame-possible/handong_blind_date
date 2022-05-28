import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../providers/matchingProvider.dart';
import 'home_page.dart';

class MatchingPage extends StatelessWidget {
  MatchingPage({Key? key}) : super(key: key);

  late MatchingProvider _matchingProvider;

  int partner_cnt = 0;

  List<String> Likeusers = [];
  List<String> Dislikeusers = [];


  @override
  Widget build(BuildContext context) {

    _matchingProvider = Provider.of<MatchingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("매칭"),
        actions: [
          IconButton(
            onPressed: () {
              print(allData);
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //윗 마진을 위한 사이즈 박스
          Flexible(
            fit: FlexFit.tight,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Padding(
                padding: EdgeInsets.only(left: 30, top: 10),
                child: Text(
                  "원하는 방향으로 스와이프 해주세요.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff767676),
                  ),
                ),
              ),
            ),
          ),
          //스와이프 방향을 안내해주는 문구, 별로예요 & 좋아요
          Padding(
            padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * (5 / 100),
              0,
              MediaQuery.of(context).size.width * (5 / 100),
              0,
            ),
            child: Row(
              children: const [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text(
                    "별로예요",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff8F8F8F),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text(
                    "좋아요",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff8F8F8F),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          // 스와이핑할 카드를 위한 섹션
          Stack(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                    0,
                    MediaQuery.of(context).size.height * (2 / 100),
                    0,
                    MediaQuery.of(context).size.height * (8 / 100)),
                width: MediaQuery.of(context).size.width * (80 / 100),
                height: MediaQuery.of(context).size.height * (65 / 100),
                color: Colors.white,
                child: SwipableStack(
                  itemCount: allData == null ? 0 : allData.length,
                  stackClipBehaviour: Clip.none,
                  //스와이핑 가능 방향을 제한한다.
                  onWillMoveNext: (index, direction) {
                    final allowedActions = [
                      SwipeDirection.right,
                      SwipeDirection.left,
                    ];
                    return allowedActions.contains(direction);
                  },
                  //어느정도 스와이핑 했을 때 선택한것으로 인지할 것인지?
                  horizontalSwipeThreshold: 0.8,
                  // 카드의 회전축이 바닥이 되도록 한다.
                  swipeAnchor: SwipeAnchor.bottom,
                  onSwipeCompleted: (index, direction) {

                    _matchingProvider.matchingResult(index, direction, allData[index], Likeusers, Dislikeusers);

                    partner_cnt++;
                    if (index == allData.length - 1) {

                      var data = {
                        'Like': Likeusers,
                        'Dislike': Dislikeusers
                      };
                      DocumentReference docref = FirebaseFirestore.instance
                          .collection('User_Data')
                          .doc(FirebaseAuth.instance.currentUser?.uid);
                      docref.set(data, SetOptions(merge: true));


                      CoolAlert.show(
                        context: context,
                        width: MediaQuery.of(context).size.width * (60 / 100),
                        type: CoolAlertType.success,
                        barrierDismissible: false,
                        backgroundColor: Colors.white,
                        lottieAsset: _matchingProvider.lottieAsset,
                        title: "Success!!!",
                        text: "모든 대상을 확인했습니다.\n홈 화면으로 이동합니다.",
                        confirmBtnText: "확인",
                        confirmBtnColor: Color(0xffff8383),
                        onConfirmBtnTap: (){
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        }
                      );
                    }
                  },
                  builder: ((context, properties) {
                    return Container(
                      //여기에 들어가는 크기 속성은 소용이 없다.
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 30,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * (5 / 100),
                            MediaQuery.of(context).size.height * (5 / 100),
                            MediaQuery.of(context).size.width * (5 / 100),
                            MediaQuery.of(context).size.height * (5 / 100)),
                        child: Column(
                          children: [
                            //사진을 담기 위한 컨테이너이다. 컨테이너의 크기는 (상위컨테이너 너비)-(패딩 너비)이다.

                            Container(
                              width: MediaQuery.of(context).size.width *
                                  (75 / 100),
                              height: MediaQuery.of(context).size.width *
                                  (75 / 100),
                              color: Colors.cyan,
                              alignment: Alignment.center,
                              child: Image.network(partners_pic[partner_cnt]),
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 3,
                                    fit: FlexFit.tight,
                                    child: Text("나이"),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Text(partners_info[partner_cnt][0],
                                      style:
                                      const TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 3,
                                    fit: FlexFit.tight,
                                    child: Text("성별"),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Text(partners_info[partner_cnt][1],
                                      style:
                                      const TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 3,
                                    fit: FlexFit.tight,
                                    child: Text("학적"),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Text(partners_info[partner_cnt][2],
                                      style:
                                      const TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 3,
                                    fit: FlexFit.tight,
                                    child: Text("닉네임"),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    fit: FlexFit.tight,
                                    child: Text(partners_info[partner_cnt][3],
                                      style:
                                      const TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


}
