import 'package:flutter/material.dart';
import '../../services/api_client/post_repository.dart';
import '../style/colors/colorstyle.dart';

// ignore: must_be_immutable
class FollowBtn extends StatelessWidget {
  String follow;
  int authorid;
  final double width;
  final double height;
  FollowBtn({
    super.key,
    required this.follow,
    required this.width,
    required this.height,
    required this.authorid,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => InkWell(
        onTap: () {
          if (follow == 'following') {
            setState(() {
              follow = 'follow';
            });
            Map formdata = {'user_to': authorid};
            PostHttpRepository.post.followeruser(formdata, context);
          } else {
            setState(() {
              follow = 'following';
            });
            Map formdata = {'user_to': authorid};
            PostHttpRepository.post.followeruser(formdata, context);
          }
        },
        child: follow == 'following'
            ? Container(
                alignment: Alignment.center,
                height: height,
                width: width,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorStyle.lightgreen,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  follow,
                  style: const TextStyle(color: ColorStyle.lightgreen),
                ),
              )
            : Container(
                alignment: Alignment.center,
                height: height,
                width: width,
                decoration: BoxDecoration(
                    color: ColorStyle.lightgreen,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  follow,
                  style: const TextStyle(color: ColorStyle.white),
                ),
              ),
      ),
    );
  }
}
