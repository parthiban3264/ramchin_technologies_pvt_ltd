import 'package:flutter/material.dart';
import 'package:ramchin_technologies_pvt_ltd/pages/SplashScreen.dart';

import 'course/pages/angular_page.dart';
import 'course/pages/courses_page.dart';
import 'course/pages/flutter_page.dart';
import 'course/pages/home_page.dart';
import 'course/pages/internships_page.dart';
import 'course/pages/privacy_policy_page.dart';
import 'course/pages/react_native_page.dart';
import 'course/pages/react_page.dart';
import 'course/pages/terms_conditions_page.dart';
import 'course/util.dart';

void main() {
  runApp(const MyWebApp());
}

class MyWebApp extends StatelessWidget {
  const MyWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ramchin Technologies Pvt Ltd',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(), // 👈 splash first
      debugShowCheckedModeBanner: false,
      routes: {
        '/courses': (_) => CoursesPage(),
        '/internships': (_) => InternshipsPage(),
        '/terms': (context) => TermsConditionsPage(),
        '/privacy': (context) => PrivacyPolicyPage(),
        '/flutter': (context) => FlutterPage(
          courseName: 'Flutter',
          amount: '${course[0]['amount']}',
        ),
        '/react': (context) =>
            ReactPage(courseName: 'React', amount: '${course[1]['amount']}'),
        '/angular': (context) => AngularPage(
          courseName: 'Angular',
          amount: '${course[3]['amount']}',
        ),
        '/react-native': (context) => ReactNativePage(
          courseName: 'React Native',
          amount: '${course[2]['amount']}',
        ),
      },
    );
  }
}

// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   runApp(SchoolFormApp());
// }
//
// class SchoolFormApp extends StatelessWidget {
//   const SchoolFormApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Ramchin Smart School Accounts',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: SchoolFormPage(),
//     );
//   }
// }
//
// class SchoolFormPage extends StatefulWidget {
//   const SchoolFormPage({super.key});
//
//   @override
//   _SchoolFormPageState createState() => _SchoolFormPageState();
// }
//
// class _SchoolFormPageState extends State<SchoolFormPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController schoolIdController = TextEditingController();
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController reasonController = TextEditingController();
//
//   Future<void> submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       final url = Uri.parse('http://localhost:3000/form');
//       final body = {
//         "schoolId": schoolIdController.text,
//         "username": usernameController.text,
//         "reason": reasonController.text,
//       };
//
//       try {
//         final response = await http.post(
//           url,
//           headers: {"Content-Type": "application/json"},
//           body: json.encode(body),
//         );
//
//         if (response.statusCode == 201 || response.statusCode == 200) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('✅ Request submitted successfully!')),
//           );
//           _formKey.currentState!.reset();
//         } else {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text('❌ Failed: ${response.body}')));
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('⚠️ Error: $e')));
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue.shade50,
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24.0),
//             child: Card(
//               elevation: 10,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16.0),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         Icons.delete_forever,
//                         color: Colors.redAccent,
//                         size: 60,
//                       ),
//                       SizedBox(height: 16),
//                       Text(
//                         'Account Deletion Request',
//                         style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Please fill out the form below to request account deletion.',
//                         style: Theme.of(context).textTheme.bodyMedium,
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 24),
//                       TextFormField(
//                         controller: schoolIdController,
//                         decoration: InputDecoration(
//                           labelText: 'School ID',
//                           hintText: 'Enter your school identification number',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           prefixIcon: Icon(Icons.school),
//                         ),
//                         validator: (value) => value!.isEmpty
//                             ? 'Please enter your School ID'
//                             : null,
//                       ),
//                       SizedBox(height: 16),
//                       TextFormField(
//                         controller: usernameController,
//                         decoration: InputDecoration(
//                           labelText: 'Username',
//                           hintText: 'Enter the username of the account',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           prefixIcon: Icon(Icons.person),
//                         ),
//                         validator: (value) =>
//                             value!.isEmpty ? 'Please enter the username' : null,
//                       ),
//                       SizedBox(height: 16),
//                       TextFormField(
//                         controller: reasonController,
//                         decoration: InputDecoration(
//                           labelText: 'Reason for Deletion',
//                           hintText:
//                               'Briefly explain why you want to delete the account',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           prefixIcon: Icon(Icons.help_outline),
//                         ),
//                         maxLines: 3,
//                         validator: (value) =>
//                             value!.isEmpty ? 'Please provide a reason' : null,
//                       ),
//                       SizedBox(height: 24),
//                       ElevatedButton(
//                         onPressed: submitForm,
//                         style: ElevatedButton.styleFrom(
//                           padding: EdgeInsets.symmetric(vertical: 16.0),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           backgroundColor: Colors.blue,
//                         ),
//                         child: Text(
//                           'Submit Request',
//                           style: TextStyle(fontSize: 18, color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
