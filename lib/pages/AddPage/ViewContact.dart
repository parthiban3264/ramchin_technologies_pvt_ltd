import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/contact_service.dart';

class ContactTable extends StatefulWidget {
  const ContactTable({super.key});

  @override
  State<ContactTable> createState() => _ContactTableState();
}

class _ContactTableState extends State<ContactTable> {
  List<Contact> contacts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    setState(() => _isLoading = true);
    final data = await ContactService().getAllContacts();
    setState(() {
      contacts = data;
      _isLoading = false;
    });
  }

  Future<void> _deleteContact(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this contact?"),
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

    if (confirmed != true) return;

    final success = await ContactService().deleteContact(id);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Contact deleted successfully")),
      );
      _fetchContacts();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to delete contact")));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    String _formatDate(DateTime date) {
      final localDate = date.toLocal(); // 🔑 Convert from UTC to local
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final created = DateTime(localDate.year, localDate.month, localDate.day);

      if (created == today) {
        return "Today";
      } else {
        return DateFormat('dd-MM-yyyy hh:mm a').format(localDate);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Admins",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black26,
      ),
      body: Column(
        children: [
          // Table Heading
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: const [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    "Message",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "Date/Time",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Actions",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Table Rows (Card-style)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: Text(contact.name)),
                        Expanded(flex: 4, child: Text(contact.email)),
                        Expanded(
                          flex: 5,
                          child: Text(
                            contact.message,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            _formatDate(contact.createdAt),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => _deleteContact(contact.id),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
