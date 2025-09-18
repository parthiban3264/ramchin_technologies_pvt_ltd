import 'dart:ui';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class InfoSection extends StatefulWidget {
  final String title;
  final String description;
  final String? subtitle;
  final TextAlign textAlign;

  const InfoSection({
    super.key,
    required this.title,
    required this.description,
    this.subtitle,
    this.textAlign = TextAlign.center,
  });

  @override
  State<InfoSection> createState() => _InfoSectionState();
}

class _InfoSectionState extends State<InfoSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _hover = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 600;

    // Adjust font sizes and padding for mobile
    final titleSize = isMobile ? 24.0 : 34.0;
    final descSize = isMobile ? 14.0 : 18.0;
    final subtitleSize = isMobile ? 14.0 : 16.0;
    final verticalPadding = isMobile ? 32.0 : 60.0;
    final horizontalPadding = isMobile ? 16.0 : 32.0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 15),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: SlideTransition(
          position: _offsetAnimation,
          child: AnimatedScale(
            scale: _hover ? 1.02 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: Card(
              elevation: _hover ? 20 : 12,
              shadowColor: _hover
                  ? Colors.indigo.withOpacity(0.4)
                  : Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: kIsWeb ? 4 : 12,
                    sigmaY: kIsWeb ? 4 : 12,
                  ),
                  child: Container(
                    width: isMobile ? double.infinity : 1150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.85),
                          Colors.indigo.shade50.withOpacity(0.65),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1.2,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: verticalPadding,
                      horizontal: horizontalPadding,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: widget.textAlign == TextAlign.center
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        // Decorative Animated Gradient Line
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                          height: 5,
                          width: _hover ? 80 : 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            gradient: const LinearGradient(
                              colors: [Colors.indigo, Colors.blueAccent],
                            ),
                          ),
                        ),
                        SizedBox(height: verticalPadding * 0.25),

                        // Title
                        Text(
                          widget.title,
                          textAlign: widget.textAlign,
                          style: TextStyle(
                            fontSize: titleSize,
                            fontWeight: FontWeight.w800,
                            color: Colors.indigo,
                            letterSpacing: 0.6,
                          ),
                        ),
                        SizedBox(height: verticalPadding * 0.2),

                        // Description
                        Text(
                          widget.description,
                          textAlign: widget.textAlign,
                          style: TextStyle(
                            fontSize: descSize,
                            height: 1.7,
                            color: Colors.grey.shade800,
                          ),
                        ),

                        // Subtitle (optional)
                        if (widget.subtitle != null) ...[
                          SizedBox(height: verticalPadding * 0.25),
                          Text(
                            widget.subtitle!,
                            textAlign: widget.textAlign,
                            style: TextStyle(
                              fontSize: subtitleSize,
                              fontWeight: FontWeight.w600,
                              color: Colors.indigo.shade400,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
