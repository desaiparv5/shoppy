import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'recentOrderDetailsCard.dart';

class RecentOrderDetail extends StatefulWidget {
  DocumentSnapshot data;
  RecentOrderDetail(this.data);

  @override
  _RecentOrderDetailState createState() => _RecentOrderDetailState();
}

class _RecentOrderDetailState extends State<RecentOrderDetail> {
  int total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                "" + widget.data["ShopID"],
                                style: TextStyle(fontSize: 25),
                              ),
                              Text(
                                "Address",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 30,
                                width: 350,
                                child: Divider(
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                          //decoration: new BoxDecoration(color: Colors.red),
                                          child: new Text("Item"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  new Column(
                                    children: <Widget>[
                                      new Container(
                                        //decoration: new BoxDecoration(color: Colors.green),
                                        child: new Text("Quantity"),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  new Column(
                                    children: <Widget>[
                                      new Container(
                                        //decoration: new BoxDecoration(color: Colors.green),
                                        child: new Text("Price"),
                                      ),
                                    ],
                                  )
                                ],
                              ),

                              RecentOrderDetailsCard(widget.data),
                              //recentcard(),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                                width: 350,
                                child: Divider(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "Total: " +
                                    widget.data["OrderTotal"].toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
