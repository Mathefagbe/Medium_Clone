import 'package:dblog/view/widgets/logo.dart';
import 'package:flutter/material.dart';
import '../../model/enums/enums.dart';
import '../style/colors/colorstyle.dart';
import 'package:provider/provider.dart';
import '../widgets/error_dialog_widget.dart';
import '../widgets/loadingindicator_widget.dart';
import '../../viewmodel/providers/home_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.h,
        flexibleSpace: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Logo(),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Home",
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              )
            ],
          ),
        ),
      ),
      body: const PopularViews(),
    );
  }
}

class PopularViews extends StatelessWidget {
  const PopularViews({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => HomeViewModel(context),
        child: Consumer<HomeViewModel>(builder: (context, value, child) {
          if (value.fetchstate == PageState.loading) {
            return const Loading();
          } else if (value.fetchstate == PageState.error) {
            return ErrorDialogWiget(
              errorMessage: value.errorMessage,
              ontap: () => Provider.of<HomeViewModel>(context, listen: false)
                  .getblogpost(context),
            );
          } else {
            return value.blogpost == null
                ? const Loading()
                : _BuildPostList(value: value);
          }
        }));
  }
}

class _BuildPostList extends StatelessWidget {
  final HomeViewModel value;
  const _BuildPostList({required this.value});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(
              color: ColorStyle.lightgray,
              height: 5.h,
            ),
        itemCount: value.blogpost.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/blogdetail',
                  arguments: value.blogpost[index].slug);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                children: [
                  _BuildRowPostAuthor(
                    imgurl: value.blogpost[index].author.userprofile.image,
                    username: value.blogpost[index].author.username,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  _BuildRowPostTitle(
                    imgurl: value.blogpost[index].image,
                    timeago: value.blogpost[index].timeAgo,
                    title: value.blogpost[index].title,
                  )
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
