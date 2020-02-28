import 'package:flutter/material.dart';
import 'package:shoppy1/BaseAuth.dart';
import 'package:shoppy1/profile.dart';
import 'package:shoppy1/contactUs.dart';
import 'package:shoppy1/main.dart';
import 'package:shoppy1/recentOrder.dart';

class DrawerMenu extends StatefulWidget {
  BaseAuth auth;
  VoidCallback logoutCallback;
  DrawerMenu(this.auth, this.logoutCallback);
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blue[50],
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Shoppy',
                      style: TextStyle(
                          fontSize: 70,
                          color: Colors.white,
                          fontFamily: "Billabong"),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(180)),
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.account_circle),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              onTap: () {
                //Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => profile(widget.auth)));
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.history),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "History",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              onTap: () {
                //Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecentOrder(widget.auth)));
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.contacts),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Contact Us",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              onTap: () {
                //Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs()));
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.power_settings_new),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Sign out",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                widget.logoutCallback();
                widget.auth.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
