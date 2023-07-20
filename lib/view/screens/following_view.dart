import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/enums/enums.dart';
import '../style/colors/colorstyle.dart';
import '../widgets/error_dialog_widget.dart';
import '../widgets/user_followbtn_widget.dart';
import '../widgets/loadingindicator_widget.dart';
import '../../viewmodel/providers/following_viewmodel.dart';

class FollowingView extends StatelessWidget {
  final int id;
  const FollowingView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FollowingViewModel(id),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Following",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            elevation: 0,
          ),
          body: Consumer<FollowingViewModel>(builder: (context, value, child) {
            if (value.fetchstate == PageState.loading) {
              return const Loading();
            } else if (value.fetchstate == PageState.error) {
              return ErrorDialogWiget(
                errorMessage: value.errorMessage,
                ontap: () =>
                    Provider.of<FollowingViewModel>(context, listen: false)
                        .getfollowingusers(id),
              );
            } else {
              return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        color: ColorStyle.lightgray,
                        height: 5,
                      ),
                  itemCount: value.following.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            value.following[index].userTo.userprofile.image,
                          ),
                        ),
                        title: Text(
                          value.following[index].userTo.username,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontSize: 16),
                        ),
                        subtitle: Text(
                          value.following[index].userTo.userprofile.bio,
                          style: Theme.of(context).textTheme.headlineSmall,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: value.following[index].status == "hide"
                            ? const SizedBox()
                            : FollowBtn(
                                width: 100,
                                height: 30,
                                authorid: value.following[index].userTo.id,
                                follow: value.following[index].status,
                              ),
                      ),
                    );
                  });
            }
          }),
        ));
  }
}
