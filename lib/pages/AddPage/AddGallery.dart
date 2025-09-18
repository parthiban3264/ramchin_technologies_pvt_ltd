import 'dart:convert';
import 'dart:io' show File;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/gallery_service.dart';
import 'package:another_flushbar/flushbar.dart';

void showFlushBar(BuildContext context, String msg, {bool success = true}) {
  Flushbar(
    message: msg,
    maxWidth: 320,
    duration: const Duration(seconds: 4),
    backgroundColor: success ? Colors.green.shade600 : Colors.red.shade600,
    margin: const EdgeInsets.all(12),
    borderRadius: BorderRadius.circular(10),
    icon: Icon(success ? Icons.check_circle : Icons.error, color: Colors.white),
    flushbarPosition: FlushbarPosition.TOP,
  ).show(context);
}

class AddGalleryPage extends StatefulWidget {
  const AddGalleryPage({super.key});

  @override
  State<AddGalleryPage> createState() => _AddGalleryPageState();
}

class _AddGalleryPageState extends State<AddGalleryPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final picker = ImagePicker();

  Uint8List? _pickedImageBytes; // For Web
  File? _pickedImageFile; // For Mobile
  bool _isLoading = false;

  final GalleryService _galleryService = GalleryService();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 85, // reduce file size
    );

    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _pickedImageBytes = bytes;
          _pickedImageFile = null;
        });
      } else {
        setState(() {
          _pickedImageFile = File(pickedFile.path);
          _pickedImageBytes = null;
        });
      }
    }
  }

  Future<void> _uploadGallery() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate() ||
        (_pickedImageFile == null && _pickedImageBytes == null)) {
      showFlushBar(context, "Please add description & image", success: false);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final success = await _galleryService.addImage(
        description: _descriptionController.text.trim(),
        imageFile: _pickedImageFile,
        imageBytes: _pickedImageBytes,
      );

      if (success) {
        showFlushBar(context, "Gallery added successfully", success: true);
        _descriptionController.clear();
        setState(() {
          _pickedImageFile = null;
          _pickedImageBytes = null;
        });
      } else {
        throw Exception("Upload failed");
      }
    } catch (e) {
      showFlushBar(context, "Error: $e", success: false);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      // appBar: AppBar(
      //   title: const Text("Add Gallery", style: TextStyle(color: Colors.black)),
      //   backgroundColor: Colors.white70,
      //   elevation: 2,
      // ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 6,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Image Preview
                      Container(
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _pickedImageBytes != null
                              ? Image.memory(
                                  _pickedImageBytes!,
                                  fit: BoxFit.cover,
                                )
                              : _pickedImageFile != null
                              ? Image.file(_pickedImageFile!, fit: BoxFit.cover)
                              : const Center(
                                  child: Text(
                                    "No Image Selected",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Pick Image Button
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(
                          Icons.image_outlined,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Select Image",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.blueGrey.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Description
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          labelText: "Description",
                          hintText: "Enter a brief description",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                        validator: (val) => val == null || val.isEmpty
                            ? "Enter description"
                            : null,
                      ),
                      const SizedBox(height: 30),

                      // Upload Button
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _uploadGallery,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 3,
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Upload to Gallery",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GalleryTablePage extends StatefulWidget {
  const GalleryTablePage({super.key});

  @override
  State<GalleryTablePage> createState() => _GalleryTablePageState();
}

class _GalleryTablePageState extends State<GalleryTablePage> {
  final GalleryService _galleryService = GalleryService();
  List<Map<String, dynamic>> _images = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    setState(() => _loading = true);
    try {
      final images = await _galleryService.getAllImages();
      setState(() {
        _images = List<Map<String, dynamic>>.from(images);
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      showFlushBar(context, "Failed to fetch images: $e", success: false);
    }
  }

  Future<void> _deleteImage(int id) async {
    final success = await _galleryService.deleteImage(id);
    if (success) {
      setState(() {
        _images.removeWhere((img) => img['id'] == id);
      });
      showFlushBar(context, "Deleted", success: true);
    } else {
      showFlushBar(context, "Delete failed", success: false);
    }
  }

  Future<void> _updateDescription(int id, String oldDesc) async {
    final controller = TextEditingController(text: oldDesc);

    final updated = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Description"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "New Description",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text("Update"),
          ),
        ],
      ),
    );

    if (updated != null && updated.isNotEmpty) {
      final success = await _galleryService.updateImage(
        id,
        description: updated,
      );
      if (success) {
        setState(() {
          final index = _images.indexWhere((img) => img['id'] == id);
          if (index != -1) {
            _images[index]['description'] = updated;
          }
        });
        showFlushBar(context, "Updated", success: true);
      } else {
        showFlushBar(context, "Update failed", success: false);
      }
    }
  }

  Widget _buildImage(String base64Str) {
    try {
      Uint8List bytes = base64Decode(base64Str);
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(bytes, width: 150, height: 120, fit: BoxFit.cover),
      );
    } catch (e) {
      return const Icon(Icons.broken_image, size: 60, color: Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _images.isEmpty
          ? const Center(
              child: Text(
                "No images found",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : RefreshIndicator(
              onRefresh: _fetchImages,
              child: ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  final img = _images[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 6,
                    ),
                    elevation: 6,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 90, // ⬆️ Increased image size
                          height: 90,
                          child: _buildImage(img['image'] ?? ""),
                        ),
                      ),
                      title: Text(
                        img['description'] ?? "No description",
                        style: const TextStyle(
                          fontSize: 18, // ⬆️ Larger text
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blueAccent,
                              size: 30, // ⬆️ Bigger icon
                            ),
                            onPressed: () => _updateDescription(
                              img['id'],
                              img['description'] ?? "",
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                              size: 30, // ⬆️ Bigger icon
                            ),
                            onPressed: () => _deleteImage(img['id']),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
