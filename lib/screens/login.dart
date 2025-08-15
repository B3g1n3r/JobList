import 'package:flutter/material.dart';
import 'package:job_management_app/screens/job_list.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class Login extends StatelessWidget {
  final _usernameController = TextEditingController(text: 'john');
  final _passwordController = TextEditingController(text: '1234');

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: "Username")),
            TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true),
            const SizedBox(height: 20),
            if (authVM.isLoading) const CircularProgressIndicator(),
            if (authVM.error != null)
              Text(authVM.error!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              child: const Text("Login"),
              onPressed: () async {
                final success = await authVM.login(
                  _usernameController.text,
                  _passwordController.text,
                );

                if (success) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => JobList(
                              userId: authVM.userId!,
                              token: authVM.token!,
                            )),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(authVM.error ?? "Login failed")),
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
