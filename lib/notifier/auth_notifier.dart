import 'package:flutter/widgets.dart';
import 'package:kiranaadminapp/model/user.dart';
import 'dart:collection';

class AuthNotifier with ChangeNotifier {
  List<Users> _userList = [];

  UnmodifiableListView<Users> get userList => UnmodifiableListView(_userList);

  set userList(List<Users> userList) {
    _userList = userList;
    notifyListeners();
  }
}
