// // import 'dart:math';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:psn_employee_app/auth/login_page.dart';
// import 'package:rive/rive.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../model/provider/provider.dart';
// import '../model/rive_asset.dart';
// import '../utils/rive_utils.dart';
// import 'info_tile.dart';
// import 'side_menu_tile.dart';

// class SideMenu extends StatefulWidget {
//   const SideMenu(
//       {super.key, required this.animation, required this.scaleAnimation});
//   final Animation<double> animation;
//   final Animation<double> scaleAnimation;
//   @override
//   State<SideMenu> createState() => _SideMenuState();
// }

// class _SideMenuState extends State<SideMenu> {
//   RiveAsset selectedMenu = sideMenus.first;
//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<ProviderModel>(context);

//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 160, 114, 238),
//       // backgroundColor: Theme.of(context).colorScheme.onPrimary,
//       body: SafeArea(
//         child: Transform(
//           alignment: Alignment.center,
//           transform: Matrix4.identity()..setEntry(3, 2, 0.001)
//           // ..rotateY(-(1 - 40 * 1 * pi / 180))
//           , // Use the opposite sign

//           child: Transform.translate(
//             offset: Offset(-0, 0), // Use the opposite sign

//             child: Transform.scale(
//               scale: 1, // Use the opposite sign
//               child: ClipRRect(
//                 borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(widget.animation.value * 24),
//                     bottomRight: Radius.circular(widget.animation.value * 24)),
//                 child: Container(
//                   width: 288,
//                   height: double.infinity,
//                   decoration: const BoxDecoration(
//                     color: Color.fromARGB(255, 160, 114, 238),
//                     // color: Theme.of(context).colorScheme.onPrimary,
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(25.0),
//                       bottomRight: Radius.circular(25.0),
//                     ),
//                   ),
//                   // color: Theme.of(context).colorScheme.onBackground,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         InfoTile(
//                           name: userProvider.user!.name,
//                           profession: "",
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               left: 24, top: 32, bottom: 16),
//                           child: Text("BROWSE",
//                               style: TextStyle(
//                                 color: Theme.of(context).colorScheme.background,
//                               )),
//                         ),
//                         ...sideMenus.map(
//                           (menu) => SideMenuTile(
//                             menu: menu,
//                             riveonInit: (artboard) {
//                               StateMachineController controller =
//                                   RiveUtils.getRiveController(artboard,
//                                       stateMachineName: menu.stateMachineName);
//                               menu.input =
//                                   controller.findSMI("active") as SMIBool;
//                             },
//                             press: () {
//                               menu.input!.change(true);
//                               Future.delayed(const Duration(seconds: 1), () {
//                                 menu.input!.change(false);
//                               });
//                               setState(() {
//                                 selectedMenu = menu;
//                               });
//                             },
//                             isActive: selectedMenu == menu,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               left: 24, top: 32, bottom: 16),
//                           child: Text("History".toUpperCase(),
//                               style: TextStyle(
//                                 color: Theme.of(context).colorScheme.background,
//                               )),
//                         ),
//                         ...sideMenu2.map(
//                           (menu) => SideMenuTile(
//                             menu: menu,
//                             riveonInit: (artboard) {
//                               StateMachineController controller =
//                                   RiveUtils.getRiveController(artboard,
//                                       stateMachineName: menu.stateMachineName);
//                               menu.input =
//                                   controller.findSMI("active") as SMIBool;
//                             },
//                             press: () {
//                               menu.input!.change(true);
//                               Future.delayed(const Duration(seconds: 1), () {
//                                 menu.input!.change(false);
//                               });
//                               setState(() {
//                                 selectedMenu = menu;
//                               });
//                             },
//                             isActive: selectedMenu == menu,
//                           ),
//                         ),
//                         ...sideMenu3.map(
//                           (menu) => SideMenuTile(
//                             menu: menu,
//                             riveonInit: (artboard) {
//                               StateMachineController controller =
//                                   RiveUtils.getRiveController(artboard,
//                                       stateMachineName: menu.stateMachineName);
//                               menu.input =
//                                   controller.findSMI("active") as SMIBool;
//                             },
//                             press: () async {
//                               Navigator.pushReplacement(
//                                   // ignore: use_build_context_synchronously
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const LoginPage(),
//                                   ));
//                             },
//                             isActive: selectedMenu == menu,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
