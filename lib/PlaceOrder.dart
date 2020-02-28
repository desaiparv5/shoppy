import 'package:flutter/material.dart';

//import './ratings.dart';
class placeOrder extends StatefulWidget {
  int total;
  Function write;
  placeOrder(this.write);
  @override
  _placeOrderState createState() => _placeOrderState();
}

class _placeOrderState extends State<placeOrder> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        color: Colors.transparent,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {
              widget.write();
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Ratings()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
//                Expanded(
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Text("Items"),
//
//                      Text("Price"),
//                    ],
//                  ),
//                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("Place Your Order"),
                    Icon(
                      Icons.navigate_next,
                    ),
                  ],
                ),
              ],
            ),
            elevation: 10,
          ),
        ),
      ),
    );
  }
}
