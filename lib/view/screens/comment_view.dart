import 'dart:convert';

import 'package:dblog/viewmodel/providers/comment_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/enums/enums.dart';
import '../../services/api_client/post_repository.dart';
import '../style/colors/colorstyle.dart';
import '../widgets/error_dialog_widget.dart';
import '../widgets/commentbox_form.dart';
import '../widgets/loadingindicator_widget.dart';

class CommentScreen extends StatefulWidget {
  final String slug;
  const CommentScreen({super.key, required this.slug});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late TextEditingController reply;
  @override
  void initState() {
    super.initState();
    reply = TextEditingController();
  }

  @override
  void dispose() {
    reply.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CommentViewModel(widget.slug),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Responses',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        body: Consumer<CommentViewModel>(builder: (context, value, child) {
          if (value.fetchstate == PageState.loading) {
            return const Loading();
          } else if (value.fetchstate == PageState.error) {
            return ErrorDialogWiget(
                errorMessage: value.errorMessage,
                ontap: () =>
                    Provider.of<CommentViewModel>(context, listen: false)
                        .commentrefresh(widget.slug));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  _CommentBody(val: value.comment),
                  Row(children: [
                    Expanded(
                      child: TextField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: Theme.of(context).textTheme.labelMedium,
                        controller: reply,
                        decoration: formBox.copyWith(
                            hintStyle: Theme.of(context).textTheme.labelMedium,
                            hintText: "What is your thought?"),
                      ),
                    ),
                    CommentSendBtn(
                      reply: reply,
                      slug: widget.slug,
                    )
                  ]),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}

class _CommentBody extends StatelessWidget {
  final dynamic val;
  const _CommentBody({required this.val});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(top: 10, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage:
                        NetworkImage(val[index].author.userprofile.image),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    val[index].author.username,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(val[index].timeAgo.replaceFirst(RegExp(r'Â'), ''),
                      style: Theme.of(context).textTheme.labelSmall),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz_outlined))
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              child: Text(utf8convert(val[index].comment),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 15, height: 1.7)),
            ),
          ],
        ),
      ),
      separatorBuilder: (context, index) => const Divider(
        height: 5,
        color: ColorStyle.lightgray,
      ),
      itemCount: val.length,
    ));
  }

  String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }
}

// ignore: must_be_immutable
class CommentSendBtn extends StatelessWidget {
  final TextEditingController reply;
  final String slug;
  CommentSendBtn({super.key, required this.reply, required this.slug});

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => InkWell(
        onTap: () async {
          if (reply.text.isNotEmpty) {
            setState(() {
              isloading = true;
            });
            Map formdata = {'comment': reply.text};
            await PostHttpRepository.post
                .postComment(formdata, slug)
                .then((value) {
              reply.clear();
              setState(() {
                isloading = false;
              });
              Provider.of<CommentViewModel>(context, listen: false)
                  .commentrefresh(slug);
            });
          }
        },
        child: isloading
            ? const CircularProgressIndicator(
                color: ColorStyle.lightgreen,
              )
            : Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 5),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: ColorStyle.lightgreen.withOpacity(0.7)),
                child: const Icon(Icons.send),
              ),
      ),
    );
  }
}
