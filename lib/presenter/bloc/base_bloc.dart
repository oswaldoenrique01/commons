import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(super.initialState);

  @override
  void onChange(Change<State> change) {
    super.onChange(change);
    dev.log(
      '🟢 Cambio en: ${change.currentState} -> ${change.nextState}',
      name: 'BLOC_LOG',
    );
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    dev.log(
      '🔴 Error en: $error',
      name: 'BLOC_ERROR',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(error, stackTrace);
  }
}