import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/common_utils.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    CommonUtils.logger.d('onEvent: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    CommonUtils.logger.d('onTransition: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    //CommonUtils.logger.d('onError: $error, $stacktrace');
    super.onError(bloc, error, stacktrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    //CommonUtils.logger.d('onChange: $bloc, $change');
    super.onChange(bloc, change);
  }
}
