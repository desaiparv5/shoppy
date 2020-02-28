import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  //TextEditingController subject,body;
  TextEditingController subject = TextEditingController();
  TextEditingController body = TextEditingController();
  String dropdownValue = 'none';
  mailQuery() async
  {
    //print();
    final Email email = Email(
      body: body.text,
      subject: subject.text,
      recipients: ['mitchoudhary15@gmail.com'],

      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Contact Us"),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Container(
                  width: double.infinity,
                  child:TextFormField(

                    controller: subject,

                    autofocus: true,


                    decoration: InputDecoration(
                      hintText: "What is your problem about?"
                        //labelText: "Enter Problem"
                    ),

                    /*child: DropdownButton<String>(
                    hint: Text("Select Something"),
                    value: dropdownValue,
                    icon: Icon(Icons.keyboard_arrow_down),

                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple,fontSize: 20),

                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['none','Product not Received ', 'Damaged product Received', 'Late Delivery',"Different Product Received"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  */),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: TextFormField(
              controller: body,
              maxLines: 5,
              autofocus: false,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: "Enter Your Complaint..."
              ),
            ),
          ),
          SizedBox(
            height: 20,
    ),
          Card(
            elevation: 10,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 60),

            child: ListTile(
            onTap: mailQuery,
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
        ],
      ),
    );
  }
}
