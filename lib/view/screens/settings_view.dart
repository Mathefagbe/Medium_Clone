// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../viewmodel/providers/themes_viewmodel.dart';

// class SettingScreen extends StatelessWidget {
//   const SettingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pushNamedAndRemoveUntil(
//                 context,
//                 "/nav",
//                 (route) => false,
//               );
//             },
//             icon: const Icon(Icons.arrow_back)),
//         elevation: 1,
//         title: Text(
//           "Settings",
//           style:
//               Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 18),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             const _BuildThemes(),
//             const Divider(
//               height: 10,
//             ),
//             SettingsContent(
//               title: "Help",
//               ontap: () {},
//             ),
//             const Divider(
//               height: 10,
//             ),
//             SettingsContent(
//               title: "Terms of service",
//               ontap: () {},
//             ),
//             const Divider(
//               height: 10,
//             ),
//             SettingsContent(
//               title: "Verison",
//               ontap: () {},
//             ),
//             const Divider(
//               height: 10,
//             ),
//             SettingsContent(
//               title: "Sign out",
//               ontap: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SettingsContent extends StatelessWidget {
//   final String title;

//   final Function() ontap;
//   const SettingsContent({required this.title, required this.ontap, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: ontap,
//       child: ListTile(
//         title: Text(
//           title,
//           style: Theme.of(context).textTheme.labelMedium,
//         ),
//       ),
//     );
//   }
// }

// class _BuildThemes extends StatelessWidget {
//   const _BuildThemes();

//   @override
//   Widget build(BuildContext context) {
//     return SettingsContent(
//       title: 'Theme',
//       ontap: () async {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             titlePadding: const EdgeInsets.all(5),
//             title: Consumer<ThemeProvider>(
//               builder: (context, value, child) => Container(
//                 width: 50,
//                 decoration:
//                     BoxDecoration(borderRadius: BorderRadius.circular(10)),
//                 child: Column(
//                   children: [
//                     ListTile(
//                       title: Text(
//                         "Dark Mode",
//                         style: Theme.of(context).textTheme.labelMedium,
//                       ),
//                       trailing: IconButton(
//                           onPressed: () {
//                             Provider.of<ThemeProvider>(context, listen: false)
//                                 .switchTheme(Mode.dark);
//                             Navigator.pop(context);
//                           },
//                           icon: value.thememode == Mode.dark
//                               ? const Icon(Icons.circle_rounded)
//                               : const Icon(Icons.circle_outlined)),
//                     ),
//                     ListTile(
//                       title: Text(
//                         "Light Mode",
//                         style: Theme.of(context).textTheme.labelMedium,
//                       ),
//                       trailing: IconButton(
//                           onPressed: () {
//                             Provider.of<ThemeProvider>(context, listen: false)
//                                 .switchTheme(Mode.light);
//                             Navigator.pop(context);
//                           },
//                           icon: value.thememode == Mode.light
//                               ? const Icon(Icons.circle_rounded)
//                               : const Icon(Icons.circle_outlined)),
//                     ),
//                     ListTile(
//                       title: Text(
//                         "System Mode",
//                         style: Theme.of(context).textTheme.labelMedium,
//                       ),
//                       trailing: IconButton(
//                           onPressed: () {
//                             Provider.of<ThemeProvider>(context, listen: false)
//                                 .switchTheme(Mode.system);
//                             Navigator.pop(context);
//                           },
//                           icon: value.thememode == Mode.system
//                               ? const Icon(Icons.circle_rounded)
//                               : const Icon(Icons.circle_outlined)),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             elevation: 5,
//             backgroundColor: Theme.of(context).cardColor,
//           ),
//         );
//       },
//     );
//   }
// }
