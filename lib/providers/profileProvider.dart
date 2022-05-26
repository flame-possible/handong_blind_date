import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profileInfoProvider.dart';

/// 프로필의 각 속성별 값을 앱 내에 저장하도록 하는 것은 좋지 않다.
/// 로컬 저장소에 값을 저장해놓는 방법을 구현해야하기 떼문이다.
/// 따라서, 프로필 데이터는 DB에만 저장하도록 하며
/// 앱 실행 후 로그인 정보를 확인할 때 해당 프로바이더의 변수에 값을 일시적으로 저장하고
/// 자기 프로필을 보여줄 때는 DB에서 값을 다시 불러오는 것이 아닌, 프로바이더에서 값을 저장 받도록 한다.
/// 프로필을 수정할 때에도 마찬가지로, 프로파이더 내의 변수를 이용하며,
/// 사용자가 '저장'버튼을 누를 경우에 DB에 값을 Update 하도록 한다.
class ProfileProvider with ChangeNotifier {
  late ProfileInfoProvider _settingProvider;

  // 이 프로바이더가 처음 생성되었을 때, firebase db로 부터 각종 데이터를 받아와 각 변수들을 초기화 시켜야 한다.
  ProfileProvider() {
    getProfileImage();
  }

  bool _seeDetailProfile = false;
  int _displayedChooseItemNum = 1;
  int _displayedShortItemNum = 1;
  int _displayedLongItemNum = 1;

  void seeDetailProfile() {
    _seeDetailProfile = !(_seeDetailProfile);

    if (_seeDetailProfile == false) {
      _displayedChooseItemNum = 1;
      _displayedShortItemNum = 1;
      _displayedLongItemNum = 1;
    } else {
      _displayedChooseItemNum = propertyChoose.length;
      _displayedShortItemNum = propertyShort.length;
      _displayedLongItemNum = propertyLong.length;
    }
    notifyListeners();
  }

  void getProfileImage() {
    _profileImage.add(
        "http://www.urbanbrush.net/web/wp-content/uploads/edd/2018/04/web-20180403145227599865.png");
    _profileImage.add(
        "https://t1.daumcdn.net/liveboard/interstella-story/32f3dbb7f8434c4383c01f1bf253986d.jpg");
    _profileImage.add(
        "https://img5.yna.co.kr/photo/cms/2020/03/18/38/PCM20200318000038005_P4.jpg");
    print("실행됨");
  }

  // 큰 범주의 속성별로 딕셔너리 자료형을만들고 해당 범주의 세부 속성별로를 인덱스를 구분하도록 한다.
  List<String> _profileImage = [];
  List<String> get profileImage => _profileImage;

  // 1. 유저 기본 정보
  late List<Map<String, dynamic>> _propertyGeneral = [
    {
      'property': "닉네임",
      'answer': "싫다네",
    },
    {
      'property': "나이",
      'answer': "",
    },
    {
      'property': "성별",
      'answer': "",
    },
    {
      'property': "나이",
      'answer': "",
    },
    {
      'property': "장거리 연애",
      'answer': "",
    },
    {
      'property': "종교",
      'answer': "",
    },
    {
      'property': "키 (cm) ",
      'answer': "",
    },
    {
      'property': "학적",
      'answer': "",
    },
    {
      'property': "군필 여부",
      'answer': "",
    }
  ];

  // 2. 선택형 정보
  List<Map<String, dynamic>> _propertyChoose = [
    {
      'property': "선택속성1",
      'question': "선택속성1은 무엇인가요?",
      'answer': "선택예시1",
    },
    {
      'property': "선택속성2",
      'question': "선택속성2은 무엇인가요?",
      'answer': "선택예시2",
    },
    {
      'property': "선택속성3",
      'question': "선택속성3은 무엇인가요?",
      'answer': "선택예시3",
    }
  ];
  // 3. 단답형 정보
  List<Map<String, dynamic>> _propertyShort = [
    {
      'property': "단답속성1",
      'question': "단답속성1은 무엇인가요?",
      'answer': "단답예시1",
    },
    {
      'property': "단답속성2",
      'question': "단답속성2은 무엇인가요?",
      'answer': "단답예시2",
    },
    {
      'property': "단답속성3",
      'question': "단답속성3은 무엇인가요?",
      'answer': "단답예시3",
    },
  ];
  // 4. 서술형 정보
  List<Map<String, dynamic>> _propertyLong = [
    {
      'property': "서술속성1",
      'question': "서술속성1은 무엇인가요?",
      'answer': "서술예시1",
    },
    {
      'property': "서술속성1",
      'question': "서술속성1은 무엇인가요?",
      'answer': "서술예시1",
    },
    {
      'property': "서술속성1",
      'question': "서술속성1은 무엇인가요?",
      'answer': "서술예시1",
    },
  ];

  List<Map<String, dynamic>> get propertyGeneral => _propertyGeneral;
  List<Map<String, dynamic>> get propertyChoose => _propertyChoose;
  List<Map<String, dynamic>> get propertyShort => _propertyShort;
  List<Map<String, dynamic>> get propertyLong => _propertyLong;

  int get displayedChooseItemNum => _displayedChooseItemNum;
  int get displayedShortItemNum => _displayedShortItemNum;
  int get displayedLongItemNum => _displayedLongItemNum;
}
