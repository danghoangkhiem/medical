import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueAccent,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Image.asset('assets/images/logo.png', width: 200),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                )),
            Expanded(
                flex: 7,
                child: Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                )
            ),
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    'Version: 1.1',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ))
          ],
        ),

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
