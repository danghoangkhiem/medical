import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() {
    return _AttendancePageState();
  }
}

class _AttendancePageState extends State<AttendancePage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  List _address = ["Bệnh viện 115", "Bệnh viện Gia Định"];
  List<DropdownMenuItem<String>> _dropDownAddress;
  String _currentAddress;

  @override
  void initState() {
//salary
    _dropDownAddress = getDropDownSalary();
    _currentAddress = _dropDownAddress[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownSalary() {
    List<DropdownMenuItem<String>> items = new List();
    for (String address in _address) {
      items.add(new DropdownMenuItem(value: address, child: new Text(address)));
    }
    return items;
  }

  void changedDropDownSalary(String selectedSalary) {
    setState(() {
      _currentAddress = selectedSalary;
    });
  }

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          "Chấm công",
          style: new TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: new Container(
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
                    new Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey[400],
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(4)),
                      child: DropdownButtonHideUnderline(
                        child: new DropdownButton(
                          isExpanded: true,
                          value: _currentAddress,
                          items: _dropDownAddress,
                          onChanged: changedDropDownSalary,
                          style: new TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                      ),
                    ),
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
                    new Container(
                      height: 200,
                      color: Colors.grey,
                    ),
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
                          onTap: (){
                            print("ok");
                          },
                          child: new Row(
                            children: <Widget>[
                              new Text("Chụp hình", style: new TextStyle(color: Colors.blueAccent),),
                              new Padding(
                                  padding: EdgeInsets.only(left: 5),
                                child: new Icon(Icons.camera_alt, color: Colors.blueAccent,),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    
                    new SizedBox(
                      height: 10,
                    ),
//                      new Expanded(
//                          child: Container(
//                            child: Center(
//                              child: InkWell(
//                                borderRadius: BorderRadius.circular(50),
//                                onTap: (){
//                                  print("OK");
//                                },
//                                  child: Icon(Icons.photo_camera, size: 50, color: Colors.blueAccent,)
//                              ),
//                            ),
//                          )
//                      )
                    new Expanded(
                        child: Container(
                      color: Colors.white,
                      child: new GridView.extent(
                        maxCrossAxisExtent: 100,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        padding: EdgeInsets.all(5),
                        children: <Widget>[
//lam piếng làm nhấn zô coi chi tiết cho từng ành nên sẽ copy bên hrp code
                          new Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "https://png.pngtree.com/png-clipart/20190118/ourlarge/pngtree-cartoon-cute-image-surprised-surprise-png-image_462278.jpg",
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                          new Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "https://png.pngtree.com/png-clipart/20190118/ourlarge/pngtree-cartoon-cute-image-surprised-surprise-png-image_462278.jpg",
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                          new Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "https://png.pngtree.com/png-clipart/20190118/ourlarge/pngtree-cartoon-cute-image-surprised-surprise-png-image_462278.jpg",
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                          new Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "https://png.pngtree.com/png-clipart/20190118/ourlarge/pngtree-cartoon-cute-image-surprised-surprise-png-image_462278.jpg",
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                          new Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "https://png.pngtree.com/png-clipart/20190118/ourlarge/pngtree-cartoon-cute-image-surprised-surprise-png-image_462278.jpg",
                                    ),
                                    fit: BoxFit.cover)),
                          ),new Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "https://png.pngtree.com/png-clipart/20190118/ourlarge/pngtree-cartoon-cute-image-surprised-surprise-png-image_462278.jpg",
                                    ),
                                    fit: BoxFit.cover)),
                          ),new Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "https://png.pngtree.com/png-clipart/20190118/ourlarge/pngtree-cartoon-cute-image-surprised-surprise-png-image_462278.jpg",
                                    ),
                                    fit: BoxFit.cover)),
                          ),


                        ],
                      ),
                    ))
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
      ),
    );
  }
}
