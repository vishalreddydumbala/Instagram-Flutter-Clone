import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';

@immutable
abstract class AddPostSubState {
  const AddPostSubState();
}

class AddPostInitialState extends AddPostSubState {
  const AddPostInitialState();
}

class AddPostLoadedState extends AddPostSubState with EquatableMixin {
  final Uint8List? selectedImage;
  final List<AssetEntity> imageEntities;
  final int index;
  const AddPostLoadedState(
      {required this.selectedImage,
      required this.imageEntities,
      this.index = 0});

  @override
  List<Object?> get props => [selectedImage];
}

class AddPostSubmitState extends AddPostSubState {
  final Uint8List selectedImage;
  const AddPostSubmitState({required this.selectedImage});
}

class AddPostErrorState extends AddPostSubState {
  const AddPostErrorState();
}