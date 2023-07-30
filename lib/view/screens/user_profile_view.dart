// ignore: file_names
import 'package:dblog/services/api_client/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/enums/enums.dart';
import '../../services/api_client/authentication_post_repository.dart';
import '../style/colors/colorstyle.dart';
import '../../viewmodel/providers/stories_viewmodel.dart';
import '../widgets/error_dialog_widget.dart';
import '../widgets/loadingindicator_widget.dart';
import '../../viewmodel/providers/profile_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                PostAutheniticationHttpRepository.post.logout();
                // Navigator.pushNamed(context, "/settings");
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: ChangeNotifierProvider(
          create: (context) => ProfileViewModel(),
          child: Consumer<ProfileViewModel>(builder: (context, value, child) {
            if (value.fetchstate == PageState.loading) {
              return const Loading();
            } else if (value.fetchstate == PageState.error) {
              return ErrorDialogWiget(
                errorMessage: value.errorMessage,
                ontap: () =>
                    Provider.of<ProfileViewModel>(context, listen: false)
                        .getprofile(),
              );
            } else {
              return value.userprofile == null
                  ? const Loading()
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                      ),
                      child: Column(
                        children: [
                          _BuildUserDetailContainer(value: value),
                          const _BottomTabContainer(),
                          Expanded(
                            child: TabBarView(children: [
                              const _UserPostListView(),
                              _AboutView(
                                aboutText: value.userprofile!.bio,
                              )
                            ]),
                          )
                        ],
                      ),
                    );
            }
          }),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, "/createpost");
            },
            backgroundColor: ColorStyle.lightgreen,
            child: const Icon(Icons.add)),
      ),
    );
  }
}

// ignore: unused_element
class _BuildUserDetailContainer extends StatelessWidget {
  final ProfileViewModel value;
  const _BuildUserDetailContainer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/following",
                              arguments: value.userprofile?.user.id);
                        },
                        child: Text(
                            "${value.userprofile!.following} following.",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontSize: 17.sp)),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/follower",
                              arguments: value.userprofile?.user.id);
                        },
                        child: Text("${value.userprofile!.followers} follower.",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontSize: 17.sp)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        ElevatedButton.icon(
            style: ButtonStyle(
                padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 100.w, vertical: 10.h)),
                backgroundColor:
                    const MaterialStatePropertyAll(ColorStyle.lightgreen)),
            onPressed: () {
              Navigator.pushNamed(context, "/edit_profile", arguments: {
                "imageurl": value.userprofile!.image,
                "aboutuser": value.userprofile!.bio,
              });
            },
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).tabBarTheme.indicatorColor,
            ),
            label: Text(
              "Edit Profile",
              style: Theme.of(context).textTheme.headlineMedium,
            ))
      ],
    );
  }
}

class _BottomTabContainer extends StatelessWidget {
  const _BottomTabContainer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: const TabBar(tabs: [
        Tab(
          text: "Stories",
        ),
        Tab(
          text: "About",
        )
      ]),
    );
  }
}

class _UserPostListView extends StatelessWidget {
  const _UserPostListView();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UserStoriesViewModel(),
        child: Consumer<UserStoriesViewModel>(builder: (context, value, child) {
          if (value.fetchstate == PageState.loading) {
            return const Loading();
          } else if (value.fetchstate == PageState.error) {
            return ErrorDialogWiget(
                errorMessage: value.errorMessage,
                ontap: () =>
                    Provider.of<UserStoriesViewModel>(context, listen: false)
                        .getStories());
          } else {
            return value.userstories.isEmpty
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
                    itemCount: value.userstories.length,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Column(children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 15.r,
                                  backgroundImage: NetworkImage(value
                                      .userstories[index]
                                      .author
                                      .userprofile
                                      .image),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(value.userstories[index].author.username,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                                const Spacer(),
                                PopupMenuButton(
                                    icon: const Icon(Icons.more_vert),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    itemBuilder: (context) => [
                                          PopupMenuItem(
                                              onTap: () => Future(() =>
                                                  Navigator.pushNamed(
                                                      context, "/editpost",
                                                      arguments: {
                                                        "post": value
                                                            .userstories[index]
                                                            .body,
                                                        "slug": value
                                                            .userstories[index]
                                                            .slug
                                                      })),
                                              child: (const Text("Edit"))),
                                          PopupMenuItem(
                                              onTap: () async {
                                                String slug = value
                                                    .userstories[index].slug;
                                                await PostHttpRepository.post
                                                    .delete(slug)
                                                    .then((value) => Provider
                                                            .of<UserStoriesViewModel>(
                                                                context,
                                                                listen: false)
                                                        .refreshstories());
                                              },
                                              child: (const Text("Delete"))),
                                        ]),
                              ],
                            ),
                            // ************************************//
                            SizedBox(
                              height: 5.h,
                            ),
                            // ************************************//
                            InkWell(
                              onTap: () => Navigator.pushNamed(
                                  context, '/blogdetail',
                                  arguments: value.userstories[index].slug),
                              child: Row(children: [
                                Container(
                                  height: 90.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              value.userstories[index].image),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(5.r)),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      value.userstories[index].title,
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    const Text("Programming",
                                        style: TextStyle(
                                            color: ColorStyle.lightgreen)),
                                    Text(
                                      value.userstories[index].timeAgo
                                          .replaceFirst(RegExp(r'Â'), ''),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    )
                                  ],
                                ))
                              ]),
                            )
                          ]));
                    },
                  );
          }
        }));
  }
}

class _AboutView extends StatelessWidget {
  final String aboutText;
  const _AboutView({required this.aboutText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
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
