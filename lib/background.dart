import 'package:flutter/material.dart';
class Background extends StatefulWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
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
            top: 30,
            right: -180,
            child: Image.asset(
                "images/backgroundimage.png",
                width: 600,
                height: 250,
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