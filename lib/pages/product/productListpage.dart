import 'package:ramchin_technologies_pvt_ltd/pages/product/product_page.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<AppCard> apps = [
    AppCard(
      app: AppItem(
        'Ramchin Smart School',
        'Track student attendance, manage records, and streamline classroom management.',
        Image.asset(
          'assets/loogo.jpg',
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      ),
      destinationPage: const SchoolPage(),
    ),
    // Add more AppCards here if needed
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final List<AppCard> _visibleApps = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), _showAppsAnimated);
  }

  void _showAppsAnimated() async {
    for (int i = 0; i < apps.length; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      _visibleApps.add(apps[i]);
      _listKey.currentState?.insertItem(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            if (width < 600) {
              // Mobile layout - simple vertical scroll
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _leftSection(isMobile: true),
                    const SizedBox(height: 28),
                    _featuredAppsTitle(),
                    const SizedBox(height: 12),
                    _appsList(),
                  ],
                ),
              );
            } else if (width < 1024) {
              // Tablet layout - two-column, scroll separately, no button
              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      child: _leftSection(isMobile: false),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.grey[200],
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _featuredAppsTitle(),
                          const SizedBox(height: 18),
                          Expanded(child: _appsList()),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              // Desktop layout - side by side without button
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 36,
                        vertical: 48,
                      ),
                      child: _leftSection(isMobile: false),
                    ),
                  ),
                  Container(
                    width: 520,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 48,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(-3, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _featuredAppsTitle(),
                        const SizedBox(height: 18),
                        Expanded(child: _appsList()),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _leftSection({required bool isMobile}) {
    final headlineStyle = TextStyle(
      fontSize: isMobile ? 26 : 36,
      fontWeight: FontWeight.bold,
      letterSpacing: -1,
      height: 1.15,
    );

    final normalTextStyle = TextStyle(
      fontSize: isMobile ? 15 : 16,
      color: Colors.grey[800],
      height: 1.4,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Built for startups,\npowered by innovation",
          style: headlineStyle,
        ),
        const SizedBox(height: 16),
        Text(
          "Streamline your workflow, save time, and scale smarter with our intuitive software platform. Designed to grow with your business while keeping your data safe and secure.",
          style: normalTextStyle,
        ),
        const SizedBox(height: 30),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Icon(Icons.check_circle_outline, color: Colors.red, size: 22),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                "Trusted by early-stage startups and growing teams worldwide.",
                style: TextStyle(fontSize: 15, height: 1.3),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Icon(Icons.security, color: Colors.red, size: 22),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                "Enterprise-grade security and privacy without the enterprise price.",
                style: TextStyle(fontSize: 15, height: 1.3),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Icon(Icons.support_agent, color: Colors.red, size: 22),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                "Responsive 24/7 support to help your startup thrive.",
                style: TextStyle(fontSize: 15, height: 1.3),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Text(
          "\"Tools designed to grow with your vision.\"",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: isMobile ? 14 : 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _featuredAppsTitle() {
    return Text(
      'FEATURED APPS',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        letterSpacing: 1.2,
        fontSize: 16,
      ),
    );
  }

  Widget _appsList() {
    return AnimatedList(
      key: _listKey,
      initialItemCount: _visibleApps.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, 0.15 * (index + 1)),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: _visibleApps[index],
        );
      },
    );
  }
}

class AppItem {
  final String title;
  final String description;
  final Widget icon; // Widget to allow AssetImage/Icon
  AppItem(this.title, this.description, this.icon);
}

class AppCard extends StatelessWidget {
  final AppItem app;
  final Widget destinationPage;

  const AppCard({required this.app, required this.destinationPage, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        color: Colors.white,
        elevation: 2,
        shadowColor: Colors.black26,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => destinationPage),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 14 : 20,
              vertical: isMobile ? 14 : 16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(tag: app.title, child: app.icon),
                SizedBox(width: isMobile ? 16 : 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        app.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: isMobile ? 14 : 18,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        app.description,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: isMobile ? 10 : 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
