import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/utils.dart';

class TeamProfileService {
  /// Get all team profiles
  Future<List<dynamic>> getAll() async {
    final response = await http.get(Uri.parse(Utils.baseUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load team profiles');
    }
  }

  /// Create profile
  Future<dynamic> create(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(Utils.baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create profile: ${response.body}');
    }
  }

  /// Update by id
  Future<dynamic> update(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('${Utils.baseUrl}/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update profile');
    }
  }

  /// Delete by id
  Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse('${Utils.baseUrl}/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete profile');
    }
  }
}
