import 'package:flutter/material.dart';

import '../../appbar/footer.dart';
import '../Admin.dart';

class AdminPageStack extends StatefulWidget {
  final void Function(int) onTabSelected;
  const AdminPageStack({super.key, required this.onTabSelected});

  @override
  State<AdminPageStack> createState() => _AdminPageStackState();
}

class _AdminPageStackState extends State<AdminPageStack> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.blue.shade50,
        child: Column(
          children: [AdminLoginPage(onTabSelected: widget.onTabSelected)],
        ),
      ),
    );
  }
}
