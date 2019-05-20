import 'package:flutter/material.dart';
import 'package:medical/src/models/location_list_model.dart';

class AttendanceLocation extends StatefulWidget {
  final LocationListModel locationList;

  AttendanceLocation({Key key, this.locationList}) : super(key: key);

  @override
  _AttendanceLocationState createState() {
    // TODO: implement createState
    return _AttendanceLocationState();
  }
}

class _AttendanceLocationState extends State<AttendanceLocation> {
  int currentLocation;

  @override
  void initState() {
    super.initState();
    currentLocation = null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(widget.locationList.map((element){
      return DropdownMenuItem(value: element.id, child: Text(element.name));
    }).toList());
    //return Container();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey[400], width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(4)),
      child: DropdownButtonHideUnderline(
        child: new DropdownButton(
          isExpanded: true,
          value: currentLocation,
          items: widget.locationList.map((element){
            return DropdownMenuItem(value: element.id, child: Text(element.name));
          }).toList(),
          onChanged: (int value){
            setState(() {
              currentLocation = value;
            });
          },
          style: new TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
        ),
      ),
    );
  }
}
