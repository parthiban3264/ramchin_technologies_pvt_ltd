import 'package:flutter/material.dart';

import '../../appbar/footer.dart';
import '../InfoSection.dart';
import '../ManagementMembers.dart';
import '../OurTechStack.dart';
import '../VisionCard.dart';
import '../ourservices.dart';

class HomePageStack extends StatelessWidget {
  const HomePageStack({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });
  final int selectedIndex;
  final void Function(int) onTabSelected;
  final int VisionNum = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          VisionCarousel(visionNum: VisionNum),
          // VisionCarousel(),
          SizedBox(height: 30),
          InfoSection(
            title: "OUR PARTNER IN SUCCESS",
            description:
                "With our deep domain expertise and commitment to innovation, "
                "we ensure our software solutions are reliable,scalable, and future-ready."
                "Let us help you stay ahead in the dynamic world of technology.",
            subtitle:
                "Contact Us Today to learn more and collaborate with our dedicated team.",
          ),
          SizedBox(height: 40),
          OurServices(
            title: "Our Services",
            description:
                "At Ramchin Technologies Private Limited, we provide a comprehensive"
                "suite of Software Development, Data Analysis, Software Testing, and"
                "Consultancy Services designed to help businesses achieve excellence and"
                "efficiency. With a team of seasoned experts, we deliver tailored, reliable,"
                "and cutting-edge solutions.",
          ),
          SizedBox(height: 40),
          OurTechStack(
            title: "Our Tech Stack",
            description:
                "At Ramchin Technologies Private Ltd, we leverage cutting-edge tools and technologies to develop robust,"
                " scalable, and high-performing solutions tailored to meet your unique needs. "
                "Here’s an overview of our core expertise:",
          ),
          SizedBox(height: 40),
          MemberSection(),
          SizedBox(height: 40),
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     buildCard(
          //       description: '',
          //       image: 'assets/Logo.png',
          //       title: 'Vision',
          //     ),
          //     Spacer(),
          //     buildCard(
          //       description: '',
          //       image: 'assets/Logo.png',
          //       title: 'Vision',
          //     ),
          //     Spacer(),
          //     buildCard(
          //       description: '',
          //       image: 'assets/Logo.png',
          //       title: 'Vision',
          //     ),
          //   ],
          // ),
          Footer(onTabSelected: onTabSelected),
        ],
      ),
    );
  }
}
