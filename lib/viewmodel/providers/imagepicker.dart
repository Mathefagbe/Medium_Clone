import 'package:dblog/viewmodel/providers/mounted_state_notfier.dart';
import 'package:image_picker/image_picker.dart';

class ImagesPickerProvdier extends MountedStateNotifer {
  String _images = "";
  String get fileimage => _images;

  void pickedImage() async {
    ImagePicker imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _images = image.path;
      notifyListeners();
    }
  }
}
