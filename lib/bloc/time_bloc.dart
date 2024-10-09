import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'time_event.dart';
part 'time_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  Timer? timer;
  TimeBloc() : super(TimeState(currentTime: DateTime.now())) {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(TickEvent());
    });
    on<TickEvent>((event, emit) {
      emit(TimeState(currentTime: DateTime.now()));
    });
  }

  Stream<TimeState> eventToState(TimeEvent event) async* {
    final currentTime = DateTime.now();
    log("Current Time: ${DateFormat.jm().format(currentTime)}");
    yield TimeState(currentTime: DateTime.now());
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
