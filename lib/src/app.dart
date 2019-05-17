import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/application/application.dart';

import 'package:medical/src/ui/pages/authentication/authentication_page.dart';

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  ApplicationBloc _applicationBloc;

  @override
  void initState() {
    _applicationBloc = ApplicationBloc();
    _applicationBloc.dispatch(ApplicationEvent.launched());
    super.initState();
  }

  @override
  void dispose() {
    _applicationBloc?.dispose();
    super.dispose();
  }

  Widget buildInitializationPage() {
    return Scaffold(
      body: BlocBuilder(
          bloc: _applicationBloc,
          builder: (BuildContext context, ApplicationState state) {
            if (state.isInitialized) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final predicate =
                    (Route route) {
                  print(route);
                  print(route.settings.name);
                  print(!route.willHandlePopInternally);
                  print(route is ModalRoute);
                  //!route.willHandlePopInternally;
                      return false;
                    };
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AuthenticationPage()),
                    ModalRoute.withName('/s'));
              });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: buildInitializationPage(),
    );
  }
}
