import 'dart:async';
import 'package:flutter/material.dart';

class VisionCarousel extends StatefulWidget {
  final int visionNum;
  const VisionCarousel({super.key, required this.visionNum});

  @override
  State<VisionCarousel> createState() => _VisionCarouselState();
}

class _VisionCarouselState extends State<VisionCarousel> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  Timer? _timer;
  bool _showOverlay = true;

  late final List<Map<String, String>> _items;

  @override
  void initState() {
    super.initState();

    // Load items based on visionNum
    _items = widget.visionNum == 0
        ? [
            {
              "title": "VISION",
              "desc":
                  "To empower businesses worldwide by providing innovative, scalable, and efficient software solutions that drive transformation, enhance productivity, and achieve long-lasting success. We strive to be a trusted partner, nurturing creativity and excellence while making a positive impact in the tech ecosystem.",
              "image": "assets/compress/DSC_2507-min.webp",
            },
            {
              "title": "MISSION",
              "desc":
                  "Our mission is to deliver tailored software solutions that empower businesses to thrive in a rapidly evolving digital world. By fostering innovation, prioritizing quality, and collaborating closely with our clients, we aim to transform ideas into powerful tools, ensuring efficiency, scalability, and measurable success. We are committed to building a culture of excellence, growth, and trust, driving progress for both our clients and our team.",
              "image": "assets/compress/DSC_2566-min.webp",
            },
            {
              "title": "OUR EXPERTISE",
              "desc":
                  "At Ramchin Technologies Private Limited, we provide a comprehensive suite of Software Development, Data Analysis, Software Testing, and Consultancy Services designed to help businesses achieve excellence and efficiency. With a team of seasoned experts, we deliver tailored, reliable, and cutting-edge solutions.",
              "image": "assets/compress/DSC_2543-min.webp",
            },
          ]
        : [
            {
              "title": "E-Commerce Solutions",
              "desc":
                  "Custom online stores designed for performance, security, and conversion.",
              "image": "assets/compress/DSC_2561-min.jpeg",
            },
            {
              "title": "Web Application",
              "desc": "Robust, scalable, and secure web applications.",
              "image": "assets/compress/DSC_2547-min.jpeg",
            },
            {
              "title": "Mobile Solutions",
              "desc": "Cross-platform iOS and Android apps with seamless UX.",
              "image": "assets/compress/75-min.jpeg",
            },
            {
              "title": "Enterprise Software",
              "desc":
                  "Comprehensive solutions for large-scale business operations.",
              "image": "assets/compress/DSC_2578-min.jpeg",
            },
          ];

    // Precache first two images for smoother start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(AssetImage(_items[0]["image"]!), context);
      if (_items.length > 1) {
        precacheImage(AssetImage(_items[1]["image"]!), context);
      }
    });

    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 7), (_) {
      final nextIndex = (_currentIndex + 1) % _items.length;
      if (_controller.hasClients) {
        _controller.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _cacheAdjacentImages() {
    if (_currentIndex < _items.length - 1) {
      precacheImage(AssetImage(_items[_currentIndex + 1]["image"]!), context);
    }
    if (_currentIndex > 0) {
      precacheImage(AssetImage(_items[_currentIndex - 1]["image"]!), context);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Widget buildBackground(String imagePath) {
    return RepaintBoundary(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          gaplessPlayback: true, // avoids flicker when images change
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: isMobile ? 400 : 500,
        child: PageView.builder(
          controller: _controller,
          itemCount: _items.length,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
            _cacheAdjacentImages();
          },
          itemBuilder: (context, index) {
            final item = _items[index];
            return GestureDetector(
              onTap: () => setState(() => _showOverlay = !_showOverlay),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background image
                  buildBackground(item["image"]!),

                  // Dark overlay
                  AnimatedOpacity(
                    opacity: _showOverlay ? 1 : 0,
                    duration: const Duration(milliseconds: 400),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),

                  // Text overlay (separated widget for fewer rebuilds)
                  OverlayContent(
                    showOverlay: _showOverlay,
                    title: item["title"]!,
                    desc: item["desc"]!,
                    isMobile: isMobile,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class OverlayContent extends StatelessWidget {
  final bool showOverlay;
  final String title;
  final String desc;
  final bool isMobile;

  const OverlayContent({
    super.key,
    required this.showOverlay,
    required this.title,
    required this.desc,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: showOverlay ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(anim),
                  child: child,
                ),
              ),
              child: Text(
                title,
                key: ValueKey("$title$showOverlay"),
                style: TextStyle(
                  fontSize: isMobile ? 24 : 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 700),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.4),
                    end: Offset.zero,
                  ).animate(anim),
                  child: child,
                ),
              ),
              child: ConstrainedBox(
                key: ValueKey("$desc$showOverlay"),
                constraints: BoxConstraints(
                  maxWidth:
                      MediaQuery.of(context).size.width / (isMobile ? 1 : 1.3),
                ),
                child: Text(
                  desc,
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 18,
                    height: isMobile ? 1.6 : 1.8,
                    letterSpacing: 0.3,
                    wordSpacing: isMobile ? 1 : 1.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
