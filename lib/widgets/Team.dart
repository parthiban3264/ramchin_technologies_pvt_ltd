import 'dart:ui';

import 'package:flutter/material.dart';

class TeamPage extends StatelessWidget {
  final List<TeamMember> teamMembers = [
    TeamMember(
      name: "DR.C.VELAYUTHAM",
      role: "ARCHITECT",
      imageUrl: "assets/cvsir2.jpg",
      bio:
          "DR.C.VELAYUTHAM is a creative and detail-oriented Architect specializing in innovative, sustainable, and functional design.",
      description: "Arjun has led multiple startups to success...",
      projects: [""],
      experience: ["10+ years in leadership", "Ex-Google Manager"],
      resumeUrl: "https://resume-link.com",
      reviews: [
        "Arjun transformed our business! – Client A",
        "Great visionary leader. – Client B",
      ],
    ),
    TeamMember(
      name: "BALASUBRAMANIAN M",
      role: "TEAM LEADER",
      imageUrl: "assets/member/bala.jpg",
      bio: "Flutter developer",
      description: "specializes in Flutter & Node.js...",
      projects: ["https://github.com/priya", "https://portfolio.com"],
      experience: ["5 years in full-stack dev", "Mobile app expert"],
      resumeUrl: "https://resume-priya.com",
      reviews: [
        "Amazing coding skills! – Client X",
        "Delivers projects on time. – Client Y",
      ],
    ),
    TeamMember(
      name: "PARTHIBAN R",
      role: "FLUTTER DEVELOPER",
      imageUrl: "assets/member/parthi.jpg",
      bio: "Flutter Developer.",
      description: "specializes in Flutter & Node.js...",
      projects: ["https://github.com/priya", "https://portfolio.com"],
      experience: ["5 years in full-stack dev", "Mobile app expert"],
      resumeUrl: "https://resume-priya.com",
      reviews: [
        "Amazing coding skills! – Client X",
        "Delivers projects on time. – Client Y",
      ],
    ),
    TeamMember(
      name: "SHIVANI SHREE G",
      role: "FLUTTER DEVELOPER",
      imageUrl: "assets/member/shivani.jpeg",
      bio: "Flutter Developer.",
      description: "Priya specializes in Flutter & Node.js...",
      projects: ["https://github.com/priya", "https://portfolio.com"],
      experience: ["5 years in full-stack dev", "Mobile app expert"],
      resumeUrl: "https://resume-priya.com",
      reviews: [
        "Amazing coding skills! – Client X",
        "Delivers projects on time. – Client Y",
      ],
    ),
  ];

  TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isMobile = screenWidth < 600; // phones
    final isTablet = screenWidth >= 600 && screenWidth < 1024; // tablets
    final isDesktop = screenWidth >= 1024; // laptops/monitors

    return Scaffold(
      body: SingleChildScrollView(
        // ✅ Scroll entire page
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              "Our Team",
              style: TextStyle(
                fontSize: isMobile ? 25 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Meet the visionaries driving innovation and shaping the future. "
                "Passionate creators turning bold ideas into reality. "
                "Collaborators who inspire, challenge, and excel together. "
                "Driven by curiosity, creativity, and relentless dedication. "
                "Committed to delivering excellence in every endeavor. "
                "Together, we craft extraordinary experiences that leave a mark.",
                style: TextStyle(
                  fontSize: isMobile ? 13 : 16,
                  color: Colors.black87,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),

            // GridView inside scroll view
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: teamMembers.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile
                      ? 1
                      : isTablet
                      ? 2
                      : isDesktop
                      ? 3
                      : 4,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return TeamCard(member: teamMembers[index]);
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class TeamCard extends StatefulWidget {
  final TeamMember member;

  const TeamCard({super.key, required this.member});

  @override
  State<TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  bool _isHovered = false;

  @override
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        if (!isMobile) setState(() => _isHovered = true);
      },
      onExit: (_) {
        if (!isMobile) setState(() => _isHovered = false);
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TeamDetailPage(member: widget.member),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blue.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Avatar
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: isMobile ? 90 : (_isHovered ? 0 : 90),
                width: isMobile ? 90 : (_isHovered ? 0 : 90),
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(widget.member.imageUrl),
                ),
              ),
              const SizedBox(height: 16),

              /// Name
              Text(
                widget.member.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              /// Role
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isMobile ? 1 : (_isHovered ? 0 : 1),
                child: Text(
                  widget.member.role,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              /// Bio
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isMobile ? 1 : (_isHovered ? 1 : 0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    widget.member.bio,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: isMobile ? 12 : 15,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              if (!isMobile && _isHovered) const SizedBox(height: 12),
              if (!isMobile && _isHovered)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: 2,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
} //TeamDetailPage

class TeamDetailPage extends StatefulWidget {
  final dynamic member;
  const TeamDetailPage({super.key, required this.member});

  @override
  State<TeamDetailPage> createState() => _TeamDetailPageState();
}

class _TeamDetailPageState extends State<TeamDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  final colors = [Colors.orange, Colors.lightBlueAccent, Colors.teal];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final member = widget.member;
    final roleColor = colors[member.role.hashCode % colors.length];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          // Gradient header background
          Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  roleColor.withOpacity(0.8),
                  roleColor.withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(40),
              ),
            ),
          ),

          // Content
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: FadeTransition(
              opacity: _fadeIn,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),

                  // Avatar with glow
                  Hero(
                    tag: member.name,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [roleColor, roleColor.withOpacity(0.6)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: roleColor.withOpacity(0.6),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(member.imageUrl),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    member.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                  Text(
                    member.role,
                    style: TextStyle(
                      fontSize: 16,
                      color: roleColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Details card
                  _buildGlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle("Bio", Icons.person),
                        Text(member.bio, style: _textStyle()),
                        const SizedBox(height: 20),

                        _sectionTitle("Description", Icons.info_outline),
                        Text(member.description, style: _textStyle()),
                        const SizedBox(height: 20),

                        _sectionTitle("Projects", Icons.work_outline),
                        Wrap(
                          spacing: 8,
                          children: member.projects.map<Widget>((p) {
                            return ActionChip(
                              label: Text(p),
                              labelStyle: const TextStyle(color: Colors.white),
                              backgroundColor: roleColor,
                              onPressed: () {}, // open project link
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),

                        _sectionTitle("Experience", Icons.timeline),
                        Wrap(
                          spacing: 8,
                          children: member.experience.map<Widget>((e) {
                            return Chip(
                              label: Text(e),
                              backgroundColor: Colors.grey.shade200,
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),

                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () {}, // open resume
                            icon: Icon(
                              Icons.picture_as_pdf,
                              color: Colors.white,
                            ),
                            label: Text(
                              "View Resume",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 14,
                              ),
                              backgroundColor: roleColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 6,
                              shadowColor: roleColor.withOpacity(0.6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        _sectionTitle("Client Reviews", Icons.reviews),
                        ...member.reviews.map(
                          (r) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.grey.shade300),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.format_quote,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    r,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),

          // Floating Back Button
          Positioned(
            top: 40,
            left: 16,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              onPressed: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          margin: const EdgeInsets.only(top: 12),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _sectionTitle(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.black87, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(fontSize: 15, height: 1.5, color: Colors.black87);
  }
}

class TeamMember {
  final String name;
  final String role;
  final String imageUrl;
  final String bio;
  final String description;
  final List<String> projects;
  final List<String> experience;
  final String resumeUrl;
  final List<String> reviews;

  TeamMember({
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.bio,
    required this.description,
    required this.projects,
    required this.experience,
    required this.resumeUrl,
    required this.reviews,
  });
}
