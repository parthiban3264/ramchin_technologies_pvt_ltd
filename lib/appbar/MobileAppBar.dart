// import 'package:flutter/material.dart';
// import '../widgets/Admin.dart';
//
// class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final int selectedIndex;
//   final void Function(int) onTabSelected;
//
//   const MobileAppBar({
//     super.key,
//     required this.selectedIndex,
//     required this.onTabSelected,
//   });
//
//   @override
//   Size get preferredSize => const Size.fromHeight(80);
//
//   final List<String> _tabs = const [
//     "Home",
//     "Products",
//     "Project Team",
//     "Projects",
//     "Services",
//     "Internship",
//     "Gallery",
//     "Contact Us",
//     "About Us",
//     "Admin",
//     "Add Data",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 4,
//       automaticallyImplyLeading: false,
//       leadingWidth: 220,
//       leading: Padding(
//         padding: const EdgeInsets.all(2.0),
//         child: Image.asset(
//           "assets/ramchinlogoB.png",
//           fit: BoxFit.contain,
//           width: 220,
//           height: 80,
//         ),
//       ),
//       actions: [
//         PopupMenuButton<int>(
//           onSelected: onTabSelected,
//           itemBuilder: (context) {
//             final items = <PopupMenuEntry<int>>[];
//             for (var i = 0; i <= 8; i++) {
//               if (i == 7) continue; // skip contact us
//               items.add(PopupMenuItem(value: i, child: Text(_tabs[i])));
//             }
//             if (AdminLoginPage.isLoggedIn == false) {
//               items.add(PopupMenuItem(value: 9, child: Text(_tabs[9])));
//             } else {
//               items.add(PopupMenuItem(value: 10, child: Text(_tabs[10])));
//             }
//             return items;
//           },
//           icon: const Icon(Icons.menu, color: Colors.black87, size: 35),
//         ),
//       ],
//     );
//   }
// }
