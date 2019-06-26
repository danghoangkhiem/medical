import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'package:medical/src/blocs/consumer/consumer.dart';

import 'consumer_search_form.dart';
import 'consumer_contact_form.dart';

class ConsumerStepOneForm extends StatelessWidget {
  final ConsumerBloc _consumerBloc;

  ConsumerStepOneForm({Key key, @required ConsumerBloc consumerBloc})
      : assert(consumerBloc != null),
        _consumerBloc = consumerBloc,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Thông tin khách hàng",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blueAccent),
          ),
          SizedBox(
            height: 15,
          ),
          ConsumerSearchForm(
            consumerBloc: _consumerBloc,
          ),
          ConsumerContactForm(
            consumerBloc: _consumerBloc,
          ),
          new SizedBox(
            height: 25,
          ),
          new Text("Lịch sử", style: new TextStyle(fontWeight:FontWeight.bold ,fontSize: 20, color: Colors.blueAccent),),
          new SizedBox(
            height: 17,
          ),
          new Column(
            children: <Widget>[
              new Text("Lần 1", textAlign: TextAlign.left, style: new TextStyle(fontWeight:FontWeight.bold ,fontSize: 16, color: Colors.black54,),),
              new SizedBox(
                height: 17,
              ),
              StickyHeader(
                header: new Container(
                  height: 40.0,
                  color: Colors.blueAccent,
                  padding: new EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: new Text('Sampling',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                content: new Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  height: 40,
                  color: Colors.grey[200],
                  child: new Row(
                    children: <Widget>[
                      new Text("Đã nhận",)
                    ],
                  ),
                ),
              ),
              StickyHeader(
                header: new Container(
                  height: 40.0,
                  color: Colors.blueAccent,
                  padding: new EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: new Text('Thông tin mua hàng',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                content: new Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        height: 40,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text("Tên sản phẩm"),
                            new Text("2")
                          ],
                        ),
                      ),
                      new Container(
                        height: 40,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text("Tên sản phẩm"),
                            new Text("1")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              StickyHeader(
                header: new Container(
                  height: 40.0,
                  color: Colors.blueAccent,
                  padding: new EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: new Text('Gift',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                content: new Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        height: 40,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text("Tên sản phẩm"),
                            new Text("2")
                          ],
                        ),
                      ),
                      new Container(
                        height: 40,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text("Tên sản phẩm"),
                            new Text("1")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              StickyHeader(
                header: new Container(
                  height: 40.0,
                  color: Colors.blueAccent,
                  padding: new EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: new Text('POSM',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                content: new Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        height: 40,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text("Tên sản phẩm"),
                            new Text("2")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
