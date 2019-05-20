import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() {
    return _AttendancePageState();
  }
}

class _AttendancePageState extends State<AttendancePage> {

  CheckInBloc _checkInBloc;


  @override
  void initState() {
    _checkInBloc = CheckInBloc();
    _checkInBloc.dispatch(GetLocation());


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
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => AttendanceHistoryPage(),
                  ),
                );
              }
          )
        ],
        title: Text(
          "Chấm công",
          style: new TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder(bloc: _checkInBloc, builder: (BuildContext context, state){
        if(state is CheckInLocationLoading){
          return LoadingIndicator();
        }
        if(state is CheckInLocationLoaded){
          return buildContainer(state.locationList);
        }
        return Container();
      })
    );
  }

  Container buildContainer(List locations) {
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
                  AttendanceLocation(locationList:locations),
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
    );
  }
}
