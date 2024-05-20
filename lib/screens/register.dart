import 'package:flutter/material.dart';
import 'package:grup81_ai_jam/constans/color.dart';
import 'package:grup81_ai_jam/screens/welcome.dart';
import 'package:grup81_ai_jam/service/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _firebaseService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _favoritebookController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      dynamic result = await _firebaseService.registerWithEmailAndPassword(
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
                ? "Register failed"
                : "Register in as ${result.email}"),
          ),
        );
        if (result != null) {
          print("Registered: ${result.email}");
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const Welcome();
            },
          ));
        }
      }
    }
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
            "Register",
            style: TextStyle(
                fontFamily: "TextStyleFont", fontSize: 34, color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              //register form
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
                  TextFormField(
                    controller: _favoritebookController,
                    decoration:
                        const InputDecoration(labelText: "Favorite Book"),
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? "Enter an book" : null,
                  ),
                  const SizedBox(height: 20.0),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _register,
                          child: const Text("Register",
                              style: TextStyle(
                                  fontFamily: "TextStyleFont",
                                  color: Colors.black,
                                  fontSize: 22)),
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
