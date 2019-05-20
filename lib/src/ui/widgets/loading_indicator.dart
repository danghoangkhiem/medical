import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final Color progressIndicatorColor;
  final double opacity;

  LoadingIndicator(
      {this.opacity = 0.8, this.progressIndicatorColor = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            backgroundColor: this.progressIndicatorColor
          ),
        ),
        ModalBarrier(
          dismissible: false,
          color: Colors.black.withOpacity(opacity),
        ),
      ],
    );
  }
}
