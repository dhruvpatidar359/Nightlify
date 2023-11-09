part of 'discover_bloc.dart';

abstract class DiscoverState extends Equatable {}

class ChangePageState extends DiscoverState {
  ChangePageState(this.index);
  final index;
  @override
  // TODO: implement props
  List<Object?> get props => [index];
}
