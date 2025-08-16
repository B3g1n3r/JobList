import 'package:flutter/material.dart';
import 'package:job_management_app/screens/landingpage.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController(text: 'john');
  final _passwordController = TextEditingController(text: '1234');
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _Login(AuthViewModel authVM) async {
    if (_formKey.currentState?.validate() != true) return;

    final success = await authVM.login(
      _usernameController.text.trim(),
      _passwordController.text.trim(),
    );

    if (success) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LandingPage(
            userId: authVM.userId!,
            token: authVM.token!,
          ),
        ),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authVM.error ?? "Login failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FB),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Welcome and logo
              const Icon(Icons.lock_outline, color: Color(0xFF7C4DFF), size: 64),
              const SizedBox(height: 18),
              Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Sign in to continue",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),
              // Login form
              Card(
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: "Username",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF7C4DFF)),
                          ),
                          validator: (value) =>
                              (value == null || value.isEmpty) ? 'Please enter username' : null,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF7C4DFF)),
                          ),
                          obscureText: true,
                          validator: (value) =>
                              (value == null || value.isEmpty) ? 'Please enter password' : null,
                          onFieldSubmitted: (_) => _Login(authVM),
                        ),
                        const SizedBox(height: 24),
                        if (authVM.error != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              authVM.error!,
                              style: const TextStyle(color: Colors.red, fontSize: 15),
                            ),
                          ),
                        authVM.isLoading
                            ? const CircularProgressIndicator()
                            : SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF7C4DFF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () => _Login(authVM),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ),
                              ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Forgot password?", style: TextStyle(fontSize: 13)),
                            TextButton(
                              onPressed: () {
                              },
                              child: const Text("Reset", style: TextStyle(color: Color(0xFF7C4DFF))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?", style: TextStyle(fontSize: 15)),
                  TextButton(
                    onPressed: () {
                     
                    },
                    child: const Text("Sign Up", style: TextStyle(color: Color(0xFF7C4DFF))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
