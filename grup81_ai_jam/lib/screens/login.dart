import 'package:flutter/material.dart';
import 'package:grup81_ai_jam/constans/color.dart';
import 'package:grup81_ai_jam/screens/welcome.dart';
import 'package:grup81_ai_jam/service/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _firebaseService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      dynamic result = await _firebaseService.signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 400),
            content: Text(result == null
                ? "Login failed"
                : "Logged in as ${result.email}"),
          ),
        );
        if (result != null) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Welcome()));
        }
      }
    }
  }

  void logout() {
    _firebaseService.signOut();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Logged out"),
        duration: Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(backgroundColor),
        appBar: AppBar(
          toolbarHeight: 70.0,
          centerTitle: true,
          backgroundColor: HexColor(headerColor),
          title: const Text(
            "Login",
            style: TextStyle(
                fontFamily: "TextStyleFont", fontSize: 34, color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                    validator: (value) =>
                        value!.isEmpty ? "Enter an email" : null,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: "Password"),
                    obscureText: true,
                    validator: (value) => value!.length < 6
                        ? "Enter a password 6+ chars long"
                        : null,
                  ),
                  const SizedBox(height: 20.0),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _login,
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontFamily: "TextStyleFont",
                              color: Colors.black,
                              fontSize: 22,
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
