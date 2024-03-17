import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  void loginUser(BuildContext context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    // Navigate to the home page after successful login
    Navigator.pushReplacementNamed(context, '/home');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('User not found.')));
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Wrong password.')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login failed: ${e.message}')));  // Remove `const` here
    }
  } catch (e) {
    // Handle other unexpected errors
    print('Error during login: $e');
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('An unexpected error occurred.')));
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Remove the app bar
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20), // Added padding to the container
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/my_icon.png', width: 500, height: 300),
                const SizedBox(height: 20),
                const Text(
                  'Добредојдовте Назад!', // Your desired text
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold, // Make the text bold
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Use Credentials to access your account', // Your desired text
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Added border radius
                      borderSide:
                          const BorderSide(width: 1), // Added border width
                    ),
                    prefixIcon: const Icon(Icons.person), // Added material icon
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Added border radius
                      borderSide:
                          const BorderSide(width: 1), // Added border width
                    ),
                    prefixIcon: const Icon(Icons.lock), // Added material icon
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    loginUser(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFF808080), // Set the background color
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(
                          double.infinity, 50), // Set full width and 50 height
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white, // Set text color to white
                    ),
                  ),
                  child: const Text('Најава', style: TextStyle(fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to the registration page
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text('Немате акаунт? Регистрација'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
