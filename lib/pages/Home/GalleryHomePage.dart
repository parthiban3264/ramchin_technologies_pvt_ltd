import 'package:flutter/material.dart';
import '../AddPage/AddGallery.dart';

class GalleryHomePage extends StatefulWidget {
  const GalleryHomePage({super.key});

  @override
  State<GalleryHomePage> createState() => _GalleryHomePageState();
}

class _GalleryHomePageState extends State<GalleryHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [AddGalleryPage(), GalleryTablePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        title: const Text(
          "Gallery Manager",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black26,
      ),

      // Main content
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: IndexedStack(
          key: ValueKey<int>(_currentIndex),
          index: _currentIndex,
          children: _pages,
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.blue.shade800,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: "Add",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart_outlined),
              label: "Table",
            ),
          ],
        ),
      ),
    );
  }
}
