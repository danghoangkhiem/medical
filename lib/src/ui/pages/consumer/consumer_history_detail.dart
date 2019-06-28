import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'package:medical/src/models/consumer_model.dart';
import 'package:medical/src/models/additional_field_model.dart';

class ConsumerHistoryDetail extends StatelessWidget {
  final ConsumerListModel history;

  ConsumerHistoryDetail({Key key, this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Lịch sử",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.blueAccent),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildHistoryList(),
        )
      ],
    );
  }

  List<Widget> _generateList(AdditionalFieldListModel items) {
    if (items == null || items.length == 0) {
      return [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Text('Không có sản phẩm'),
        ),
      ];
    }
    return items
        .map(
          (item) => Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(item.label.toString()),
                    Text(item.value.toString()),
                  ],
                ),
              ),
        )
        .toList();
  }

  List<Widget> _buildHistoryList() {
    int index = 1;
    if (history.length == 0) {
      return [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          child: Text('Không có lịch sử'),
        )
      ];
    }
    return history.map((consumer) {
      bool hasSampled = consumer.additionalData.samples.any((item) =>
          item.value != null && int.tryParse(item.value.toString()) > 0);
      return Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Text(
            "Lần ${index++} - ${DateFormat('dd/MM/y').format(consumer.createdAt)}",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          SizedBox(
            height: 17,
          ),
          StickyHeader(
            header: Container(
              height: 40.0,
              color: Colors.deepOrangeAccent,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Sampling',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            content: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              height: 40,
              color: Colors.grey[200],
              child: Row(
                children: <Widget>[
                  Text(
                    hasSampled ? "Đã nhận" : "Chưa nhận",
                  )
                ],
              ),
            ),
          ),
          StickyHeader(
            header: Container(
              height: 40.0,
              color: Colors.deepOrangeAccent,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Mua hàng',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            content: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              color: Colors.grey[200],
              child: Column(
                children: _generateList(consumer.additionalData.purchases),
              ),
            ),
          ),
          StickyHeader(
            header: Container(
              height: 40.0,
              color: Colors.deepOrangeAccent,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'Quà tặng',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            content: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              color: Colors.grey[200],
              child: Column(
                children: _generateList(consumer.additionalData.gifts),
              ),
            ),
          ),
          StickyHeader(
            header: Container(
              height: 40.0,
              color: Colors.deepOrangeAccent,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                'POSM',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            content: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              color: Colors.grey[200],
              child: Column(
                children:
                    _generateList(consumer.additionalData.pointOfSaleMaterials),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}
