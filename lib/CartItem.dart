import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  @override
  String pname, pprice, pquantity;
  Function set;
  CartItem(this.pname, this.pprice, this.pquantity, this.set);
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int counter = 0;
  static int price;
  String item_name = "";

  Widget add_button() {
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

  void decrement() {
    counter = counter - 1;
    widget.set(item_name, counter.toString(), price);
  }

  void increment() {
    counter = counter + 1;
    widget.set(item_name, counter.toString(), price);
  }

  String countPrice() {
    return (int.parse(widget.pprice) * counter).toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      counter = int.parse(widget.pquantity);
      item_name = widget.pname;
      price = int.parse(widget.pprice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (counter <= 0)
        ? Container()
        : Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("$item_name"),
                add_button(),
                Text((countPrice())),
              ],
            ),
          );
  }
}
