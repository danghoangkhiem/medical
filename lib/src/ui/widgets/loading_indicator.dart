import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final Color progressIndicatorColor;
  final double opacity;
  final bool willPop;

  LoadingIndicator({
    this.opacity = 0.3,
    this.progressIndicatorColor = Colors.white,
    this.willPop = true
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return willPop;
        },
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                  backgroundColor: this.progressIndicatorColor),
            ),
            ModalBarrier(
              dismissible: false,
              color: Colors.black.withOpacity(opacity),
            ),
          ],
        ));
  }
}
