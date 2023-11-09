import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:nightlify/details/media/data/mediaRepository/mediaRepository.dart';
part 'media_state.dart';
part 'media_events.dart';

class MediaBloc extends Bloc<MediaEvents, MediaState> {
  final MediaRepository mediaRepository;
  final storageRef = FirebaseStorage.instance.ref();
  final user = FirebaseAuth.instance.currentUser;

  late UploadTask refToMediaOneUpload;
  late UploadTask refToMediaTwoUpload;
  late UploadTask refToMediaThreeUpload;

  bool refOneClosed = true;
  bool refTwoClosed = true;
  bool refThreeClose = true;

  MediaBloc({required this.mediaRepository}) : super(NoMediaState()) {
    on<ImageMediaOnePick>(
      (event, state) async {
        final path = await mediaRepository.pickImage();
        if (path == "") {
          emit(NoMediaOneState());
        } else {
          refToMediaOneUpload = storageRef
              .child("images/${user?.uid}/primaryImage")
              .putFile(File(path));

          // ref is in user (open ha bro)
          refOneClosed = false;

          refToMediaOneUpload.snapshotEvents
              .listen((TaskSnapshot taskSnapshot) {
            switch (taskSnapshot.state) {
              case TaskState.running:
                final progress =
                    (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);

                print("Upload is $progress% complete.");

                emit(ImageMediaOneUploadingState(progress));

                break;
              case TaskState.paused:
                print("Upload is paused.");

                break;
              case TaskState.canceled:
                print("Upload was canceled");
                refOneClosed = true;
                break;
              case TaskState.error:
                // Handle unsuccessful uploads
                refOneClosed = true;
                break;
              case TaskState.success:
                emit(GotImageOneState());
                emit(ImageMediaOneSuccessState(path));
                refOneClosed = true;
                // Handle successful uploads on complete
                // ...
                break;
            }
          });
        }
      },
    );
    on<ImageMediaOneDelete>(
      (event, state) {
        try {
          if (!refOneClosed) {
            refToMediaOneUpload.cancel();
          }
        } catch (e) {
          debugPrint("secRefTOMediaOneUpload has not been init");
        }
        if (event.isPresent) {
          emit(ImageOneRemoved());
        }
        emit(NoMediaOneState());
      },
    );

    on<ImageMediaTwoPick>(
      (event, state) async {
        final path = await mediaRepository.pickImage();
        if (path == "") {
          emit(NoMediaTwoState());
        } else {
          refToMediaTwoUpload = storageRef
              .child("images/${user?.uid}/secondaryImage")
              .putFile(File(path));

          refTwoClosed = true;
          refToMediaTwoUpload.snapshotEvents
              .listen((TaskSnapshot taskSnapshot) {
            switch (taskSnapshot.state) {
              case TaskState.running:
                final progress =
                    (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);

                print("Upload is $progress% complete.");

                emit(ImageMediaTwoUploadingState(progress));

                break;
              case TaskState.paused:
                print("Upload is paused.");
                break;
              case TaskState.canceled:
                print("Upload was canceled");
                refTwoClosed = true;
                break;
              case TaskState.error:
                // Handle unsuccessful uploads
                refTwoClosed = true;
                break;
              case TaskState.success:
                emit(GotImageTwoState());
                emit(ImageMediaTwoSuccessState(path));

                refTwoClosed = true;
                // Handle successful uploads on complete
                // ...
                break;
            }
          });
        }
      },
    );

    on<ImageMediaTwoDelete>(
      (event, state) {
        try {
          if (!refTwoClosed) {
            refToMediaTwoUpload.cancel();
          }
        } catch (e) {
          debugPrint("refToMediaTwoUpload has not been init");
        }
        if (event.isPresent) {
          emit(ImageTwoRemoved());
        }
        emit(NoMediaTwoState());
      },
    );

    on<VideoMediaPick>((event, state) async {
      final path = await mediaRepository.pickVideo();
      if (path == "") {
        emit(NoMediaThreeState());
      } else {
        refToMediaThreeUpload = storageRef
            .child("images/${user?.uid}/primaryVideo")
            .putFile(File(path));

        refThreeClose = false;

        refToMediaThreeUpload.snapshotEvents
            .listen((TaskSnapshot taskSnapshot) async {
          switch (taskSnapshot.state) {
            case TaskState.running:
              final progress =
                  (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);

              print("Upload is $progress% complete.");

              emit(VideoMediaUploadingState(progress));

              break;
            case TaskState.paused:
              print("Upload is paused.");

              break;
            case TaskState.canceled:
              print("Upload was canceled");
              refThreeClose = true;
              break;
            case TaskState.error:
              // Handle unsuccessful uploads
              refThreeClose = true;
              break;
            case TaskState.success:
              emit(GotVideoState());
              emit(VideoMediaSuccessState(path));

              refThreeClose = true;

              // Handle successful uploads on complete
              // ...
              break;
          }
        });
      }
    });

    on<VideoMediaDelete>(
      (event, state) {
        try {
          if (!refThreeClose) {
            refToMediaThreeUpload.cancel();
          }
        } catch (e) {
          debugPrint("refToMediaThreeUpload has not been init");
        }

        if (event.isPresent) {
          emit(VideoRemoved());
        }

        emit(NoMediaThreeState());
      },
    );
  }
}
