import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppy1/shopDetail.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyCard extends StatefulWidget {
  String shopName, shopImage, shopRating, shopID, shopAddress;
  String txtProd;
  MyCard(
      {this.shopName,
      this.shopImage,
      this.shopRating,
      this.shopID,
      this.shopAddress});
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

  Widget show() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShopDetails(
                        widget.shopID,
                        widget.shopName,
                        widget.shopImage,
                        widget.shopAddress)));
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
