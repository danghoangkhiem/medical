import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

Timer _debounceTimer;
Timer _throttleTimer;

void exitApp(BuildContext context) async {
  final bool accepted = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận'),
          content: Text('Bạn có chắc chắn muốn thoát khỏi ứng dụng?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('Thoát'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      });
  if (accepted is bool && accepted) {
    SystemNavigator.pop();
  }
}

void throttle(int milliseconds, Function callback) {
  if (_throttleTimer == null) {
    _throttleTimer = Timer(Duration(milliseconds: milliseconds), () {
      _throttleTimer = null;
    });
    callback();
  }
}

void debounce(int milliseconds, Function callback) {
  if (_debounceTimer?.isActive ?? false) {
    _debounceTimer.cancel();
  }
  _debounceTimer = Timer(Duration(milliseconds: milliseconds), callback);
}
