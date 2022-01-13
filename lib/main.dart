import 'package:flutter/material.dart';
import 'package:rishanlogin/background.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:rishanlogin/signup.dart';

int count=0;
var a;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        splash:Icons.lock,
        duration: 3000,
        nextScreen: MyHomePage(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Color.fromARGB(255,189,231,229),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _passwordVisible = false;
  TextEditingController username= new TextEditingController();
  TextEditingController password= new TextEditingController();



  Future sendLoginData() async{
    print(count);
    String usernameLoginData= username.text;
    String passwordLoginData = password.text;

    var LoginData={
      "username" : usernameLoginData, "password" : passwordLoginData
    };
    var url = Uri.parse('http://192.168.29.52:8000/api/login');

    var response = await http.post(url,headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
    }, body: json.encode(LoginData));
    //print(LoginData);

    if(response.statusCode == 200) {
      var decoded = json.decode(response.body);
      print(decoded);

      a = (decoded['status']);

      // return(decoded['status']);
      count++;
    }

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Background(

        child: SingleChildScrollView(
        child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Text(
                  "LOGIN",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,color: Color(0xFF2661FA),
                  fontSize: 36
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
              decoration:InputDecoration(
                prefixIcon: Icon(Icons.account_circle_rounded),
                hintText: "Username",
                border:OutlineInputBorder(),

              ),
            ),


          ),
          //SizedBox(height: size.height * 0.001),
          Container(
            padding: EdgeInsets.all(20.0),
            width: MediaQuery.of(context).size.width,
            alignment:Alignment.centerLeft,
            child: TextFormField(
              obscureText: _passwordVisible,
              controller: password,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                hintText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment(0.92,1),
            margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 40.0),
            child: Text(
              "Forget your password ?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0XFF2661FA),

              ),

            ),
          ),

          Container(
            alignment: Alignment(0.8,0.1),
           // margin: EdgeInsets.symmetric(horizontal: 10,vertical: 30),

            child: RaisedButton(
              onPressed: (){
                sendLoginData();
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
                          Color.fromARGB(255, 255, 136, 34),
                          Color.fromARGB(255, 255, 177, 41)
                        ]
                    )
                ),
                child: Text(
                  "LOGIN",
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
            //alignment: Alignment.centerRight ,
            margin: EdgeInsets.fromLTRB(135.0, 10.0, 0.0, 10.0),

            child: GestureDetector(
              onTap: ()=>{
              Navigator.push(context, MaterialPageRoute(builder: (context) => signup())),
              },
              child: Text(
                "Dont Have an account? Sign Up",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blueAccent
                ),
              ),
            ),
          )


  ]
    )
    ),
        ),
    );
  }
}


