part of 'pair_bloc.dart';

abstract class PairState extends Equatable {}

class FetchPairLoadingState extends PairState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchPairSuccessState extends PairState {
  FetchPairSuccessState(this.urls);

  final urls;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchPairFailedState extends PairState {
  FetchPairFailedState(this.error);

  final error;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class NotFetchPairsState extends PairState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
