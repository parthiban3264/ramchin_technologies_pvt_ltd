import 'package:flutter/material.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  final Map<String, Map<String, dynamic>> roleFeatures = const {
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
          "Generate Monthly & Periodical Attendance Report (PDF download)",
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
      },
    },

    "Staff": {
      "Home": [
        "View Today’s Message",
        "View Student & Class Count",
        "View Present & Absent Count (Forenoon & Afternoon)",
        "View Marked / Not Marked Count (Forenoon & Afternoon)",
      ],
      "Attendance": {
        "Student Attendance": [
          "Mark attendance",
          "View absentees",
          "View attendance records",
          "Generate Monthly & Periodical Attendance Report (PDF download)",
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
        "Classwork": ["View homework and assignment"],
      },
    },
  };

  final Map<String, IconData> roleIcons = const {
    "Admin": Icons.admin_panel_settings,
    "Staff": Icons.person,
    "Student": Icons.school,
  };

  final Map<String, Color> roleColors = const {
    "Admin": Colors.blue,
    "Staff": Colors.orange,
    "Student": Colors.green,
  };

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Role-based Features",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // ✅ Responsive Layout
            if (width >= 600)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: roleFeatures.keys.map((role) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: HoverCard(
                        role: role,
                        features: roleFeatures[role]!,
                        icon: roleIcons[role]!,
                        color: roleColors[role]!,
                      ),
                    ),
                  );
                }).toList(),
              )
            else
              Column(
                children: roleFeatures.keys.map((role) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: HoverCard(
                      role: role,
                      features: roleFeatures[role]!,
                      icon: roleIcons[role]!,
                      color: roleColors[role]!,
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class HoverCard extends StatefulWidget {
  final String role;
  final Map<String, dynamic> features;
  final IconData icon;
  final Color color;

  const HoverCard({
    super.key,
    required this.role,
    required this.features,
    required this.icon,
    required this.color,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  double _scale = 1.0;
  double _elevation = 6.0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        _scale = 1.05;
        _elevation = 14.0;
      }),
      onExit: (_) => setState(() {
        _scale = 1.0;
        _elevation = 6.0;
      }),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 250),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GuidePage(role: widget.role),
              ),
            );
          },
          child: Card(
            elevation: _elevation,
            shadowColor: widget.color.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            child: Container(
              height: 550,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    widget.color.withOpacity(0.95),
                    widget.color.withOpacity(0.65),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.help_outline, color: Colors.white70),
                    ),
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Icon(widget.icon, size: 35, color: widget.color),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.role,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: ListView(
                        children: widget.features.entries.map((entry) {
                          final featureData = entry.value;

                          if (featureData is List<String>) {
                            return buildSection(entry.key, featureData);
                          } else if (featureData is Map<String, List<String>>) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 14.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.key,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ...featureData.entries.map((subEntry) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        left: 12.0,
                                        bottom: 8,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            subEntry.key,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white70,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          ...subEntry.value.map(
                                            (point) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 2,
                                                  ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    Icons.check_circle,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Expanded(
                                                    child: Text(
                                                      point,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
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
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSection(String title, List<String> points) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          ...points.map(
            (f) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      f,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
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
  }
}

class GuidePage extends StatelessWidget {
  final String role;

  const GuidePage({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          "$role Guide",
          style: const TextStyle(color: Colors.black87),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Dummy Video Placeholder
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black26),
                ),
                child: const Center(
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 80,
                    color: Colors.black38,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Description
              Text(
                "📘 Guide for $role\n\nHere you can add role-specific instructions, FAQs, or tutorials. "
                "A video can be placed above as a guide for this role.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
