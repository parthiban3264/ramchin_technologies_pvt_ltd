import 'package:flutter/material.dart';
import '../appbar/mobile_appbar.dart';
import 'desktop_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static int selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, 70),
        child: ResponsiveAppBar(
          selectedIndex: selectedIndex,
          onTabSelected: _onTabSelected,
        ),
      ),
      body: DesktopHomePage(
        selectedIndex: selectedIndex,
        onTabSelected: _onTabSelected,
      ),

      // ✅ Floating Contact Icon
      floatingActionButton: FloatingActionButton(
        tooltip: "Contact Us",
        backgroundColor: Colors.blue,
        child: const Icon(Icons.contact_phone, color: Colors.white),
        onPressed: () {
          _onTabSelected(7);
        },
      ),
    );
  }
}
