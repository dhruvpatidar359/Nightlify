part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileSuccessfullyLoaded extends ProfileState {
  ProfileSuccessfullyLoaded(this.userModel);
  UserModel userModel;
  @override
  // TODO: implement props
  List<Object?> get props => [userModel];
}

class ProfileResetState extends ProfileState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
