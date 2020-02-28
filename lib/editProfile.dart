import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EditProfile extends StatefulWidget {
  DocumentSnapshot doc;


  EditProfile(this.doc);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name;
  TextEditingController add;
  TextEditingController pin;
  TextEditingController add2;
  updateData()
  {
    Firestore.instance
        .collection('Users')
        .document(widget.doc.documentID)
        .updateData({
          'Name': name.text,
          'Address': add.text,
          'Pincode': pin.text
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    add2=TextEditingController(text:widget.doc.data["Address"] );
    add=TextEditingController(text:widget.doc.data["Address"] );
    name=TextEditingController(text:widget.doc.data["Name"] );
    pin=TextEditingController(text:widget.doc.data["Pincode"] );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50)
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: name,
                      //initialValue: "Name",
                      decoration: InputDecoration(
                          labelText: widget.doc.data["Name"],

                          icon: Icon((Icons.contact_phone)),
                          hintText: String.fromEnvironment("Name")

                      ),
                    ),
                    TextFormField(
                      controller: pin,
                      //initialValue: "Pincode",
                      decoration: InputDecoration(
                          labelText: widget.doc.data["Pincode"],
                          icon: Icon((Icons.contact_phone)),
                          hintText: String.fromEnvironment("Name")

                      ),
                    ),
                    TextFormField(
                      controller: add,
                      //initialValue: "Address",
                      decoration: InputDecoration(
                          labelText: widget.doc.data["Address"],
                          icon: Icon((Icons.place)),
                          hintText: String.fromEnvironment("Name")

                      ),
                    ),TextFormField(
                      controller: add2,

                      //initialValue: "Address",
                      decoration: InputDecoration(
                          labelText: widget.doc.data["Address"],
                          icon: Icon((Icons.place)),
                          hintText: String.fromEnvironment("Name")

                      ),
                    ),
                    GestureDetector(
                      onTap: updateData,
                      child: Card(
                        elevation: 10,
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),

                        child: ListTile(

                          title: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontSize: 18,

                              ),
                            ),
                          ),
                        ),
                        color: Colors.white,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
