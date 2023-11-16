part of 'media_bloc.dart';

abstract class MediaEvents extends Equatable {}

class ImageMediaOnePick extends MediaEvents {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ImageMediaTwoPick extends MediaEvents {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class VideoMediaPick extends MediaEvents {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ImageMediaOneDelete extends MediaEvents {
  ImageMediaOneDelete(this.isPresent);

  final isPresent;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ImageMediaTwoDelete extends MediaEvents {
  ImageMediaTwoDelete(this.isPresent);

  final isPresent;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class VideoMediaDelete extends MediaEvents {
  VideoMediaDelete(this.isPresent);

  final isPresent;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
