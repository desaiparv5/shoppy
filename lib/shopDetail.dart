import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppy1/BaseAuth.dart';
import 'package:shoppy1/Cart.dart';
import 'package:shoppy1/homePage.dart';
import 'viewCartButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

import './ShopItem.dart';

class ShopDetails extends StatefulWidget {
  String shopName, shopImage, shopID, shopAddress, priorityProduct;
  ShopDetails(
      {this.shopID,
      this.shopName,
      this.shopImage,
      this.shopAddress,
      this.priorityProduct});
  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  List<Widget> array = [];
  final databaseref = Firestore.instance;
  String shop_name = "";
  String address = "";
  List<String> pname = [], pquantity = [], pprice = [];

  Future<DocumentSnapshot> demo() async {
    DocumentSnapshot docSnapshot =
        await databaseref.collection("Shops").document(widget.shopID).get();
    return docSnapshot;
  }

  void set(name, quantity, price) {
    if (quantity == 0) {
      int i = pname.indexOf(name);
      pname.removeAt(i);
      pquantity.removeAt(i);
      pprice.removeAt(i);
      return;
    }
    if (pname.isEmpty) {
      pname.add(name);
      pquantity.add(quantity);
      pprice.add(price);
    } else if (pname.indexOf(name) == -1) {
      pname.add(name);
      pquantity.add(quantity);
      pprice.add(price);
    } else {
      int i = pname.indexOf(name);
      pquantity[i] = quantity;
    }
  }

  void setData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList("ProductName", pname);
    pref.setStringList("ProductQuantity", pquantity);
    pref.setStringList("ProductPrice", pprice);
    if (pquantity.length > 0) {
      pref.setString("ShopID", widget.shopID.toString());
    }
  }

  void createList() {
    setData();
    Navigator.push(context, MaterialPageRoute(builder: (_) => Cart()));
  }

  @override
  void initState() {
    super.initState();
    shop_name = widget.shopName;
    address = widget.shopAddress;
    //showPrefs();
    demo().then((snapShot) {
      for (var i = 0; i < snapShot.data["Products"].length; i++) {
        if (widget.priorityProduct == null) {
          array.add(shopItem(
              snapShot.data["Products"][i]["Name"],
              snapShot.data["Products"][i]["ProductImage"],
              snapShot.data["Products"][i]["Price"].toString(),
              widget.shopID,
              set));
        } else {
          if (snapShot.data["Products"][i]["Name"]
              .toString()
              .toLowerCase()
              .contains(widget.priorityProduct.toLowerCase())) {
            array.insert(
                0,
                shopItem(
                    snapShot.data["Products"][i]["Name"],
                    snapShot.data["Products"][i]["ProductImage"],
                    snapShot.data["Products"][i]["Price"].toString(),
                    widget.shopID,
                    set));
          } else {
            array.add(shopItem(
                snapShot.data["Products"][i]["Name"],
                snapShot.data["Products"][i]["ProductImage"],
                snapShot.data["Products"][i]["Price"].toString(),
                widget.shopID,
                set));
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          RaisedButton(
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            color: Colors.transparent,
            onPressed: createList,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.7), BlendMode.darken),
                          image: CachedNetworkImageProvider(widget.shopImage),
                          fit: BoxFit.cover)),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "$shop_name",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "$address",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: double.infinity,
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: demo(),
                      builder: (_, snapshot) {
//                        if (snapshot.connectionState ==
//                            ConnectionState.waiting) {
//                          return Text("Loading...");
//                        } else {
//                          return Column(
//                            children: array,
//                          );
//                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading...");
                        } else if (snapshot.hasData) {
                          return Column(
                            children: array,
                          );
                        } else {
                          return Text("Error fetching data");
                        }
                      },
                    ), //shopItem(),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
      bottomNavigationBar: bottomButton(createList),
    );
  }
}
