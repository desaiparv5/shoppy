import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Cart.dart';
import 'viewCartButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './ShopItem.dart';

class ShopDetails extends StatefulWidget {
  String shopId;
  ShopDetails(this.shopId);
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
        await databaseref.collection("Shops").document(widget.shopId).get();
    print("JO to: " + docSnapshot.toString());
    print("length" + docSnapshot.data["Products"].length.toString());
    return docSnapshot;
  }

  void set(name, quantity, price) {
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
      print("index:" + i.toString());
      pquantity[i] = quantity;
    }
  }

  void setData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList("ProductName", pname);
    pref.setStringList("ProductQuantity", pquantity);
    pref.setStringList("ProductPrice", pprice);

    /*print(pref.getStringList("ProductName").toString());
    print(pref.getStringList("ProductQuantity").toString());
    print(pref.getStringList("ProductPrice").toString());*/
  }

  void createList() {
    setData();
    Navigator.push(context, MaterialPageRoute(builder: (_) => Cart()));
//    print("Name list: " + pname.toString());
//    print("Quabt list: " + pquantity.toString());
//    print("Price list: " + pprice.toString());
  }

  @override
  void initState() {
    super.initState();
    demo().then((snapShot) {
      for (var i = 0; i < snapShot.data["Products"].length; i++) {
        array.add(shopItem(
            snapShot.data["Products"][i]["Name"],
            snapShot.data["Products"][i]["Price"].toString(),
            widget.shopId,
            set));
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
                          image: AssetImage("images/s1.png"),
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
