import 'package:flutter/material.dart';
import 'Home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FBFF), Color(0xFFEFF3F6)], // light gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/ramchinlogoB.png',
                  width: isMobile ? 200 : 320,
                  height: isMobile ? 60 : 110,
                ),
                // const SizedBox(height: 2),
                // const Text(
                //   "Ramchin Technologies Pvt Ltd.",
                //   style: TextStyle(
                //     fontSize: 22,
                //     fontWeight: FontWeight.w600,
                //     color: Colors.black87,
                //     letterSpacing: 1.1,
                //   ),
                // ),
                // const SizedBox(height: 30),
                const SizedBox(
                  width: 50,
                  height: 28,
                  child: SpinKitThreeBounce(color: Colors.blueAccent, size: 25),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
