import 'package:bloc/bloc.dart';

import 'package:medical/src/blocs/application/application.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  @override
  ApplicationState get initialState => ApplicationState.uninitialized();

  @override
  Stream<ApplicationState> mapEventToState(ApplicationEvent event) async* {
    if (!currentState.isInitialized) {
      yield ApplicationState.uninitialized();
    }
    if (event.type == ApplicationEventType.launched) {
      await Future.delayed(Duration(seconds: 3));
      yield ApplicationState.progressing(100);
    }
    if (event.type == ApplicationEventType.initialized) {
      yield ApplicationState.initialized();
    }
  }
}
