

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'pair_event.dart';
part 'pair_state.dart';

class PairBloc extends Bloc<PairState,PairEvent> {
  PairBloc(super.initialState);

}