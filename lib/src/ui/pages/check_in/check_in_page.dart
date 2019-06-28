import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medical/src/ui/widgets/loading_indicator.dart';

//bloc
import 'package:medical/src/blocs/check_in/check_in.dart';
import 'package:medical/src/blocs/authentication/authentication.dart';
import 'package:medical/src/blocs/synchronization/synchronization.dart';

//model
import 'package:medical/src/models/attendance_model.dart';
import 'package:medical/src/models/location_list_model.dart';
import 'package:medical/src/models/check_in_model.dart';
import 'package:medical/src/models/check_out_model.dart';

//page
import 'package:medical/src/ui/pages/attendance/attendance_history_page.dart';

class CheckInPage extends StatefulWidget {
  @override
  _CheckInPage createState() {
    return _CheckInPage();
  }
}

class _CheckInPage extends State<CheckInPage> {
  bool _isCheckInPressed = false;
  bool _isCheckOutPressed = false;

  var location = new Location();

  Map<String, double> userLocation;

  CheckInBloc _checkInBloc;
  int currentLocation;
  List<File> _image = [];

  CheckInModel newCheckInModel;

  //maps
  LocationData _currentLocation;

  //GoogleMapController controller;

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
      if (image != null) {
        _image.add(image);
      }
    });
  }

  SynchronizationBloc _synchronizationBloc;

  @override
  void initState() {
    currentLocation = null;
    initPlatformState();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _synchronizationBloc = BlocProvider.of<SynchronizationBloc>(context);
    _checkInBloc = CheckInBloc(synchronizationBloc: _synchronizationBloc);
    _checkInBloc.dispatch(CheckIO());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _checkInBloc.dispose();
    _locationSubscription.cancel();
    super.dispose();
  }

  Future<Map<String, double>> _getLocation() async {
    var currentLocation = <String, double>{};
    LocationData current;
    try {
      current = await location.getLocation();
      currentLocation["latitude"] = current.latitude;
      currentLocation["longitude"] = current.longitude;
    } catch (e) {
      currentLocation["latitude"] = null;
      currentLocation["longitude"] = null;
    }
    return currentLocation;
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
            try {
              controller.animateCamera(
                  CameraUpdate.newCameraPosition(_currentCameraPosition));
            } catch (_) {}


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
                    builder: (BuildContext context) => AttendanceHistoryPage(),
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
        builder: (BuildContext context, CheckInState state) {
          if (state is CheckIOLoading) {
            return LoadingIndicator();
          }
          if (state is CheckIOFailure || state is CheckInFailure || state is CheckOutFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_){
              AuthenticationBloc auth = BlocProvider.of<AuthenticationBloc>(context);
              auth.dispatch(AuthenticationEvent.loggedOut());
            });
            return notificationError();
          }
          if (state is CheckIOLoaded && state.isCheckIn == false) {
            return checkIn(state.locationList);
          }
          if (state is CheckIOLoaded && state.isCheckIn == true) {
            return checkOut(state.attendanceModel);
          }
          if (state is CheckInLoading) {
            return LoadingIndicator(
              opacity: 0,
            );
          }
          if (state is Synchronizing) {
            return Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 15),
                    Text('Đang đồng bộ dữ liệu máy chủ'),
                  ],
                ),
              ),
            );
          }
          if (state is Synchronized) {
            return Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.cloud_done),
                    SizedBox(height: 15),
                    Text('Đang đồng bộ dữ liệu máy chủ'),
                  ],
                ),
              ),
            );
          }
          if (state is CheckInError) {
            setState(() {
              _isCheckInPressed = false;
            });
            _locationSubscription?.cancel();
            return checkInNotificationError();
          }
          if (state is CheckInLoaded) {
            _locationSubscription?.cancel();
            return checkInNotification();
          }
          if (state is CheckOutLoading) {
            return LoadingIndicator(
              opacity: 0,
            );
          }
          if (state is CheckOutError) {
            setState(() {
              _isCheckOutPressed = false;
            });
            _locationSubscription?.cancel();
            return checkOutNotification();
          }
          if (state is CheckOutLoaded) {
            _locationSubscription?.cancel();
            return checkOutNotification();
          }
          _locationSubscription?.cancel();
          return Container();
        },
      ),
    );
  }

  Widget inputLocation(LocationListModel locationList) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.grey[400], width: 1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: new DropdownButton(
          isExpanded: true,
          value: currentLocation,
          items: locationList.map((element) {
            return DropdownMenuItem(
                value: element.id, child: Text(element.name));
          }).toList(),
          onChanged: (int value) {
            setState(() {
              currentLocation = value;
            });
          },
          style: new TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }

  Widget checkIn(LocationListModel locationList) {
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
                          fontSize: 16,
                          color: Colors.black54),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  inputLocation(locationList),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: new Text(
                      "Vị trí hiện tại của bạn",
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
                          target: LatLng(10.7797855, 106.6990189), zoom: 16.0),
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
                              fontSize: 16,
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
                                  image: FileImage(item), fit: BoxFit.cover),
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
          Material(
            elevation: 15,
            child: new Container(
              height: 65,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4)),
                    child: new FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        onPressed: () async {
                          if (currentLocation == null) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Thông báo"),
                                    content: Text("Bạn phải chọn địa điểm!"),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("OK"))
                                    ],
                                  );
                                });
                            return;
                          }
                          if (_image.length == 0 || _image.length > 5) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Thông báo"),
                                    content: Text(
                                        "Bạn phải chụp hình và không quá 5 tấm hình!"),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("OK"))
                                    ],
                                  );
                                });
                            return;
                          }
                          setState(() {
                            _isCheckInPressed = true;
                          });
                          userLocation = await _getLocation();
                          if (userLocation['latitude'] == null || userLocation["longitude"] == null) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Thông báo"),
                                    content: Text(
                                        "Có lỗi trong việc xác định vị trí, vui lòng thử lại!"),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => CheckInPage()));
                                          },
                                          child: Text("OK"))
                                    ],
                                  );
                                });
                            setState(() {
                              _isCheckInPressed = false;
                            });
                            return;
                          }
                          CheckInModel newCheckInModel = CheckInModel(
                              locationId: currentLocation,
                              lat: userLocation["latitude"],
                              lon: userLocation["longitude"],
                              images: _image);
                          _checkInBloc.dispatch(AddCheckIn(newCheckInModel));
                        },
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _isCheckInPressed
                                ? new SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  )
                                : SizedBox(),
                            new Container(
                              margin: EdgeInsets.only(left: 10),
                              child: new Text(
                                "Chấm công vào",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            )
                          ],
                        )),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget checkOut(AttendanceModel attendanceModel) {
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
                          fontSize: 16,
                          color: Colors.black54),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  new Container(
                    height: 40,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey[400],
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(4)),
                            child: new Text(
                              attendanceModel.location.name,
                              style: new TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: new Text(
                      "Vị trí hiện tại của bạn",
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
                          target: LatLng(10.7797855, 106.6990189), zoom: 16.0),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Material(
            elevation: 15,
            child: new Container(
              height: 65,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(4)),
                      child: new FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        onPressed: () async {
                          setState(() {
                            _isCheckOutPressed = true;
                          });

                          userLocation = await _getLocation();
                          if (userLocation['latitude'] == null || userLocation["longitude"] == null) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Thông báo"),
                                    content: Text(
                                        "Có lỗi trong việc xác định vị trí, vui lòng thử lại!"),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => CheckInPage()));
                                          },
                                          child: Text("OK"))
                                    ],
                                  );
                                });
                            setState(() {
                              _isCheckOutPressed = false;
                            });
                            return;
                          }

                          CheckOutModel newCheckOut = CheckOutModel(
                              latitude: userLocation['latitude'],
                              longitude: userLocation['longitude']);
                          _checkInBloc.dispatch(AddCheckOut(newCheckOut));
                        },
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _isCheckOutPressed
                                ? new SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  )
                                : SizedBox(),
                            new Container(
                              margin: EdgeInsets.only(left: 10),
                              child: new Text(
                                "Chấm công ra",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget notificationError() {
    return Container(
        child: AlertDialog(
          title: Text("Thông báo"),
          content: Text("Có lỗi xảy ra, vui lòng đăng nhập lại!"),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"))
          ],
        ));
  }

  Widget checkInNotificationError() {
    return Container(
        child: AlertDialog(
      title: Text("Thông báo"),
      content: Text("Check In thất bại! Vui lòng thử lại"),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => CheckInPage()));
            },
            child: Text("OK"))
      ],
    ));
  }

  Widget checkInNotification() {
    return Container(
        child: AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 50,
          ),
          SizedBox(
            height: 10,
          ),
          Text("Đã chấm công vào!")
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => CheckInPage()));
            },
            child: Text("OK"))
      ],
    ));
  }

  Widget checkOutNotification() {
    return Container(
        child: AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 50,
          ),
          SizedBox(
            height: 10,
          ),
          Text("Đã chấm công ra!")
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => CheckInPage()));
            },
            child: Text("OK"))
      ],
    ));
  }
}
