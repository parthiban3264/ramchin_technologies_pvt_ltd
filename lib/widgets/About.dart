// import 'package:flutter/material.dart';
//
// class AboutUsPage extends StatelessWidget {
//   AboutUsPage({super.key});
//
//   // ---------- Sample Data ----------
//   final List<_StoryEvent> story = [
//     _StoryEvent(
//       year: "2025",
//       title: "Founded",
//       detail: "Started in Tamil Nadu to help SMEs go digital.",
//     ),
//     _StoryEvent(
//       year: "2026",
//       title: "First 20 Clients",
//       detail: "Scaled service delivery with quality-first culture.",
//     ),
//     _StoryEvent(
//       year: "2027",
//       title: "Products Launch",
//       detail: "Released two SaaS tools for mobile commerce & analytics.",
//     ),
//     _StoryEvent(
//       year: "2028",
//       title: "Global Footprint",
//       detail: "Served customers across 6 countries.",
//     ),
//   ];
//
//   final List<TeamMember> team = [
//     TeamMember(
//       name: "Arjun Kumar",
//       role: "CEO",
//       imageUrl: "https://via.placeholder.com/150",
//       bio: "Vision-driven entrepreneur focused on product-market fit.",
//     ),
//     TeamMember(
//       name: "Priya Sharma",
//       role: "Lead Developer",
//       imageUrl: "https://via.placeholder.com/150",
//       bio: "Full-stack specialist in Flutter, Node.js, cloud.",
//     ),
//     TeamMember(
//       name: "Rahul Verma",
//       role: "Design Lead",
//       imageUrl: "https://via.placeholder.com/150",
//       bio: "Human-centered design, brand systems, motion.",
//     ),
//     TeamMember(
//       name: "Neha Singh",
//       role: "Project Manager",
//       imageUrl: "https://via.placeholder.com/150",
//       bio: "Delivery excellence, agile facilitation, stakeholder success.",
//     ),
//   ];
//
//   final List<_Service> services = [
//     _Service(
//       "Custom Software",
//       Icons.developer_mode,
//       "Web, mobile, and API platforms tailored to your workflow.",
//     ),
//     _Service(
//       "Cloud & DevOps",
//       Icons.cloud_done_outlined,
//       "Scalable, secure, cost-optimized infrastructure.",
//     ),
//     _Service(
//       "UI/UX Design",
//       Icons.design_services_outlined,
//       "Delightful, accessible, conversion-focused design.",
//     ),
//     _Service(
//       "Data & Analytics",
//       Icons.insights_outlined,
//       "Dashboards, BI pipelines, decision intelligence.",
//     ),
//   ];
//
//   final List<_Value> values = [
//     _Value(
//       "Integrity",
//       Icons.verified_user_outlined,
//       "We do the right thing—always.",
//     ),
//     _Value(
//       "Innovation",
//       Icons.lightbulb_outline,
//       "We experiment, learn, and innovate fast.",
//     ),
//     _Value(
//       "Customer-First",
//       Icons.favorite_outline,
//       "Your success defines ours.",
//     ),
//     _Value(
//       "Sustainability",
//       Icons.eco_outlined,
//       "Responsible tech with long-term impact.",
//     ),
//   ];
//
//   final List<_Achievement> achievements = [
//     _Achievement("50+ Projects Delivered", Icons.rocket_launch_outlined),
//     _Achievement("98% On-time Delivery", Icons.schedule_outlined),
//     _Achievement("Top Rated by Clients", Icons.stars_outlined),
//     _Achievement("6 Countries Served", Icons.public_outlined),
//   ];
//
//   final List<_Testimonial> testimonials = [
//     _Testimonial(
//       name: "Client A",
//       role: "Founder, RetailTech",
//       quote: "Ramchin Technologics transformed our mobile experience.",
//     ),
//     _Testimonial(
//       name: "Client B",
//       role: "COO, FinServe",
//       quote: "Highly reliable partner—great engineers, better people.",
//     ),
//     _Testimonial(
//       name: "Client C",
//       role: "CTO, HealthPlus",
//       quote: "Clear communication, strong delivery, and measurable results.",
//     ),
//   ];
//
//   final List<String> futureGoals = [
//     "Launch two vertical SaaS products for SMEs.",
//     "Expand engineering hubs across South Asia.",
//     "Achieve ISO/IEC security certifications.",
//     "Invest in R&D for AI-powered automation.",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final isWide = MediaQuery.of(context).size.width > 900;
//
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       body: CustomScrollView(
//         slivers: [
//           // ---------- Header / Who We Are ----------
//           SliverToBoxAdapter(
//             child: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Color(0xFFA1C4FD),
//                     Color(0xFFC2E9FB),
//                   ], // light, professional
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(28),
//                   bottomRight: Radius.circular(28),
//                 ),
//               ),
//               padding: const EdgeInsets.fromLTRB(24, 56, 24, 32),
//               child: Column(
//                 children: [
//                   Text(
//                     "Who We Are",
//                     style: TextStyle(
//                       fontSize: isWide ? 42 : 32,
//                       fontWeight: FontWeight.w800,
//                       color: Colors.black87,
//                       letterSpacing: 0.3,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 12),
//                   const Text(
//                     "Ramchin Technologics is a product and services company helping businesses\n"
//                     "modernize with cloud-native software, scalable platforms, and thoughtful design.\n"
//                     "Founded to bridge ambition and execution, we partner with teams to ship reliable\n"
//                     "technology that creates real business value.",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black87,
//                       height: 1.6,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 18),
//                   Wrap(
//                     alignment: WrapAlignment.center,
//                     spacing: 10,
//                     runSpacing: 10,
//                     children: [
//                       _pill("Founded: 2025"),
//                       _pill("HQ: Tamil Nadu, India"),
//                       _pill("Focus: Software • Cloud • Design • Data"),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           // ---------- Mission & Vision ----------
//           SliverToBoxAdapter(
//             child: _section(
//               context,
//               title: "Mission & Vision",
//               child: LayoutBuilder(
//                 builder: (_, __) => Wrap(
//                   spacing: 16,
//                   runSpacing: 16,
//                   alignment: WrapAlignment.center,
//                   children: [
//                     _infoCard(
//                       icon: Icons.flag_outlined,
//                       title: "Mission (Today)",
//                       text:
//                           "Design and deliver reliable, scalable software that helps customers ship faster,\nreduce costs, and grow with confidence.",
//                     ),
//                     _infoCard(
//                       icon: Icons.visibility_outlined,
//                       title: "Vision (Future)",
//                       text:
//                           "Be a global catalyst for digital innovation—building platforms that empower\nmillions and elevate how businesses operate.",
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           // ---------- Company Overview (Core values & Why founded) ----------
//           SliverToBoxAdapter(
//             child: _section(
//               context,
//               title: "Company Overview",
//               child: _infoCard(
//                 icon: Icons.apartment_outlined,
//                 title: "Why We Started",
//                 text:
//                     "We saw teams struggle to turn ideas into scalable products. Ramchin Technologics exists to\nclose that gap with experienced engineering, design thinking, and a partnership mindset.",
//               ),
//             ),
//           ),
//
//           // ---------- Our Story / Timeline ----------
//           SliverToBoxAdapter(
//             child: _section(
//               context,
//               title: "Our Story",
//               subtitle:
//                   "How it all started • Struggles • Achievements • Growth",
//               child: _timeline(story),
//             ),
//           ),
//
//           // ---------- What We Do / Services ----------
//           SliverToBoxAdapter(
//             child: _section(
//               context,
//               title: "What We Do",
//               subtitle: "Why customers choose us",
//               child: _servicesGrid(services),
//             ),
//           ),
//
//           // ---------- Meet Our Team ----------
//           SliverToBoxAdapter(
//             child: _section(
//               context,
//               title: "Meet Our Team",
//               subtitle: "The people behind the progress",
//               child: _teamGrid(team),
//             ),
//           ),
//
//           // ---------- Core Values / Culture ----------
//           SliverToBoxAdapter(
//             child: _section(
//               context,
//               title: "Core Values & Culture",
//               child: _valuesGrid(values),
//             ),
//           ),
//
//           // ---------- Achievements & Milestones ----------
//           SliverToBoxAdapter(
//             child: _section(
//               context,
//               title: "Achievements & Milestones",
//               child: _achievementsWrap(achievements),
//             ),
//           ),
//
//           // ---------- Client Testimonials ----------
//           SliverToBoxAdapter(
//             child: _section(
//               context,
//               title: "What Clients Say",
//               child: _testimonialsCarousel(testimonials),
//             ),
//           ),
//
//           // ---------- Future Goals ----------
//           SliverToBoxAdapter(
//             child: _section(
//               context,
//               title: "Future Goals",
//               child: _goalsList(futureGoals),
//             ),
//           ),
//
//           // ---------- CTA ----------
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(24, 0, 24, 36),
//               child: _ctaBar(
//                 onWorkWithUs: () {},
//                 onJoinTeam: () {},
//                 onContact: () {},
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ---------- UI Building Blocks ----------
//
//   static Widget _section(
//     BuildContext context, {
//     required String title,
//     String? subtitle,
//     required Widget child,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(24, 28, 24, 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.w800,
//               color: Colors.black87,
//             ),
//           ),
//           if (subtitle != null) ...[
//             const SizedBox(height: 6),
//             Text(
//               subtitle,
//               style: const TextStyle(fontSize: 14, color: Colors.black54),
//               textAlign: TextAlign.center,
//             ),
//           ],
//           const SizedBox(height: 16),
//           child,
//         ],
//       ),
//     );
//   }
//
//   static Widget _pill(String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.85),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Text(text, style: const TextStyle(fontSize: 13)),
//     );
//   }
//
//   static Widget _infoCard({
//     required IconData icon,
//     required String title,
//     required String text,
//   }) {
//     return Container(
//       width: 460,
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey.shade200),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 28, color: Colors.blueAccent),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(text, style: const TextStyle(fontSize: 14, height: 1.55)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static Widget _timeline(List<_StoryEvent> events) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Column(
//         children: events
//             .map(
//               (e) => Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Dot & line
//                   Column(
//                     children: [
//                       Container(
//                         width: 14,
//                         height: 14,
//                         decoration: const BoxDecoration(
//                           color: Colors.blueAccent,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       if (e != events.last)
//                         Container(
//                           width: 2,
//                           height: 48,
//                           color: Colors.blueAccent.withOpacity(0.4),
//                         ),
//                     ],
//                   ),
//                   const SizedBox(width: 12),
//                   // Card
//                   Expanded(
//                     child: Container(
//                       margin: const EdgeInsets.only(bottom: 16),
//                       padding: const EdgeInsets.all(14),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: Colors.grey.shade200),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "${e.year} — ${e.title}",
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 14,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           Text(
//                             e.detail,
//                             style: const TextStyle(fontSize: 14, height: 1.5),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }
//
//   static Widget _servicesGrid(List<_Service> services) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // Decide columns based on screen width
//         int crossAxisCount = 1; // default (mobile)
//         if (constraints.maxWidth > 1200) {
//           crossAxisCount = 3; // desktop
//         } else if (constraints.maxWidth > 700) {
//           crossAxisCount = 2; // tablet
//         }
//
//         return GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: services.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: crossAxisCount,
//             crossAxisSpacing: 16,
//             mainAxisSpacing: 16,
//             childAspectRatio: crossAxisCount == 1 ? 2 : 1.8,
//           ),
//           itemBuilder: (_, i) {
//             final s = services[i];
//             return AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: Colors.grey.shade200),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(s.icon, size: 28, color: Colors.blueAccent),
//                   const SizedBox(height: 12),
//                   Text(
//                     s.title,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     s.desc,
//                     style: const TextStyle(fontSize: 14, height: 1.6),
//                   ),
//                   const Spacer(),
//                   Wrap(
//                     spacing: 8,
//                     children: [
//                       _tag("Secure"),
//                       _tag("Scalable"),
//                       _tag("Reliable"),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   static Widget _teamGrid(List<TeamMember> team) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: team.length,
//       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//         maxCrossAxisExtent: 360,
//         mainAxisSpacing: 16,
//         crossAxisSpacing: 16,
//         childAspectRatio: 1.2,
//       ),
//       itemBuilder: (_, i) => _teamCard(team[i]),
//     );
//   }
//
//   static Widget _teamCard(TeamMember m) {
//     return InkWell(
//       onTap: () {}, // hook to your detail page if you want
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 250),
//         curve: Curves.easeInOut,
//         padding: const EdgeInsets.all(14),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.white, Colors.blue.shade50],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: Colors.grey.shade200),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             CircleAvatar(radius: 36, backgroundImage: NetworkImage(m.imageUrl)),
//             const SizedBox(height: 10),
//             Text(
//               m.name,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//             ),
//             Text(
//               m.role,
//               style: const TextStyle(color: Colors.black54, fontSize: 13),
//             ),
//             const SizedBox(height: 8),
//             Expanded(
//               child: Text(
//                 m.bio,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontSize: 13, height: 1.4),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   static Widget _valuesGrid(List<_Value> values) {
//     return Wrap(
//       spacing: 16,
//       runSpacing: 16,
//       alignment: WrapAlignment.center,
//       children: values
//           .map(
//             (v) => Container(
//               width: 240,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: Colors.grey.shade200),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Icon(v.icon, size: 32, color: Colors.blueAccent),
//                   const SizedBox(height: 10),
//                   Text(
//                     v.title,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     v.desc,
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(fontSize: 14, height: 1.5),
//                   ),
//                 ],
//               ),
//             ),
//           )
//           .toList(),
//     );
//   }
//
//   static Widget _achievementsWrap(List<_Achievement> achievements) {
//     return Wrap(
//       spacing: 12,
//       runSpacing: 12,
//       alignment: WrapAlignment.center,
//       children: achievements
//           .map(
//             (a) => Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(14),
//                 border: Border.all(color: Colors.grey.shade200),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 8,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(a.icon, color: Colors.blueAccent),
//                   const SizedBox(width: 8),
//                   Text(
//                     a.title,
//                     style: const TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//           )
//           .toList(),
//     );
//   }
//
//   static Widget _testimonialsCarousel(List<_Testimonial> testimonials) {
//     return SizedBox(
//       height: 170,
//       child: PageView.builder(
//         controller: PageController(viewportFraction: 0.9),
//         itemCount: testimonials.length,
//         itemBuilder: (_, i) {
//           final t = testimonials[i];
//           return AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             margin: const EdgeInsets.symmetric(horizontal: 6),
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: Colors.grey.shade200),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.06),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.format_quote, color: Colors.blueAccent),
//                 const SizedBox(height: 8),
//                 Text(
//                   t.quote,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontSize: 14, height: 1.6),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   "${t.name} — ${t.role}",
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.black54,
//                     fontStyle: FontStyle.italic,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   static Widget _goalsList(List<String> goals) {
//     return Column(
//       children: goals
//           .map(
//             (g) => Padding(
//               padding: const EdgeInsets.symmetric(vertical: 6.0),
//               child: Row(
//                 children: [
//                   const Icon(
//                     Icons.check_circle_outline,
//                     color: Colors.blueAccent,
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(g, style: const TextStyle(fontSize: 14)),
//                   ),
//                 ],
//               ),
//             ),
//           )
//           .toList(),
//     );
//   }
//
//   static Widget _tag(String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.blue.shade50,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(fontSize: 12, color: Colors.black87),
//       ),
//     );
//   }
//
//   static Widget _ctaBar({
//     required VoidCallback onWorkWithUs,
//     required VoidCallback onJoinTeam,
//     required VoidCallback onContact,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey.shade200),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Wrap(
//         alignment: WrapAlignment.center,
//         spacing: 12,
//         runSpacing: 12,
//         children: [
//           _ctaButton("Work with Us", Icons.handshake_outlined, onWorkWithUs),
//           _ctaButton("Join Our Team", Icons.badge_outlined, onJoinTeam),
//           _ctaButton("Contact Us", Icons.email_outlined, onContact),
//         ],
//       ),
//     );
//   }
//
//   static Widget _ctaButton(String text, IconData icon, VoidCallback onPressed) {
//     return ElevatedButton.icon(
//       onPressed: onPressed,
//       icon: Icon(icon),
//       label: Text(text),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.blueAccent,
//         foregroundColor: Colors.white,
//         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         elevation: 2,
//       ),
//     );
//   }
// }
//
// // ---------- Simple Models ----------
// class TeamMember {
//   final String name;
//   final String role;
//   final String imageUrl;
//   final String bio;
//   TeamMember({
//     required this.name,
//     required this.role,
//     required this.imageUrl,
//     required this.bio,
//   });
// }
//
// class _StoryEvent {
//   final String year;
//   final String title;
//   final String detail;
//   _StoryEvent({required this.year, required this.title, required this.detail});
// }
//
// class _Service {
//   final String title;
//   final IconData icon;
//   final String desc;
//   _Service(this.title, this.icon, this.desc);
// }
//
// class _Value {
//   final String title;
//   final IconData icon;
//   final String desc;
//   _Value(this.title, this.icon, this.desc);
// }
//
// class _Achievement {
//   final String title;
//   final IconData icon;
//   _Achievement(this.title, this.icon);
// }
//
// class _Testimonial {
//   final String name;
//   final String role;
//   final String quote;
//   _Testimonial({required this.name, required this.role, required this.quote});
// }
