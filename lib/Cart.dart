import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<String> pname = [], pquantity = [], pprice = [];
  void getShared() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pname = pref.getStringList("ProductName");
      pquantity = pref.getStringList("ProductQuantity");
      pprice = pref.getStringList("ProductPrice");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getShared();
    print(pname);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: pname.length,
        itemBuilder: (_, index) {
          return Text(pname[index]);
        },
      ),
    );
  }
}
