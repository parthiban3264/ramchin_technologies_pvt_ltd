import 'dart:convert';
import 'dart:typed_data';
import 'dart:io' show File;
import 'package:http/http.dart' as http;

import '../utils/utils.dart';

class GalleryService {
  /// ✅ CREATE (Upload image with description)
  Future<bool> addImage({
    required String description,
    File? imageFile,
    Uint8List? imageBytes,
  }) async {
    try {
      // Convert to Base64
      String? imageBase64;
      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();
        imageBase64 = base64Encode(bytes);
      } else if (imageBytes != null) {
        imageBase64 = base64Encode(imageBytes);
      }

      if (imageBase64 == null) throw Exception("No image selected");

      final response = await http.post(
        Uri.parse("${Utils.baseUrl}/gallery/upload"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"image": imageBase64, "description": description}),
      );

      print("📤 Upload Response: ${response.statusCode} -> ${response.body}");

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("❌ Error uploading image: $e");
      return false;
    }
  }

  /// ✅ READ (Get all images)
  Future<List<dynamic>> getAllImages() async {
    try {
      final response = await http.get(
        Uri.parse("${Utils.baseUrl}/gallery/download"),
        headers: {"Content-Type": "application/json"},
      );

      print("📥 Fetch Response: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) return data;
      }
      return [];
    } catch (e) {
      print("❌ Error fetching images: $e");
      return [];
    }
  }

  /// ✅ UPDATE (Update description or image)
  /// ✅ UPDATE (Update description or imag, String updatede)
  Future<bool> updateImage(
    int id, {
    String? description,
    File? imageFile,
    Uint8List? imageBytes,
  }) async {
    try {
      // Convert image if provided
      String? imageBase64;
      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();
        imageBase64 = base64Encode(bytes);
      } else if (imageBytes != null) {
        imageBase64 = base64Encode(imageBytes);
      }

      // Build request body
      final Map<String, dynamic> body = {};
      if (description != null) body["description"] = description;
      if (imageBase64 != null) body["image"] = imageBase64; // ✅ FIXED

      if (body.isEmpty) throw Exception("Nothing to update");

      final response = await http.put(
        Uri.parse("${Utils.baseUrl}/gallery/$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("❌ Error updating image: $e");
      return false;
    }
  }

  /// ✅ DELETE (Remove image by ID)
  Future<bool> deleteImage(int id) async {
    try {
      final response = await http.delete(
        Uri.parse("${Utils.baseUrl}/gallery/$id"),
        headers: {"Content-Type": "application/json"},
      );

      print("🗑️ Delete Response: ${response.statusCode} -> ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("❌ Error deleting image: $e");
      return false;
    }
  }
}
