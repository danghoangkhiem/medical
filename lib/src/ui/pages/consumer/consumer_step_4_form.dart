import 'package:flutter/material.dart';

import 'package:medical/src/blocs/consumer/consumer.dart';

import 'package:medical/src/models/additional_field_model.dart';

class ConsumerStepFourForm extends StatefulWidget {
  final ConsumerBloc consumerBloc;

  ConsumerStepFourForm({Key key, @required this.consumerBloc})
      : assert(consumerBloc != null),
        assert(consumerBloc.additionalFields.samples != null),
        super(key: key);

  @override
  _ConsumerStepFourFormState createState() => _ConsumerStepFourFormState();
}

class _ConsumerStepFourFormState extends State<ConsumerStepFourForm> {
  ConsumerBloc get _consumerBloc => widget.consumerBloc;
  AdditionalFieldListModel _fields;
  AdditionalFieldListModel _cachedFields;

  @override
  void initState() {
    super.initState();
    _fields = AdditionalFieldListModel.fromJson(
        _consumerBloc.additionalFields.gifts.toJson());
    _cachedFields = _consumerBloc.currentState.consumer.additionalData.gifts;
    _fields.append(_cachedFields);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Thông tin quà tặng",
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
                        _fields[index].value = int.tryParse(value);
                        _consumerBloc.currentState.consumer.additionalData
                            .gifts = _fields;
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
