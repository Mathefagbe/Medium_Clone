import 'package:dblog/view/screens/auth_wrapper.dart';
import 'package:dblog/viewmodel/providers/auth_viewmodel.dart';
import 'package:dblog/viewmodel/providers/imagepicker.dart';
import 'package:dblog/viewmodel/providers/password_visibility.dart';
import 'package:dblog/viewmodel/routers/ongenerate_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'viewmodel/providers/navigate_viewmodel.dart';
import 'viewmodel/providers/themes_viewmodel.dart';
import 'view/style/themes/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> naviagtorkey = GlobalKey();

String basetoken = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  basetoken = pref.getString("accesstoken") ?? "";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(360.0, 734.0),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => VisibilityNotifier()),
          ChangeNotifierProvider(create: (context) => NavigateViewModel()),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => ImagesPickerProvdier()),
          ChangeNotifierProvider(
              create: (context) => SignInAuthChangeNotifer()),
          ChangeNotifierProvider(create: (context) => SignUpAuthChangeNotifer())
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, provider, widget) => MaterialApp(
            darkTheme: CustomThemes.dark(),
            theme: CustomThemes.light(),
            themeMode: provider.thememode == Mode.dark
                ? ThemeMode.dark
                : provider.thememode == Mode.light
                    ? ThemeMode.light
                    : ThemeMode.system,
            home: const WrapperView(),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.generateroute,
            initialRoute: '/',
            navigatorKey: naviagtorkey,
          ),
        ),
      ),
    );
  }
}
