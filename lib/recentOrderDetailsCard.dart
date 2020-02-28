import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RecentOrderDetailsCard extends StatefulWidget {
  DocumentSnapshot data;
  RecentOrderDetailsCard(this.data);
  @override
  _RecentOrderDetailsCardState createState() => _RecentOrderDetailsCardState();
}

class _RecentOrderDetailsCardState extends State<RecentOrderDetailsCard> {
  String item="";
  String qty="";
  String price="";
  List<Widget> array=[];
  Text textInput(String a)
  {
    if(a.length==1)
    {
      return Text("   $a");
    }
    else if(a.length==2)
      {
        return Text("  $a");
      }
    else if(a.length==3){
      return Text(" $a");
    }
    else{
      return Text("$a");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0;i<widget.data["Products"].length;i++) {
//      print("asdjgajhsd----------------------------" +
//          widget.data["Products"].length.toString());
      qty = widget.data["Products"][i]["Quantity"].toString();
      item = widget.data["Products"][i]["ProductName"];
      price = widget.data["Products"][i]["ProductPrice"].toString();
      array.add(Row(
        children: <Widget>[

          Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  //decoration: new BoxDecoration(color: Colors.red),
                  child: Text("$item"),
                ),


              ],
            ),
          ),

          new Column(
            children: <Widget>[
              new Container(
                //decoration: new BoxDecoration(color: Colors.green),
                child: textInput("$qty"),
              ),

            ],
          ),
          SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 20,
          ),
          new Column(
            children: <Widget>[
              new Container(
                //decoration: new BoxDecoration(color: Colors.green),
                child: textInput("$price"),
              ),

            ],
          )

        ],
      ));
      print("Quantity" + qty.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    //print("asdjgajhsd----------------------------"+widget.data["Products"].length.toString());

      return Column(
        children: array,
      );
    ;
  }
}
class recentcard extends StatefulWidget {
  @override
  _recentcardState createState() => _recentcardState();
}

class _recentcardState extends State<recentcard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: new BoxDecoration(color: Colors.grey),
      child: new Row(
        children: <Widget>[

          Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  //decoration: new BoxDecoration(color: Colors.red),
                  child: new Text("item 1"),
                ),


              ],
            ),
          ),

          new Column(
            children: <Widget>[
              new Container(
                //decoration: new BoxDecoration(color: Colors.green),
                child: new Text("item 2"),
              ),

            ],
          ),
          SizedBox(
            width: 20,
          ),
          new Column(
            children: <Widget>[
              new Container(
                //decoration: new BoxDecoration(color: Colors.green),
                child: new Text("item 5"),
              ),

            ],
          )

        ],
      ),
    );
  }
}




