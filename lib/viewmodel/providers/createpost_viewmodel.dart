import 'package:dblog/services/api_client/patch_repository.dart';
import 'package:dblog/services/api_client/post_repository.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class CreatePost {
  static Future<void> savePost(QuillEditorController controller) async {
    dynamic htmlBody = await controller.getText();
    var control = await controller.getDelta();
    List<String> title = [];
    List<Map> images = [];
    for (var elment in control['ops']) {
      var getElement = elment['insert'];
      if (getElement.runtimeType == String && getElement.toString().isEmpty) {
      } else if (getElement.runtimeType == String) {
        title.add(getElement);
      } else {
        images.add(getElement);
      }
    }

    var postImage = images.first['image'].toString().split(",").last;
    Map formdata = {
      'title': title.first,
      'image': postImage,
      'body': htmlBody,
    };
    return await PostHttpRepository.post.createPost(formdata);
  }

  static Future<void> editPost(
      QuillEditorController controller, String slug) async {
    dynamic htmlBody = await controller.getText();
    var control = await controller.getDelta();
    List<String> title = [];
    List<Map> images = [];
    for (var elment in control['ops']) {
      var getElement = elment['insert'];
      if (getElement.runtimeType == String && getElement.toString().isEmpty) {
      } else if (getElement.runtimeType == String) {
        title.add(getElement);
      } else {
        images.add(getElement);
      }
    }

    var postImage = images.first['image'].toString().split(",").last;
    Map formdata = {
      'title': title.first,
      'image': postImage,
      'body': htmlBody,
    };
    return await PatchHttpRepository.patch.editPost(formdata, slug);
  }
}
