import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_icons/simple_icons.dart';

class OurTechStackCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final List<Color> colors;
  final int index; // for stagger animation

  const OurTechStackCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.colors,
    required this.index,
  });

  @override
  State<OurTechStackCard> createState() => _OurTechStackCardState();
}

class _OurTechStackCardState extends State<OurTechStackCard> {
  bool _isHovered = false;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    // staggered animation for fade-in
    Future.delayed(Duration(milliseconds: widget.index * 200), () {
      if (mounted) setState(() => _isVisible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    final bool active = !isMobile && _isHovered;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 800),
      opacity: _isVisible ? 1 : 0,
      curve: Curves.easeOut,
      child: AnimatedSlide(
        offset: _isVisible ? Offset.zero : const Offset(0, 0.2),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) {
            if (!isMobile) setState(() => _isHovered = true);
          },
          onExit: (_) {
            if (!isMobile) setState(() => _isHovered = false);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            transform: Matrix4.identity()
              ..scale(active ? 1.07 : 1.0)
              ..rotateZ(active ? 0.01 : 0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: widget.colors.last.withOpacity(active ? 0.6 : 0.25),
                  blurRadius: active ? 30 : 15,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: isMobile
                // Mobile → only icon + title
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(widget.icon, size: 35, color: Colors.white),
                      const SizedBox(height: 15),
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                // Desktop → hover shows description
                : AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                    child: active
                        ? Text(
                            widget.description,
                            key: const ValueKey("description"),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              height: 1.5,
                              color: Colors.white,
                            ),
                          )
                        : Column(
                            key: const ValueKey("iconAndTitle"),
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(widget.icon, size: 40, color: Colors.white),
                              const SizedBox(height: 15),
                              Text(
                                widget.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                  ),
          ),
        ),
      ),
    );
  }
}

class OurTechStackSection extends StatelessWidget {
  const OurTechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final techStack = [
      OurTechStackCard(
        index: 0,
        icon: FontAwesomeIcons.mobileScreenButton,
        title: "Flutter",
        description:
            "Crafting visually appealing, cross-platform mobile apps that deliver a native-like experience.",
        colors: [Colors.blueAccent, Colors.lightBlue],
      ),
      OurTechStackCard(
        index: 1,
        icon: FontAwesomeIcons.react,
        title: "React Native",
        description:
            "Build native mobile apps with JavaScript & React and user-friendly interfaces with reusable components.",
        colors: [Colors.cyan, Colors.blue],
      ),
      OurTechStackCard(
        index: 2,
        icon: FontAwesomeIcons.react,
        title: "React",
        description:
            "Creating dynamic, fast, and user-friendly interfaces with reusable components.",
        colors: [Colors.indigo, Colors.purpleAccent],
      ),
      OurTechStackCard(
        index: 3,
        icon: FontAwesomeIcons.angular,
        title: "Angular",
        description: "Enterprise-grade frontend web applications.",
        colors: [Colors.red, Colors.deepOrange],
      ),
      OurTechStackCard(
        index: 4,
        icon: FontAwesomeIcons.nodeJs,
        title: "Node.js",
        description:
            "Developing scalable and efficient server-side applications with real-time capabilities.",
        colors: [Colors.green, Colors.teal],
      ),
      OurTechStackCard(
        index: 5,
        icon: SimpleIcons.nestjs,
        title: "Nest.js",
        description:
            "Building highly optimized, server-rendered, and SEO-friendly applications.",
        colors: [Color(0xFFE0234E), Color(0xFFE65100)],
      ),
      OurTechStackCard(
        index: 6,
        icon: FontAwesomeIcons.server,
        title: "Express.js",
        description:
            "We express seamless communication between the frontend and backendlayers while maintaining superior performance and security.",
        colors: [Colors.orange, Colors.deepOrangeAccent],
      ),
      OurTechStackCard(
        index: 7,
        icon: FontAwesomeIcons.microsoft,
        title: ".NET",
        description:
            "Building enterprise-grade, secure, and performance-driven applications tailored for diverse industries.",
        colors: [Colors.indigo, Colors.blueAccent],
      ),
      OurTechStackCard(
        index: 8,
        icon: FontAwesomeIcons.php,
        title: "PHP",
        description:
            "We craft tailored solutions that are secure, scalable, and maintainable.",
        colors: [Colors.deepPurple, Colors.indigo],
      ),
      OurTechStackCard(
        index: 9,
        icon: FontAwesomeIcons.database,
        title: "MySQL",
        description:
            "Designing structured and scalable relational database systems for your business needs.",
        colors: [Colors.teal, Colors.blueGrey],
      ),
      OurTechStackCard(
        index: 10,
        icon: FontAwesomeIcons.database,
        title: "MongoDB",
        description:
            "Delivering flexibility and speed with NoSQL database solutions, perfect for handling large datasets.",
        colors: [Colors.green, Colors.lightGreen],
      ),
      OurTechStackCard(
        index: 11,
        icon: FontAwesomeIcons.python,
        title: "Python",
        description:
            "Powerful and versatile language for AI, data science, backend, and automation.",
        colors: [Colors.blue, Colors.yellow],
      ),
    ];

    // Responsive crossAxisCount
    int crossAxisCount = MediaQuery.sizeOf(context).width > 1000
        ? 4
        : MediaQuery.sizeOf(context).width > 600
        ? 3
        : 2;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: MediaQuery.sizeOf(context).width > 600 ? 1.2 : 1,
      ),
      itemCount: techStack.length,
      itemBuilder: (context, index) => techStack[index],
    );
  }
}

class OurTechStack extends StatelessWidget {
  final String title;
  final String description;
  final String? subtitle;
  final TextAlign textAlign;

  const OurTechStack({
    super.key,
    required this.title,
    required this.description,
    this.subtitle,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.sizeOf(context).width < 600;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
              fontSize: isMobile ? 25 : 34,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            description,
            textAlign: textAlign,
            style: TextStyle(
              fontSize: isMobile ? 15 : 18,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 25),
            Text(
              subtitle!,
              textAlign: textAlign,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
          const SizedBox(height: 50),
          const OurTechStackSection(),
        ],
      ),
    );
  }
}
