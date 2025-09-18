// import 'package:flutter/material.dart';
// import '../pages/Home.dart';
//
// class Appbar extends StatefulWidget {
//   final int selectedIndex;
//   final void Function(int) onTabSelected;
//
//   const Appbar({
//     super.key,
//     required this.selectedIndex,
//     required this.onTabSelected,
//   });
//
//   @override
//   AppBarState createState() => AppBarState();
// }
//
// class AppBarState extends State<Appbar> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   final List<String> _tabs = [
//     "Home",
//     "Services",
//     "Products",
//     "Projects",
//     "Internship",
//     "Gallery",
//     "Contact Us",
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(
//       length: _tabs.length,
//       vsync: this,
//       initialIndex: widget.selectedIndex,
//     );
//
//     _tabController.addListener(() {
//       if (_tabController.indexIsChanging) {
//         widget.onTabSelected(_tabController.index);
//       }
//     });
//   }
//
//   @override
//   void didUpdateWidget(covariant Appbar oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (_tabController.index != widget.selectedIndex) {
//       _tabController.animateTo(widget.selectedIndex);
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
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Logo
//           InkWell(
//             onTap: () => widget.onTabSelected(0),
//             child: Image.asset(
//               "assets/ramchinlogoB.png",
//               fit: BoxFit.contain,
//               width: 280,
//               height: 80,
//             ),
//           ),
//           const Spacer(),
//           TabBar(
//             controller: _tabController,
//             isScrollable: true,
//             dividerColor: Colors.transparent,
//             indicator: BoxDecoration(
//               color: Colors.blue.withValues(alpha: 0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             labelColor: Colors.blue,
//             unselectedLabelColor: Colors.black87,
//             labelStyle: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//             unselectedLabelStyle: const TextStyle(fontSize: 15),
//             tabs: _tabs
//                 .map(
//                   (e) => Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: Tab(text: e),
//                   ),
//                 )
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
