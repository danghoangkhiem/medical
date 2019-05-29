import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: new Center(
        child: new Image.asset("assets/images/logo.png", width: 200,),
      ),
    );
  }
}

//Stack(
//children: <Widget>[
//Align(
//alignment: Alignment.center,
//child: CircularProgressIndicator(),
//),
//ModalBarrier(
//dismissible: false,
//color: Colors.black.withOpacity(0.3),
//),
//],
//)
