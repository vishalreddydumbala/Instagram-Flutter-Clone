import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/helper/profile_image_picker.dart';
import 'package:instagram/nav/bloc/addpostbloc/add_post_event.dart';
import 'package:instagram/nav/bloc/addpostbloc/add_post_state.dart';
import 'package:instagram/services/auth/auth_service.dart';
import 'package:instagram/services/cloud/firebase_cloud.dart';
import 'package:instagram/services/imageService/image_provider.dart';

class AddPostSubBloc extends Bloc<AddPostSubEvent, AddPostSubState> {
  final _imageProvider = ImageProvider();
  final _cloudService = FirebaseCloud();
  final _authUser = AuthService.firebase().currentUser;

  AddPostSubBloc() : super(const AddPostInitialState()) {
    /// [Initialising Event] - This event is called when the user clicks on the add post button
    on<AddPostSubInitialEvent>((event, emit) async {
      final images = await _imageProvider.loadImages();
      final selectedImage = await _imageProvider.getSelectedImage(0);
      emit(AddPostLoadedState(
          selectedImage: selectedImage, imageEntities: images, index: 0));
    });

    /// [Image Selected Event] - This event is called when the user selects an image from the gallery
    on<AddPostSubImageSelectedEvent>((event, emit) {
      if (event.selectedImage == null) {
        log("image is null");
        emit(const AddPostErrorState());
      }
      emit(AddPostSubmitState(selectedImage: event.selectedImage!));
    });

    /// [Post Event] - This event is called when the user clicks on the post button
    on<AddPostPostEvent>((event, emit) async{
      try{
      await _cloudService.createNewPost(
          caption: event.caption,
          displayName: _authUser!.displayName!,
          profileImageUrl: _authUser.profilePictureUrl!,
          post: event.selectedImage,
          ownerUid: _authUser.uid);
      final images = await _imageProvider.loadImages();
      final selectedImage = await _imageProvider.getSelectedImage(0);
      emit(AddPostLoadedState(
          selectedImage: selectedImage, imageEntities: images, index: 0));
      }catch(_){
        emit(const AddPostErrorState());
      }
    });

    /// [Get Image Event] - This event is called when the user clicks on the image in the grid
    on<AddPostSubGetImageEvent>((event, emit) async {
      final selectedImage = await _imageProvider.getSelectedImage(event.index);
      final images = await _imageProvider.loadImages();
      emit(AddPostLoadedState(
          selectedImage: selectedImage,
          imageEntities: images,
          index: event.index));
    });

    /// [Get Camera Image Event] - This event is called when the user clicks on the camera button
    on<AddPostGetCameraImageEvent>((event, emit) async {
      final Uint8List? selectedImage = await profilePicker(ImageSource.camera);
      final images = await _imageProvider.loadImages();
      emit(AddPostLoadedState(
          selectedImage: selectedImage, imageEntities: images, index: -1));
    });
  }
}
