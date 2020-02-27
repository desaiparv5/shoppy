import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './CartItem.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<String> pname = [], pquantity = [], pprice = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
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
      print("index:" + i.toString());
      pquantity[i] = quantity;
    }
  }

  Future<bool> cartPopped() async {
    print("back gayu");
    print(pname);
    print(pprice);
    print(pquantity);
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setStringList("ProductName", pname);
    pref.setStringList("ProductQuantity", pquantity);
    pref.setStringList("ProductPrice", pprice);
    return new Future.value(true);
  }

  void getPrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pname = pref.getStringList("ProductName");
      pquantity = pref.getStringList("ProductQuantity");
      pprice = pref.getStringList("ProductPrice");
    });
  }

  @override
  Widget build(BuildContext context) {
    print(pname);
    print(pprice);
    print(pquantity);
    return WillPopScope(
      onWillPop: cartPopped,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Shoppy"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Your Cart",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 0,
                  width: double.infinity,
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Items",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 2,
                                width: 50,
                                child: Divider(
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Price",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 2,
                              width: 50,
                              child: Divider(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: ListView.builder(
                    itemCount: pname.length,
                    itemBuilder: (_, index) {
                      return (CartItem(
                          pname[index], pprice[index], pquantity[index], set));
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text("Checkout"),
                        onPressed: () {},
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
