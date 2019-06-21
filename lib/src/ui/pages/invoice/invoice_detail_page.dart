import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:medical/src/blocs/invoice_detail/invoice_detail.dart';
import 'package:medical/src/blocs/invoice/invoice.dart' as invoiceBloc;

import 'package:medical/src/models/event_type.dart';
import 'package:medical/src/models/invoice_item_model.dart';
import 'package:medical/src/models/invoice_model.dart';

import 'package:medical/src/ui/widgets/loading_indicator.dart';

class InvoiceDetailPage extends StatefulWidget {
  final InvoiceModel invoice;
  final invoiceBloc.InvoiceBloc invoiceBloc;

  InvoiceDetailPage({
    Key key,
    @required this.invoice,
    @required this.invoiceBloc,
  }) : super(key: key);

  @override
  _InvoiceDetailPageState createState() => _InvoiceDetailPageState();
}

class _InvoiceDetailPageState extends State<InvoiceDetailPage> {
  InvoiceDetailBloc _invoiceDetailBloc;

  InvoiceModel get _invoice => widget.invoice;
  invoiceBloc.InvoiceBloc get _invoiceBloc => widget.invoiceBloc;

  @override
  void initState() {
    _invoiceDetailBloc = InvoiceDetailBloc();
    super.initState();
  }

  @override
  void dispose() {
    _invoiceDetailBloc?.dispose();
    super.dispose();
  }

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
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${DateFormat('dd-MM-yyyy').format(_invoice.date)}'
                      ' / '
                      '${_mapInvoiceTypeToText(_invoice.type)}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.white,
                child: ListView(
                  children: <Widget>[
                    _buildRow(
                        title:
                            _mapEventTypeToName(EventType.pointOfSaleMaterials),
                        items: _invoice.items[EventType.pointOfSaleMaterials]),
                    _buildRow(
                        title: _mapEventTypeToName(EventType.gifts),
                        items: _invoice.items[EventType.gifts]),
                    _buildRow(
                        title: _mapEventTypeToName(EventType.samples),
                        items: _invoice.items[EventType.samples]),
                    _buildRow(
                        title: _mapEventTypeToName(EventType.purchases),
                        items: _invoice.items[EventType.purchases]),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${_invoice.type == InvoiceType.import ? 'Từ' : 'Đến'} '
                      '${_invoice.owner}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: BlocBuilder(
                bloc: _invoiceDetailBloc,
                builder: (BuildContext context, InvoiceDetailState state) {
                  if (state is Loading) {
                    return LoadingIndicator(opacity: 0);
                  }
                  if (state is Loaded) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Đã cập nhật thành công'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1),
                      ));
                    });
                    _invoiceBloc.dispatch(invoiceBloc.RefreshFilterResult());
                    return _buildControlPanel(state.invoiceStatus);
                  }
                  if (state is Failure) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(state.errorMessage.toString()),
                        backgroundColor: Colors.redAccent,
                      ));
                    });
                  }
                  return _buildControlPanel(_invoice.status);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow({String title, InvoiceItemListModel items}) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
          ),
          ListBody(
            children: items == null
                ? []
                : items.map((item) {
                    return Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: Colors.grey[200]))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            item.label.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            item.quantity.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildControlPanel(InvoiceStatus status) {
    if (status == InvoiceStatus.pending) {
      return Row(
        children: <Widget>[
          Expanded(child: _buildRedButton()),
          Expanded(child: _buildGreenButton())
        ],
      );
    }
    if (status == InvoiceStatus.approved) {
      return Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check,
              color: Colors.green,
            ),
            Text(' Đã nhận')
          ],
        ),
        alignment: Alignment.center,
      );
    }
    return Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.close, color: Colors.red),
          Text(' Đã từ chối')
        ],
      ),
      alignment: Alignment.center,
    );
  }

  Widget _buildGreenButton() {
    return Container(
      margin: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(4)),
      child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 13),
          onPressed: () {
            _invoiceDetailBloc.dispatch(ButtonPressed(
                invoiceId: _invoice.id, invoiceStatus: InvoiceStatus.approved));
          },
          child: Text(
            'Xác nhận',
            style: TextStyle(fontSize: 18, color: Colors.white),
          )),
    );
  }

  Widget _buildRedButton() {
    return Container(
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(4)),
      child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 13),
          onPressed: () {
            _invoiceDetailBloc.dispatch(ButtonPressed(
                invoiceId: _invoice.id, invoiceStatus: InvoiceStatus.denied));
          },
          child: Text(
            'Từ chối',
            style: TextStyle(fontSize: 18, color: Colors.white),
          )),
    );
  }

  String _mapInvoiceTypeToText(InvoiceType type) {
    if (type == InvoiceType.import) {
      return 'Nhập Hàng';
    }
    if (type == InvoiceType.export) {
      return 'Xuất Hàng';
    }
    return 'Không xác định';
  }

  String _mapEventTypeToName(EventType type) {
    if (type == EventType.pointOfSaleMaterials) {
      return 'POSM';
    }
    if (type == EventType.samples) {
      return 'SAMPLING';
    }
    if (type == EventType.gifts) {
      return 'GIFTS';
    }
    if (type == EventType.purchases) {
      return 'SALES';
    }
    return 'Không xác định';
  }
}
