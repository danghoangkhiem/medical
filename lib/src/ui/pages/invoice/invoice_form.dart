import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:medical/src/blocs/invoice/invoice.dart';

class InvoiceForm extends StatefulWidget {
  final InvoiceBloc invoiceBloc;

  InvoiceForm({Key key, @required this.invoiceBloc}) : super(key: key);

  @override
  _InvoiceFormState createState() => _InvoiceFormState();
}

class _InvoiceFormState extends State<InvoiceForm> {
  DateTime _startDate;
  DateTime _endDate;
  DateTime _now;

  InvoiceBloc get _invoiceBloc => widget.invoiceBloc;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _startDate =
        _endDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(_now));
  }

  @override
  Widget build(BuildContext context) => Form(child: _buildContainer());

  Widget _buildContainer() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Text(
                "Từ ngày ",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              SizedBox(
                width: 30,
              ),
              Flexible(
                child: DateTimePickerFormField(
                  inputType: InputType.date,
                  format: DateFormat("dd-MM-yyyy"),
                  initialDate: _endDate ?? _now,
                  lastDate: _endDate ?? _now,
                  initialValue: _startDate,
                  editable: false,
                  decoration: InputDecoration(
                    labelText: 'Chọn ngày bắt đầu',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.grey),
                    hasFloatingPlaceholder: false,
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2)),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                  onChanged: (selectedDate) {
                    print('startDate: $selectedDate');
                    setState(() {
                      _startDate = selectedDate;
                    });
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Text(
                "Đến ngày ",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                child: DateTimePickerFormField(
                  inputType: InputType.date,
                  format: DateFormat("dd-MM-yyyy"),
                  initialDate: _startDate ?? _now,
                  firstDate: _startDate,
                  initialValue: _endDate,
                  lastDate: _now,
                  editable: false,
                  decoration: InputDecoration(
                    labelText: 'Chọn ngày kết thúc',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.grey),
                    hasFloatingPlaceholder: false,
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2)),
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                  onChanged: (selectedDate) {
                    setState(() {
                      _endDate = selectedDate;
                    });
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blueAccent,
            ),
            height: 42,
            child: FlatButton(
                onPressed: () {
                  _invoiceBloc.dispatch(
                      InvoiceFilter(startDate: _startDate, endDate: _endDate));
                },
                child: new Text(
                  "Tìm",
                  style: new TextStyle(fontSize: 18, color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
