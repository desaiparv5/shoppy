import 'package:flutter/material.dart';
import 'editProfile.dart';
import 'package:shoppy1/BaseAuth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class profile extends StatefulWidget {
  BaseAuth auth;
  profile(this.auth);
  @override
  _profileState createState() => _profileState();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final databaseReference = Firestore.instance;
}

class _profileState extends State<profile> {
  String name="";
  String curr_user="";
  String mobile_number="";
  String email="";
  bool userFound=false;
  DocumentSnapshot doc;
  final databaseRef = Firestore.instance;

  FirebaseUser user;
  Future<List<DocumentSnapshot>> demo()  async{

    // ignore: missing_return
    user = await widget.auth.getCurrentUser().then((onValue) async{
      // ignore: missing_return
      curr_user = onValue.uid;
      //print("--------------------------------------------------------------"+curr_user);
      doc =  await databaseRef.collection("Users").document(curr_user).get().then((onValue){
        return onValue;
      });
      print(onValue.email);
      if(doc.data!=null)
        {
          //print("Found");
          name=doc.data["Name"];
          email=onValue.email;
          mobile_number=doc.data["Mobile"];
          setState(() {

          });
        }
      else
        {
          print("does not");
        }

      //print(name);
      //print(onValue.uid);

      //print()
      //return onValue;
    });



    //return querySnapshot;
    //QuerySnapshot querySnapshot =
    //await databaseRef.collection("Orders").getDocuments();
    //print("qs"+querySnapshot.toString());
    //return querySnapshot.documents;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    demo();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            Center(
//              child: CircleAvatar(
//                radius: 50,
//                backgroundImage: AssetImage('images/2.png'),
//              ),
//
//            ),

            Text(
              "$name",
              style: TextStyle(
                fontSize: 40,

                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',

              ),

            ),
            SizedBox(
              height: 10,
            ),


            Card(

              child: ListTile(
                leading: Icon(
                  Icons.call,
                  color: Colors.teal,
                ),
                title: Text(
                  "$mobile_number",
                  style: TextStyle(
                    fontSize: 18,

                  ),
                ),

              ),
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),

              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.teal,
                ),
                title: Text(
                  "$email",
                  style: TextStyle(
                    fontSize: 18,

                  ),
                ),
              ),
              color: Colors.white,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile(doc)));
              },
              child: Card(
                elevation: 30,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),

                child: ListTile(
                  leading: Icon(
                    Icons.perm_identity,
                    color: Colors.teal,
                  ),
                  title: Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 18,

                    ),
                  ),
                ),
                color: Colors.white,
              ),
            ),
          ],

        ),
      ),

    );
  }
}
