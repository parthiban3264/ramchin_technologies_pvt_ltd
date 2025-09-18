// import 'package:flutter/material.dart';
// import '../widgets/Admin.dart';
//
// class DesktopAppBar extends StatefulWidget implements PreferredSizeWidget {
//   final int selectedIndex;
//   final void Function(int) onTabSelected;
//
//   const DesktopAppBar({
//     super.key,
//     required this.selectedIndex,
//     required this.onTabSelected,
//   });
//
//   @override
//   Size get preferredSize => const Size.fromHeight(80);
//
//   @override
//   State<DesktopAppBar> createState() => _DesktopAppBarState();
// }
//
// class _DesktopAppBarState extends State<DesktopAppBar>
//     with TickerProviderStateMixin {
//   late TabController _tabController;
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
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 7, vsync: this);
//     _tabController.index = widget.selectedIndex.clamp(0, 6);
//   }
//
//   @override
//   void didUpdateWidget(covariant DesktopAppBar oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (_tabController.index != widget.selectedIndex &&
//         widget.selectedIndex <= 6) {
//       _tabController.index = widget.selectedIndex;
//     }
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       color: Colors.white,
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Image.asset(
//               "assets/ramchinlogoB.png",
//               fit: BoxFit.contain,
//               width: 220,
//               height: 70,
//             ),
//           ),
//           const Spacer(),
//           TabBar(
//             controller: _tabController,
//             isScrollable: true,
//             indicatorColor: Colors.blue,
//             labelColor: Colors.blue,
//             unselectedLabelColor: Colors.black87,
//             tabs: _tabs.sublist(0, 7).map((t) => Tab(text: t)).toList(),
//             onTap: widget.onTabSelected,
//           ),
//           PopupMenuButton<int>(
//             onSelected: widget.onTabSelected,
//             itemBuilder: (context) {
//               final menu = <PopupMenuEntry<int>>[
//                 const PopupMenuItem(value: 8, child: Text("About Us")),
//               ];
//               if (AdminLoginPage.isLoggedIn == false) {
//                 menu.add(const PopupMenuItem(value: 9, child: Text("Admin")));
//               } else {
//                 menu.add(
//                   const PopupMenuItem(value: 10, child: Text("Add Data")),
//                 );
//               }
//               return menu;
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
