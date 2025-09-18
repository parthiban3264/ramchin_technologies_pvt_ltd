// import 'package:flutter/material.dart';
// import '../widgets/Admin.dart';
//
// class TabletAppBar extends StatefulWidget implements PreferredSizeWidget {
//   final int selectedIndex;
//   final void Function(int) onTabSelected;
//
//   const TabletAppBar({
//     super.key,
//     required this.selectedIndex,
//     required this.onTabSelected,
//   });
//
//   @override
//   Size get preferredSize => const Size.fromHeight(80);
//
//   @override
//   State<TabletAppBar> createState() => _TabletAppBarState();
// }
//
// class _TabletAppBarState extends State<TabletAppBar>
//     with TickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
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
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: Image.asset(
//               "assets/ramchinlogoB.png",
//               fit: BoxFit.contain,
//               width: 200,
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
//             tabs: const [
//               Tab(text: "Home"),
//               Tab(text: "Products"),
//               Tab(text: "Project Team"),
//             ],
//             onTap: widget.onTabSelected,
//           ),
//           PopupMenuButton<int>(
//             onSelected: widget.onTabSelected,
//             itemBuilder: (context) {
//               final menu = [
//                 const PopupMenuItem(value: 3, child: Text("Projects")),
//                 const PopupMenuItem(value: 4, child: Text("Services")),
//                 const PopupMenuItem(value: 5, child: Text("Internship")),
//                 const PopupMenuItem(value: 6, child: Text("Gallery")),
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
