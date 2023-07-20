import 'package:dblog/viewmodel/providers/createpost_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import '../style/colors/colorstyle.dart';
import '../widgets/loadingindicator_widget.dart';

class EditPostView extends StatefulWidget {
  final String post;
  final String slug;
  const EditPostView({super.key, required this.post, required this.slug});

  @override
  State<EditPostView> createState() => _EditPostViewState();
}

class _EditPostViewState extends State<EditPostView> {
  late QuillEditorController controller;

  ///[customToolBarList] pass the custom toolbarList to show only selected styles in the editor

  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.clean,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
  ];

  final _toolbarColor = Colors.grey.shade200;
  final _toolbarIconColor = Colors.black87;
  final _hintTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black12, fontWeight: FontWeight.normal);

  bool isloading = false;
  @override
  void initState() {
    super.initState();
    controller = QuillEditorController();
  }

  @override
  void dispose() {
    /// please do not forget to dispose the controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            StatefulBuilder(
              builder: (context, setState) => TextButton(
                  onPressed: () async {
                    setState(() {
                      isloading = true;
                    });
                    await CreatePost.editPost(controller, widget.slug)
                        .then((value) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/nav", (route) => false);
                    });
                    setState(() {
                      isloading = false;
                    });
                  },
                  child: isloading
                      ? const Loading()
                      : Text(
                          "Publish",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: ColorStyle.lightgreen),
                        )),
            )
          ],
          title: Text(
            "Edit Post",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: QuillHtmlEditor(
                loadingBuilder: (context) => const Loading(),
                text: widget.post,
                hintText: 'Hint text goes here',
                controller: controller,
                isEnabled: true,
                minHeight: 200,
                textStyle: Theme.of(context).textTheme.bodyLarge,
                hintTextStyle: _hintTextStyle,
                hintTextAlign: TextAlign.start,
                padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                hintTextPadding: const EdgeInsets.only(left: 20),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              height: 50,
              child: ToolBar.scroll(
                mainAxisAlignment: MainAxisAlignment.start,
                toolBarColor: _toolbarColor,
                padding: const EdgeInsets.all(8),
                iconSize: 25,
                iconColor: _toolbarIconColor,
                activeIconColor: Colors.greenAccent.shade400,
                controller: controller,
                crossAxisAlignment: CrossAxisAlignment.center,
                direction: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
