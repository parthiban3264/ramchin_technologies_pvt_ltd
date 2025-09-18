import 'package:flutter/material.dart';

class AboutPageStack extends StatelessWidget {
  const AboutPageStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Coming Soon. . .",
            style: TextStyle(color: Colors.grey.shade400, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
