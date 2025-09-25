import 'package:flutter/material.dart';
import '../widgets/stacks/About_page_stack.dart';
import '../widgets/stacks/AddData_page_stack.dart';
import '../widgets/stacks/Admin_page_stack.dart';
import '../widgets/stacks/Team_page_stack.dart';
import '../widgets/stacks/home_page_stack.dart';
import '../widgets/stacks/service_page_stack.dart';
import '../widgets/stacks/product_page_stack.dart';
import '../widgets/stacks/project_page_stack.dart';
import '../widgets/stacks/internship__page_stack.dart';
import '../widgets/stacks/gallery_page_stack.dart';
import '../widgets/stacks/contact_us__page_stack.dart';
//
// class DesktopHomePage extends StatelessWidget {
//   final int selectedIndex;
//   final void Function(int) onTabSelected;
//
//   const DesktopHomePage({
//     super.key,
//     required this.selectedIndex,
//     required this.onTabSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return IndexedStack(
//       index: selectedIndex,
//       children: [
//         HomePageStack(
//           selectedIndex: selectedIndex,
//           onTabSelected: onTabSelected,
//         ),
//         ProductPageStack(),
//         TeamPageStack(),
//         ProjectPageStack(),
//         ServicePageStack(onTabSelected: onTabSelected),
//         InternshipPageStack(),
//         GalleryPageStack(),
//         ContactUsPageStack(onTabSelected: onTabSelected),
//         AboutPageStack(),
//         AdminPageStack(onTabSelected: onTabSelected),
//         AddDataPageStack(),
//       ],
//     );
//   }
// }

class DesktopHomePage extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onTabSelected;

  const DesktopHomePage({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  State<DesktopHomePage> createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<DesktopHomePage> {
  int _currentIndex = 0;

  @override
  void didUpdateWidget(covariant DesktopHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedIndex != _currentIndex) {
      // ✅ Release focus when changing tab so keyboard doesn’t get stuck
      FocusScope.of(context).unfocus();
      setState(() {
        _currentIndex = widget.selectedIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ This ensures keyboard pushes content up
      // resizeToAvoidBottomInset: true,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomePageStack(
            selectedIndex: _currentIndex,
            onTabSelected: widget.onTabSelected,
          ),
          ProductPageStack(),
          TeamPageStack(),
          ProjectPageStack(),
          ServicePageStack(onTabSelected: widget.onTabSelected),
          InternshipPageStack(),
          GalleryPageStack(),
          ContactUsPageStack(onTabSelected: widget.onTabSelected),
          AboutPageStack(),
          AdminPageStack(onTabSelected: widget.onTabSelected),
          AddDataPageStack(),
        ],
      ),
    );
  }
}
