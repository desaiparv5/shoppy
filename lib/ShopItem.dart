import 'package:flutter/material.dart';

class shopItem extends StatefulWidget {
  String name, price, shopId;
  Function set;
  shopItem(this.name, this.price, this.shopId, this.set);
  @override
  _shopItemState createState() => _shopItemState();
}

class _shopItemState extends State<shopItem> {
  String pro_name = "";
  int counter = 1;
  int c = 0;
  Map getData() {
    print("Counter ni value: " + counter.toString());
    Map data = {
      "Name": widget.name,
      "Quantity": counter,
      "Price": widget.price,
    };
  }

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
      counter = 0;
      c = 0;
    }
    widget.set(widget.name, counter.toString(), widget.price);
  }

//  void storeIncrement(counter) async {
//    final prefs = await SharedPreferences.getInstance();
//    prefs.setString("ShopId", widget.shopId);
//    print(prefs.getString("ShopId"));
//  }

  void increment() {
    counter = counter + 1;
    widget.set(widget.name, counter.toString(), widget.price);
//    storeIncrement(counter);
  }

  void increment_c() {
    counter = 1;
    widget.set(widget.name, counter.toString(), widget.price);
    c = c + 1;
//    print(c);
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
                        "₹" + widget.price,
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
