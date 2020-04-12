import 'dart:collection';
import 'package:kiranaadminapp/model/order.dart';
import 'package:flutter/cupertino.dart';

class OrderNotifier with ChangeNotifier {
  List<Orders> _orderList = [];

  UnmodifiableListView<Orders> get orderList =>
      UnmodifiableListView(_orderList);

  set orderList(List<Orders> orderList) {
    _orderList = orderList;
    notifyListeners();
  }

  deleteFood(Orders orders) {
    _orderList.removeWhere((_orders) => _orders.id == orders.id);
    notifyListeners();
  }
}
