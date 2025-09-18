import 'package:flutter/material.dart';
import '../InternProjects.dart';
import '../VisionCard.dart';

class ProjectPageStack extends StatelessWidget {
  const ProjectPageStack({super.key});

  @override
  Widget build(BuildContext context) {
    final int VisionNum = 2;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 12),
          InternshipHeader(),
          SizedBox(height: 10),
          // VisionCarousel(index: selectedIndex),
          VisionCarousel(visionNum: VisionNum),
          SizedBox(height: 30),
          MemberCardGrid(),
          SizedBox(height: 30),
          TechStackGrid(),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
