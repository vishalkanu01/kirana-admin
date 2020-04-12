import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kiranaadminapp/model/user.dart';
import 'dart:collection';

class AuthNotifier with ChangeNotifier {
  List<Users> _userList = [];

  UnmodifiableListView<Users> get userList => UnmodifiableListView(_userList);

  set userList(List<Users> userList) {
    _userList = userList;
    notifyListeners();
  }

  FirebaseUser _user;

  FirebaseUser get user => _user;

  void setUser(FirebaseUser user) {
    _user = user;
    notifyListeners();
  }
}