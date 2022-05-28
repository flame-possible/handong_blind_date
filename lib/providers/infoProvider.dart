import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class InfoProvider with ChangeNotifier{


  final List<String> _validateList = ['학생증 첨부', '졸업 증명서 첨부'];
  String? _validateValue = '학생증 첨부';
  final List<String> _genderList = ['남', '여'];
  String? _genderValue = '남';
  final List<String> _stateList = ['재학생', '졸업생', '휴학생'];
  String? _stateValue = '재학생';

  String _fileName = 'Choose file';

  List<String> get validateList => _validateList;
  String? get validateValue => _validateValue;
  List<String> get genderList => _genderList;
  String? get genderValue => _genderValue;
  List<String> get stateList => _stateList;
  String? get stateValue => _stateValue;

  String get fileName => _fileName;


  String _birthday = DateFormat('yy-MM-dd').format(DateTime.now()).toString();

  String get birthday => _birthday;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _IDController = TextEditingController();
  final TextEditingController _nickController = TextEditingController();
  final TextEditingController _StdentIDController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get IDController => _IDController;
  TextEditingController get nickController => _nickController;
  TextEditingController get StudentIDController => _StdentIDController;
  TextEditingController get phoneNumController => _phoneNumController;


  void validateSelect(String selected){
    _validateValue = selected;
    notifyListeners();
  }

  void genderSelect(String selected){
    _genderValue = selected;
    notifyListeners();
  }

  void stateSelect(String selected){
    _stateValue = selected;
    notifyListeners();
  }

  void FileSelect(String selected){
    _fileName=selected;
    notifyListeners();
  }

  void bdaySelect(DateTime selected){
    _birthday=selected.toString();
    notifyListeners();
  }


}


