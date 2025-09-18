import 'package:flutter/material.dart';

import '../Team.dart';

class TeamPageStack extends StatelessWidget {
  const TeamPageStack({super.key});

  @override
  Widget build(BuildContext context) {
    return TeamPage();
  }
}

// // Floating Back Button
// Positioned(
// top: 40,
// left: 16,
// child: FloatingActionButton(
// mini: true,
// backgroundColor: Colors.white,
// onPressed: () => Navigator.pop(context),
// child: const Icon(Icons.arrow_back, color: Colors.black87),
// ),
// ),
