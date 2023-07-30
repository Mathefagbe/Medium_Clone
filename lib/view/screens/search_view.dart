import 'package:dblog/view/style/colors/colorstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/enums/enums.dart';
import '../widgets/commentbox_form.dart';
import '../widgets/error_dialog_widget.dart';
import '../widgets/loadingindicator_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../viewmodel/providers/search_viewmodel.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  String searchvalue = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchViewModel(),
      builder: (_, child) => Scaffold(
          appBar: AppBar(
            toolbarHeight: 100.h,
            title: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Column(children: [
                Text(
                  "Explore",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontSize: 20.sp),
                ),
               SizedBox(
                  height: 10.h,
                ),
                TextField(
                  style: Theme.of(context).textTheme.labelMedium,
                  onChanged: (String value) {
                    searchvalue = value;
                    Provider.of<SearchViewModel>(_, listen: false)
                        .getsearchpost(searchvalue);
                  },
                  decoration: formBox.copyWith(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                          onPressed: () {
                            searchvalue = '';
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: ColorStyle.lightgreen,
                          )),
                      hintText: "Search Medium",
                      hintStyle: Theme.of(context).textTheme.labelMedium,
                      fillColor: Theme.of(context).cardColor,
                      filled: true),
                ),
              ]),
            ),
          ),
          body: Consumer<SearchViewModel>(builder: (context, value, child) {
            if (value.fetchstate == PageState.loading) {
              return const Loading();
            } else if (value.fetchstate == PageState.error) {
              return ErrorDialogWiget(
                errorMessage: value.errrormessage,
                ontap: () =>
                    Provider.of<SearchViewModel>(context, listen: false)
                        .getsearchpost(searchvalue),
              );
            } else {
              return value.searchpost == null
                  ? const Center(
                      child: Text("search a blog"),
                    )
                  : _BuildSearhPost(
                      value: value,
                    );
            }
          })),
    );
  }
}

class _BuildSearhPost extends StatelessWidget {
  final SearchViewModel value;

  const _BuildSearhPost({required this.value});

  @override
  Widget build(BuildContext context) {
    return value.searchpost.isEmpty
        ? const Center(
            child: Text("No post found"),
          )
        : _BuildPostList(value: value);
  }
}

class _BuildPostList extends StatelessWidget {
  final SearchViewModel value;
  const _BuildPostList({required this.value});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) =>  Divider(
              color: ColorStyle.lightgray,
              height: 5.h,
            ),
        itemCount: value.searchpost.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/blogdetail',
                  arguments: value.searchpost[index].slug);
            },
            child: Container(
              padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              child: Column(
                children: [
                  _BuildRowPostAuthor(
                    imgurl: value.searchpost[index].author.userprofile.image,
                    username: value.searchpost[index].author.username,
                  ),
                  // ************************************//
                  SizedBox(
                    height: 10.h,
                  ),
                  _BuildRowPostTitle(
                    imgurl: value.searchpost[index].image,
                    timeago: value.searchpost[index].timeAgo,
                    title: value.searchpost[index].title,
                  )
                  // ************************************//
                ],
              ),
            ),
          );
        });
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
        const Icon(Icons.more_vert)
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
