import 'package:flutter/material.dart';
import '../../widgets/Privacy.dart';
import 'features_page.dart';
import 'package:video_player/video_player.dart';
import 'dart:html' as html;

class SchoolPage extends StatefulWidget {
  const SchoolPage({super.key});

  @override
  State<SchoolPage> createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _textAnimationController;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();
    _textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _textSlideAnimation =
        Tween<Offset>(begin: const Offset(-0.5, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _textAnimationController,
            curve: Curves.easeOut,
          ),
        );
    _textAnimationController.forward();
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    super.dispose();
  }

  // Future<void> _launchPlayStore() async {
  //   if (Platform.isAndroid) {
  //     final Uri playStoreUrl = Uri.parse(
  //       // "https://play.google.com/store/apps/details?id=com.example.schoolapp",
  //       "https://play.google.com/store/apps/details?id=YOUR_APP_PACKAGE_NAME",
  //     );
  //
  //     if (await canLaunchUrl(playStoreUrl)) {
  //       await launchUrl(playStoreUrl, mode: LaunchMode.externalApplication);
  //     } else {
  //       if (mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text("Could not open Play Store")),
  //         );
  //       }
  //     }
  //   } else {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Available only on Android devices")),
  //       );
  //     }
  //   }
  // }

  void _launchAppStore() {
    const url = 'https://apps.apple.com/app/idYOUR_APP_ID';
    html.window.open(url, '_blank'); // For Flutter Web
  }

  void _launchPlayStore() {
    const url =
        'https://play.google.com/store/apps/details?id=YOUR_APP_PACKAGE_NAME';
    html.window.open(url, '_blank'); // For Flutter Web
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ramchin Smart School"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---------------- HERO SECTION ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isWide = constraints.maxWidth > 800;
                  return isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// Left Text
                            Expanded(
                              flex: 1,
                              child: SlideTransition(
                                position: _textSlideAnimation,
                                child: _buildHeroText(isWide),
                              ),
                            ),
                            const SizedBox(width: 30),

                            /// Right Image
                            Expanded(flex: 1, child: _buildHeroImage(isWide)),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// Top Image (mobile first)
                            _buildHeroImage(isWide),
                            const SizedBox(height: 20),

                            /// Bottom Text
                            SlideTransition(
                              position: _textSlideAnimation,
                              child: _buildHeroText(isWide),
                            ),
                          ],
                        );
                },
              ),
            ),

            /// ---------------- DEMO LOGIN SECTION ----------------
            Container(
              width: double.infinity,
              color: Colors.blue.shade50,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Explore Our School App Live",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Login with demo accounts and explore Attendance, Homework, Assignments, and more.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Download For Ramchin Smart School App.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // /// Android Download Button
                  // ElevatedButton.icon(
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.green,
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 24,
                  //       vertical: 14,
                  //     ),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //   ),
                  //   onPressed: _launchPlayStore,
                  //   icon: const Icon(
                  //     Icons.android,
                  //     size: 24,
                  //     color: Colors.white,
                  //   ),
                  //   label: const Text(
                  //     "Download Ramchin Smart SchoolApp ",
                  //     style: TextStyle(
                  //       fontSize: 18,
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(width: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Android Download Card
                      InkWell(
                        onTap: _launchPlayStore,
                        borderRadius: BorderRadius.circular(16),
                        child: Column(
                          children: [
                            Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              color: Colors.green,
                              child: const Padding(
                                padding: EdgeInsets.all(20),
                                child: Icon(
                                  Icons.android,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Android",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 24),

                      /// iOS Download Card
                      InkWell(
                        onTap: _launchAppStore,
                        borderRadius: BorderRadius.circular(16),
                        child: Column(
                          children: [
                            Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              color: Colors.black,
                              child: const Padding(
                                padding: EdgeInsets.all(20),
                                child: Icon(
                                  Icons.apple,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "iOS",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  ApkDownloadButton(),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrivacyPolicy(),
                        ),
                      );
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors
                          .click, // 👈 makes it a hand pointer
                      child: const Text(
                        "Privacy Policy",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  /// Demo Accounts
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: const [
                          DemoCard(
                            role: "Admin",
                            schoolid: "2",
                            login: "demoadmin",
                            password: "demo@123",
                          ),
                          DemoCard(
                            role: "Staff",
                            schoolid: "2",
                            login: "9876543210",
                            password: "demo@123",
                          ),
                          DemoCard(
                            role: "Student",
                            schoolid: "2",
                            login: "2025000",
                            password: "demo@123",
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            /// ---------------- WHY SCHOOLS TRUST US ----------------
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Why Schools Trust Us",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Wrap(
                    spacing: 30,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: const [
                      TrustCard(
                        icon: Icons.lock,
                        title: "Secure & Reliable",
                        description:
                            "End-to-end encrypted data with reliable servers.",
                      ),
                      TrustCard(
                        icon: Icons.speed,
                        title: "Fast & Easy",
                        description:
                            "User-friendly design with lightning speed.",
                      ),
                      TrustCard(
                        icon: Icons.support_agent,
                        title: "24/7 Support",
                        description:
                            "Dedicated support team for your school anytime.",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Extracted Widgets for readability
  Widget _buildHeroText(bool isWide) {
    return Column(
      crossAxisAlignment: isWide
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        const Icon(Icons.school, size: 80, color: Colors.blue),
        const SizedBox(height: 20),
        Text(
          "Smart Solutions for Smarter Schools",
          textAlign: isWide ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            fontSize: isWide ? 42 : 28,
            color: Colors.blue.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Attendance, Homework, Assignments and more –\nfor Admins, Staff and Students.",
          textAlign: isWide ? TextAlign.start : TextAlign.center,
          style: TextStyle(fontSize: isWide ? 20 : 16, color: Colors.black87),
        ),
        const SizedBox(height: 25),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 4,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FeaturesPage()),
            );
          },
          icon: const Icon(Icons.explore, size: 20),
          label: const Text(
            "Explore Features",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage(bool isWide) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      height: screenWidth > 1024
          ? MediaQuery.sizeOf(context).height *
                0.45 // Desktop smaller
          : screenWidth > 600
          ? MediaQuery.sizeOf(context).height *
                0.43 // Tablet
          : MediaQuery.sizeOf(context).height * 0.3, // Mobile
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.transparent),
      child: AutoPlayVideo(),
    );
  }
}

/// ---------------- TRUST CARD ----------------
class TrustCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const TrustCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, size: 50, color: Colors.blue),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------- DEMO CARD ----------------
class DemoCard extends StatelessWidget {
  final String role;
  final String login;
  final String password;
  final String schoolid;

  const DemoCard({
    super.key,
    required this.role,
    required this.login,
    required this.password,
    required this.schoolid,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              role,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "School ID: $schoolid",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 5),
            Text(
              "User ID: $login",
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 5),
            Text(
              "Password: $password",
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}

class AutoPlayVideo extends StatefulWidget {
  @override
  _AutoPlayVideoState createState() => _AutoPlayVideoState();
}

class _AutoPlayVideoState extends State<AutoPlayVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset(
            'assets/screenV.mp4',
          ) // or VideoPlayerController.network('URL')
          ..initialize().then((_) {
            setState(() {}); // Refresh UI when initialized
            _controller.play(); // Autoplay video
            _controller.setLooping(true); // Optional: loop video
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : CircularProgressIndicator(),
    );
  }
}

class ApkDownloadButton extends StatelessWidget {
  const ApkDownloadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Path to APK inside web build
        final apkPath = 'assets/apk/ramchinsmartschool.apk';

        html.AnchorElement anchor = html.AnchorElement(href: apkPath)
          ..setAttribute('download', 'ramchin_smart_school.apk')
          ..click();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange, // Button color
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        elevation: 5, // Shadow effect
      ),
      child: const Text(
        "TRY DEMO APK",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
