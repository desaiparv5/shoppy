import 'package:flutter/material.dart';
import 'package:shoppy1/BaseAuth.dart';
import 'package:shoppy1/Root.dart';
import 'package:shoppy1/main.dart';

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
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Shoppy',
              style: TextStyle(fontSize: 30),
            ),
            decoration: BoxDecoration(
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
              Navigator.pop(context);
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
              Navigator.pop(context);
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
              Navigator.pop(context);
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
    );
  }
}
