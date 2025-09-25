// import 'package:flutter/material.dart';
//
// class FeaturesPage extends StatelessWidget {
//   const FeaturesPage({super.key});
//
//   final Map<String, Map<String, dynamic>> roleFeatures = const {
//     "Admin": {
//       "Home": [
//         "View Staff & Student Count",
//         "View Present & Absent Count (Forenoon & Afternoon)",
//         "View Class Count",
//         "View Marked / Not Marked Count (Forenoon & Afternoon)",
//         "View Today’s Message",
//       ],
//       "Attendance": {
//         "Staff Attendance": [
//           "Mark attendance",
//           "View absentees",
//           "View attendance records",
//         ],
//         "Student Attendance": [
//           "Update attendance",
//           "View absentees",
//           "View attendance records",
//           "Generate Monthly & Periodical Attendance Report (PDF download)",
//         ],
//       },
//       "Manage": {
//         "Manage": [
//           "Create or Remove Admin, Staff, Student, Class",
//           "Edit or Announce Messages",
//           "Create Holidays",
//         ],
//         "Services": [
//           "View Leave Requests and Accept / Reject",
//           "View Feedback",
//           "Submit Tickets for issues",
//         ],
//         "Bulk Upload": ["Upload Admins, Staff, Student via Excel"],
//         "View Profiles": ["Admin Profile", "Staff Profile", "Student Profile"],
//       },
//     },
//
//     "Staff": {
//       "Home": [
//         "View Today’s Message",
//         "View Student & Class Count",
//         "View Present & Absent Count (Forenoon & Afternoon)",
//         "View Marked / Not Marked Count (Forenoon & Afternoon)",
//       ],
//       "Attendance": {
//         "Student Attendance": [
//           "Mark attendance",
//           "View absentees",
//           "View attendance records",
//           "Generate Monthly & Periodical Attendance Report (PDF download)",
//         ],
//         "Myself": [
//           "View personal attendance",
//           "Apply for leave request",
//           "Check leave approval status",
//         ],
//       },
//       "Manage": {
//         "Manage": [
//           "View and edit class-wise timetable",
//           "View student leave requests and Accept / Reject",
//           "Assign homework to students",
//         ],
//         "Services": ["Raise tickets for issues"],
//       },
//     },
//
//     "Student": {
//       "Home": ["View Today’s Message", "View Class Timetable"],
//       "Attendance": {
//         "Myself": [
//           "View personal attendance",
//           "Apply for leave request",
//           "Check leave approval status",
//         ],
//         "Classwork": ["View homework and assignment"],
//       },
//     },
//   };
//
//   final Map<String, IconData> roleIcons = const {
//     "Admin": Icons.admin_panel_settings,
//     "Staff": Icons.person,
//     "Student": Icons.school,
//   };
//
//   final Map<String, Color> roleColors = const {
//     "Admin": Colors.blue,
//     "Staff": Colors.orange,
//     "Student": Colors.green,
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F6FA),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 2,
//         centerTitle: true,
//         title: const Text(
//           "Smart School Features",
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             const Text(
//               "Role-based Features",
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black87,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 40),
//
//             // ✅ Responsive Layout
//             if (width >= 600)
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: roleFeatures.keys.map((role) {
//                   return Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       child: HoverCard(
//                         role: role,
//                         features: roleFeatures[role]!,
//                         icon: roleIcons[role]!,
//                         color: roleColors[role]!,
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               )
//             else
//               Column(
//                 children: roleFeatures.keys.map((role) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10.0),
//                     child: HoverCard(
//                       role: role,
//                       features: roleFeatures[role]!,
//                       icon: roleIcons[role]!,
//                       color: roleColors[role]!,
//                     ),
//                   );
//                 }).toList(),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class HoverCard extends StatefulWidget {
//   final String role;
//   final Map<String, dynamic> features;
//   final IconData icon;
//   final Color color;
//
//   const HoverCard({
//     super.key,
//     required this.role,
//     required this.features,
//     required this.icon,
//     required this.color,
//   });
//
//   @override
//   State<HoverCard> createState() => _HoverCardState();
// }
//
// class _HoverCardState extends State<HoverCard> {
//   double _scale = 1.0;
//   double _elevation = 6.0;
//
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() {
//         _scale = 1.05;
//         _elevation = 14.0;
//       }),
//       onExit: (_) => setState(() {
//         _scale = 1.0;
//         _elevation = 6.0;
//       }),
//       child: AnimatedScale(
//         scale: _scale,
//         duration: const Duration(milliseconds: 250),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(22),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => GuidePage(role: widget.role),
//               ),
//             );
//           },
//           child: Card(
//             elevation: _elevation,
//             shadowColor: widget.color.withOpacity(0.4),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(22),
//             ),
//             child: Container(
//               height: 550,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     widget.color.withOpacity(0.95),
//                     widget.color.withOpacity(0.65),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(22),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: Column(
//                   children: [
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: Icon(Icons.help_outline, color: Colors.white70),
//                     ),
//                     CircleAvatar(
//                       radius: 35,
//                       backgroundColor: Colors.white,
//                       child: Icon(widget.icon, size: 35, color: widget.color),
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       widget.role,
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         letterSpacing: 1,
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     Expanded(
//                       child: ListView(
//                         children: widget.features.entries.map((entry) {
//                           final featureData = entry.value;
//
//                           if (featureData is List<String>) {
//                             return buildSection(entry.key, featureData);
//                           } else if (featureData is Map<String, List<String>>) {
//                             return Padding(
//                               padding: const EdgeInsets.only(bottom: 14.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     entry.key,
//                                     style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   ...featureData.entries.map((subEntry) {
//                                     return Padding(
//                                       padding: const EdgeInsets.only(
//                                         left: 12.0,
//                                         bottom: 8,
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             subEntry.key,
//                                             style: const TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w600,
//                                               color: Colors.white70,
//                                             ),
//                                           ),
//                                           const SizedBox(height: 4),
//                                           ...subEntry.value.map(
//                                             (point) => Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                     vertical: 2,
//                                                   ),
//                                               child: Row(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   const Icon(
//                                                     Icons.check_circle,
//                                                     color: Colors.white,
//                                                     size: 16,
//                                                   ),
//                                                   const SizedBox(width: 6),
//                                                   Expanded(
//                                                     child: Text(
//                                                       point,
//                                                       style: const TextStyle(
//                                                         color: Colors.white,
//                                                         fontSize: 14,
//                                                         height: 1.3,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   }),
//                                 ],
//                               ),
//                             );
//                           }
//                           return const SizedBox.shrink();
//                         }).toList(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildSection(String title, List<String> points) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 17,
//               fontWeight: FontWeight.w700,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 8),
//           ...points.map(
//             (f) => Padding(
//               padding: const EdgeInsets.symmetric(vertical: 3),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Icon(Icons.check_circle, color: Colors.white, size: 18),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       f,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         height: 1.3,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class GuidePage extends StatelessWidget {
//   final String role;
//
//   const GuidePage({super.key, required this.role});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F9FB),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 2,
//         title: Text(
//           "$role Guide",
//           style: const TextStyle(color: Colors.black87),
//         ),
//         iconTheme: const IconThemeData(color: Colors.black87),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Dummy Video Placeholder
//               Container(
//                 width: double.infinity,
//                 height: 220,
//                 decoration: BoxDecoration(
//                   color: Colors.black12,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: Colors.black26),
//                 ),
//                 child: const Center(
//                   child: Icon(
//                     Icons.play_circle_outline,
//                     size: 80,
//                     color: Colors.black38,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // Description
//               Text(
//                 "📘 Guide for $role\n\nHere you can add role-specific instructions, FAQs, or tutorials. "
//                 "A video can be placed above as a guide for this role.",
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontSize: 18, height: 1.5),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FeaturesPage extends StatefulWidget {
  const FeaturesPage({super.key});

  @override
  State<FeaturesPage> createState() => _FeaturesPageState();
}

class _FeaturesPageState extends State<FeaturesPage> {
  static const roleFeatures = {
    "Admin": {
      "Home": [
        "View Staff & Student Count",
        "View Present & Absent Count (Forenoon & Afternoon)",
        "View Class Count",
        "View Marked / Not Marked Count (Forenoon & Afternoon)",
        "View Today’s Message",
      ],
      "Attendance": {
        "Staff Attendance": [
          "Mark attendance",
          "View absentees",
          "View attendance records",
        ],
        "Student Attendance": [
          "Update attendance",
          "View absentees",
          "View attendance records",
          "Generate Monthly & Periodical Attendance Report",
        ],
      },
      "Manage": {
        "Manage": [
          "Create or Remove Admin, Staff, Student, Class",
          "Edit or Announce Messages",
          "Create Holidays",
        ],
        "Services": [
          "View Leave Requests and Accept / Reject",
          "View Feedback",
          "Submit Tickets for issues",
        ],
        "Bulk Upload": ["Upload Admins, Staff, Student via Excel"],
        "View Profiles": ["Admin Profile", "Staff Profile", "Student Profile"],
        "Reports": [
          "Admin, Staff & Student Lists",
          "Periodical, Daily & Community lists",
        ],
      },
    },
    "Staff": {
      "Home": [
        "View Today’s Message"
            "View Student & Class Count",
        "View Present & Absent Count (Forenoon & Afternoon)",
        "View Marked / Not Marked Count (Forenoon & Afternoon)",
      ],
      "Attendance": {
        "Student Attendance": [
          "Mark attendance",
          "View absentees",
          "View attendance records",
          "Generate Monthly & Periodical Attendance Report",
        ],
        "Myself": [
          "View personal attendance",
          "Apply for leave request",
          "Check leave approval status",
        ],
      },
      "Manage": {
        "Manage": [
          "View and edit class-wise timetable",
          "View student leave requests and Accept / Reject",
          "Assign homework to students",
        ],
        "Services": ["Raise tickets for issues"],
      },
    },
    "Student": {
      "Home": ["View Today’s Message", "View Class Timetable"],
      "Attendance": {
        "Myself": [
          "View personal attendance",
          "Apply for leave request",
          "Check leave approval status",
        ],
      },
      "HomeWork": ["View homework and assignment"],
    },
  };

  static const roleIcons = {
    "Admin": Icons.admin_panel_settings,
    "Staff": Icons.person,
    "Student": Icons.school,
  };

  static const roleColors = {
    "Admin": Colors.blue,
    "Staff": Colors.orange,
    "Student": Colors.green,
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: roleFeatures.keys.length,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          centerTitle: true,
          title: const Text(
            "Smart School Features",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(54),
            child: Container(
              color: Colors.white,
              child: TabBar(
                indicatorColor: Colors.blueAccent,
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.black45,
                tabs: [
                  for (final role in roleFeatures.keys)
                    Tab(
                      icon: Icon(roleIcons[role], color: roleColors[role]),
                      text: role,
                    ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            for (final role in roleFeatures.keys)
              SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: RoleContainer(
                  role: role,
                  features: roleFeatures[role]!,
                  color: roleColors[role]!,
                  icon: roleIcons[role]!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class RoleContainer extends StatelessWidget {
  final String role;
  final Map<String, dynamic> features;
  final Color color;
  final IconData icon;

  const RoleContainer({
    super.key,
    required this.role,
    required this.features,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    final List<Widget> cards = [];
    features.forEach((featureType, featureData) {
      cards.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 7.0),
          child: FeatureCard(
            role: role,
            featureType: featureType,
            featureData: featureData,
            icon: icon,
            color: color,
          ),
        ),
      );
    });

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 1200),
      decoration: BoxDecoration(
        color: color.withOpacity(0.11),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: color.withOpacity(0.21), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 27,
                            backgroundColor: Colors.white,
                            child: Icon(icon, size: 28, color: color),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            role,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: color,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 2,
                        ),
                        icon: const Icon(Icons.video_library),
                        label: const Text('Watch Guideness'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GuidePage(role: role),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                : Row(
                    children: [
                      CircleAvatar(
                        radius: 27,
                        backgroundColor: Colors.white,
                        child: Icon(icon, size: 28, color: color),
                      ),
                      const SizedBox(width: 13),
                      Text(
                        role,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: color,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 2,
                        ),
                        icon: const Icon(Icons.video_library),
                        label: const Text('Watch Guideness'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GuidePage(role: role),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                final bool isWide = constraints.maxWidth > 900;
                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: cards.map((c) => Expanded(child: c)).toList(),
                  );
                }
                return Column(children: cards);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String role;
  final String featureType;
  final dynamic featureData;
  final IconData icon;
  final Color color;

  const FeatureCard({
    super.key,
    required this.role,
    required this.featureType,
    required this.featureData,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      shadowColor: color.withOpacity(0.22),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 240, maxWidth: 410),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.95), color.withOpacity(0.65)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                featureType,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              (featureData is List<String>)
                  ? buildSection(featureData)
                  : buildMapSection(featureData),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection(List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...points.map(
          (f) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 16),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    f,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMapSection(Map<String, List<String>> map) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...map.entries.map((subEntry) {
          return Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subEntry.key,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 4),
                ...subEntry.value.map(
                  (point) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 15,
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: Text(
                            point,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class GuidePage extends StatefulWidget {
  final String role;

  const GuidePage({super.key, required this.role});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  late VideoPlayerController _controller;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();

    // Pick video based on role
    String videoPath;
    switch (widget.role.toLowerCase()) {
      case "admin":
        videoPath = 'assets/adminguide.mp4';
        break;
      case "staff":
        videoPath = 'assets/stafguide.mp4';
        break;
      case "student":
      default:
        videoPath = 'assets/studentguide.mp4';
        break;
    }

    _controller = VideoPlayerController.asset(videoPath)
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });

    // Refresh seek bar while playing
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMute() {
    setState(() {
      if (_isMuted) {
        _controller.setVolume(1.0);
      } else {
        _controller.setVolume(0.0);
      }
      _isMuted = !_isMuted;
    });
  }

  /// Format duration as mm:ss
  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  Widget _buildReelsVideo() {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          color: Colors.black,
          child: _controller.value.isInitialized
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    });
                  },
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      VideoPlayer(_controller),

                      // Progress bar (seek support)
                      Positioned(
                        bottom: 40,
                        left: 0,
                        right: 0,
                        child: VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          colors: const VideoProgressColors(
                            playedColor: Colors.teal,
                            bufferedColor: Colors.white54,
                            backgroundColor: Colors.white24,
                          ),
                        ),
                      ),

                      // Controls
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                _isMuted ? Icons.volume_off : Icons.volume_up,
                                color: Colors.white,
                              ),
                              onPressed: _toggleMute,
                            ),
                            Text(
                              "${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  /// Role-based guide text
  Widget _buildGuideText() {
    List<String> content;

    switch (widget.role.toLowerCase()) {
      case "admin":
        content = [
          "🏠 Home",
          "• Attendance stats with today’s message and quick counts for staff, students, and sections.",
          "",
          "📋 Attendance",
          "1. Mark staff attendance and view absentees or records by date.",
          "2. Update student attendance, view absentees, check class/monthly records, and generate reports.",
          "",
          "⚙️ Manage",
          "1. Manage messages, accounts, classes, holidays, and timetables.",
          "2. Handle leave requests, support tickets, bulk upload accounts, and view staff/student profiles.",
          "3. Download lists of admins, staff, and students.",
          "4. Export attendance and reports as PDFs.",
        ];
        break;

      case "staff":
        content = [
          "🏠 Home",
          "• See today’s message and attendance summary for students/sections.",
          "",
          "📋 Attendance",
          "1. Mark attendance, view absentees, and check class/monthly records.",
          "2. View your own attendance and apply for leave.",
          "",
          "⚙️ Manage",
          "1. Update timetables and manage student leave requests.",
          "2. Assign homework to your class.",
          "3. Raise support tickets.",
        ];
        break;

      case "student":
      default:
        content = [
          "🏠 Home",
          "• See today’s message and timetable.",
          "",
          "📋 Attendance",
          "1. View your attendance record.",
          "2. Apply for leave and track status.",
          "",
          "⚙️ Manage",
          "• View class homework with submission dates.",
        ];
        break;
    }

    return SingleChildScrollView(
      // 🔥 fixes overflow
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "📘 Guide for ${widget.role}",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 16),
          ...content.map(
            (line) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                line,
                style: TextStyle(
                  fontSize:
                      line.startsWith("•") || RegExp(r'^\d').hasMatch(line)
                      ? 15
                      : 17,
                  fontWeight:
                      line.startsWith("🏠") ||
                          line.startsWith("📋") ||
                          line.startsWith("⚙️")
                      ? FontWeight.w600
                      : FontWeight.normal,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // ElevatedButton.icon(
          //   onPressed: () {},
          //   icon: const Icon(Icons.arrow_forward),
          //   label: const Text("Continue"),
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.teal,
          //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          "${widget.role} Guide",
          style: const TextStyle(color: Colors.black87),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 1, child: _buildReelsVideo()),
                    const SizedBox(width: 32),
                    Expanded(
                      flex: 1,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: _buildGuideText(),
                        ),
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildReelsVideo(),
                      const SizedBox(height: 20),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: _buildGuideText(),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

// class RoleContainer extends StatefulWidget {
//   final String role;
//   final Map<String, dynamic> features;
//   final Color color;
//   final IconData icon;
//
//   const RoleContainer({
//     super.key,
//     required this.role,
//     required this.features,
//     required this.color,
//     required this.icon,
//   });
//
//   @override
//   State<RoleContainer> createState() => _RoleContainerState();
// }
//
// class _RoleContainerState extends State<RoleContainer> {
//   bool _showGuide = false;
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   void _toggleGuide() {
//     setState(() {
//       _showGuide = !_showGuide;
//     });
//     if (!_showGuide) return;
//
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       // Scroll down smoothly to the guide content
//       await _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 400),
//         curve: Curves.easeInOut,
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> cards = [];
//     widget.features.forEach((featureType, featureData) {
//       cards.add(
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 7.0),
//           child: FeatureCard(
//             role: widget.role,
//             featureType: featureType,
//             featureData: featureData,
//             icon: widget.icon,
//             color: widget.color,
//           ),
//         ),
//       );
//     });
//
//     return Container(
//       width: double.infinity,
//       constraints: const BoxConstraints(maxWidth: 1200),
//       decoration: BoxDecoration(
//         color: widget.color.withOpacity(0.11),
//         borderRadius: BorderRadius.circular(25),
//         border: Border.all(color: widget.color.withOpacity(0.21), width: 1.5),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 16.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 27,
//                   backgroundColor: Colors.white,
//                   child: Icon(widget.icon, size: 28, color: widget.color),
//                 ),
//                 const SizedBox(width: 13),
//                 Text(
//                   widget.role,
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: widget.color,
//                     letterSpacing: 1.5,
//                   ),
//                 ),
//                 const Spacer(),
//                 ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: widget.color,
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     elevation: 2,
//                   ),
//                   icon: Icon(
//                     _showGuide
//                         ? Icons.keyboard_arrow_up_outlined
//                         : Icons.video_library,
//                   ),
//                   label: Text(
//                     _showGuide ? 'Hide Guideness' : 'Watch Guideness',
//                   ),
//                   onPressed: _toggleGuide,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),
//             LayoutBuilder(
//               builder: (context, constraints) {
//                 final bool isWide = constraints.maxWidth > 900;
//                 if (isWide) {
//                   return Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: cards.map((c) => Expanded(child: c)).toList(),
//                   );
//                 }
//                 return Column(children: cards);
//               },
//             ),
//             if (_showGuide) ...[
//               const SizedBox(height: 30),
//               Divider(color: widget.color.withOpacity(0.4), thickness: 1.5),
//               const SizedBox(height: 24),
//               // Guide content inline
//               Container(
//                 height: 300,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(25),
//                   boxShadow: [
//                     BoxShadow(
//                       color: widget.color.withOpacity(0.15),
//                       blurRadius: 10,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                   border: Border.all(color: widget.color.withOpacity(0.3)),
//                 ),
//                 child: SingleChildScrollView(
//                   controller: _scrollController,
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         height: 160,
//                         decoration: BoxDecoration(
//                           color: Colors.black12,
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(color: Colors.black26),
//                         ),
//                         child: const Center(
//                           child: Icon(
//                             Icons.play_circle_outline,
//                             size: 80,
//                             color: Colors.black38,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       Text(
//                         '📘 Guide for ${widget.role}\n\n'
//                             'Here you can add instructions, FAQs, or tutorials specific to ${widget.role} features. '
//                             'A video can be placed above as a guide for this module.',
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           height: 1.5,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
