import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//check in bloc
import 'package:medical/src/blocs/check_in/check_in.dart';

//location bloc
import 'package:medical/src/blocs/location/localtion.dart';

import 'package:medical/src/ui/pages/attendance/attendance_history_page.dart';
import 'package:medical/src/models/check_in_model.dart';

class CheckInPage extends StatefulWidget {
  @override
  _CheckInPage createState() {
    return _CheckInPage();
  }
}

class _CheckInPage extends State<CheckInPage> {
  CheckInBloc _checkInBloc;
  LocationBloc _locationBloc;
  int currentLocation;
  List<File> _image = [];

  CheckInModel newCheckInModel;
  //maps
  GoogleMapController controller;

  LocationData _currentLocation;

  StreamSubscription<LocationData> _locationSubscription;

  Location _locationService = new Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _currentCameraPosition;

  GoogleMap googleMap;

  // map

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 800, maxHeight: 600);
    setState(() {
      if(image != null){
        _image.add(image);
      }
    });
  }

  @override
  void initState() {
    _checkInBloc = CheckInBloc();
    _locationBloc = LocationBloc();
    _locationBloc.dispatch(GetLocation());
    currentLocation = null;

    initPlatformState();
    super.initState();
  }

  @override
  void dispose(){
    _checkInBloc.dispose();
    _locationBloc.dispose();
    _locationSubscription.cancel();
    super.dispose();
  }

  initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      //print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        //print("Permission: $_permission");
        if (_permission) {

          _locationSubscription = _locationService
              .onLocationChanged()
              .listen((LocationData result) async {
            _currentCameraPosition = CameraPosition(
                target: LatLng(result.latitude, result.longitude), zoom: 16);

            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(
                CameraUpdate.newCameraPosition(_currentCameraPosition));

            if (mounted) {
              setState(() {
                _currentLocation = result;
              });
            }
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
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
              }),
        ],
        title: Text(
          "Chấm công",
          style: new TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder(
        bloc: _checkInBloc,
        builder: (BuildContext context, state) {
          return Container(
            child: new Column(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: new Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: new Text(
                            "Chọn địa điểm",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black54),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BlocBuilder(
                          bloc: _locationBloc,
                          builder: (BuildContext context, state) {
                            if (state is LocationLoading) {
                              return Container();
                            }
                            if (state is LocationLoaded) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey[400],
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: new DropdownButton(
                                    isExpanded: true,
                                    value: currentLocation,
                                    items: state.locationList.map((element) {
                                      return DropdownMenuItem(
                                          value: element.id,
                                          child: Text(element.name));
                                    }).toList(),
                                    onChanged: (int value) {
                                      setState(() {
                                        currentLocation = value;
                                      });
                                    },
                                    style: new TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: new Text(
                            "Vị trí hiện tại của bạn",
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 200,
                          color: Colors.grey,
                          child: GoogleMap(
                            mapType: MapType.normal,
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(10.7797855, 106.6990189),
                                zoom: 16.0),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          ),
                        ),
                        SizedBox(
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
                                    style:
                                        new TextStyle(color: Colors.blueAccent),
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
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: new GridView.extent(
                              maxCrossAxisExtent: 100,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              padding: EdgeInsets.all(5),
                              children: _image.map((item) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: FileImage(item),
                                        fit: BoxFit.cover),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: new Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: new FlatButton(
                      onPressed: () {
                        if(currentLocation == null){
                          showDialog(context: context, builder: (context){
                            return AlertDialog(title: Text("Thông báo"),content: Text("Bạn phải chọn địa điểm!"),actions: <Widget>[
                              FlatButton(onPressed: (){Navigator.pop(context);}, child: Text("OK"))
                            ],);
                          });
                          return;
                        }
                        if(_image.length == 0 || _image.length > 5){
                          showDialog(context: context, builder: (context){
                            return AlertDialog(title: Text("Thông báo"),content: Text("Bạn phải chụp hình và không quá 5 tấm hình!"),actions: <Widget>[
                              FlatButton(onPressed: (){Navigator.pop(context);}, child: Text("OK"))
                            ],);
                          });
                          return;
                        }
                        CheckInModel newCheckInModel = CheckInModel(
                            locationId: currentLocation, lat: _currentLocation.latitude, lon: _currentLocation.longitude, images: _image);
                        _checkInBloc.dispatch(AddCheckIn(newCheckInModel));
                      },
                      child: new Text(
                        "Check in",
                        style: new TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}








