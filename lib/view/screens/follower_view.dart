import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/enums/enums.dart';
import '../style/colors/colorstyle.dart';
import '../widgets/error_dialog_widget.dart';
import '../widgets/user_followbtn_widget.dart';
import '../widgets/loadingindicator_widget.dart';
import '../../viewmodel/providers/follower_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FollowerView extends StatelessWidget {
  final int id;
  const FollowerView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FollowerViewModel(id),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Followers",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          body: Consumer<FollowerViewModel>(builder: (context, value, child) {
            if (value.fetchstate == PageState.loading) {
              return const Loading();
            } else if (value.fetchstate == PageState.error) {
              return ErrorDialogWiget(
                errorMessage: value.errorMessage,
                ontap: () =>
                    Provider.of<FollowerViewModel>(context, listen: false)
                        .getfollowers(id),
              );
            } else {
              return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        color: ColorStyle.lightgray,
                        height: 5.h,
                      ),
                  itemCount: value.follower.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding:  EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 20.w),
                      leading: CircleAvatar(
                        radius: 20.r,
                        backgroundImage: NetworkImage(
                          value.follower[index].userFrom.userprofile.image,
                        ),
                      ),
                      title: Text(
                        value.follower[index].userFrom.username,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 16.sp),
                      ),
                      subtitle: Text(
                        value.follower[index].userFrom.userprofile.bio,
                        style: Theme.of(context).textTheme.headlineSmall,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: value.follower[index].status == "hide"
                          ? const SizedBox()
                          : FollowBtn(
                              height: 30.h,
                              width: 100.w,
                              authorid: value.follower[index].userFrom.id,
                              follow: value.follower[index].status,
                            ),
                    );
                  });
            }
          }),
        ));
  }
}
