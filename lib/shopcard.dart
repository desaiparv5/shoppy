import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppy1/BaseAuth.dart';
import 'package:shoppy1/shopDetail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCard extends StatefulWidget {
  String shopName, shopImage, shopRating, shopID, shopAddress, productSearch;
  BaseAuth auth;
  MyCard(
      {this.shopName,
      this.shopImage,
      this.shopRating,
      this.shopID,
      this.shopAddress,
      this.auth,
      this.productSearch});
  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  String status = "Open";
  final store = Firestore.instance;

//  Widget search() {
//    bool isThere = true;
//    List products = widget.data["Products"];
////    print(widget.data["Name"] + " " + products[0]["Name"]);
//    if (products != null && products.toString().isNotEmpty) {
//      for (var i = 0; i < products.length; i++) {
//        if (products[i]["Name"]
//            .toString()
//            .toLowerCase()
//            .contains(widget.txtProd.toLowerCase())) {
//          setState(() {
//            widget.setArray(products[i]["Price"]);
//          });
//          return show();
//        }
//      }
//    }
//    return Container();
//  }

  void CartKhalikaro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ShopDetails(
                shopImage: widget.shopImage,
                shopAddress: widget.shopAddress,
                shopName: widget.shopName,
                shopID: widget.shopID,
                priorityProduct: widget.productSearch)));
    //Navigator.of(context, rootNavigator: true).pop('dialog');
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text("Proceed will clear the cart"),
              content: Row(
                children: <Widget>[
                  FlatButton(
                    child: Text("Go Back"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text("Proceed"),
                    onPressed: () {
                      Navigator.pop(context);
                      CartKhalikaro();
                    },
                  )
                ],
              ),
            ));
  }

  void showPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ShopId = prefs.getString("ShopID") ?? "0";
    print("Pref ma" + ShopId);
    print("Card ma" + widget.shopID);
    if (ShopId.compareTo("0") != 0) {
      if (ShopId.compareTo(widget.shopID) != 0) {
        showAlert(context);
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShopDetails(
                    shopID: widget.shopID,
                    shopName: widget.shopName,
                    shopAddress: widget.shopAddress,
                    shopImage: widget.shopImage,
                    priorityProduct: widget.productSearch)));
      }
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShopDetails(
                  shopID: widget.shopID,
                  shopName: widget.shopName,
                  shopAddress: widget.shopAddress,
                  shopImage: widget.shopImage,
                  priorityProduct: widget.productSearch)));
    }
    print(ShopId);
    print("Widget" + widget.shopID);
  }

  Widget show() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: GestureDetector(
          onTap: () {
            showPrefs();
          },
          child: Card(
            elevation: 10,
            child: Row(
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  child: CachedNetworkImage(
                    imageUrl: widget.shopImage.toString(),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    //height: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            widget.shopName.toString(),
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
                                "Rating: " + widget.shopRating.toString(),
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

  @override
  void initState() {
    // TODO: implement initState
//    getShopData();
//    shop_name = widget.data["Name"];
//    shopImage = widget.data["ShopImage"];
//    ratings = widget.data["Rating"].toString();
  }

  @override
  Widget build(BuildContext context) {
    //products = widget.data["Products"];
    //print(products);
    return show();
  }
}
