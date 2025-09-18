import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/utils.dart';

class ContactService {
  /// ✅ Send a new contact message
  Future<bool> sendMessage(String name, String email, String message) async {
    final url = Uri.parse("${Utils.baseUrl}/contact/create");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name, "email": email, "message": message}),
      );

      print("Send Message Response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data["status"] == "Message sent successfully";
      }
      return false;
    } catch (e) {
      print("Error sending message: $e");
      return false;
    }
  }

  /// ✅ Delete a contact by ID
  Future<bool> deleteContact(int id) async {
    final url = Uri.parse("${Utils.baseUrl}/contact/$id");

    try {
      final response = await http.delete(
        url,
        headers: {"Content-Type": "application/json"},
      );

      print(
        "Delete Contact Response: ${response.statusCode} - ${response.body}",
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status'] == 'success';
      }
      return false;
    } catch (e) {
      print("Error deleting contact: $e");
      return false;
    }
  }

  /// ✅ Fetch all contacts
  Future<List<Contact>> getAllContacts() async {
    final url = Uri.parse("${Utils.baseUrl}/contact/all");

    try {
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      print("Get All Contacts Response: ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Contact.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print("Error fetching contacts: $e");
      return [];
    }
  }
}

class Contact {
  final int id;
  final String name;
  final String email;
  final String message;
  final DateTime createdAt; // <-- Use DateTime instead of String

  Contact({
    required this.id,
    required this.name,
    required this.email,
    required this.message,
    required this.createdAt,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      message: json['message'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(), // fallback if null
    );
  }
  @override
  String toString() {
    return 'Contact{name: $name, email: $email, message: $message, createdAt: $createdAt}';
  }
}
