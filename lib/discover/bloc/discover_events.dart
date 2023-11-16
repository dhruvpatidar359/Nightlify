part of 'discover_bloc.dart';

abstract class DiscoverEvent extends Equatable {}

class ChangePageEvent extends DiscoverEvent {
  ChangePageEvent(this.index);

  final index;

  @override
  // TODO: implement props
  List<Object?> get props => [index];
}
