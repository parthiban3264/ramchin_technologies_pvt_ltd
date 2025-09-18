// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// //
// // class AdminAuthService {
// //   final String baseUrl = "https://rdt3tvjb-3000.inc1.devtunnels.ms";
// //
// //   Future<bool> sendMessage(String name, String email, String password) async {
// //     final url = Uri.parse("${Utils.baseUrl}/Adminauth/register");
// //
// //     try {
// //       final response = await http.post(
// //         url,
// //         headers: {"Content-Type": "application/json"},
// //         body: jsonEncode({"name": name, "email": email, "password": password}),
// //       );
// //
// //       print("Response status: ${response.statusCode}");
// //       print("Response body: ${response.body}");
// //
// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         final data = jsonDecode(response.body);
// //
// //         if (data["status"] == "Admin registered successfully") {
// //           return true;
// //         }
// //       }
// //       return false;
// //     } catch (e) {
// //       print("Error sending message: $e");
// //       return false;
// //     }
// //   }
// // }
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class Admin {
//   final int id;
//   final String name;
//   final String email;
//
//   Admin({required this.id, required this.name, required this.email});
//
//   factory Admin.fromJson(Map<String, dynamic> json) {
//     return Admin(id: json['id'], name: json['name'], email: json['email']);
//   }
// }
//
// class AdminService {
//   static const String baseUrl = "https://rdt3tvjb-3000.inc1.devtunnels.ms";
//
//   /// ✅ Get all admins
//   static Future<List<Admin>> getAllAdmins() async {
//     try {
//       final response = await http.get(
//         Uri.parse("${Utils.baseUrl}/Adminauth/all"),
//         headers: {"Content-Type": "application/json"},
//       );
//
//       print("📥 Fetch Response: ${response.statusCode}");
//
//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         return data.map((json) => Admin.fromJson(json)).toList();
//       } else {
//         print("❌ Failed to fetch admins: ${response.body}");
//         return [];
//       }
//     } catch (e) {
//       print("❌ Error fetching admins: $e");
//       return [];
//     }
//   }
// }
//
// class AdminAuthService {
//   final String baseUrl = "https://rdt3tvjb-3000.inc1.devtunnels.ms";
//
//   // ✅ Register Admin
//   Future<bool> register(String name, String email, String password) async {
//     final url = Uri.parse("${Utils.baseUrl}/Adminauth/register");
//
//     try {
//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"name": name, "email": email, "password": password}),
//       );
//
//       print("Register response: ${response.body}");
//       final data = jsonDecode(response.body);
//       if ((response.statusCode == 200 || response.statusCode == 201) &&
//           data["status"] == "success") {
//         return true;
//       } else {
//         return false;
//         throw Exception(data["message"] ?? "Register failed");
//       }
//     } catch (e) {
//       print("Register error: $e");
//       return false;
//     }
//   }
//
//   // ✅ Login Admin
//   Future<String?> login(String email, String password) async {
//     final url = Uri.parse("${Utils.baseUrl}/Adminauth/login");
//
//     try {
//       final response = await http.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"email": email, "password": password}),
//       );
//
//       print("Login response: ${response.statusCode} - ${response.body}");
//
//       final data = jsonDecode(response.body);
//
//       if ((response.statusCode == 200 || response.statusCode == 201) &&
//           data["status"] == "success") {
//         return data["access_token"];
//       } else {
//         throw Exception(data["message"] ?? "Login failed");
//       }
//     } catch (e) {
//       print("Login error: $e");
//       return null;
//     }
//   }
//
//   /// ✅ Update admin
//   static Future<bool> updateAdmin(
//     int id, {
//     String? name,
//     String? email,
//     String? password,
//   }) async {
//     final url = Uri.parse("${Utils.baseUrl}/Adminauth/$id");
//
//     final Map<String, dynamic> body = {};
//     if (name != null) body['name'] = name;
//     if (email != null) body['email'] = email;
//     if (password != null) body['password'] = password;
//
//     if (body.isEmpty) return false;
//
//     try {
//       final response = await http.put(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(body),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return data['status'] == 'success';
//       } else {
//         print("❌ Failed to update admin: ${response.body}");
//         return false;
//       }
//     } catch (e) {
//       print("❌ Error updating admin: $e");
//       return false;
//     }
//   }
//
//   /// ✅ Delete admin
//   static Future<bool> deleteAdmin(int id) async {
//     final url = Uri.parse("${Utils.baseUrl}/Adminauth/$id");
//
//     try {
//       final response = await http.delete(
//         url,
//         headers: {"Content-Type": "application/json"},
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return data['status'] == 'success';
//       } else {
//         print("❌ Failed to delete admin: ${response.body}");
//         return false;
//       }
//     } catch (e) {
//       print("❌ Error deleting admin: $e");
//       return false;
//     }
//   }
// }

import 'dart:convert';
import 'package:ramchin_technologies_pvt_ltd/utils/utils.dart';
import 'package:http/http.dart' as http;

/// ✅ Admin Model
class Admin {
  final int id;
  final String name;
  final String email;

  Admin({required this.id, required this.name, required this.email});

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(id: json['id'], name: json['name'], email: json['email']);
  }
}

/// ✅ Service to fetch admins (GET)
class AdminService {
  static Future<List<Admin>> getAllAdmins() async {
    try {
      final response = await http.get(
        Uri.parse("${Utils.baseUrl}/Adminauth/all"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Admin.fromJson(json)).toList();
      } else {
        print("❌ Failed to fetch admins: ${response.body}");
        return [];
      }
    } catch (e) {
      print("❌ Error fetching admins: $e");
      return [];
    }
  }

  /// ✅ Update admin (PUT)
  static Future<bool> updateAdmin(
    int id, {
    String? name,
    String? email,
    String? password,
  }) async {
    final url = Uri.parse("${Utils.baseUrl}/Adminauth/$id");

    final Map<String, dynamic> body = {};
    if (name != null) body['name'] = name;
    if (email != null) body['email'] = email;
    if (password != null) body['password'] = password;

    if (body.isEmpty) return false;

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status'] == 'success';
      } else {
        print("❌ Failed to update admin: ${response.body}");
        return false;
      }
    } catch (e) {
      print("❌ Error updating admin: $e");
      return false;
    }
  }

  /// ✅ Delete admin (DELETE)
  static Future<bool> deleteAdmin(int id) async {
    final url = Uri.parse("${Utils.baseUrl}/Adminauth/$id");

    try {
      final response = await http.delete(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status'] == 'success';
      } else {
        print("❌ Failed to delete admin: ${response.body}");
        return false;
      }
    } catch (e) {
      print("❌ Error deleting admin: $e");
      return false;
    }
  }
}

/// ✅ Admin Auth Service for login/register
class AdminAuthService {
  Future<bool> register(String name, String email, String password) async {
    final url = Uri.parse("${Utils.baseUrl}/Adminauth/register");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name, "email": email, "password": password}),
      );

      final data = jsonDecode(response.body);
      return (response.statusCode == 200 || response.statusCode == 201) &&
          data["status"] == "success";
    } catch (e) {
      print("❌ Register error: $e");
      return false;
    }
  }

  Future<String?> login(String email, String password) async {
    final url = Uri.parse("${Utils.baseUrl}/Adminauth/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      final data = jsonDecode(response.body);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          data["status"] == "success") {
        return data["access_token"];
      } else {
        print("❌ Login failed: ${data['message']}");
        return null;
      }
    } catch (e) {
      print("❌ Login error: $e");
      return null;
    }
  }
}
