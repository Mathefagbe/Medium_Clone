import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/enums/enums.dart';
import '../style/colors/colorstyle.dart';
import '../../viewmodel/providers/stories_viewmodel.dart';
import '../widgets/error_dialog_widget.dart';
import '../widgets/user_followbtn_widget.dart';
import '../widgets/loadingindicator_widget.dart';
import '../../viewmodel/providers/profile_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BloggerProfileScreen extends StatelessWidget {
  final int authorid;
  final String status;
  const BloggerProfileScreen(
      {super.key, required this.authorid, required this.status});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthorProfileViewModel(authorid),
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
            ),
            body: Consumer<AuthorProfileViewModel>(
                builder: (context, value, child) {
              if (value.fetchstate == PageState.loading) {
                return const Loading();
              } else if (value.fetchstate == PageState.error) {
                return ErrorDialogWiget(
                    errorMessage: value.errorMessage,
                    ontap: () => Provider.of<AuthorProfileViewModel>(context,
                            listen: false)
                        .getprofile(authorid));
              } else {
                return value.userprofile == null
                    ? const Loading()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _BuildAuthorProfileHeader(
                                value: value,
                                authorid: authorid,
                                status: status),
                            SizedBox(
                              height: 3.h,
                            ),
                            SizedBox(
                              height: 35.h,
                              child: const TabBar(tabs: [
                                Tab(
                                  text: "Stories",
                                ),
                                Tab(
                                  text: "About",
                                )
                              ]),
                            ),
                            Expanded(
                                child: TabBarView(children: [
                              _BuildAuthorPostListView(id: authorid),
                              AboutView(aboutText: value.userprofile!.bio),
                            ]))
                          ],
                        ),
                      );
              }
            }),
          )),
    );
  }
}

class _BuildAuthorProfileHeader extends StatelessWidget {
  final AuthorProfileViewModel value;
  final int authorid;
  final String status;
  const _BuildAuthorProfileHeader(
      {required this.value, required this.authorid, required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            CircleAvatar(
              radius: 30.r,
              backgroundImage: NetworkImage(value.userprofile!.image),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    value.userprofile!.user.username,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 20.sp),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/following",
                            arguments: authorid);
                      },
                      child: Text("following ${value.userprofile!.following} .",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontSize: 15.sp)),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/follower",
                              arguments: authorid);
                        },
                        child: Text("follower ${value.userprofile!.followers}",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontSize: 15.sp)))
                  ]),
                ]))
          ]),
          SizedBox(
            height: 10.h,
          ),
          status == "hide"
              ? const SizedBox()
              : FollowBtn(
                  follow: status,
                  authorid: authorid,
                  height: 40.h,
                  width: double.maxFinite,
                ),
        ],
      ),
    );
  }
}

class _BuildAuthorPostListView extends StatelessWidget {
  final int id;
  const _BuildAuthorPostListView({required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthorStoriesViewModel(id),
        child:
            Consumer<AuthorStoriesViewModel>(builder: (context, value, child) {
          if (value.fetchstate == PageState.loading) {
            return const Loading();
          } else if (value.fetchstate == PageState.error) {
            return ErrorDialogWiget(
              errorMessage: value.errorMessage,
              ontap: () =>
                  Provider.of<AuthorStoriesViewModel>(context, listen: false)
                      .getstories(id),
            );
          } else {
            return value.stories.isEmpty
                ? Center(
                    child: Text(
                      "You haven't posted and post yet",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: ColorStyle.lightgray,
                      height: 5.h,
                    ),
                    itemCount: value.stories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/blogdetail',
                                arguments: value.stories[index].slug);
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 20.h),
                              child: Column(children: [
                                _BuildRowPostAuthor(
                                  imgurl: value
                                      .stories[index].author.userprofile.image,
                                  username:
                                      value.stories[index].author.username,
                                ),

                                SizedBox(
                                  height: 10.h,
                                ),

                                _BuildRowPostTitle(
                                    imgurl: value.stories[index].image,
                                    timeago: value.stories[index].timeAgo,
                                    title: value.stories[index].title),
                                // ************************************//
                              ])));
                    },
                  );
          }
        }));
  }
}

class _BuildRowPostAuthor extends StatelessWidget {
  final String imgurl;
  final String username;
  const _BuildRowPostAuthor({required this.imgurl, required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 15.r,
          backgroundImage: NetworkImage(imgurl),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(username, style: Theme.of(context).textTheme.headlineSmall),
        const Spacer(),
      ],
    );
  }
}

class _BuildRowPostTitle extends StatelessWidget {
  final String imgurl;
  final String title;
  final String timeago;
  const _BuildRowPostTitle(
      {required this.imgurl, required this.timeago, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 90.h,
          width: 90.w,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imgurl), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(5)),
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          child: SizedBox(
            height: 90.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  softWrap: true,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Text("Programming",
                    style: TextStyle(color: ColorStyle.lightgreen)),
                Text(
                  timeago.replaceFirst(RegExp(r'Â'), ''),
                  style: Theme.of(context).textTheme.labelSmall,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class AboutView extends StatelessWidget {
  final String aboutText;
  const AboutView({super.key, required this.aboutText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Text(
        aboutText,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(fontSize: 20.sp),
      ),
    );
  }
}
