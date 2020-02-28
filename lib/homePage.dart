import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './BaseAuth.dart';
import "./shopcard.dart";
import './Cart.dart';
import './drawer.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String category;
  HomePage({this.auth, this.logoutCallback, this.category});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> array = [];
  List<int> priceArr = [];
  TextEditingController txt;
  bool flag = false;
  bool found = false;
  int delivery = 15;
  TextEditingController txtprod = TextEditingController();
  String pincode = "388120";
  final databaseRef = Firestore.instance;

  void setArr(price) {
    priceArr.add(price);
  }

  void sortKar() {
    if (priceArr.isEmpty) {
      return;
    }
    List<Widget> temp = [];
    int length = priceArr.length;
    for (int j = 0; j < length; j++) {
      int i = priceArr.indexOf(priceArr.reduce(min));
      priceArr.removeAt(i);
      temp.add(array[i]);
      array.removeAt(i);
    }
    setState(() {
      array = temp;
    });
  }

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
                      priceArr = [-3, -2, -1];
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
              found = false;
              priceArr = [-3, -2, -1];
              if (txtprod.text.isNotEmpty)
                flag = true;
              else
                flag = false;
              demo(txt.text);
            },
          ),
        )
      ],
    ));
    if (flag) {
      array.add(RaisedButton(
        child: Text("Sort by Price"),
        onPressed: () {
          sortKar();
        },
      ));
    }
    databaseRef
        .collection("Shops")
        .where("Pincode", isEqualTo: pin)
        .where("Category", isEqualTo: widget.category)
        //.orderBy("Rating", descending: true)
        .snapshots()
        .listen((data) {
      data.documents.forEach((doc) {
        if (flag) {
          List products = doc["Products"];
          if (products != null && products.toString().isNotEmpty) {
            for (var i = 0; i < products.length; i++) {
              if (products[i]["Name"]
                  .toString()
                  .toLowerCase()
                  .contains(txtprod.text.toLowerCase())) {
                found = true;
                priceArr.add(products[i]["Price"]);
                setState(() {
                  array.add(MyCard(
                    shopID: doc.documentID,
                    shopImage: doc["ShopImage"],
                    shopName: doc["Name"],
                    shopRating: doc["Rating"].toString(),
                    shopAddress: doc["Address"],
                    productSearch: txtprod.text,
                  ));
                });
              }
            }
          }
        } else {
          found = true;
          setState(() {
            array.add(MyCard(
              shopID: doc.documentID,
              shopImage: doc["ShopImage"],
              shopName: doc["Name"],
              shopRating: doc["Rating"].toString(),
              shopAddress: doc["Address"],
            ));
          });
        }
      });
      if (!found) {
        setState(() {
          array.add(Text("No shops sell this product"));
        });
      }
    });
  }

  void getpref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    //pref.clear();
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
                      child: Text("Shoppy",
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontFamily: "Billabong")),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Cart()));
                          },
                          child: Icon(Icons.shopping_cart)),
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
