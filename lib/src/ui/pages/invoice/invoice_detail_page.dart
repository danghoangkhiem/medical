import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:medical/src/blocs/invoice/invoice.dart';

import 'package:medical/src/models/invoice_model.dart';

class InvoiceDetailPage extends StatefulWidget {
  final InvoiceModel invoice;
  final InvoiceBloc invoiceBloc;

  InvoiceDetailPage(
      {Key key, @required this.invoice, @required this.invoiceBloc})
      : super(key: key);

  @override
  _InvoiceDetailPageState createState() => _InvoiceDetailPageState();
}

class _InvoiceDetailPageState extends State<InvoiceDetailPage> {
  InvoiceModel get _invoice => widget.invoice;
  InvoiceBloc get _invoiceBloc => widget.invoiceBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Phiếu xuất nhập hàng"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ngày '
                            '${DateFormat('dd-MM-yyyy').format(_invoice.date)}'
                            ' - '
                            '${_mapInvoiceTypeToText(_invoice.type)}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "POSM",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: ListView(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 80),
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1,
                                          color: Colors.grey[200]))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Túi giấy",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    "5",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 60,
                              padding: EdgeInsets.symmetric(horizontal: 80),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1,
                                          color: Colors.grey[200]))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Bút",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    "20",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 60,
                              padding: EdgeInsets.symmetric(horizontal: 80),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1,
                                          color: Colors.grey[200]))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Bút",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    "20",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 80),
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1,
                                          color: Colors.grey[200]))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Túi giấy",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    "5",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Text(
                                "GIFT",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    _invoice.type == InvoiceType.import
                                        ? 'Đến'
                                        : 'Từ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: _buildRedButton()),
                      Expanded(child: _buildGreenButton())
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Container _buildGreenButton() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(4)),
      child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 13),
          onPressed: () {
            _invoiceBloc.dispatch(GreenButtonPressed());
          },
          child: Text(
            "Xác nhận",
            style: TextStyle(fontSize: 18, color: Colors.white),
          )),
    );
  }

  Container _buildRedButton() {
    return Container(
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(4)),
      child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 13),
          onPressed: () {
            _invoiceBloc.dispatch(RedButtonPressed());
          },
          child: Text(
            "Từ chối",
            style: TextStyle(fontSize: 18, color: Colors.white),
          )),
    );
  }

  String _mapInvoiceTypeToText(InvoiceType type) {
    if (type == InvoiceType.import) {
      return 'Nhập';
    }
    if (type == InvoiceType.export) {
      return 'Xuất';
    }
    return 'Không xác định';
  }
}
