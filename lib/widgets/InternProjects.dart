// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:visibility_detector/visibility_detector.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../services/Internship_service.dart';
//
// /// HEADER WIDGET
// class InternshipHeader extends StatelessWidget {
//   const InternshipHeader({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           RichText(
//             textAlign: TextAlign.center,
//             text: TextSpan(
//               style: const TextStyle(
//                 fontSize: 38,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//               children: [
//                 const TextSpan(text: "Our "),
//                 TextSpan(
//                   text: "Internship Projects",
//                   style: TextStyle(
//                     foreground: Paint()
//                       ..shader = const LinearGradient(
//                         colors: [
//                           Color(0xFF4F46E5), // Indigo
//                           Color(0xFF9333EA), // Purple
//                           Color(0xFFEC4899), // Pink
//                         ],
//                       ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 12),
//           Container(
//             height: 3,
//             width: 260,
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Color(0xFFEC4899), Color(0xFF4F46E5)],
//               ),
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             "Discover the innovative digital solutions crafted by our talented team. "
//             "Each project is designed with cutting-edge technology and user experience in mind.",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 18, color: Colors.black54, height: 1.4),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class MemberCard {
//   final String image; // Base64 from backend
//   final String name;
//   final String project;
//   final String link;
//
//   MemberCard({
//     required this.image,
//     required this.name,
//     required this.project,
//     required this.link,
//   });
//   @override
//   String toString() {
//     // TODO: implement toString
//     print(image + name + project + link);
//     return super.toString();
//   }
// }
//
// class MemberCardGrid extends StatefulWidget {
//   const MemberCardGrid({super.key});
//
//   @override
//   State<MemberCardGrid> createState() => _MemberCardGridState();
// }
//
// class _MemberCardGridState extends State<MemberCardGrid>
//     with TickerProviderStateMixin {
//   List<MemberCard> members = [];
//   bool _isLoading = true;
//
//   late List<AnimationController> _controllers;
//   late List<Animation<Offset>> _slideAnimations;
//   late List<Animation<double>> _fadeAnimations;
//   final Set<int> _animatedIndexes = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchMembers();
//   }
//
//   Future<void> _fetchMembers() async {
//     try {
//       final data = await InternshipService.getAll(); // List<dynamic>
//       members = data.map<MemberCard>((item) {
//         final map = item as Map<String, dynamic>;
//         return MemberCard(
//           image: map['image'] ?? '', // empty string if null
//           name: map['name'] ?? '',
//           project:
//               (map['projects'] != null && (map['projects'] as List).isNotEmpty)
//               ? (map['projects'] as List).first
//               : '',
//           link: (map['links'] != null && (map['links'] as List).isNotEmpty)
//               ? (map['links'] as List).first
//               : '',
//         );
//       }).toList();
//
//       _setupAnimations(); // ✅ initialize animations after members are loaded
//
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     } catch (e) {
//       print("❌ Error fetching members: $e");
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }
//
//   void _setupAnimations() {
//     _controllers = List.generate(
//       members.length,
//       (i) => AnimationController(
//         vsync: this,
//         duration: const Duration(milliseconds: 600),
//       ),
//     );
//
//     _slideAnimations = _controllers
//         .map(
//           (c) => Tween<Offset>(
//             begin: const Offset(0, 0.2),
//             end: Offset.zero,
//           ).animate(CurvedAnimation(parent: c, curve: Curves.easeOut)),
//         )
//         .toList();
//
//     _fadeAnimations = _controllers
//         .map((c) => CurvedAnimation(parent: c, curve: Curves.easeIn))
//         .toList();
//   }
//
//   void _triggerAnimation(int index) {
//     if (!_animatedIndexes.contains(index)) {
//       _animatedIndexes.add(index);
//       Future.delayed(Duration(milliseconds: 120 * (index % 3)), () {
//         if (mounted) _controllers[index].forward();
//       });
//     }
//   }
//
//   Future<void> _openLink(String url) async {
//     if (url.isNotEmpty && await canLaunchUrl(Uri.parse(url))) {
//       await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//     }
//   }
//
//   @override
//   void dispose() {
//     for (var c in _controllers) {
//       c.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     if (members.isEmpty) {
//       return const Center(child: Text("No members found"));
//     }
//
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         int crossAxisCount = constraints.maxWidth > 1000
//             ? 3
//             : constraints.maxWidth > 600
//             ? 2
//             : 1;
//
//         return GridView.builder(
//           padding: const EdgeInsets.all(16),
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: members.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: crossAxisCount,
//             crossAxisSpacing: 16,
//             mainAxisSpacing: 40,
//             childAspectRatio: 1.1,
//           ),
//           itemBuilder: (context, index) {
//             final member = members[index];
//
//             return VisibilityDetector(
//               key: Key("member_$index"),
//               onVisibilityChanged: (info) {
//                 if (info.visibleFraction > 0.2) {
//                   _triggerAnimation(index);
//                 }
//               },
//               child: FadeTransition(
//                 opacity: _fadeAnimations[index],
//                 child: SlideTransition(
//                   position: _slideAnimations[index],
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(16),
//                     onTap: () => _openLink(member.link),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.06),
//                             blurRadius: 8,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 10,
//                             decoration: const BoxDecoration(
//                               borderRadius: BorderRadius.vertical(
//                                 top: Radius.circular(16),
//                               ),
//                               gradient: LinearGradient(
//                                 colors: [Colors.blue, Colors.purple],
//                                 begin: Alignment.centerLeft,
//                                 end: Alignment.centerRight,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.all(14.0),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   CircleAvatar(
//                                     radius: 50,
//                                     backgroundColor: Colors.white,
//                                     backgroundImage: member.image.isNotEmpty
//                                         ? MemoryImage(
//                                             base64Decode(member.image),
//                                           )
//                                         : null,
//                                     child: member.image.isEmpty
//                                         ? const Icon(Icons.person, size: 50)
//                                         : null,
//                                   ),
//                                   const SizedBox(height: 12),
//                                   Text(
//                                     member.name,
//                                     textAlign: TextAlign.center,
//                                     style: const TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 10),
//                                   const Text(
//                                     "Featured Project",
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.black54,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 6),
//                                   Text(
//                                     member.project,
//                                     textAlign: TextAlign.center,
//                                     style: const TextStyle(
//                                       fontSize: 13,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   GestureDetector(
//                                     onTap: () => _openLink(member.link),
//                                     child: Text(
//                                       member.link,
//                                       textAlign: TextAlign.center,
//                                       style: const TextStyle(
//                                         fontSize: 13,
//                                         color: Colors.blueAccent,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
//
// class TechStackGrid extends StatefulWidget {
//   const TechStackGrid({super.key});
//
//   @override
//   State<TechStackGrid> createState() => _TechStackGridState();
// }
//
// class _TechStackGridState extends State<TechStackGrid>
//     with TickerProviderStateMixin {
//   late List<AnimationController> _controllers;
//   late List<Animation<Offset>> _slideAnimations;
//   late List<Animation<double>> _fadeAnimations;
//   final Set<int> _animatedIndexes = {};
//
//   final List<Map<String, String>> techStack = [
//     {"icon": "assets/react.png", "name": "React", "desc": "Frontend"},
//     {"icon": "assets/flutter1.png", "name": "Flutter", "desc": "Mobile"},
//     {"icon": "assets/node.png", "name": "Node.js", "desc": "Backend"},
//     {"icon": "assets/mysql2.png", "name": "MySQL", "desc": "Database"},
//     {"icon": "assets/mongodb.png", "name": "MongoDB", "desc": "Database"},
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controllers = List.generate(
//       techStack.length,
//       (i) => AnimationController(
//         vsync: this,
//         duration: const Duration(milliseconds: 600),
//       ),
//     );
//
//     _slideAnimations = _controllers
//         .map(
//           (c) => Tween<Offset>(
//             begin: const Offset(0, 0.15),
//             end: Offset.zero,
//           ).animate(CurvedAnimation(parent: c, curve: Curves.easeOut)),
//         )
//         .toList();
//
//     _fadeAnimations = _controllers
//         .map((c) => CurvedAnimation(parent: c, curve: Curves.easeIn))
//         .toList();
//   }
//
//   void _triggerAnimation(int index) {
//     if (!_animatedIndexes.contains(index)) {
//       _animatedIndexes.add(index);
//       Future.delayed(Duration(milliseconds: 100 * (index % 3)), () {
//         if (mounted) _controllers[index].forward();
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     for (var c in _controllers) {
//       c.dispose();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 20),
//         Text.rich(
//           TextSpan(
//             children: [
//               const TextSpan(
//                 text: "Our ",
//                 style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
//               ),
//               TextSpan(
//                 text: "Technology Stack",
//                 style: TextStyle(
//                   fontSize: 35,
//                   fontWeight: FontWeight.bold,
//                   foreground: Paint()
//                     ..shader = const LinearGradient(
//                       colors: [Colors.blue, Colors.purple],
//                     ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
//                 ),
//               ),
//             ],
//           ),
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 8),
//         const Text(
//           "We leverage industry-leading technologies to build robust and scalable solutions",
//           textAlign: TextAlign.center,
//           style: TextStyle(color: Colors.black54, fontSize: 14),
//         ),
//         const SizedBox(height: 30),
//         LayoutBuilder(
//           builder: (context, constraints) {
//             int crossAxisCount = constraints.maxWidth > 1000
//                 ? 5
//                 : constraints.maxWidth > 700
//                 ? 3
//                 : 2;
//
//             return GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: crossAxisCount,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 1.3,
//               ),
//               itemCount: techStack.length,
//               itemBuilder: (context, index) {
//                 final tech = techStack[index];
//
//                 return VisibilityDetector(
//                   key: Key("tech_$index"),
//                   onVisibilityChanged: (info) {
//                     if (info.visibleFraction > 0.2) {
//                       _triggerAnimation(index);
//                     }
//                   },
//                   child: FadeTransition(
//                     opacity: _fadeAnimations[index],
//                     child: SlideTransition(
//                       position: _slideAnimations[index],
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withValues(alpha: 0.05),
//                               blurRadius: 8,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(tech["icon"]!, height: 60, width: 60),
//                             const SizedBox(height: 15),
//                             Text(
//                               tech["name"]!,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               tech["desc"]!,
//                               style: const TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';

/// HEADER WIDGET
class InternshipHeader extends StatelessWidget {
  const InternshipHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              children: [
                const TextSpan(text: "Our "),
                TextSpan(
                  text: "Internship Projects",
                  style: TextStyle(
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: [
                          Color(0xFF4F46E5), // Indigo
                          Color(0xFF9333EA), // Purple
                          Color(0xFFEC4899), // Pink
                        ],
                      ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 3,
            width: 260,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFEC4899), Color(0xFF4F46E5)],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Discover the innovative digital solutions crafted by our talented team. "
            "Each project is designed with cutting-edge technology and user experience in mind.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black54, height: 1.4),
          ),
        ],
      ),
    );
  }
}

/// MODEL
class MemberCard {
  final String image;
  final String name;
  final String project;
  final String link;

  MemberCard({
    required this.image,
    required this.name,
    required this.project,
    required this.link,
  });
}

/// MEMBER CARD GRID
class MemberCardGrid extends StatefulWidget {
  const MemberCardGrid({super.key});

  @override
  State<MemberCardGrid> createState() => _MemberCardGridState();
}

class _MemberCardGridState extends State<MemberCardGrid>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _slideAnimations;
  late final List<Animation<double>> _fadeAnimations;
  final Set<int> _animatedIndexes = {};

  final List<MemberCard> members = [
    MemberCard(
      image: "assets/member/shivani.jpeg",
      name: "Shivani Shree G",
      project: "Online Slipper Shopping",
      link: "http://hover-shop.s3-website.eu-north-1.amazonaws.com",
    ),
    MemberCard(
      image: "assets/member/gopi.jpeg",
      name: "Rajagopika N",
      project: "Tech Gadgets Store",
      link: "http://tech-gadgets-store.s3-website.eu-north-1.amazonaws.com",
    ),
    MemberCard(
      image: "assets/member/brightlin.jpeg",
      name: "Brightlin A",
      project: "ToyTrove-Smart Toy for Smort Kids!",
      link: "https://ramchintech.com/brightlin/login.php",
    ),
    MemberCard(
      image: "assets/member/dharsha.jpeg",
      name: "Dharsha Gayathri G",
      project: "Online Slipper Shopping",
      link: "https://ramchintech.com/gaya/login.php",
    ),
    MemberCard(
      image: "assets/member/sowmiya.jpeg",
      name: "Sowmiya T",
      project: "Paradise Resort Hotel Booking System",
      link: "https://projects.ramchintech.com",
    ),
    MemberCard(
      image: "assets/member/yoga.jpeg",
      name: "Yogalakshmi K",
      project: "E-commerce Website :CareKart",
      link: "http://care-kart.s3-website.eu-north-1.amazonaws.com/",
    ),
    MemberCard(
      image: "assets/member/swarlin.jpeg",
      name: "Swarlin Aishwarya B",
      project: "E-commerce Website :Word Aura",
      link: "http://word-aura.s3-website.ap-south-1.amazonaws.com/",
    ),
    MemberCard(
      image: "assets/member/lakshmi.jpeg",
      name: "Lakshmi K",
      project: "E-commerce Website:Lakshmi Jewellery Shop",
      link: "http://jewellery-shop1.s3-website.eu-north-1.amazonaws.com/",
    ),
    MemberCard(
      image: "assets/member/ramu.jpeg",
      name: "Ramu K",
      project: "E-commerce Website: Online Bag Shop",
      link: "http://bag-shop.s3-website.ap-south-1.amazonaws.com/",
    ),
    MemberCard(
      image: "assets/member/parthi.jpg",
      name: "Parthiban",
      project: "Coming Soon",
      link: " ",
    ),
    MemberCard(
      image: "assets/member/bala.jpg",
      name: "Balasubramaninan M",
      project: "Coming Soon",
      link: " ",
    ),
    MemberCard(
      image: "assets/pmember/murali.jpeg",
      name: "Murali K",
      project: "Coming Soon",
      link: "",
    ),
    MemberCard(
      image: "assets/member/pooja.jpg",
      name: "Pooja M",
      project: "View E-commerce Website",
      link: "https://ramchintech.com/video/pooja.mp4",
    ),
    MemberCard(
      image: "assets/member/essakkiyammal.jpg",
      name: "Muthu Essakkiammal ",
      project: "View E-commerce Website",
      link: "https://ramchintech.com/video/esakkiammal.mp4",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      members.length,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      ),
    );
    _slideAnimations = _controllers
        .map(
          (c) => Tween<Offset>(
            begin: const Offset(0, 0.2),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: c, curve: Curves.easeOut)),
        )
        .toList();
    _fadeAnimations = _controllers
        .map((c) => CurvedAnimation(parent: c, curve: Curves.easeIn))
        .toList();
  }

  void _triggerAnimation(int index) {
    if (!_animatedIndexes.contains(index)) {
      _animatedIndexes.add(index);
      Future.delayed(Duration(milliseconds: 120 * (index % 3)), () {
        if (mounted) _controllers[index].forward();
      });
    }
  }

  Future<void> _openLink(String url) async {
    if (url.isNotEmpty && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 1000
            ? 3
            : constraints.maxWidth > 600
            ? 2
            : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1.05,
            crossAxisSpacing: 16,
            mainAxisSpacing: 40,
          ),
          itemCount: members.length,
          itemBuilder: (context, index) {
            final member = members[index];
            return VisibilityDetector(
              key: Key("member_$index"),
              onVisibilityChanged: (info) {
                if (info.visibleFraction > 0.2) {
                  _triggerAnimation(index);
                }
              },
              child: FadeTransition(
                opacity: _fadeAnimations[index],
                child: SlideTransition(
                  position: _slideAnimations[index],
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => _openLink(member.link),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 10,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              gradient: LinearGradient(
                                colors: [Colors.blue, Colors.purple],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage(member.image),
                                    backgroundColor: Colors.grey[100],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    member.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: isMobile ? 18 : 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    "Featured Project",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    member.project,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: isMobile ? 12 : 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  if (member.link.isNotEmpty)
                                    Text(
                                      member.link,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: isMobile ? 11 : 13,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

/// TECH STACK GRID
class TechStackGrid extends StatefulWidget {
  const TechStackGrid({super.key});

  @override
  State<TechStackGrid> createState() => _TechStackGridState();
}

class _TechStackGridState extends State<TechStackGrid>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _slideAnimations;
  late final List<Animation<double>> _fadeAnimations;
  final Set<int> _animatedIndexes = {};

  final List<Map<String, String>> techStack = [
    {"icon": "assets/react1.png", "name": "React", "desc": "Frontend"},
    {"icon": "assets/flutter1.png", "name": "Flutter", "desc": "Mobile"},
    {"icon": "assets/node1.png", "name": "Node.js", "desc": "Backend"},
    {"icon": "assets/mysql21.png", "name": "MySQL", "desc": "Database"},
    {"icon": "assets/mong.png", "name": "MongoDB", "desc": "Database"},
  ];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      techStack.length,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      ),
    );
    _slideAnimations = _controllers
        .map(
          (c) => Tween<Offset>(
            begin: const Offset(0, 0.15),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: c, curve: Curves.easeOut)),
        )
        .toList();
    _fadeAnimations = _controllers
        .map((c) => CurvedAnimation(parent: c, curve: Curves.easeIn))
        .toList();
  }

  void _triggerAnimation(int index) {
    if (!_animatedIndexes.contains(index)) {
      _animatedIndexes.add(index);
      Future.delayed(Duration(milliseconds: 100 * (index % 3)), () {
        if (mounted) _controllers[index].forward();
      });
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: "Our ",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: "Technology Stack",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                    ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          "We leverage industry-leading technologies to build robust and scalable solutions",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black54, fontSize: 14),
        ),
        const SizedBox(height: 30),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 1000
                ? 5
                : constraints.maxWidth > 700
                ? 3
                : 2;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: techStack.length,
              itemBuilder: (context, index) {
                final tech = techStack[index];
                return VisibilityDetector(
                  key: Key("tech_$index"),
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0.2) _triggerAnimation(index);
                  },
                  child: FadeTransition(
                    opacity: _fadeAnimations[index],
                    child: SlideTransition(
                      position: _slideAnimations[index],
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(tech["icon"]!, height: 60, width: 60),
                            const SizedBox(height: 15),
                            Text(
                              tech["name"]!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              tech["desc"]!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
