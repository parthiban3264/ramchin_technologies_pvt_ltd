import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
import '../../services/internship_service.dart';

class AddInternshipPage extends StatefulWidget {
  const AddInternshipPage({super.key});

  @override
  State<AddInternshipPage> createState() => _AddInternshipPageState();
}

class _AddInternshipPageState extends State<AddInternshipPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final List<TextEditingController> _projectControllers = [];
  final List<TextEditingController> _linkControllers = [];

  bool _isLoading = false;
  Uint8List? _imageBytes;
  File? _imageFile; // only for mobile

  final ImagePicker _picker = ImagePicker();

  void showFlushBar(BuildContext context, String msg, {bool success = true}) {
    Flushbar(
      message: msg,
      maxWidth: 350,
      duration: const Duration(seconds: 4),
      backgroundColor: success ? Colors.green : Colors.red,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(12),
      icon: Icon(
        success ? Icons.check_circle : Icons.error,
        color: Colors.white,
      ),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  void _addProjectField() {
    setState(() => _projectControllers.add(TextEditingController()));
  }

  void _addLinkField() {
    setState(() => _linkControllers.add(TextEditingController()));
  }

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      if (kIsWeb) {
        final bytes = await picked.readAsBytes();
        final file = File(picked.path);
        setState(() {
          _imageBytes = bytes;
          _imageFile = file;
        });
      } else {
        final file = File(picked.path);
        final bytes = await file.readAsBytes();
        setState(() {
          _imageFile = file;
          _imageBytes = bytes;
        });
      }
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_imageBytes == null) {
      showFlushBar(context, "Please pick an image", success: false);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Convert projects and links to comma-separated strings
      final projectsList = _projectControllers
          .map((c) => c.text.trim())
          .where((p) => p.isNotEmpty)
          .toList();

      final linksList = _linkControllers
          .map((c) => c.text.trim())
          .where((l) => l.isNotEmpty)
          .toList();

      final response = await InternshipService().createInternship(
        name: _nameController.text.trim(),
        imageBytes: _imageBytes,
        projects: projectsList, // List<String>
        links: linksList, // List<String>
      );

      if (!mounted) return;

      if (response['id'] != null) {
        showFlushBar(context, "Internship added successfully", success: true);

        // Clear form
        _nameController.clear();
        _projectControllers.clear();
        _linkControllers.clear();
        _imageBytes = null;
        _imageFile = null;
        setState(() {}); // Refresh UI
      } else {
        showFlushBar(context, "Failed to add internship", success: false);
      }
    } catch (e) {
      showFlushBar(context, "Error: $e", success: false);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // @override
  // void dispose() {
  //   _nameController.dispose();
  //   for (var c in _projectControllers) c.dispose();
  //   for (var c in _linkControllers) c.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Name
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? "Enter a name" : null,
                  ),
                  const SizedBox(height: 16),

                  /// Image Picker
                  Row(
                    children: [
                      _imageBytes != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                _imageBytes!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.image, size: 40),
                            ),
                      const SizedBox(width: 5),
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.upload_file),
                        label: const Text("Pick Image"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  /// Projects Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Projects",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.blueAccent,
                        ),
                        onPressed: _addProjectField,
                      ),
                    ],
                  ),
                  Column(
                    children: _projectControllers
                        .asMap()
                        .entries
                        .map(
                          (entry) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              controller: entry.value,
                              decoration: InputDecoration(
                                labelText: "Project ${entry.key + 1}",
                                prefixIcon: const Icon(Icons.work_outline),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),

                  /// Links Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Links",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.blueAccent,
                        ),
                        onPressed: _addLinkField,
                      ),
                    ],
                  ),
                  Column(
                    children: _linkControllers
                        .asMap()
                        .entries
                        .map(
                          (entry) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              controller: entry.value,
                              decoration: InputDecoration(
                                labelText: "Link ${entry.key + 1}",
                                prefixIcon: const Icon(Icons.link),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 30),

                  /// Submit
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(Icons.save, color: Colors.white),
                            label: const Text(
                              "Save Internship",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} //InternshipTable

class InternshipTable extends StatefulWidget {
  const InternshipTable({super.key});

  @override
  State<InternshipTable> createState() => _InternshipTableState();
}

class _InternshipTableState extends State<InternshipTable> {
  List<dynamic> internships = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchInternships();
  }

  Future<void> _fetchInternships() async {
    setState(() => _isLoading = true);
    final data = await InternshipService().getAllInternships();
    setState(() {
      internships = data;
      _isLoading = false;
    });
  }

  Future<void> _deleteInternship(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Internship"),
        content: const Text("Are you sure you want to delete this internship?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await InternshipService().deleteInternship(id);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Deleted successfully")));
      _fetchInternships();
    }
  }

  // Future<void> _updateInternship(Map<String, dynamic> internship) async {
  //   final nameController = TextEditingController(
  //     text: internship['name'] ?? '',
  //   );
  //
  //   final projectControllers = <TextEditingController>[];
  //   final linkControllers = <TextEditingController>[];
  //
  //   // 🔹 Handle both String ("hotel,hotel1") and List
  //   final projects = internship['projects'] is String
  //       ? (internship['projects'] as String).split(',')
  //       : (internship['projects'] as List?) ?? [];
  //
  //   final links = internship['links'] is String
  //       ? (internship['links'] as String).split(',')
  //       : (internship['links'] as List?) ?? [];
  //
  //   for (var p in projects) {
  //     projectControllers.add(TextEditingController(text: p.toString().trim()));
  //   }
  //   for (var l in links) {
  //     linkControllers.add(TextEditingController(text: l.toString().trim()));
  //   }
  //
  //   Uint8List? selectedImageBytes;
  //
  //   final updated = await showDialog<bool>(
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) => AlertDialog(
  //           title: const Text("Update Internship"),
  //           content: SingleChildScrollView(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 TextField(
  //                   controller: nameController,
  //                   decoration: const InputDecoration(labelText: "Name"),
  //                 ),
  //                 const SizedBox(height: 15),
  //                 Row(
  //                   children: [
  //                     if (selectedImageBytes != null)
  //                       Image.memory(
  //                         selectedImageBytes!,
  //                         width: 60,
  //                         height: 60,
  //                         fit: BoxFit.cover,
  //                       )
  //                     else if (internship['image'] != null &&
  //                         internship['image'].toString().isNotEmpty)
  //                       Image.network(
  //                         internship['image'],
  //                         width: 60,
  //                         height: 60,
  //                         fit: BoxFit.cover,
  //                       )
  //                     else
  //                       const Icon(Icons.image_not_supported, size: 40),
  //                     const SizedBox(width: 10),
  //                     ElevatedButton(
  //                       onPressed: () async {
  //                         final picker = ImagePicker();
  //                         final file = await picker.pickImage(
  //                           source: ImageSource.gallery,
  //                         );
  //                         if (file != null) {
  //                           final bytes = await file.readAsBytes();
  //                           setState(() => selectedImageBytes = bytes);
  //                         }
  //                       },
  //                       child: const Text("Pick Image"),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 15),
  //                 const Text("Projects"),
  //                 ...projectControllers.asMap().entries.map(
  //                   (e) => Padding(
  //                     padding: const EdgeInsets.only(bottom: 8),
  //                     child: TextField(
  //                       controller: e.value,
  //                       decoration: InputDecoration(
  //                         labelText: "Project ${e.key + 1}",
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 15),
  //                 const Text("Links"),
  //                 ...linkControllers.asMap().entries.map(
  //                   (e) => Padding(
  //                     padding: const EdgeInsets.only(bottom: 8),
  //                     child: TextField(
  //                       controller: e.value,
  //                       decoration: InputDecoration(
  //                         labelText: "Link ${e.key + 1}",
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.pop(context, false),
  //               child: const Text("Cancel"),
  //             ),
  //             ElevatedButton(
  //               onPressed: () => Navigator.pop(context, true),
  //               child: const Text("Update"),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  //
  //   if (updated == true) {
  //     final payload = {
  //       "name": nameController.text.trim(),
  //       "projects": projectControllers
  //           .map((c) => c.text.trim())
  //           .where((p) => p.isNotEmpty)
  //           .toList(),
  //       "links": linkControllers
  //           .map((c) => c.text.trim())
  //           .where((l) => l.isNotEmpty)
  //           .toList(),
  //     };
  //
  //     await InternshipService().updateInternship(
  //       internship['id'],
  //       payload,
  //       imageBytes: selectedImageBytes, // ✅ send new image if picked
  //     );
  //
  //     if (!mounted) return;
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text("Updated successfully")));
  //     _fetchInternships();
  //   }
  //
  //   // Dispose controllers
  //   nameController.dispose();
  //   for (var c in projectControllers) c.dispose();
  //   for (var c in linkControllers) c.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (internships.isEmpty) {
      return const Center(child: Text("No internships found"));
    }

    return ListView.builder(
      itemCount: internships.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final item = internships[index];
        final id = item['id'] ?? 0;
        final name = item['name'] ?? '';
        final image = item['image'] ?? '';
        final projects = item['projects'] ?? '';
        final links = item['links'] ?? '';

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (image.isNotEmpty)
                      Image.network(
                        image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      )
                    else
                      const Icon(Icons.image_not_supported, size: 60),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // IconButton(
                    //   icon: const Icon(Icons.edit, color: Colors.blue),
                    //   onPressed: () async {
                    //     await _updateInternship(item);
                    //   },
                    // ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteInternship(id),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text("Projects: $projects"),
                const SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    children: links.isNotEmpty
                        ? links.split(',').map<InlineSpan>((link) {
                            final trimmedLink = link.trim();
                            return WidgetSpan(
                              child: GestureDetector(
                                onTap: () async {
                                  final uri = Uri.parse(trimmedLink);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(
                                      uri,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Cannot open link: $trimmedLink",
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: Text(
                                    trimmedLink,
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList()
                        : [
                            const TextSpan(
                              text: "No links",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
