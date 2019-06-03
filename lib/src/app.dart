import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medical/src/blocs/application/application.dart';
import 'package:medical/src/blocs/authentication/authentication.dart';
import 'package:medical/src/blocs/synchronization/synchronization.dart';

import 'package:medical/src/ui/pages/authentication/authentication_page.dart';
import 'package:medical/src/ui/pages/splash/splash_page.dart';

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  ApplicationBloc _applicationBloc;
  AuthenticationBloc _authenticationBloc;
  SynchronizationBloc _synchronizationBloc;

  @override
  void initState() {
    _applicationBloc = ApplicationBloc();
    _applicationBloc.dispatch(ApplicationEvent.launched());
    _synchronizationBloc = SynchronizationBloc();
    _synchronizationBloc.dispatch(SynchronizationEvent.check());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _authenticationBloc = AuthenticationBloc();
    _authenticationBloc.dispatch(AuthenticationEvent.identified());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _applicationBloc?.dispose();
    _authenticationBloc?.dispose();
    _synchronizationBloc?.dispose();
    super.dispose();
  }

  Widget _buildInitializationPage() {
    return Scaffold(
      body: BlocBuilder(
          bloc: _applicationBloc,
          builder: (BuildContext context, ApplicationState state) {
            if (state.isInitialized) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => AuthenticationPage()));
              });
            }
            return SplashPage();
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<ApplicationBloc>(bloc: _applicationBloc),
        BlocProvider<AuthenticationBloc>(bloc: _authenticationBloc),
        BlocProvider<SynchronizationBloc>(bloc: _synchronizationBloc),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _buildInitializationPage(),
      ),
    );
  }
}
