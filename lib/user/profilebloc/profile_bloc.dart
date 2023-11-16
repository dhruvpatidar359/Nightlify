import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nightlify/models/user_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final fireStoreRepository;

  ProfileBloc({required this.fireStoreRepository})
      : super(ProfileLoadingState()) {
    on<ProfileFetchEvent>((event, state) async {
      // TODO: implement event handler
      emit(ProfileLoadingState());
      final userModel = await fireStoreRepository.fetchUserDetails();
      emit(ProfileSuccessfullyLoaded(userModel));
    });

    on<ProfileResetEvent>((event, state) {
      emit(ProfileLoadingState());
    });
  }
}
