import 'dart:math';
import 'package:flutter/material.dart';

class ServiceCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final String moreText;
  final List<Color> colors;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.moreText,
    required this.colors,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard>
    with SingleTickerProviderStateMixin {
  bool _showBack = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  void _toggleCard() {
    if (_showBack) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() => _showBack = !_showBack);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildFrontCard(bool isMobile) {
    final titleSize = isMobile ? 16.0 : 20.0;
    final descSize = isMobile ? 0.0 : 14.0;

    return _cardWrapper(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              child: Icon(widget.icon, size: 34, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (!isMobile) ...[
              const SizedBox(height: 12),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: descSize,
                  height: 1.5,
                  color: Colors.white70,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBackCard() {
    return _cardWrapper(
      child: Center(
        child: Text(
          "${widget.description}\n\n${widget.moreText}",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            height: 1.5,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _cardWrapper({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: widget.colors.last.withValues(alpha: 0.4),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final bool isMobile = width < 600;

    Widget cardCore = GestureDetector(
      onTap: _toggleCard,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final angle = _controller.value * pi;
          final isBack = angle > pi / 2;
          final scale = 1 - (0.05 * sin(angle));
          return Transform(
            transform: Matrix4.identity()
              ..rotateY(angle)
              ..scale(scale),
            alignment: Alignment.center,
            child: isBack
                ? Transform(
                    transform: Matrix4.rotationY(pi),
                    alignment: Alignment.center,
                    child: _buildBackCard(),
                  )
                : _buildFrontCard(isMobile),
          );
        },
      ),
    );

    // Desktop hover
    // if (isDesktop) {
    //   cardCore = MouseRegion(
    //     cursor: SystemMouseCursors.click,
    //     onEnter: (_) => setState(() => _isHover = true),
    //     onExit: (_) => setState(() => _isHover = false),
    //     child: cardCore,
    //   );
    // }

    return cardCore;
  }
}

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    int crossAxisCount;
    double aspectRatio;

    if (width >= 1200) {
      crossAxisCount = 3;
      aspectRatio = 1.5;
    } else if (width >= 900) {
      crossAxisCount = 3;
      aspectRatio = 1.2;
    } else if (width >= 600) {
      crossAxisCount = 2;
      aspectRatio = 1.2;
    } else {
      crossAxisCount = 1;
      aspectRatio = 1.1;
    }

    final services = [
      ServiceCard(
        icon: Icons.settings,
        title: "Software Development",
        description:
            "Custom software solutions tailored to meet your unique business needs.",
        moreText:
            "From design, development, to deployment and maintenance, we ensure robust, scalable applications.",
        colors: [Colors.blue, Colors.blueAccent],
      ),
      ServiceCard(
        icon: Icons.analytics,
        title: "Data Analysis & Data Science",
        description:
            "Turning raw data into actionable insights using advanced tools and techniques.",
        moreText:
            "Our team helps you make better decisions with advanced analytics and real-time dashboards.",
        colors: [Colors.deepPurple, Colors.purpleAccent],
      ),
      ServiceCard(
        icon: Icons.bug_report,
        title: "Software Testing",
        description:
            "Validate the core functionalities and features of your software.",
        moreText:
            "We provide automated/manual testing, performance checks, and custom testing frameworks.",
        colors: [Colors.teal, Colors.green],
      ),
      ServiceCard(
        icon: Icons.security,
        title: "Cybersecurity",
        description:
            "Strategic advice to align technology with business goals.",
        moreText:
            "We provide vulnerability assessment, penetration testing, and compliance checks.",
        colors: [Colors.redAccent, Colors.deepOrange],
      ),
      ServiceCard(
        icon: Icons.cloud_circle,
        title: "Data Warehousing",
        description:
            "We specialize in designing and implementing modern, scalable data warehousing solutions.",
        moreText:
            "Our experts design, implement, and manage scalable cloud infrastructures.",
        colors: [Colors.indigo, Colors.lightBlue],
      ),
      ServiceCard(
        icon: Icons.support_agent,
        title: "IT Support & Maintenance",
        description:
            "We leverage modern tools and technologies to deliver high-quality support services.",
        moreText:
            "We align technology with your business strategy to maximize ROI.",
        colors: [Colors.pink, Colors.purple],
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: aspectRatio,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) => services[index],
    );
  }
}

class OurServices extends StatelessWidget {
  final String title;
  final String description;
  final String? subtitle;
  final TextAlign textAlign;

  const OurServices({
    super.key,
    required this.title,
    required this.description,
    this.subtitle,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      color: const Color(0xFFF7F9FC),
      child: Column(
        crossAxisAlignment: textAlign == TextAlign.center
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: textAlign,
            style: TextStyle(
              fontSize: width < 600 ? 22 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: textAlign,
            style: TextStyle(
              fontSize: width < 600 ? 14 : 18,
              height: 1.6,
              color: Colors.black54,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 25),
            Text(
              subtitle!,
              textAlign: textAlign,
              style: TextStyle(
                fontSize: width < 600 ? 12 : 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
          const SizedBox(height: 50),
          const ServicesSection(),
        ],
      ),
    );
  }
}
