import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './Category.dart';
import 'package:shoppy1/login.dart';
import './homePage.dart';
import 'BaseAuth.dart';
import './homePage1.dart';

class Root extends StatefulWidget {
  BaseAuth auth;
  Root({this.auth});
  @override
  _RootState createState() => _RootState();
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _RootState extends State<Root> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String uid = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          uid = user?.uid;
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void setLogin() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        uid = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void setLogout() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      uid = "";
    });
  }

  Widget showLoading() {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return showLoading();
        break;

      case AuthStatus.NOT_LOGGED_IN:
        return Login(widget.auth, setLogin, setLogout);
        break;
      case AuthStatus.LOGGED_IN:
        if (uid.length > 0 && uid != null) {
          return Categories(
            auth: widget.auth,
            logoutCallback: setLogout,
          );
          /*HomePage(
            auth: widget.auth,
            logoutCallback: setLogout,

          );*/
        } else {
          return showLoading();
        }
        break;
      default:
        return showLoading();
    }
  }
}
