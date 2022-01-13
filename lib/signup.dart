import 'package:flutter/material.dart';
import 'package:rishanlogin/background.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'backgroundsignup.dart';
import 'package:rishanlogin/main.dart';

class signup extends StatefulWidget {

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController username=new TextEditingController();
  TextEditingController password=new TextEditingController();
  TextEditingController phonenumber=new TextEditingController();
  bool visible=false;


  Future sendData() async {
    // Showing CircularProgressIndicator using State.

    setState(() {
      visible = true ;
    });
    // Getting value from Controller
    String usernameData = username.text;
    String passwordData = password.text;
    String phonenumberData = phonenumber.text;




    var data = {
      'username': usernameData,
      'password': passwordData,
      'phonenumber': phonenumberData,
    };

    // Starting Web Call with data.
    var response = await http.post(Uri.parse('http://192.168.29.52:8000/api/signup'),headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
    }, body: json.encode(data));
    //var response = await http.post(Uri.parse('http://127.0.0.1:8000/api/signup'), body: json.encode(data));


    var decoded;
    // Getting Server response into variable.
    Map<String, dynamic> message = new Map<String, dynamic>.from(json.decode(response.body));
    //var message = jsonDecode(response.body);
    if(response.statusCode == 200){
      setState(() {
        var decoded = json.decode(response.body);
        //print(decoded['status']);
        visible = false;
      });
    }
    print(message);
    print(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BackgroundSign(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                    color: Color(0xFF2661FA),
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                  textAlign: TextAlign.left,


                ),
              ),
              SizedBox(height: size.height * 0.06),
              Container(
                padding: EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                child: TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.account_circle),
                  )
                ),

              ),
              Container(

                padding: EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                child: TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                child: TextFormField(
                  controller: phonenumber,
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.add_call),
                  ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  onPressed: (){
                    sendData();
                    
                  },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0),
                    child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.5,
                    decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: new LinearGradient(
                    colors: [
                    Color.fromARGB(255, 73, 73,255),
                    Color.fromARGB(255, 191, 191,255),
                    ]
                    )
                    ),
                    child: Text(
                    "SIGN UP",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    ),
                ),
              ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 135.0, 10.0),
                child: GestureDetector(
                  onTap: ()=>{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage())),
                  },
                  child: Text(
                    "Already Have An Account !",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blueAccent
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
