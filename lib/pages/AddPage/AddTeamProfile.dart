import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import '../../services/TeamProfile_service.dart';

class AddTeamProfilePage extends StatefulWidget {
  const AddTeamProfilePage({super.key});

  @override
  State<AddTeamProfilePage> createState() => _AddTeamProfilePageState();
}

class _AddTeamProfilePageState extends State<AddTeamProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TeamProfileService _service = TeamProfileService();

  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _bioController = TextEditingController();
  final _descController = TextEditingController();
  final _projectsController = TextEditingController();
  final _experienceController = TextEditingController();
  final _reviewsController = TextEditingController();

  String? _base64Image;
  Uint8List? _imageBytes;
  String? _resumeFileName;
  String? _resumeBase64;

  bool _loading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _base64Image = base64Encode(bytes);
      });
    }
  }

  Future<void> _pickResume() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _resumeFileName = result.files.single.name;
        _resumeBase64 = base64Encode(result.files.single.bytes!);
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      final data = {
        "name": _nameController.text.trim(),
        "role": _roleController.text.trim(),
        "image": _base64Image,
        "bio": _bioController.text.trim(),
        "description": _descController.text.trim(),
        "projects": _projectsController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        "experience": _experienceController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        "resume": _resumeBase64, // ✅ send file base64
        "reviews": _reviewsController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
      };

      await _service.create(data);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("🎉 Team profile added successfully!"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Add Team Profile"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _imageBytes != null
                          ? MemoryImage(_imageBytes!)
                          : null,
                      child: _imageBytes == null
                          ? const Icon(Icons.camera_alt, size: 40)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: _inputDecoration("Name"),
                    validator: (v) => v!.isEmpty ? "Enter name" : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _roleController,
                    decoration: _inputDecoration("Role"),
                    validator: (v) => v!.isEmpty ? "Enter role" : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _bioController,
                    decoration: _inputDecoration("Bio"),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descController,
                    decoration: _inputDecoration("Description"),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _projectsController,
                    decoration: _inputDecoration("Projects (comma separated)"),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _experienceController,
                    decoration: _inputDecoration(
                      "Experience (comma separated)",
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _resumeFileName ?? "No resume selected",
                          style: TextStyle(
                            color: _resumeFileName == null
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _pickResume,
                        icon: const Icon(Icons.upload_file),
                        label: const Text("Upload Resume"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _reviewsController,
                    decoration: _inputDecoration("Reviews (comma separated)"),
                  ),
                  const SizedBox(height: 20),
                  _loading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "💾 Save Profile",
                              style: TextStyle(fontSize: 16),
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
}
