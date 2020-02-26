import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  Future<DocumentSnapshot> demo() async {
    DocumentSnapshot docSnapshot =
        await databaseref.collection("Shops").document(widget.shopId).get();
    print("JO to: " + docSnapshot.toString());
    print("length" + docSnapshot.data["Products"].length.toString());
    return docSnapshot;
  }

  void add(snapShot, i) {
    setState(() {
      array.add(shopItem(snapShot.data["Products"][i]["Name"],
          snapShot.data["Products"][i]["Price"].toString()));
    });
  }

  @override
  void initState() {
    super.initState();
    demo().then((snapShot) {
      for (var i = 0; i < snapShot.data["Products"].length; i++) {
        array.add(shopItem(snapShot.data["Products"][i]["Name"],
            snapShot.data["Products"][i]["Price"].toString()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: demo(),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading...");
                        } else {
                          return Column(
                            children: array,
                          );
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
    );
  }
}

class shopItem extends StatefulWidget {
  String name, price;
  shopItem(this.name, this.price);
  @override
  _shopItemState createState() => _shopItemState();
}

class _shopItemState extends State<shopItem> {
//  String product_name = widget.name;
//  int price = int.parse(widget.price);
  int counter = 1;
  int c = 0;
  Widget add_button() {
    if (c == 0) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "Add",
            style: TextStyle(fontSize: 15),
          ),
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: Container(
              height: 30,
              width: 30,
              child: Icon(Icons.remove),
              color: Colors.black12,
            ),
            onTap: () {
              setState(() {
                decrement();
              });
            },
          ),
          Container(
            height: 30,
            width: 30,
            child: Center(
                child: Text(
              "$counter",
              style: TextStyle(fontSize: 20),
            )),
            color: Colors.black12,
          ),
          GestureDetector(
            child: Container(
              height: 30,
              width: 30,
              child: Icon(Icons.add),
              color: Colors.black12,
            ),
            onTap: () {
              setState(() {
                increment();
              });
            },
          ),
        ],
      );
    }
  }

  void decrement() {
    if (counter != 1) {
      counter = counter - 1;
    } else {
      c = 0;
    }
  }

  void increment() {
    counter = counter + 1;
  }

  void increment_c() {
    c = c + 1;
    print(c);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 100,
        child: Row(
          children: <Widget>[
            Image(
              image: AssetImage("images/s1.png"),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.price,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    increment_c();
                  });
                },
                child: add_button(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
