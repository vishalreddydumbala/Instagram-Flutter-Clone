import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/helper/profile_image_picker.dart';
import 'package:instagram/nav/bloc/addpostbloc/add_post_event.dart';
import 'package:instagram/nav/bloc/addpostbloc/add_post_state.dart';
import 'package:instagram/services/imageService/image_provider.dart';

class AddPostSubBloc extends Bloc<AddPostSubEvent, AddPostSubState> {
  final imageProvider = ImageProvider();

  AddPostSubBloc() : super(const AddPostInitialState()) {
    on<AddPostSubInitialEvent>((event, emit) async {
      final images = await imageProvider.loadImages();
      final selectedImage = await imageProvider.getSelectedImage(0);
      emit(AddPostLoadedState(
          selectedImage: selectedImage, imageEntities: images, index: 0));
    });

    on<AddPostSubImageSelectedEvent>((event, emit) {
      if (event.selectedImage == null) {
        log("image is null");
        emit(const AddPostErrorState());
      }
      emit(AddPostSubmitState(selectedImage: event.selectedImage!));
    });

    on<AddPostPostEvent>((event, emit) {});

    on<AddPostSubGetImageEvent>((event, emit) async {
      final selectedImage = await imageProvider.getSelectedImage(event.index);
      final images = await imageProvider.loadImages();
      emit(AddPostLoadedState(
          selectedImage: selectedImage,
          imageEntities: images,
          index: event.index));
    });

    on<AddPostGetCameraImageEvent>((event, emit) async {
      final Uint8List? selectedImage = await profilePicker(ImageSource.camera);
      final images = await imageProvider.loadImages();
      emit(AddPostLoadedState(
          selectedImage: selectedImage, imageEntities: images, index: -1));
    });
  }
}
