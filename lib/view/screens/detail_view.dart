import 'dart:convert';

import 'package:dblog/services/api_client/post_repository.dart';
import 'package:dblog/view/widgets/user_followbtn_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/enums/enums.dart';
import '../style/colors/colorstyle.dart';
import '../widgets/error_dialog_widget.dart';
import '../widgets/loadingindicator_widget.dart';
import '../../viewmodel/providers/home_viewmodel.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class BlogPostDetailScreen extends StatelessWidget {
  final String slug;
  const BlogPostDetailScreen({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostDetailViewModel(slug),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: const [
            Icon(Icons.share),
            SizedBox(
              width: 15,
            ),
            Icon(Icons.bookmark_add_outlined),
            SizedBox(
              width: 15,
            ),
            Icon(Icons.more_vert_rounded),
            SizedBox(
              width: 15,
            ),
          ],
        ),
        body: Consumer<PostDetailViewModel>(builder: (context, value, child) {
          if (value.fetchstate == PageState.loading) {
            return const Loading();
          } else if (value.fetchstate == PageState.error) {
            return ErrorDialogWiget(
              errorMessage: value.errorMessage,
              ontap: () =>
                  Provider.of<PostDetailViewModel>(context, listen: false)
                      .getblogpost(slug),
            );
          } else {
            return value.blogpost == null
                ? const Loading()
                : Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        children: [
                          _BuildHeader(
                            timeago: value.blogpost!.post.timeAgo,
                            url: value.blogpost!.post.author.userprofile.image,
                            username: value.blogpost!.post.author.username,
                            authorid: value.blogpost!.post.author.id,
                            status: value.blogpost!.status,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          _BuildPostBody(textBody: value.blogpost!.post.body),
                          const SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                      ActionContainer(
                        comment: value.blogpost!.post.commentCount,
                        slug: value.blogpost!.post.slug,
                        likeCount: value.blogpost!.post.like,
                        likeStatus: value.blogpost!.likestatus,
                      ),
                    ],
                  );
          }
        }),
      ),
    );
  }
}

class _BuildHeader extends StatelessWidget {
  final String username;
  final String url;
  final String timeago;
  final int authorid;
  final String status;
  const _BuildHeader(
      {required this.username,
      required this.url,
      required this.timeago,
      required this.authorid,
      required this.status});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> headerparams = {
      "authorid": authorid,
      "status": status
    };
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/blogger_profile",
          arguments: headerparams,
        );
      },
      child: SizedBox(
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(url),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      username,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    status == "hide"
                        ? const SizedBox()
                        : FollowBtn(
                            follow: status,
                            authorid: authorid,
                            width: 100,
                            height: 30,
                          )
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  timeago.replaceFirst(RegExp(r'Â'), ''),
                  style: Theme.of(context).textTheme.labelSmall,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildPostBody extends StatelessWidget {
  final String textBody;
  const _BuildPostBody({required this.textBody});

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      textBody,
      buildAsync: false,
      enableCaching: false,
      textStyle: Theme.of(context).textTheme.bodyLarge,
    );
  }

  String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }
}

// ignore: must_be_immutable
class ActionContainer extends StatelessWidget {
  final int comment;
  final String slug;
  int likeCount;
  String likeStatus;
  ActionContainer(
      {super.key,
      required this.comment,
      required this.slug,
      required this.likeCount,
      required this.likeStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).canvasColor.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/comment', arguments: slug);
            },
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.chat_bubble,
                  size: 30,
                  color: ColorStyle.lightgray,
                ),
                Text("$comment")
              ],
            ),
          ),
          StatefulBuilder(
            builder: (context, setState) => InkWell(
              onTap: () {
                PostHttpRepository.post.likepost(slug, context);
                if (likeStatus == "liked") {
                  setState(
                    () {
                      likeCount = likeCount - 1;
                      likeStatus = "unlike";
                    },
                  );
                } else {
                  setState(
                    () {
                      likeCount = likeCount + 1;
                      likeStatus = "liked";
                    },
                  );
                }
              },
              child: Row(
                children: [
                  likeStatus == "liked"
                      ? const Icon(
                          CupertinoIcons.heart_fill,
                          size: 30,
                          color: ColorStyle.lightgray,
                        )
                      : const Icon(
                          CupertinoIcons.heart,
                          size: 30,
                          color: ColorStyle.lightgray,
                        ),
                  Text("$likeCount")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
