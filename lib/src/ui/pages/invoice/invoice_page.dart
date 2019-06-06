import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:medical/src/blocs/invoice/invoice.dart';

import 'package:medical/src/models/invoice_model.dart';

import 'package:medical/src/utils.dart';

import 'invoice_form.dart';
import 'invoice_detail_page.dart';

import 'package:medical/src/ui/widgets/loading_indicator.dart';

class InvoicePage extends StatefulWidget {
  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final ScrollController _controller = ScrollController();

  InvoiceListModel _invoiceList;
  InvoiceBloc _invoiceBloc;

  bool _isLoading = false;
  bool _isReachMax = false;

  @override
  void initState() {
    _invoiceList = InvoiceListModel.fromJson([]);
    _invoiceBloc = InvoiceBloc();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _invoiceBloc?.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_isReachMax) {
      return;
    }
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      throttle(200, () {
        if (_isLoading != true) {
          _isLoading = true;
          _invoiceBloc.dispatch(LoadMore());
        }
      });
    }
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
              flex: 3,
              child: InvoiceForm(invoiceBloc: _invoiceBloc),
            ),
            Expanded(
                flex: 6,
                child: BlocListener(
                  bloc: _invoiceBloc,
                  listener: (BuildContext context, InvoiceState state) {
                    if (state is NoRecordsFound) {
                      Scaffold.of(context).removeCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Không có dữ liệu được tìm thấy!'),
                      ));
                    }
                    if (state is ReachMax) {
                      Scaffold.of(context).removeCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Đã hiển thị tất cả dữ liệu!'),
                      ));
                      _isLoading = false;
                      _isReachMax = true;
                    }
                    if (state is Failure) {
                      Scaffold.of(context).removeCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(state.errorMessage),
                        backgroundColor: Colors.redAccent,
                      ));
                    }
                    if (state is Loaded) {
                      if (state.isLoadMore) {
                        _invoiceList.addAll(state.invoiceList);
                        _isLoading = false;
                      } else {
                        _invoiceList = state.invoiceList;
                        _isReachMax = false;
                      }
                    }
                  },
                  child: BlocBuilder(
                      bloc: _invoiceBloc,
                      builder: (BuildContext context, InvoiceState state) {
                        if (state is Loading && !state.isLoadMore) {
                          return LoadingIndicator();
                        }
                        return ListView.builder(
                          controller: _controller,
                          itemCount: _isLoading
                              ? _invoiceList.length + 1
                              : _invoiceList.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (_isLoading && index == _invoiceList.length) {
                              return SizedBox(
                                height: 50,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator()),
                              );
                            }
                            return _buildRow(_invoiceList[index]);
                          },
                        );
                      }),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildRow(InvoiceModel invoice) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: Colors.grey[200], style: BorderStyle.solid, width: 1)),
        color: Colors.white,
      ),
      height: 50,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => InvoiceDetailPage(
                      invoice: invoice)));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  DateFormat('dd-MM-yyyy hh:mm:ss').format(invoice.date),
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      ),
                ),
                Text(
                  _mapInvoiceStatusToName(invoice.status),
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Icon(
                  _mapInvoiceStatusToIconData(invoice.status),
                  color: _mapInvoiceStatusToColor(invoice.status),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _mapInvoiceStatusToName(InvoiceStatus status) {
    if (status == InvoiceStatus.approved) {
      return 'Nhận';
    }
    if (status == InvoiceStatus.pending) {
      return 'Chờ';
    }
    if (status == InvoiceStatus.denied) {
      return 'Từ chối';
    }
    return 'Không xác định';
  }

  IconData _mapInvoiceStatusToIconData(InvoiceStatus status) {
    if (status == InvoiceStatus.approved) {
      return Icons.check_circle;
    }
    if (status == InvoiceStatus.pending) {
      return Icons.new_releases;
    }
    if (status == InvoiceStatus.denied) {
      return Icons.cancel;
    }
    return Icons.warning;
  }

  Color _mapInvoiceStatusToColor(InvoiceStatus status) {
    if (status == InvoiceStatus.approved) {
      return Colors.green;
    }
    if (status == InvoiceStatus.pending) {
      return Colors.yellow;
    }
    if (status == InvoiceStatus.denied) {
      return Colors.red;
    }
    return Colors.redAccent;
  }
}
