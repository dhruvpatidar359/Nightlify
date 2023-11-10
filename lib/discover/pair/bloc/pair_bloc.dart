import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../firebase/data/firestoreRepository/firestore_repository.dart';

part 'pair_event.dart';
part 'pair_state.dart';

class PairBloc extends Bloc<PairEvent, PairState> {
  final FirestoreRepository firestoreRepository;

  PairBloc({required this.firestoreRepository}) : super(NotFetchPairsState()) {
    on<FetchPairsEvent>((event, state) {
      emit(FetchPairLoadingState());
      // dummy the data process untill we have the original data
      try {
        // emit(FetchPairSuccessState(urls));
      } catch (e) {
        emit(FetchPairFailedState(e.toString()));
      }
    });
  }
}
