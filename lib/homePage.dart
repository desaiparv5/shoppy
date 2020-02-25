import 'package:flutter/material.dart';
import './BaseAuth.dart';
import './ShopDetails.dart';
import './drawer.dart';

class HomePage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  HomePage({this.auth, this.logoutCallback});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget shopList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ShopDetails()),
          );
        },
        child: Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.green[900],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.red,
              style: BorderStyle.solid,
            ),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage(
                    "images/s1.png",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Text("Shoppy"),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.shopping_cart),
                ],
              ),
            ],
          ),
        ),
        drawer: DrawerMenu(widget.auth, widget.logoutCallback),
        body: shopList(),
      ),
    );
  }
}
