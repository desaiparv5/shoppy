import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './BaseAuth.dart';
import "./shopcard.dart";
import 'package:keyboard_avoider/keyboard_avoider.dart';
import './drawer.dart';

class HomePage1 extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback logoutCallback;

  HomePage1({this.auth, this.logoutCallback});

  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  List<Widget> array = [];
  TextEditingController txt;
  TextEditingController txtprod = TextEditingController();
  String pincode = "389230";
  final databaseRef = Firestore.instance;

  Future demo(String pin) async {
    array = [];
    array.add(Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Container(
            child: TextField(
              decoration: InputDecoration(labelText: "Pincode"),
              controller: txt,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: FlatButton(
            child: Icon(Icons.search),
            onPressed: txt.text.isEmpty
                ? () {
                    Fluttertoast.showToast(
                        msg: "Please Enter pincode",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 16.0);
                  }
                : () {
                    setState(() {
                      demo(txt.text);
                    });
                  },
          ),
        )
      ],
    ));
    array.add(Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Container(
            child: TextField(
              decoration: InputDecoration(labelText: "Search Products"),
              controller: txtprod,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: FlatButton(
            child: Icon(Icons.search),
            onPressed: () {
              demo(txt.text);
            },
          ),
        )
      ],
    ));
    databaseRef
        .collection("Shops")
        .where("Pincode", isEqualTo: pin)
        .snapshots()
        .listen((data) {
      data.documents.forEach((doc) {
        setState(() {
          //array.add(MyCard(doc, txtprod.text,);
        });
      });
    });

    ///return querySnapshot.documents;
  }

  void getpref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      txt = TextEditingController(text: pincode);
    });
    demo(txt.text);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: false,
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
            body: SingleChildScrollView(
                child: Column(
              children: array,
            ))));
  }
}
