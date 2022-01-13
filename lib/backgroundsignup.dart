import 'package:flutter/material.dart';
class BackgroundSign extends StatefulWidget {
  final Widget child;

  const BackgroundSign({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<BackgroundSign> createState() => _BackgroundSignState();
}

class _BackgroundSignState extends State<BackgroundSign> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: size.height,

            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 10,
                  right: -150,
                  child: Image.asset(
                    "images/backgroundimage2.png",
                    width: 500,
                    height: 300,
                  ),
                ),
                widget.child
              ],
            ),
          ),
        ),
      ),
    );
  }
}