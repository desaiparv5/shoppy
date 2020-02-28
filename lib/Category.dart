import 'package:flutter/material.dart';
import 'package:shoppy1/homePage.dart';
import 'drawer.dart';
import './BaseAuth.dart';
import 'Cart.dart';

class Categories extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  Categories({this.auth, this.logoutCallback});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Text(
                  "Shoppy",
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontFamily: "Billabong"),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Cart()));
                    },
                    child: Icon(Icons.shopping_cart)),
              ],
            ),
          ],
        ),
        //backgroundColor: Colors.transparent,
      ),
      drawer: DrawerMenu(widget.auth, widget.logoutCallback),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  auth: widget.auth,
                                  logoutCallback: widget.logoutCallback,
                                  category: "Grocery",
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/g1.jpg"),
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.purple[500].withOpacity(0.7),
                            BlendMode.darken),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      child: Center(
                          child: Text(
                        "Grocery",
                        style: TextStyle(
                            fontSize: 60,
                            color: Colors.white,
                            fontFamily: "Billabong"),
                      )),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  auth: widget.auth,
                                  logoutCallback: widget.logoutCallback,
                                  category: "Super Market",
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/sm1.jpg"),
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.indigo.withOpacity(0.7), BlendMode.darken),
                      ),
                    ),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        "Super Market",
                        style: TextStyle(
                            fontSize: 60,
                            color: Colors.white,
                            fontFamily: "Billabong"),
                      )),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  auth: widget.auth,
                                  logoutCallback: widget.logoutCallback,
                                  category: "Electronics",
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/e1.jpg"),
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.green.withOpacity(0.7), BlendMode.darken),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      child: Center(
                          child: Text(
                        "Electronics",
                        style: TextStyle(
                            fontSize: 60,
                            color: Colors.white,
                            fontFamily: "Billabong"),
                      )),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  auth: widget.auth,
                                  logoutCallback: widget.logoutCallback,
                                  category: "Medical Store",
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/m1.jpg"),
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.red.withOpacity(0.7), BlendMode.darken),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      child: Center(
                          child: Text(
                        "Medical Store",
                        style: TextStyle(
                            fontSize: 60,
                            color: Colors.white,
                            fontFamily: "Billabong"),
                      )),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  auth: widget.auth,
                                  logoutCallback: widget.logoutCallback,
                                  category: "Other",
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/o2.jpg"),
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.brown[700].withOpacity(0.7),
                            BlendMode.darken),
                      ),
                    ),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        "Others",
                        style: TextStyle(
                            fontSize: 60,
                            color: Colors.white,
                            fontFamily: "Billabong"),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
