import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './BaseAuth.dart';
import "./shopcard.dart";
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
  Future demo() async {
    QuerySnapshot querySnapshot =
        await databaseRef.collection("Shops").getDocuments();
    return querySnapshot.documents;
  }

  void getpref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    getpref();
    super.initState();
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
          body: FutureBuilder(
            future: demo(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading..."),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return MyCard(snapshot.data[index]);
                  },
                );
              }
            },
          )),
    );
  }
}
