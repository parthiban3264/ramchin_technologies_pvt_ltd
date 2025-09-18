import 'package:flutter/material.dart';

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
    return AdminLoginPage(onTabSelected: widget.onTabSelected);
  }
}
