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

class DesktopHomePage extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onTabSelected;

  const DesktopHomePage({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: selectedIndex,
      children: [
        HomePageStack(
          selectedIndex: selectedIndex,
          onTabSelected: onTabSelected,
        ),
        ProductPageStack(),
        TeamPageStack(),
        ProjectPageStack(),
        ServicePageStack(onTabSelected: onTabSelected),
        InternshipPageStack(),
        GalleryPageStack(),
        ContactUsPageStack(onTabSelected: onTabSelected),
        AboutPageStack(),
        AdminPageStack(onTabSelected: onTabSelected),
        AddDataPageStack(),
      ],
    );
  }
}
