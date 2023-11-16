part of 'media_bloc.dart';

abstract class MediaState extends Equatable {}

class NoMediaState extends MediaState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ImageMediaOneUploadingState extends MediaState {
  ImageMediaOneUploadingState(this.progress);

  final progress;

  @override
  // TODO: implement props
  List<Object?> get props => [progress];
}

class ImageMediaOneSuccessState extends MediaState {
  ImageMediaOneSuccessState(this.path, this.url);

  final path;
  final String url;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NoMediaOneState extends MediaState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ImageMediaTwoUploadingState extends MediaState {
  ImageMediaTwoUploadingState(this.progress);

  final progress;

  @override
  // TODO: implement props
  List<Object?> get props => [progress];
}

class ImageMediaTwoSuccessState extends MediaState {
  ImageMediaTwoSuccessState(this.path, this.url);

  final path;
  final String url;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NoMediaTwoState extends MediaState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class VideoMediaUploadingState extends MediaState {
  VideoMediaUploadingState(this.progress);

  final progress;

  @override
  // TODO: implement props
  List<Object?> get props => [progress];
}

class VideoMediaSuccessState extends MediaState {
  VideoMediaSuccessState(this.path, this.url);

  final path;
  final String url;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NoMediaThreeState extends MediaState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// some states related to progress for the profile - just to show

class GotImageOneState extends MediaState {
  @override
  // TODO: implement props
  List<Object?> get props => [5];
}

class ImageOneRemoved extends MediaState {
  @override
  // TODO: implement props
  List<Object?> get props => [-5];
}

class GotImageTwoState extends MediaState {
  @override
  // TODO: implement props
  List<Object?> get props => [5];
}

class ImageTwoRemoved extends MediaState {
  @override
  // TODO: implement props
  List<Object?> get props => [-5];
}

class GotVideoState extends MediaState {
  @override
  // TODO: implement props
  List<Object?> get props => [5];
}

class VideoRemoved extends MediaState {
  @override
  // TODO: implement props
  List<Object?> get props => [-5];
}
