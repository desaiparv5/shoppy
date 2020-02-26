import 'package:flutter/material.dart';

class bottomButton extends StatefulWidget {
  Function createList;
  bottomButton(this.createList);
  @override
  _bottomButtonState createState() => _bottomButtonState();
}

class _bottomButtonState extends State<bottomButton> {
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
              widget.createList();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Items"),
                      Text("Price"),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("View Cart"),
                    Icon(Icons.navigate_next)
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
