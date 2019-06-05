import 'package:flutter/material.dart';

import 'package:medical/src/blocs/consumer/consumer.dart';

import 'package:medical/src/models/additional_field_model.dart';

class ConsumerStepThreeForm extends StatefulWidget {
  final ConsumerBloc consumerBloc;

  ConsumerStepThreeForm({Key key, @required this.consumerBloc})
      : assert(consumerBloc != null),
        assert(consumerBloc.additionalFields.samples != null),
        super(key: key);

  @override
  _ConsumerStepThreeFormState createState() => _ConsumerStepThreeFormState();
}

class _ConsumerStepThreeFormState extends State<ConsumerStepThreeForm> {
  ConsumerBloc get _consumerBloc => widget.consumerBloc;
  AdditionalFieldListModel _fields;
  AdditionalFieldListModel _cachedFields;

  @override
  void initState() {
    super.initState();
    _fields = AdditionalFieldListModel.fromJson(
        _consumerBloc.additionalFields.purchases.toJson());
    _cachedFields =
        _consumerBloc.currentState.consumer.additionalData.purchases;
    _fields.append(_cachedFields);
  }

  @override
  void dispose() {
    _consumerBloc.currentState.consumer.additionalData.purchases = _fields;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Thông tin mua hàng",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blueAccent),
          ),
          SizedBox(
            height: 15,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: _fields.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      _fields[index].label,
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onSaved: (String value) {
                        if (value.isEmpty) {
                          return;
                        }
                        _fields[index].value = int.parse(value);
                      },
                      initialValue: _fields[index]?.value?.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[350], width: 1)),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
