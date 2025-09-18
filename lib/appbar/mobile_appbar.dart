import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/Admin.dart';

class ResponsiveAppBar extends StatefulWidget implements PreferredSizeWidget {
  final int selectedIndex;
  final void Function(int) onTabSelected;

  const ResponsiveAppBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  State<ResponsiveAppBar> createState() => _ResponsiveAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _ResponsiveAppBarState extends State<ResponsiveAppBar>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  TabController? _desktopController;
  TabController? _tabletController;
  bool _isOuterMenu = false;
  Timer? _resizeDebounce;

  final List<String> _tabs = const [
    "Home", // 0
    "Products", // 1
    "Project Team", // 2
    "Projects", // 3
    "Services", // 4
    "Internship", // 5
    "Gallery", // 6
    "Contact Us", // 7
    "About Us", // 8
    "Admin", // 9
    "Add Data", // 10
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didUpdateWidget(covariant ResponsiveAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncControllersWithSelectedIndex();
  }

  void _syncControllersWithSelectedIndex() {
    if (_desktopController != null &&
        _desktopController!.index != widget.selectedIndex &&
        widget.selectedIndex <= 6) {
      _desktopController!.index = widget.selectedIndex;
    }
    if (_tabletController != null &&
        _tabletController!.index != widget.selectedIndex &&
        widget.selectedIndex <= 2) {
      _tabletController!.index = widget.selectedIndex;
    }
  }

  @override
  void didChangeMetrics() {
    _resizeDebounce?.cancel();
    _resizeDebounce = Timer(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      setState(() {});
    });

    // Close keyboard / popup safely
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      FocusManager.instance.primaryFocus?.unfocus();
      if (Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).maybePop();
      }
    });
    super.didChangeMetrics();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _desktopController?.dispose();
    _tabletController?.dispose();
    _resizeDebounce?.cancel();
    super.dispose();
  }

  TabController _createController(int length) {
    return TabController(length: length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    final bool isDesktop = screenWidth >= 1024;

    if (isMobile) {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        automaticallyImplyLeading: false,
        leadingWidth: 220,
        leading: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Image.asset(
            "assets/ramchinlogoB.png",
            fit: BoxFit.contain,
            width: 220,
            height: 80,
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() => _isOuterMenu = true);
                widget.onTabSelected(value);
              });
            },
            itemBuilder: (context) {
              final items = <PopupMenuEntry<int>>[];
              for (var i = 0; i <= 8; i++) {
                if (i == 7) continue;
                items.add(PopupMenuItem(value: i, child: Text(_tabs[i])));
              }
              if (AdminLoginPage.isLoggedIn == false) {
                items.add(PopupMenuItem(value: 9, child: Text(_tabs[9])));
              } else {
                items.add(PopupMenuItem(value: 10, child: Text(_tabs[10])));
              }
              return items;
            },
            icon: const Icon(Icons.menu, color: Colors.black87, size: 35),
          ),
        ],
      );
    }

    if (isTablet) {
      _tabletController?.dispose();
      _tabletController = _createController(3);
      _syncControllersWithSelectedIndex();

      return Container(
        height: 80,
        color: Colors.white,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Image.asset(
                "assets/ramchinlogoB.png",
                fit: BoxFit.contain,
                width: 200,
                height: 70,
              ),
            ),
            const Spacer(),
            TabBar(
              controller: _tabletController,
              isScrollable: true,
              indicatorColor: _isOuterMenu ? Colors.transparent : Colors.blue,
              labelColor: _isOuterMenu ? Colors.black87 : Colors.blue,
              unselectedLabelColor: Colors.black87,
              tabs: const [
                Tab(text: "Home"),
                Tab(text: "Products"),
                Tab(text: "Project Team"),
              ],
              onTap: (index) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() => _isOuterMenu = false);
                  widget.onTabSelected(index);
                });
              },
            ),
            PopupMenuButton<int>(
              onSelected: (value) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() => _isOuterMenu = true);
                  widget.onTabSelected(value);
                });
              },
              itemBuilder: (context) {
                final menuItem = [
                  const PopupMenuItem(value: 3, child: Text("Projects")),
                  const PopupMenuItem(value: 4, child: Text("Services")),
                  const PopupMenuItem(value: 5, child: Text("Internship")),
                  const PopupMenuItem(value: 6, child: Text("Gallery")),
                  const PopupMenuItem(value: 8, child: Text("About Us")),
                ];
                if (AdminLoginPage.isLoggedIn == false) {
                  menuItem.add(
                    const PopupMenuItem(value: 9, child: Text("Admin")),
                  );
                } else {
                  menuItem.add(
                    const PopupMenuItem(value: 10, child: Text("Add Data")),
                  );
                }
                return menuItem;
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.more_vert, color: Colors.black87),
              ),
            ),
          ],
        ),
      );
    }

    if (isDesktop) {
      _desktopController?.dispose();
      _desktopController = _createController(7);
      _syncControllersWithSelectedIndex();

      return Container(
        height: 80,
        color: Colors.white,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Image.asset(
                "assets/ramchinlogoB.png",
                fit: BoxFit.contain,
                width: 220,
                height: 70,
              ),
            ),
            const Spacer(),
            TabBar(
              controller: _desktopController,
              isScrollable: true,
              indicatorColor: _isOuterMenu ? Colors.transparent : Colors.blue,
              labelColor: _isOuterMenu ? Colors.black87 : Colors.blue,
              unselectedLabelColor: Colors.black87,
              tabs: _tabs.sublist(0, 7).map((t) => Tab(text: t)).toList(),
              onTap: (index) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() => _isOuterMenu = false);
                  widget.onTabSelected(index);
                });
              },
            ),
            PopupMenuButton<int>(
              onSelected: (value) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() => _isOuterMenu = true);
                  widget.onTabSelected(value);
                });
              },
              itemBuilder: (context) {
                final List<PopupMenuEntry<int>> menuItems = [
                  const PopupMenuItem(value: 8, child: Text("About Us")),
                ];
                if (AdminLoginPage.isLoggedIn == false) {
                  menuItems.add(
                    const PopupMenuItem(value: 9, child: Text("Admin")),
                  );
                } else {
                  menuItems.add(
                    const PopupMenuItem(value: 10, child: Text("Add Data")),
                  );
                }
                return menuItems;
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.more_vert, color: Colors.black87),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

// import 'package:flutter/material.dart';
// import '../widgets/Admin.dart';
// import 'DesktopAppBar.dart';
// import 'MobileAppBar.dart';
// import 'TabletAppBar.dart';
//
// class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final int selectedIndex;
//   final void Function(int) onTabSelected;
//
//   const ResponsiveAppBar({
//     super.key,
//     required this.selectedIndex,
//     required this.onTabSelected,
//   });
//
//   @override
//   Size get preferredSize => const Size.fromHeight(80);
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//
//     if (width < 600) {
//       return MobileAppBar(
//         selectedIndex: selectedIndex,
//         onTabSelected: onTabSelected,
//       );
//     } else if (width < 1024) {
//       return TabletAppBar(
//         selectedIndex: selectedIndex,
//         onTabSelected: onTabSelected,
//       );
//     } else {
//       return DesktopAppBar(
//         selectedIndex: selectedIndex,
//         onTabSelected: onTabSelected,
//       );
//     }
//   }
// }
