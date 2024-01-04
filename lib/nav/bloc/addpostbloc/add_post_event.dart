import 'package:flutter/foundation.dart';

@immutable
abstract class AddPostSubEvent {
  const AddPostSubEvent();
}

class AddPostSubInitialEvent extends AddPostSubEvent {
  const AddPostSubInitialEvent();
}

class AddPostSubImageSelectedEvent extends AddPostSubEvent {
  final Uint8List? selectedImage;
  const AddPostSubImageSelectedEvent({@required this.selectedImage});
}

class AddPostPostEvent extends AddPostSubEvent {
  final Uint8List selectedImage;
  const AddPostPostEvent(this.selectedImage);
}

class AddPostSubGetImageEvent extends AddPostSubEvent {
  final int index;
  const AddPostSubGetImageEvent(this.index);
}

class AddPostGetCameraImageEvent extends AddPostSubEvent {
  const AddPostGetCameraImageEvent();
}