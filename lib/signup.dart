import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp();

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  static final formKey = GlobalKey<FormState>();

  static final controller = TextEditingController();

  final name = TextFormField(
    style: TextStyle(fontFamily: "Hero"),
    autofocus: false,
    decoration: InputDecoration(
        hintText: "Name",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(Icons.account_box)),
    validator: (val) {
      if (val.isEmpty)
        return "Please enter name";
      else
        return null;
    },
  );

  final phone = TextFormField(
    style: TextStyle(fontFamily: "Hero"),
    autofocus: false,
    decoration: InputDecoration(
        hintText: "Phone Number",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(Icons.phone)),
    validator: (val) {
      if (val.isEmpty)
        return "Please enter name";
      else
        return null;
    },
  );

  final email = TextFormField(
    style: TextStyle(fontFamily: 'Hero'),
    keyboardType: TextInputType.emailAddress,
    autofocus: false,
    decoration: InputDecoration(
      hintText: 'Email',
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      prefixIcon: Icon(Icons.email),
    ),
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
  );

  final password = TextFormField(
    style: TextStyle(fontFamily: 'Hero'),
    autofocus: false,
    obscureText: true,
    decoration: InputDecoration(
      hintText: 'Password',
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      prefixIcon: Icon(Icons.lock),
    ),
    validator: (val) => val.isEmpty ? "Password Required" : null,
  );

  final loginButton = Padding(
    padding: EdgeInsets.symmetric(vertical: 16.0),
    child: RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {
        if (formKey.currentState.validate()) {
          print("success");
        }
      },
      padding: EdgeInsets.all(12),
      color: Colors.blue,
      child: Text('Sign Up',
          style: TextStyle(color: Colors.white, fontFamily: 'Hero')),
    ),
  );

  final addressl1 = TextFormField(
    maxLines: null,
    controller: controller,
    keyboardType: TextInputType.multiline,
    style: TextStyle(fontFamily: 'Hero'),
    autofocus: false,
    decoration: InputDecoration(
      hintText: 'Address Line 1',
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      prefixIcon: Icon(Icons.add_location),
    ),
    validator: (val) => val.isEmpty ? "Address Required" : null,
  );
  final addressl2 = TextFormField(
    maxLines: null,
    keyboardType: TextInputType.multiline,
    style: TextStyle(fontFamily: 'Hero'),
    autofocus: false,
    decoration: InputDecoration(
      hintText: 'Address Line 2',
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      prefixIcon: Icon(Icons.add_location),
    ),
    validator: (val) => val.isEmpty ? "Address Required" : null,
  );

  final pincode = TextFormField(
    style: TextStyle(fontFamily: 'Hero'),
    keyboardType: TextInputType.number,
    autofocus: false,
    decoration: InputDecoration(
      hintText: 'Pincode',
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      prefixIcon: Icon(Icons.add_location),
    ),
    validator: (val) {
      if (val.isEmpty)
        return "Pincode Required";
      else if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(val)) {
        return "Invalid Pincode ";
      } else
        return null;
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 48.0),
            Text(
              "Sign Up",
              style: TextStyle(
                  fontFamily: "Hero",
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: Colors.blue),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 48.0),
            name,
            SizedBox(height: 8.0),
            phone,
            SizedBox(height: 8.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 8.0),
            addressl1,
            SizedBox(height: 8.0),
            addressl2,
            SizedBox(height: 8.0),
            pincode,
            //SizedBox(height: 24.0),
            loginButton,
          ],
        ),
      ),
    );
  }
}
