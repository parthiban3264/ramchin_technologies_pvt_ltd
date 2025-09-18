// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class TeamProfileService {
//   // Replace with your backend URL
//   final String baseUrl = 'http://localhost:3000/teamprofile';
//
//   /// Get all team profiles
//   Future<List<TeamProfile>> getAll() async {
//     final response = await http.get(Uri.parse(baseUrl));
//     if (response.statusCode == 200) {
//       final List data = jsonDecode(response.body);
//       return data.map((json) => TeamProfile.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load team profiles');
//     }
//   }
//
//   /// Create a new team profile
//   Future<TeamProfile> create(TeamProfile profile) async {
//     final response = await http.post(
//       Uri.parse(baseUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(profile.toJson()),
//     );
//
//     if (response.statusCode == 201 || response.statusCode == 200) {
//       return TeamProfile.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to create team profile');
//     }
//   }
//
//   /// Update existing team profile by ID
//   Future<TeamProfile> update(int id, TeamProfile profile) async {
//     final response = await http.put(
//       Uri.parse('$baseUrl/$id'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(profile.toJson()),
//     );
//
//     if (response.statusCode == 200) {
//       return TeamProfile.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to update team profile');
//     }
//   }
//
//   /// Delete team profile by ID
//   Future<void> delete(int id) async {
//     final response = await http.delete(Uri.parse('$baseUrl/$id'));
//
//     if (response.statusCode != 200) {
//       throw Exception('Failed to delete team profile');
//     }
//   }
// }
