import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/AdminAuth_service.dart';
import 'package:another_flushbar/flushbar.dart';

class AdminLoginPage extends StatefulWidget {
  static bool isLoggedIn = false;
  final void Function(int) onTabSelected;
  const AdminLoginPage({super.key, required this.onTabSelected});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AdminAuthService();
  bool _obscurePassword = true;
  bool _isLoading = false;

  void showFlushBar(BuildContext context, String msg, {bool success = true}) {
    Flushbar(
      message: msg,
      maxWidth: 230,
      duration: const Duration(seconds: 5),
      backgroundColor: success ? Colors.green : Colors.red,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      icon: Icon(
        success ? Icons.check_circle : Icons.error,
        color: Colors.white,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
    ).show(context);
  }

  // ✅ Handle login
  Future<void> _adminLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final token = await _authService.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (token != null) {
      // Save token locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("admin_token", token);

      if (mounted) {
        showFlushBar(context, "Login successful", success: true);
        setState(() => AdminLoginPage.isLoggedIn = true);

        // ✅ Direct go to AddDataPageStack (index = 10)
        widget.onTabSelected(10);
      }

      print("JWT Token: $token");
    } else {
      if (mounted) {
        showFlushBar(context, "Failed to Login", success: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth < 600 ? screenWidth * 0.9 : 400.0;

    return SingleChildScrollView(
      child: Container(
        height: 500,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFACE0F9), Color(0xFFBFFCC6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                width: cardWidth,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.admin_panel_settings,
                        size: 60,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Admin Login",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // ✅ Email field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          hintText: "Email",
                          hintStyle: const TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          if (!value.contains("@")) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // ✅ Password field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          hintText: "Password",
                          hintStyle: const TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // ✅ Login button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _adminLogin,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.2,
                            ),
                            elevation: 6,
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
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
        ),
      ),
    );
  }
}

class AdminRegisterPage extends StatefulWidget {
  const AdminRegisterPage({super.key});

  @override
  State<AdminRegisterPage> createState() => _AdminRegisterPageState();
}

class _AdminRegisterPageState extends State<AdminRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AdminAuthService();

  bool _obscurePassword = true;
  bool _isLoading = false;

  void showFlushBar(BuildContext context, String msg, {bool success = true}) {
    Flushbar(
      message: msg,
      maxWidth: 300,
      duration: const Duration(seconds: 4),
      backgroundColor: success ? Colors.green : Colors.red,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(12),
      icon: Icon(
        success ? Icons.check_circle : Icons.error,
        color: Colors.white,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
    ).show(context);
  }

  // ✅ Handle register
  Future<void> _adminRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final success = await _authService.register(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (success) {
      if (mounted) {
        showFlushBar(context, "Registration successful", success: true);
        // Navigator.pop(context); // go back to login if needed
      }
    } else {
      if (mounted) {
        showFlushBar(context, "Failed to Register", success: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth < 600 ? screenWidth * 0.9 : 400.0;
    // final screenWidth = MediaQuery.of(context).size.width;
    // final isMobile = screenWidth < 600;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3EADCF), Color(0xFFABE9CD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  width: cardWidth,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.admin_panel_settings,
                          size: 65,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Admin Register",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // ✅ Name
                        _buildTextField(
                          controller: _nameController,
                          hint: "Name",
                          icon: Icons.person,
                          validator: (v) =>
                              v == null || v.isEmpty ? "Enter your name" : null,
                        ),
                        const SizedBox(height: 16),

                        // ✅ Email
                        _buildTextField(
                          controller: _emailController,
                          hint: "Email",
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.isEmpty) return "Enter email";
                            if (!v.contains("@")) return "Enter valid email";
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // ✅ Password
                        _buildTextField(
                          controller: _passwordController,
                          hint: "Password",
                          icon: Icons.lock,
                          obscure: _obscurePassword,
                          suffix: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "Enter password";
                            }
                            if (v.length < 6) {
                              return "At least 6 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 28),

                        // ✅ Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _adminRegister,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              backgroundColor: Colors.white.withOpacity(0.25),
                              elevation: 6,
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    "Register",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
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
          ),
        ),
      ),
    );
  }

  // ✅ Custom TextField builder
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffix,
      ),
    );
  }
}

class AdminTable extends StatefulWidget {
  const AdminTable({super.key});

  @override
  State<AdminTable> createState() => _AdminTableState();
}

class _AdminTableState extends State<AdminTable> {
  List<Admin> admins = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAdmins();
  }

  Future<void> _fetchAdmins() async {
    setState(() => _isLoading = true);
    final data = await AdminService.getAllAdmins();
    setState(() {
      admins = data;
      _isLoading = false;
    });
  }

  /// ✅ Delete admin
  void _deleteAdmin(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this admin?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final success = await AdminService.deleteAdmin(id);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Admin deleted successfully")),
        );
        _fetchAdmins();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Failed to delete admin")));
      }
    }
  }

  /// ✅ Update admin
  void _editAdmin(Admin admin) {
    final nameController = TextEditingController(text: admin.name);
    final emailController = TextEditingController(text: admin.email);
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Update Admin"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: "Password (leave blank to keep)",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final success = await AdminService.updateAdmin(
                admin.id,
                name: nameController.text,
                email: emailController.text,
                password: passwordController.text.isEmpty
                    ? null
                    : passwordController.text,
              );

              Navigator.pop(context);

              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Admin updated successfully")),
                );
                _fetchAdmins();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Failed to update admin")),
                );
              }
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    return Column(
      children: [
        // Table Heading
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Colors.blueGrey.shade50,
          child: Row(
            children: const [
              Expanded(
                flex: 1,
                child: Text(
                  "ID",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "Actions",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Table Rows
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            itemCount: admins.length,
            itemBuilder: (context, index) {
              final admin = admins[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Text(admin.id.toString())),
                      Expanded(flex: 3, child: Text(admin.name)),
                      Expanded(flex: 4, child: Text(admin.email)),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () => _editAdmin(admin),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                              onPressed: () => _deleteAdmin(admin.id),
                            ),
                          ],
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
    );
  }
}
