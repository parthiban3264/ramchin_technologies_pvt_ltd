import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ManagementMember {
  final String image;
  final String name;
  final String role;
  final String description;
  final String pdfPath;

  ManagementMember({
    required this.image,
    required this.name,
    required this.role,
    required this.description,
    required this.pdfPath,
  });
}

class MemberSection extends StatelessWidget {
  MemberSection({super.key});

  final List<ManagementMember> members = [
    ManagementMember(
      image: "assets/cvsir2.jpg",
      name: "Dr. C VELAYUTHAM",
      role: "Managing Director",
      description:
          "Dr C Velayutham, is the Managing Director of Ramchin Technologies (P) Ltd., He did Postgraduate in Applied Mathematics, Doctoral degree in Computer Science.",
      pdfPath: "assets/drcv.pdf",
    ),
    ManagementMember(
      image: "assets/mozhi2.png",
      name: "Mrs V THIRAVIDAMOZHI, MBA",
      role: "Director HRD",
      description:
          "Mrs. V Thiravidamozhi is the Director of Ramchin Technologies (P) Ltd. She did MBA (HRD) in Alagappa University, Karaikudi.",
      pdfPath: "assets/team/thiravidamozhi.pdf",
    ),
    ManagementMember(
      image: "assets/SenPhoto3.jpg",
      name: "SENTHIL RAMCHIN V",
      role: "Data Analyst",
      description:
          "Mr Senthil Ramchin V is the Data Analyst of Ramchin Technologies (P) Ltd. He is M.Sc Post Graduate in Mathematics, Manonmaniam Sundaranar University, Tirunelveli.",
      pdfPath: "assets/team/senthil.pdf",
    ),
    ManagementMember(
      image: "assets/SarPhoto.png",
      name: "SARAVANA RAMCHIN V",
      role: "Director - Operations",
      description:
          "Mr Saravana Ramchin V is the Director Admin of Ramchin Technologies (P) Ltd. He is B.E Graduate in Computer Science and Engineering, Anna University, Chennai.",
      pdfPath: "assets/team/saravana.pdf",
    ),
  ];

  Future<void> _openPdf(String path) async {
    final Uri url = Uri.parse(path);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not open PDF at $path");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 🔹 Title Section
        const SizedBox(height: 40),
        const Text(
          "Management",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        Center(
          child: Text(
            "We have a strong Management team",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 30),

        // 🔹 Horizontal Scroll Cards
        SizedBox(
          height: 360,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: members.map((member) {
                return Container(
                  width: 300,
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(member.image),
                        radius: 45,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        member.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        member.role,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        member.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () => _openPdf(member.pdfPath),
                        child: const Text(
                          "Read more",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
