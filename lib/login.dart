import 'package:flutter/material.dart';
import 'package:shoppy1/signup.dart';
import 'BaseAuth.dart';

class Login extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback loginCallback;
  final VoidCallback logoutCallback;

  Login(this.auth, this.loginCallback, this.logoutCallback);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  String email, password;

  Future<void> login() async {
    String uid = "";
    try {
      uid = await widget.auth.signIn(email, password);
      if (uid.length > 0 && uid != null) widget.loginCallback();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: ListView(
        children: <Widget>[
          //SizedBox(height: 30.0),
          Center(
            child: Text(
              'Login',
              style: TextStyle(fontSize: 40, color: Colors.green),
            ),
          ),
          SizedBox(height: 40.0),
          Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.vertical()),
                        hintText: 'Email'),
                    validator: (val) {
                      if (val.isEmpty)
                        return "Email Required";
                      else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val)) {
                        return "Invalid Email";
                      } else
                        return null;
                    },
                    onSaved: (val) {
                      email = val.trim();
                    },
                  ),
                  SizedBox(height: 30.0),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.vertical()),
                        hintText: 'Password'),
                    validator: (val) {
                      if (val.isEmpty)
                        return "Password Required";
                      else
                        return null;
                    },
                    onSaved: (val) {
                      password = val.trim();
                    },
                  ),
                ],
                //SizedBox(height: 30.0),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Center(
            child: RaisedButton(
              onPressed: () {
                if (formkey.currentState.validate()) {
                  formkey.currentState.save();
                  login();
                }
              },
              child: Text('Submit'),
            ),
          ),
          SizedBox(height: 10.0),
          Center(
            child: FlatButton(
              onPressed: () {},
              child: Text('Forgot Password?'),
            ),
          ),
          Center(
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignUp(widget.auth,
                            widget.loginCallback, widget.logoutCallback)));
              },
              child: Text("Don't Have an Account? Sign Up"),
            ),
          )
        ],
      ),
    );
  }
}
