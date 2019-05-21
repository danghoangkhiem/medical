import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/src/blocs/check_in/check_in.dart';
import 'package:medical/src/ui/pages/attendance/attendance_location.dart';
import 'package:medical/src/ui/pages/attendance/attendance_history_page.dart';
import 'package:medical/src/ui/widgets/loading_indicator.dart';
import 'package:medical/src/ui/pages/attendance/attendance_coordinate.dart';
import 'package:medical/src/models/coordinate_model.dart';

import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() {
    return _AttendancePageState();
  }
}

class _AttendancePageState extends State<AttendancePage> {
  CheckInBloc _checkInBloc;

  List<File> _image = [];

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 100, maxHeight: 100);
    print(image.readAsBytesSync().length);
    setState(() {
      _image.add(image);
    });
  }

  Widget _ListImage(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
            image: FileImage(_image[index]), fit: BoxFit.cover),
      ),
    );
  }

  @override
  void initState() {
    _checkInBloc = CheckInBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            new IconButton(
                icon: Icon(Icons.history),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AttendanceHistoryPage(),
                    ),
                  );
                })
          ],
          title: Text(
            "Chấm công",
            style: new TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder(
            bloc: _checkInBloc,
            builder: (BuildContext context, state) {
              if (state is CheckInLocationLoading) {
                return LoadingIndicator();
              }
              if (state is CheckInLocationLoaded) {
                return buildContainer(state.locationList, state.coordinate);
              }
              return Container();
            }));
  }

  Container buildContainer(List locations, CoordinateModel coordinate) {
    return new Container(
      child: new Column(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: new Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new SizedBox(
                    height: 20,
                  ),
                  new Container(
                    child: new Text(
                      "Chọn địa điểm",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black54),
                    ),
                  ),
                  new SizedBox(
                    height: 10,
                  ),
                  AttendanceLocation(locationList: locations),
                  new SizedBox(
                    height: 20,
                  ),
                  new Container(
                    child: new Text(
                      "Vị trí hiện tại của bạn",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black54),
                    ),
                  ),
                  new SizedBox(
                    height: 10,
                  ),
                  AttendanceCoordinate(coordinate: coordinate),
                  new SizedBox(
                    height: 20,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Container(
                        child: new Text(
                          "Hình ảnh check in",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black54),
                        ),
                      ),
                      InkWell(
                        onTap: getImage,
                        child: new Row(
                          children: <Widget>[
                            new Text(
                              "Chụp hình",
                              style: new TextStyle(color: Colors.blueAccent),
                            ),
                            new Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: new Icon(
                                Icons.camera_alt,
                                color: Colors.blueAccent,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  new SizedBox(
                    height: 10,
                  ),
                  new Expanded(
                      child: Container(
                    color: Colors.white,
                    child: new GridView.extent(
                      maxCrossAxisExtent: 100,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      padding: EdgeInsets.all(5),
                      children: _image.map((item){
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(image: FileImage(item),fit: BoxFit.cover)

                          )
                        );
                      }).toList(),
                  
                    
                    )
                      )
                  )
                ],
              ),
            ),
          ),
          new Expanded(
              flex: 1,
              child: new Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: new FlatButton(
                    onPressed: () {},
                    child: new Text(
                      "Check in",
                      style: new TextStyle(fontSize: 18, color: Colors.white),
                    )),
              ))
        ],
      ),
    );
  }
}



