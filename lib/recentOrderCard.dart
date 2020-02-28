import 'package:flutter/material.dart';
import 'package:shoppy1/recentOrder.dart';
import 'recentOrderDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecentOrderCard extends StatefulWidget {
  int items, total;
  DocumentSnapshot data;
  //RecentOrderCard(this.items,this.total);
//  DocumentSnapshot data;
  RecentOrderCard(this.data);
  @override
  _RecentOrderCardState createState() => _RecentOrderCardState();
}

class _RecentOrderCardState extends State<RecentOrderCard> {
//  int item=2;
//  int total = 100;

  dispData() {
    //print("Data in ROC:" + widget.data["OrderTotal"]);
  }

  @override
  Widget build(BuildContext context) {
    dispData();

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Container(
        height: 184,
        width: double.infinity,
        //color: Colors.blue,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "" + widget.data["ShopID"],
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 0,
                  width: double.infinity,
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Container(
                                    child: Text(
                              "Items",
                              style: TextStyle(fontSize: 20),
                            ))),
                            Text(
                              "" + widget.data["Products"].length.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Container(
                                    child: Text(
                              "Total",
                              style: TextStyle(fontSize: 20),
                            ))),
                            Text(
                              "₹ " + widget.data["OrderTotal"].toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RecentOrderDetail(widget.data)));
                      },
                      child: Text(
                        "View Details",
                        style: TextStyle(fontSize: 20),
                      ),
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      )),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
