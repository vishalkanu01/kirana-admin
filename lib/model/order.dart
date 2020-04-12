import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  String userId;
  String userName;
  String id;
  String name;
  String image;
  String price;
  Timestamp orderTime;

  Orders();

  Orders.fromMap(Map<String, dynamic> data) {
    orderTime = data['Order Time'];
    userId = data['User ID'];
    userName = data['User Name'];
    id = data['id'];
    image = data['image'];
    name = data['name'];
    price = data['price'];
  }
}
