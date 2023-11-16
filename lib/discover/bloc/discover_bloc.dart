import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'discover_events.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverBloc() : super(ChangePageState(0)) {
    on<ChangePageEvent>((event, state) {
      emit(ChangePageState(event.index));
    });
  }
}
