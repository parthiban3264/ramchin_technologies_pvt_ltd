import 'dart:ui';
import 'package:flutter/material.dart';
import '../services/contact_service.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  bool _hover = false;
  final _service = ContactService();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  void showFlushBar(BuildContext context, String msg, {bool success = true}) {
    Flushbar(
      message: msg,
      maxWidth: 300,
      duration: const Duration(seconds: 5),
      backgroundColor: success ? Colors.green : Colors.red,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      icon: Icon(
        success ? Icons.check_circle : Icons.error,
        color: Colors.white,
      ),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  Future<void> _handleSend() async {
    setState(() => _isLoading = true);
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    // Dismiss keyboard on mobile after button pressed
    FocusScope.of(context).unfocus(); // Key mobile keyboard fix[1][2]

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      setState(() => _isLoading = false);
      showFlushBar(context, "Please fill all fields", success: false);
      return;
    }

    final success = await _service.sendMessage(name, email, message);
    setState(() => _isLoading = false);

    if (success) {
      showFlushBar(context, "Message sent successfully", success: true);
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    } else {
      showFlushBar(context, "Failed to send message", success: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFe0f7fa), Color(0xFF80deea)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SingleChildScrollView(
        // Enable drag-to-dismiss for the keyboard on mobile
        keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.onDrag, // [2]
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            const PulsingImage(),
            const SizedBox(height: 40),
            isMobile
                ? Column(
                    children: [
                      AnimatedPadding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        child: _buildContactFormCard(),
                      ),
                      const SizedBox(height: 20),
                      _buildContactInfoCard(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: _buildContactFormCard()),
                      const SizedBox(width: 40),
                      Expanded(child: _buildContactInfoCard()),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactFormCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          color: Colors.white.withAlpha(192),
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildAnimatedField(
                  delay: 300,
                  hint: "Your Name",
                  icon: Icons.person,
                  controller: _nameController,
                ),
                const SizedBox(height: 16),
                _buildAnimatedField(
                  delay: 600,
                  hint: "Your Email",
                  icon: Icons.email,
                  controller: _emailController,
                ),
                const SizedBox(height: 16),
                _buildAnimatedField(
                  delay: 900,
                  hint: "Your Message",
                  icon: Icons.message,
                  controller: _messageController,
                  maxLines: 4,
                ),
                const SizedBox(height: 24),
                _buildSendButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfoCard() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutBack,
      tween: Tween<double>(begin: 0.8, end: 1.0),
      builder: (context, double value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Card(
            elevation: 8,
            color: Colors.white.withAlpha(192),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Padding(
              padding: EdgeInsets.all(28.0),
              child: ContactInfoWidget(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedField({
    required int delay,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return AnimatedInputField(
      delay: delay,
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          hintText: hint,
          filled: true,
          fillColor: Colors.white.withAlpha(230),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return InkWell(
      onTap: _isLoading ? null : _handleSend,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()
            ..scale(_hover && !_isLoading ? 1.08 : 1.0),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.blue, Colors.lightBlue],
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade200,
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isLoading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  ),
                )
              else ...[
                const Icon(Icons.send, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                const Text(
                  "Send Message",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Animated Input Field
class AnimatedInputField extends StatelessWidget {
  final Widget child;
  final int delay;
  const AnimatedInputField({
    super.key,
    required this.child,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      builder: (context, Offset offset, child) {
        return Transform.translate(offset: offset * 40, child: child);
      },
      child: child,
    );
  }
}

class ContactInfoWidget extends StatelessWidget {
  const ContactInfoWidget({super.key});

  Widget _buildInfoRow(String label, String value, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label ",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isLink ? Colors.blue : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow("Company:", "Ramchin Technologies Private Limited"),
        _buildInfoRow(
          "Corporate Identification Number (CIN):",
          "U62013TN2025PTC179750",
        ),
        _buildInfoRow("Phone:", "+91 9342401822 | +91 8610819018"),
        _buildInfoRow("Email:", "ramchintech@gmail.com", isLink: true),
        const SizedBox(height: 6),
        const Text(
          "Address:",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          "1/139-15, I st Street, Kurunji Nagar,\n"
          "Veerapandianpatnam,\n"
          "Tiruchendur,\n"
          "Thoothukudi Dt,\n"
          "Tamil Nadu, PIN: 628216",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        const Text(
          "Follow Us:",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        const SocialLinks(),
      ],
    );
  }
}

class PulsingImage extends StatefulWidget {
  const PulsingImage({super.key});
  @override
  _PulsingImageState createState() => _PulsingImageState();
}

class _PulsingImageState extends State<PulsingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(
        begin: 1.0,
        end: 1.1,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      child: Text(
        '✨ Get In Touch ✨',
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
          shadows: [
            Shadow(blurRadius: 10, color: Colors.blue, offset: Offset(0, 0)),
          ],
        ),
      ),
    );
  }
}

class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 12,
      children: [
        _buildLink(
          FontAwesomeIcons.linkedin,
          "LinkedIn",
          "https://linkedin.com",
        ),
        _buildLink(
          FontAwesomeIcons.facebook,
          "Facebook",
          "https://facebook.com",
        ),
        _buildLink(
          FontAwesomeIcons.instagram,
          "Instagram",
          "https://instagram.com",
        ),
        _buildLink(FontAwesomeIcons.upwork, "Upwork", "https://upwork.com"),
        _buildLink(FontAwesomeIcons.youtube, "YouTube", "https://youtube.com"),
        _buildLink(FontAwesomeIcons.xTwitter, "X (Twitter)", "https://x.com"),
      ],
    );
  }

  Widget _buildLink(IconData icon, String text, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(icon, color: Colors.blue, size: 20),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 16,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
