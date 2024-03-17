import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  SignupPage({super.key});

void registerUser(BuildContext context) async {
  try {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Passwords do not match.')));
      return; // Exit the function if passwords don't match
    }
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    // Registration successful, navigate back to the login page
    Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Password is too weak.')));
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Email already in use.')));
    } else {
      String errorMessage = 'Registration failed: ${e.message}';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  } catch (e) {
    // Handle other unexpected errors
    print('Error during registration: $e');
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('An unexpected error occurred.')));
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/my_icon.png', width: 500, height: 200),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Име', // Name
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Пасворд', // Password
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Потврди пасворда', // Confirm Password
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                registerUser(context);
              },
              child: const Text('Sign Up'),
            ),
            TextButton(
              onPressed: () {
                // Navigate back to the login page
                Navigator.pop(context);
              },
              child: const Text('Already have an account? Log In'),
            ),
          ],
        ),
      ),
    );
  }
}
