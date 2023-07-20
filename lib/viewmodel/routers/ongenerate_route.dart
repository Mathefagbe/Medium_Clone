import 'package:dblog/view/screens/edit_profileview.dart';
import 'package:dblog/view/screens/editpost_view.dart';
import 'package:dblog/view/screens/login_view.dart';
import 'package:dblog/view/screens/signup_view.dart';
import 'package:dblog/view/screens/detail_view.dart';
import 'package:dblog/view/screens/follower_view.dart';
import 'package:flutter/material.dart';
import '../../view/screens/comment_view.dart';
import '../../view/screens/createpost_view.dart';
import '../../view/screens/home_view.dart';
import '../../view/screens/nav_view.dart';
import '../../view/screens/author_profile_view.dart';
// import '../../view/screens/settings_view.dart';
import '../../view/screens/following_view.dart';
import '../../view/screens/user_profile_view.dart';

class RouteGenerator {
  static Route<dynamic> generateroute(RouteSettings settings) {
    switch (settings.name) {
      case "/home":
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case "/blogger_profile":
        final kwargs = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => BloggerProfileScreen(
                  authorid: kwargs['authorid'],
                  status: kwargs['status'],
                ));
      case "/blogdetail":
        final slug = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => BlogPostDetailScreen(
                  slug: slug,
                ));
      case '/comment':
        final slug = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => CommentScreen(
                  slug: slug,
                ));
      case '/nav':
        return MaterialPageRoute(
          builder: (context) => const NavigationBottomBarView(),
        );
      case "/login":
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case "/signup":
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );
      // case "/settings":
      //   return MaterialPageRoute(
      //     builder: (context) => const SettingScreen(),
      //   );
      case "/follower":
        final id = settings.arguments as int;
        return MaterialPageRoute(
            builder: (context) => FollowerView(
                  id: id,
                ));
      case "/edit_profile":
        final kwargs = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => EditProfileView(
                  about: kwargs['aboutuser'],
                  imageurl: kwargs['imageurl'],
                ));
      case "/following":
        final id = settings.arguments as int;
        return MaterialPageRoute(
            builder: (context) => FollowingView(
                  id: id,
                ));
      case "/userProfile":
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      case "/editpost":
        final kwargs = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => EditPostView(
                  post: kwargs['post'],
                  slug: kwargs['slug'],
                ));
      case "/createpost":
        return MaterialPageRoute(builder: (context) => const CreatePostView());
      default:
    }
    return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}


// EditProfileView