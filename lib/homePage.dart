import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './BaseAuth.dart';
import './ShopDetails.dart';
import './drawer.dart';

class HomePage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  HomePage({this.auth, this.logoutCallback});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final databaseRef = Firestore.instance;
  List<DocumentSnapshot> data;
  Future<void> getData() async {
    await databaseRef
        .collection("Shops")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      data = snapshot.documents;
    });
    //print(data);
  }

  Widget shopList() {
    getData();
    print(data);
    data.forEach((f) {
      print(f.data["Rating"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Text("Shoppy"),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.shopping_cart),
                ],
              ),
            ],
          ),
        ),
        drawer: DrawerMenu(widget.auth, widget.logoutCallback),
        body: shopList(),
      ),
    );
  }
}
