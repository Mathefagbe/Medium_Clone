import 'dart:io';

import 'package:dblog/viewmodel/providers/imagepicker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/api_client/patch_repository.dart';
import '../style/colors/colorstyle.dart';
import '../widgets/commentbox_form.dart';

class EditProfileView extends StatefulWidget {
  final String imageurl;
  final String about;
  const EditProfileView(
      {super.key, required this.imageurl, required this.about});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController aboutuser;

  @override
  void initState() {
    super.initState();
    aboutuser = TextEditingController();
    aboutuser.text = widget.about;
  }

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    var imagepicked = Provider.of<ImagesPickerProvdier>(context).fileimage;
    return Scaffold(
        appBar: AppBar(
          actions: [
            StatefulBuilder(
              builder: (context, setState) => TextButton(
                  onPressed: () async {
                    setState(() {
                      isloading = true;
                    });
                    Map formdata = {
                      'bio': aboutuser.text,
                      'image': imagepicked
                    };
                    await PatchHttpRepository.patch
                        .patchUserProfile(formdata)
                        .then((value) {
                      setState(() {
                        isloading = false;
                      });
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/nav", (route) => false);
                    });
                  },
                  child: isloading
                      ? const CircularProgressIndicator(
                          color: ColorStyle.lightgreen,
                        )
                      : Text(
                          "save",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: ColorStyle.lightgreen),
                        )),
            ),
          ],
          title: Text("Edit Profile",
              style: Theme.of(context).textTheme.titleMedium),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(alignment: Alignment.bottomRight, children: [
                  imagepicked == ""
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(widget.imageurl),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(File(imagepicked)),
                          radius: 60,
                        ),
                  IconButton(
                      onPressed: () {
                        Provider.of<ImagesPickerProvdier>(context,
                                listen: false)
                            .pickedImage();
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 30,
                      )),
                ]),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(height: 1.5),
                  maxLength: 300,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: aboutuser,
                  decoration: formBox.copyWith(
                      labelStyle: const TextStyle(color: ColorStyle.lightgreen),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorStyle.lightgreen.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(3)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorStyle.lightgreen.withOpacity(0.3)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 8),
                      labelText: "short bio"),
                ),
              ],
            ),
          ),
        ));
  }
}
