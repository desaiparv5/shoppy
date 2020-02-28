import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppy1/PlaceOrder.dart';

class payment extends StatefulWidget {
  int total;
  payment(this.total);
  @override
  paymentState createState() => paymentState();
}

class paymentState extends State<payment> {
  int curr = 1;
  String address_1 = "Address Line 1";
  String address_2 = "Address Line 2";
  int pincode = 388120;
  String shopId;
  String uid;
  String paymentType;
  List<String> pname, pquantity, pprice;

  final ref = Firestore.instance;

  void writeItems() {
    List<Map> productList = [];
    for (int i = 0; i < pname.length; i++) {
      productList.add({
        "ProductName": pname[i],
        "ProductPrice": pprice[i],
        "Quantity": pquantity[i]
      });
    }

    ref.collection("Orders").document().setData({
      "OrderTotal": widget.total,
      "PaymentType": "COD",
      "Products": productList,
      "ShopID": shopId,
      "Time": DateTime.now().toString(),
      "UserID": uid
    });
    Navigator.popUntil(
        context, ModalRoute.withName(Navigator.defaultRouteName));
  }

  Future getPrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    String uidh = await firebaseAuth.currentUser().then((val) {
      return val.uid;
    });
    setState(() {
      pname = pref.getStringList("ProductName") ?? [];
      pquantity = pref.getStringList("ProductQuantity") ?? [];
      pprice = pref.getStringList("ProductPrice") ?? [];
      shopId = pref.getString("ShopID");
      uid = uidh;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Text(
                      "Payment",
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text(
                              "Cash On Delivery",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Radio(
                              groupValue: curr,
                              onChanged: (int i) => setState(() => curr = i),
                              value: 1,
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
          SizedBox(height: 50.0),
          placeOrder(writeItems),
//              ],
//            ),
//          ),
          // SizedBox(height: 20.0,)
        ],
      ),
    );
  }
}
