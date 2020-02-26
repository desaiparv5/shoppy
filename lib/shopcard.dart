import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppy1/shopDetail.dart';

class MyCard extends StatefulWidget {
  DocumentSnapshot data;
  MyCard(this.data);
  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  String shop_name = "";
  String ratings = "";
  String status = "Open";
  String ShopID = "";

  @override
  Widget build(BuildContext context) {
    shop_name = widget.data["Name"];
    ratings = widget.data["Rating"].toString();
    ShopID = widget.data.documentID;
    print(ShopID);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ShopDetails(ShopID)));
          },
          child: Card(
            elevation: 10,
            child: Row(
              children: <Widget>[
                Image(
                  image: AssetImage(
                    "images/s1.png",
                  ),
                  height: 100,
                ),
                Container(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "$shop_name",
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star_border,
                              size: 20,
                            ),
                            Text(
                              "Rating: $ratings",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Arial',
                              ),
                            ),
                          ],
                        ),
                        Text("$status"),
                      ],
                    ),
                  ),
                )
//            Container(
//                child: Column(
//                  children: <Widget>[
//                    Text("Hello"),
//                  ],
//                ),
//              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
