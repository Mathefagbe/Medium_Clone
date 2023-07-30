import 'package:dblog/view/screens/home_view.dart';
import 'package:dblog/viewmodel/providers/navigate_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_profile_view.dart';
import 'search_view.dart';


class NavigationBottomBarView extends StatelessWidget {
  const NavigationBottomBarView({super.key});

  @override
  Widget build(BuildContext context) {
    var currentindex = Provider.of<NavigateViewModel>(context).currentindex;
    return Scaffold(
        body: screen.elementAt(currentindex),
        bottomNavigationBar: BottomNavigationBar(
            elevation: 3,
            selectedItemColor: Theme.of(context).tabBarTheme.labelColor,
            unselectedItemColor:
                Theme.of(context).tabBarTheme.unselectedLabelColor,
            currentIndex: currentindex,
            onTap: (index) {
              Provider.of<NavigateViewModel>(context, listen: false)
                  .getindex(index);
            },
            items: const [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "search",
                icon: Icon(Icons.search),
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(Icons.person),
              ),
            ]));
  }
}

List<Widget> screen = [
  const HomeScreen(),
  SearchScreen(),
  const ProfileScreen(),
];
