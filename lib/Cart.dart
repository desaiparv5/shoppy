import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppy1/payment.dart';
import './CartItem.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<String> pname = [], pquantity = [], pprice = [];
  int total = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs().then((val) {
      int tot = 0;
      for (int i = 0; i < pquantity.length; i++) {
        tot = tot + int.parse(pquantity[i]) * int.parse(pprice[i]);
      }
      setState(() {
        total = tot;
      });
    });
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
    int tot = 0;
    for (int i = 0; i < pquantity.length; i++) {
      tot = tot + int.parse(pquantity[i]) * int.parse(pprice[i]);
    }
    setState(() {
      total = tot;
    });
  }

  Future<bool> cartPopped() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString("ShopID"));
    pref.setStringList("ProductName", pname);
    pref.setStringList("ProductQuantity", pquantity);
    pref.setStringList("ProductPrice", pprice);
    return new Future.value(true);
  }

  Future getPrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pname = pref.getStringList("ProductName") ?? [];
      pquantity = pref.getStringList("ProductQuantity") ?? [];
      pprice = pref.getStringList("ProductPrice") ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: cartPopped,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Shoppy"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Card(
              elevation: 10,
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Items:",
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
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
                      flex: 5,
                      child: ListView.builder(
                        itemCount: pname.length,
                        itemBuilder: (_, index) {
                          return (CartItem(pname[index], pprice[index],
                              pquantity[index], set));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                      width: double.infinity,
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Total : $total",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8, left: 8, right: 8),
                              child: Text(
                                "Delivery Charges:   15",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: RaisedButton(
                              elevation: 10,
                              child: Row(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Checkout",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          "Total: " + (total + 15).toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => payment(total + 15)));
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
