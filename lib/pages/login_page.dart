import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isRegistering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isRegistering ? 'Register' : 'Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRegistering ? _register : _login,
              child: Text(_isRegistering ? 'Register' : 'Login'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isRegistering = !_isRegistering;
                });
              },
              child: Text(_isRegistering ? 'Already have an account? Login' : 'Don\'t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    final prefs = await SharedPreferences.getInstance();
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (prefs.getString('username') == username && prefs.getString('password') == password) {
      prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacementNamed(context, '/categories', arguments: username);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid credentials')));
    }
  }

  void _register() async {
    final prefs = await SharedPreferences.getInstance();
    final username = _usernameController.text;
    final password = _passwordController.text;

    prefs.setString('username', username);
    prefs.setString('password', password);
    prefs.setBool('isLoggedIn', true);
    Navigator.pushReplacementNamed(context, '/categories', arguments: username);
  }
}
