import 'package:flutter/material.dart';
import 'package:shoppy1/BaseAuth.dart';
import 'recentOrderCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class RecentOrder extends StatefulWidget {
  BaseAuth auth;
  RecentOrder(this.auth);
  @override
  _RecentOrderState createState() => _RecentOrderState();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final databaseReference = Firestore.instance;
}

class _RecentOrderState extends State<RecentOrder> {
  QuerySnapshot querySnapshot;
  final databaseRef = Firestore.instance;
  List<Widget> array=[];
  FirebaseUser user;
   Future<List<DocumentSnapshot>> demo()  async{

      user = await widget.auth.getCurrentUser().then((onValue) async{
       querySnapshot =  await databaseRef.collection("Orders").getDocuments().then((onValue){
         return onValue;
       });
       return onValue;

     });

    return querySnapshot.documents;
    //QuerySnapshot querySnapshot =
    //await databaseRef.collection("Orders").getDocuments();
    //print("qs"+querySnapshot.toString());
    //return querySnapshot.documents;
  }
  /*QuerySnapshot querySnapshot =
      await databaseRef.collection("Orders").where("UserID",isEqualTo: onValue.uid).getDocuments().then((onValue){
  return onValue;
  });*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    demo().then((onValue)
    {
      onValue.forEach((f){
          if(user.uid.compareTo(f.data["UserID"].toString())==0){
            print("User: "+user.uid);
            print("DB: "+f.data["UserID"]);
            setState(() {
              array.add(RecentOrderCard(f));
            });
          }
      });
//      setState(() {
//        onValue.forEach((f){
//          //print(f.data["OrderTotal"].toString());
//          array.add(RecentOrderCard(f));
//        });
//      });
    }
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recent Orders"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Text("Your Orders",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  height: 0,
                  width: 350,
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
              ),
              //RecentOrderCard(5,100),

              Expanded(
                child: Container(
                  child: FutureBuilder(
                    future: demo(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Text("Loading..."),
                        );
                      } return ListView(
                          children:array,
                        );
                      //return Text("Error fetching data"+snapshot.connectionState.toString());
                    },
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

