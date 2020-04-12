import 'dart:io';
import 'package:kiranaadminapp/model/food.dart';
import 'package:kiranaadminapp/model/order.dart';
import 'package:kiranaadminapp/model/user.dart';
import 'package:kiranaadminapp/notifier/auth_notifier.dart';
import 'package:kiranaadminapp/notifier/food_notifier.dart';
import 'package:kiranaadminapp/notifier/order_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

getUsers(AuthNotifier authNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('users')
      //.orderBy("createdAt", descending: true)
      .getDocuments();

  List<Users> _userList = [];

  snapshot.documents.forEach((document) {
    Users users = Users.fromMap(document.data);
    _userList.add(users);
  });

  authNotifier.userList = _userList;
}

getFoods(FoodNotifier foodNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Foods')
      .orderBy("createdAt", descending: true)
      .getDocuments();

  List<Food> _foodList = [];

  snapshot.documents.forEach((document) {
    Food food = Food.fromMap(document.data);
    _foodList.add(food);
  });

  foodNotifier.foodList = _foodList;
}

getOrders(OrderNotifier orderNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Orders')
       .orderBy("Order Time", descending: false)
      .getDocuments();

  List<Orders> _orderList = [];

  snapshot.documents.forEach((document) {
    Orders orders = Orders.fromMap(document.data);
    _orderList.add(orders);
  });

  orderNotifier.orderList = _orderList;
}

uploadFoodAndImage(
    Food food, bool isUpdating, File localFile, Function foodUploaded) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('foods/images/$uuid$fileExtension');

    await firebaseStorageRef
        .putFile(localFile)
        .onComplete
        .catchError((onError) {
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");
    _uploadFood(food, isUpdating, foodUploaded, imageUrl: url);
  } else {
    print('...skipping image upload');
    _uploadFood(food, isUpdating, foodUploaded);
  }
}

_uploadFood(Food food, bool isUpdating, Function foodUploaded,
    {String imageUrl}) async {
  CollectionReference foodRef = Firestore.instance.collection('Foods');

  if (imageUrl != null) {
    food.image = imageUrl;
  }

  if (isUpdating) {
    food.updatedAt = Timestamp.now();

    await foodRef.document(food.id).updateData(food.toMap());

    foodUploaded(food);
    print('updated food with id: ${food.id}');
  } else {
    food.createdAt = Timestamp.now();

    DocumentReference documentRef = await foodRef.add(food.toMap());

    food.id = documentRef.documentID;

    print('uploaded food successfully: ${food.toString()}');

    await documentRef.setData(food.toMap(), merge: true);

    foodUploaded(food);
  }
}

deleteFood(Food food, Function foodDeleted) async {
  if (food.image != null) {
    StorageReference storageReference =
        await FirebaseStorage.instance.getReferenceFromUrl(food.image);

    print(storageReference.path);

    await storageReference.delete();

    print('image deleted');
  }

  await Firestore.instance.collection('Foods').document(food.id).delete();
  foodDeleted(food);
}
