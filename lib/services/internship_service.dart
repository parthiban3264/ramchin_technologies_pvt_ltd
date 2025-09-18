// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// //
// // class InternshipService {
// //   static const String baseUrl =
// //       "https://rdt3tvjb-3000.inc1.devtunnels.ms/internship";
// //
// //   /// ✅ Add (Create) internship
// //   static Future<bool> addInternship({
// //     required String name,
// //     required String image,
// //     List<String>? projects,
// //     List<String>? links,
// //   }) async {
// //     try {
// //       final body = {
// //         "name": name,
// //         "image": image,
// //         "projects": projects ?? [],
// //         "links": links ?? [],
// //       };
// //
// //       final response = await http.post(
// //         Uri.parse('$baseUrl/create'),
// //         headers: {"Content-Type": "application/json"},
// //         body: jsonEncode(body),
// //       );
// //
// //       print("📤 Add Response: ${response.statusCode} -> ${response.body}");
// //
// //       return response.statusCode == 200 || response.statusCode == 201;
// //     } catch (e) {
// //       print("❌ Error adding internship: $e");
// //       return false;
// //     }
// //   }
// //
// //   /// ✅ Get all internships
// //   static Future<List<dynamic>> getAll() async {
// //     try {
// //       final response = await http.get(
// //         Uri.parse("$baseUrl/getAll"),
// //         headers: {"Content-Type": "application/json"},
// //       );
// //
// //       print("📥 Fetch Response: ${response.statusCode}");
// //
// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         if (data is List) return data;
// //       }
// //       return [];
// //     } catch (e) {
// //       print("❌ Error fetching internships: $e");
// //       return [];
// //     }
// //   }
// //
// //   /// ✅ Update internship
// //   static Future<bool> updateInternship(
// //     int id, {
// //     String? name,
// //     String? image,
// //     List<String>? projects,
// //     List<String>? links,
// //   }) async {
// //     try {
// //       final Map<String, dynamic> body = {};
// //       if (name != null) body["name"] = name;
// //       if (image != null) body["image"] = image;
// //       if (projects != null) body["projects"] = projects;
// //       if (links != null) body["links"] = links;
// //
// //       if (body.isEmpty) throw Exception("Nothing to update");
// //
// //       final response = await http.put(
// //         Uri.parse("$baseUrl/$id"),
// //         headers: {"Content-Type": "application/json"},
// //         body: jsonEncode(body),
// //       );
// //
// //       print("✏️ Update Response: ${response.statusCode} -> ${response.body}");
// //
// //       return response.statusCode == 200;
// //     } catch (e) {
// //       print("❌ Error updating internship: $e");
// //       return false;
// //     }
// //   }
// //
// //   /// ✅ Delete internship
// //   static Future<bool> deleteInternship(int id) async {
// //     try {
// //       final response = await http.delete(
// //         Uri.parse("$baseUrl/$id"),
// //         headers: {"Content-Type": "application/json"},
// //       );
// //
// //       print("🗑️ Delete Response: ${response.statusCode} -> ${response.body}");
// //
// //       return response.statusCode == 200;
// //     } catch (e) {
// //       print("❌ Error deleting internship: $e");
// //       return false;
// //     }
// //   }
// // }
//
// import 'dart:io';
// import 'package:dio/dio.dart';
//
// class InternshipService {
//   final String baseUrl =
//       "https://rdt3tvjb-3000.inc1.devtunnels.ms/internship"; // replace with your backend URL
//   final Dio _dio = Dio();
//
//   // ✅ Create internship (with optional image file)
//   Future<Map<String, dynamic>> create({
//     required String name,
//     File? imageFile,
//     List<String>? projects,
//     List<String>? links,
//   }) async {
//     try {
//       FormData formData = FormData.fromMap({
//         'name': name,
//         'projects': projects ?? [],
//         'links': links ?? [],
//         if (imageFile != null)
//           'image': await MultipartFile.fromFile(
//             imageFile.path,
//             filename: imageFile.path.split('/').last,
//           ),
//       });
//
//       final response = await _dio.post('$baseUrl/create', data: formData);
//       return response.data;
//     } catch (e) {
//       print("Error creating internship: $e");
//       rethrow;
//     }
//   }
//
//   // ✅ Get all internships
//   Future<List<dynamic>> getAll() async {
//     try {
//       final response = await _dio.get('$baseUrl/getAll');
//       return response.data;
//     } catch (e) {
//       print("Error fetching internships: $e");
//       return [];
//     }
//   }
//
//   // ✅ Update internship (optionally with new image)
//   Future<Map<String, dynamic>> update({
//     required int id,
//     required String name,
//     File? imageFile,
//     List<String>? projects,
//     List<String>? links,
//   }) async {
//     try {
//       FormData formData = FormData.fromMap({
//         'name': name,
//         'projects': projects ?? [],
//         'links': links ?? [],
//         if (imageFile != null)
//           'image': await MultipartFile.fromFile(
//             imageFile.path,
//             filename: imageFile.path.split('/').last,
//           ),
//       });
//
//       final response = await _dio.put('$baseUrl/$id', data: formData);
//       return response.data;
//     } catch (e) {
//       print("Error updating internship: $e");
//       rethrow;
//     }
//   }
//
//   // ✅ Delete internship
//   Future<bool> delete(int id) async {
//     try {
//       final response = await _dio.delete('$baseUrl/$id');
//       return response.statusCode == 200;
//     } catch (e) {
//       print("Error deleting internship: $e");
//       return false;
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

import '../utils/utils.dart';

class InternshipService {
  /// ✅ Create Internship with optional image
  Future<Map<String, dynamic>> createInternship({
    required String name,
    List<String>? projects,
    List<String>? links,
    Uint8List? imageBytes, // 👈 bytes instead of File
    String? filename = 'image.jpg', // 👈 required if uploading
  }) async {
    final uri = Uri.parse('${Utils.baseUrl}/internship/create');
    final request = http.MultipartRequest('POST', uri);

    // 🔹 Required text field
    request.fields['name'] = name;

    if (projects != null && projects.isNotEmpty) {
      request.fields['projects'] = projects.join(','); // ✅ "hotel,hotel1"
    }
    if (links != null && links.isNotEmpty) {
      request.fields['links'] = links.join(','); // ✅ "link1,link2"
    }

    // 🔹 Optional image upload
    if (imageBytes != null && filename != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'image', // must match @UseInterceptors(FileInterceptor('image'))
          imageBytes,
          filename: filename,
        ),
      );
    }

    // 🔹 Send request
    final response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(body) as Map<String, dynamic>;
    } else {
      throw Exception(
        'Failed to create internship. Status: ${response.statusCode}, Body: $body',
      );
    }
  }

  /// ✅ Get all internships
  Future<List<dynamic>> getAllInternships() async {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/internship/getAll'),
    );
    print('get body');
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load internships");
    }
  }

  // /// ✅ Update internship (without file upload for web)
  // Future<Map<String, dynamic>> updateInternship(
  //   int id,
  //   Map<String, dynamic> data,
  // ) async {
  //   final response = await http.put(
  //     Uri.parse("${Utils.baseUrl}/internship/$id"),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode(data),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception("Failed to update internship");
  //   }
  // }

  Future<Map<String, dynamic>> updateInternship(
    String id,
    Map<String, dynamic> data, {
    Uint8List? imageBytes,
    String? filename = 'image.jpg',
  }) async {
    final uri = Uri.parse('${Utils.baseUrl}/internship/update/$id');
    final request = http.MultipartRequest('PUT', uri);

    // 🔹 Add fields
    request.fields['name'] = data['name'];

    // 🔹 Handle projects
    if (data['projects'] != null) {
      if (data['projects'] is List<String>) {
        request.fields['projects'] = data['projects'].join(',');
      } else {
        request.fields['projects'] = data['projects'].toString();
      }
    }

    // 🔹 Handle links
    if (data['links'] != null) {
      if (data['links'] is List<String>) {
        request.fields['links'] = data['links'].join(',');
      } else {
        request.fields['links'] = data['links'].toString();
      }
    }

    // 🔹 Handle image
    if (imageBytes != null) {
      request.files.add(
        http.MultipartFile.fromBytes('image', imageBytes, filename: filename),
      );
    }

    final response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return jsonDecode(body);
    } else {
      throw Exception(
        "Failed to update internship: ${response.statusCode}, $body",
      );
    }
  }

  /// ✅ Delete internship
  Future<void> deleteInternship(int id) async {
    final response = await http.delete(
      Uri.parse("${Utils.baseUrl}/internship/$id"),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to delete internship");
    }
  }
}
