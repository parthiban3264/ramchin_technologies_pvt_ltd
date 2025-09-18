import 'package:flutter/material.dart';

import '../../appbar/footer.dart';
import '../ourservices.dart';

class ServicePageStack extends StatelessWidget {
  const ServicePageStack({super.key, required this.onTabSelected});
  final void Function(int) onTabSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OurServices(
            title: "Our Services",
            description:
                "At Ramchin Technologies Private Limited, we provide a comprehensive"
                "suite of Software Development, Data Analysis, Software Testing, and"
                "Consultancy Services designed to help businesses achieve excellence and"
                "efficiency. With a team of seasoned experts, we deliver tailored, reliable,"
                "and cutting-edge solutions.",
          ),
          Footer(onTabSelected: onTabSelected),
        ],
      ),
    );
  }
}
