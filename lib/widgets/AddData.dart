import 'package:flutter/material.dart';

import '../pages/AddPage/ViewContact.dart';
import '../pages/Home/AdminHomePage.dart';
import '../pages/Home/GalleryHomePage.dart';
import '../pages/Home/InternshipHomePage.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        "title": "Gallery Manager",
        "page": const AddGalleryPage1(),
        "icon": Icons.photo_library,
        "color1": Colors.purple,
        "color2": Colors.deepPurpleAccent,
      },
      {
        "title": "Add Admin",
        "page": const AddAdminPage(),
        "icon": Icons.admin_panel_settings,
        "color1": Colors.blue,
        "color2": Colors.lightBlueAccent,
      },
      {
        "title": "Add Internship Projects",
        "page": const AddInternshipPage1(),
        "icon": Icons.school,
        "color1": Colors.orange,
        "color2": Colors.deepOrangeAccent,
      },
      {
        "title": "View Message",
        "page": const ViewMsgPage(),
        "icon": Icons.message,
        "color1": Colors.pink,
        "color2": Colors.pinkAccent,
      },
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2; // default mobile

    if (screenWidth >= 1200) {
      crossAxisCount = 4; // desktop
    } else if (screenWidth >= 800) {
      crossAxisCount = 3;
    }

    // detect mobile (small screens)
    final bool isMobile = screenWidth < 600;
    final double iconSize = isMobile ? 22 : 60;
    final double fontSize = isMobile ? 11 : 18;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.3,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => item["page"]),
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [item["color1"], item["color2"]],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: item["color1"].withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(3, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item["icon"], size: iconSize, color: Colors.white),
                    const SizedBox(height: 12),
                    Text(
                      item["title"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: const [
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(1, 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Dummy Pages
class AddGalleryPage1 extends StatelessWidget {
  const AddGalleryPage1({super.key});
  @override
  Widget build(BuildContext context) {
    return GalleryHomePage();
  }
}

class AddAdminPage extends StatelessWidget {
  const AddAdminPage({super.key});
  @override
  Widget build(BuildContext context) {
    return AdminHomePage();
  }
}

class AddInternshipPage1 extends StatelessWidget {
  const AddInternshipPage1({super.key});
  @override
  Widget build(BuildContext context) {
    return InternshipHomePage();
  }
}

class ViewMsgPage extends StatelessWidget {
  const ViewMsgPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ContactTable();
  }
}
