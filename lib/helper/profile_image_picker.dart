import 'package:image_picker/image_picker.dart';

profilePicker(ImageSource source) async {
  final ImagePicker picker = ImagePicker();

  XFile? file = await picker.pickImage(source: source);

  if (file != null) {
    return file.readAsBytes();
  }
}
