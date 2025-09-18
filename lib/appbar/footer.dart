import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key, required this.onTabSelected});
  final void Function(int) onTabSelected;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Container(
      color: const Color(0xFF2E3238),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: Column(
        children: [
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _companyInfo(context),
                    const SizedBox(height: 30),
                    _siteLinks(),
                    const SizedBox(height: 30),
                    _officeAddress(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _companyInfo(context)),
                    _divider(),
                    Expanded(flex: 2, child: _siteLinks()),
                    _divider(),
                    Expanded(flex: 2, child: _officeAddress()),
                  ],
                ),
          const SizedBox(height: 20),
          const Divider(color: Colors.white24),
          const SizedBox(height: 10),
          const Text(
            "© 2025 Ramchin Technologies Pvt Ltd. All Rights Reserved.",
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  // Reusable vertical divider
  Widget _divider() => Container(
    height: 180,
    margin: const EdgeInsets.symmetric(horizontal: 50),
    width: 1,
    color: Colors.white24,
  );

  // ✅ Company Info Section
  Widget _companyInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          "assets/ramchinlogo.png",
          fit: BoxFit.contain,
          width: 220,
          height: 80,
        ),
        const SizedBox(height: 12),
        const Text(
          "Ramchin Technologies Pvt Ltd is a Software Development and "
          "Consultancy Company founded in 2025, delivering streamlined "
          "and customizable services and solutions to clients.",
          style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
        ),
        const SizedBox(height: 15),
        InkWell(
          onTap: () {
            _openPdf("assets/Brochure.pdf");
          },
          borderRadius: BorderRadius.circular(8),
          child: Row(
            children: const [
              Icon(Icons.picture_as_pdf, color: Colors.redAccent),
              SizedBox(width: 8),
              Text(
                "View Our Brochure",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _openPdf(String path) async {
    final Uri url = Uri.parse(path);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not open PDF at $path");
    }
  }

  // ✅ Site Links Section
  Widget _siteLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Site Links",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FooterLink("Home", onTabSelected: onTabSelected, index: 0),
                  FooterLink("Careers", onTabSelected: onTabSelected, index: 0),
                  FooterLink(
                    "CEO's Profile",
                    onTabSelected: onTabSelected,
                    index: 0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FooterLink(
                    "Services",
                    onTabSelected: onTabSelected,
                    index: 4,
                  ),
                  FooterLink(
                    "Contact Us",
                    onTabSelected: onTabSelected,
                    index: 7,
                  ),
                  FooterLink(
                    "Management",
                    onTabSelected: onTabSelected,
                    index: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ✅ Office Address Section
  Widget _officeAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Office Address",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "Ramchin Technologies Private Limited,\n"
          "1/396-15, 1st Street, Kurunji Nagar,\n"
          "Veerapandianpatnam,\n"
          "Tiruchendur, Thoothukudi dt - 628216.\n"
          "CIN: U62013TN2025PTC179750",
          style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
        ),
        const SizedBox(height: 10),

        // Phone
        _contactRow(
          icon: Icons.phone,
          text: "+91 8610819018",
          onTap: () => _launchPhone("+918610819018"),
          onLongPress: () => _launchWhatsApp("918610819018"),
          underline: true,
        ),
        const SizedBox(height: 6),

        // Email
        _contactRow(
          icon: Icons.email,
          text: "ramchintech@gmail.com",
          onTap: () => _launchEmail("ramchintech@gmail.com"),
          underline: true,
          color: Colors.blue.shade300,
        ),
        const SizedBox(height: 6),

        // Website
        _contactRow(
          icon: Icons.language,
          text: "www.ramchintech.com",
          onTap: () => _launchWebsite("https://www.ramchintech.com"),
          underline: true,
          color: Colors.blue.shade300,
        ),
      ],
    );
  }

  Widget _contactRow({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    VoidCallback? onLongPress,
    bool underline = false,
    Color color = Colors.white70,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white70),
        const SizedBox(width: 6),
        InkWell(
          onTap: () => Future.microtask(onTap),
          onLongPress: onLongPress != null
              ? () => Future.microtask(onLongPress)
              : null,
          child: Text(
            text,
            style: TextStyle(
              color: color,
              decoration: underline ? TextDecoration.underline : null,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchPhone(String phone) async {
    final Uri uri = Uri(scheme: 'tel', path: phone);
    launchUrl(uri);
  }

  Future<void> _launchWhatsApp(String phone) async {
    final Uri uri = Uri.parse("https://wa.me/$phone");
    launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _launchEmail(String email) async {
    final Uri uri = Uri(scheme: 'mailto', path: email);
    launchUrl(uri);
  }

  Future<void> _launchWebsite(String url) async {
    final Uri uri = Uri.parse(url);
    launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class FooterLink extends StatefulWidget {
  final String title;
  final int index;
  final void Function(int) onTabSelected;
  const FooterLink(
    this.title, {
    super.key,
    required this.onTabSelected,
    required this.index,
  });

  @override
  State<FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<FooterLink> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTabSelected(widget.index),
      onHover: (hovering) => setState(() => _isHovering = hovering),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              Icons.chevron_right,
              size: 12,
              color: _isHovering ? Colors.blueAccent : Colors.white70,
            ),
            const SizedBox(width: 6),
            Text(
              widget.title,
              style: TextStyle(
                color: _isHovering ? Colors.blueAccent : Colors.white70,
                fontSize: 12,
                fontWeight: _isHovering ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
// class PdfViewerPage extends StatelessWidget {
//   final String assetPath;
//
//   const PdfViewerPage({Key? key, required this.assetPath}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ,
//     );
//   }
// }
