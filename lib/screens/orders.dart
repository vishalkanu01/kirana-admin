import 'package:kiranaadminapp/api/food_api.dart';
import 'package:kiranaadminapp/notifier/order_notifier.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    OrderNotifier orderNotifier =
        Provider.of<OrderNotifier>(context, listen: false);
    getOrders(orderNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OrderNotifier orderNotifier = Provider.of<OrderNotifier>(context);

    Future<void> _refreshList() async {
      getOrders(orderNotifier);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Orders"),
        ),
        body: new RefreshIndicator(
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return CustomListItemTwo(
                thumbnail: Image.network(
                  orderNotifier.orderList[index].image != null
                      ? orderNotifier.orderList[index].image
                      : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                  width: 120,
                  fit: BoxFit.fitWidth,
                ),
                title: orderNotifier.orderList[index].name,
                subtitle:
                    "\Customer Name: ${orderNotifier.orderList[index].userName}",
                author: 'Dash',
                publishDate: 'mcsaah',
                readDuration: '5 mins',
              );
            },
            itemCount: orderNotifier.orderList.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.black,
              );

              //             ListTile(
//              leading: Image.network(
//                orderNotifier.orderList[index].image != null
//                    ? orderNotifier.orderList[index].image
//                    : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
//                width: 120,
//                fit: BoxFit.fitWidth,
//              ),
//              title: Text(orderNotifier.orderList[index].name),
//              subtitle: Text("\Customer Name: ${orderNotifier.orderList[index].userName}"),
//             // onTap: () {},
//            );
            },
          ),
          onRefresh: _refreshList,
        ));
  }
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    Key key,
    this.thumbnail,
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.readDuration,
  }) : super(key: key);

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  publishDate: publishDate,
                  readDuration: readDuration,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({
    Key key,
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.readDuration,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$subtitle',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '$author',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$publishDate · $readDuration ★',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
