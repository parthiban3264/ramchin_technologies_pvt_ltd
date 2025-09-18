import 'package:flutter/material.dart';
import 'package:ramchin_technologies_pvt_ltd/pages/SplashScreen.dart';

import 'course/pages/angular_page.dart';
import 'course/pages/courses_page.dart';
import 'course/pages/flutter_page.dart';
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
