import 'package:flutter/material.dart';
import 'package:grup81_ai_jam/constans/color.dart';
import 'package:grup81_ai_jam/screens/login.dart';
import 'package:grup81_ai_jam/screens/register.dart';
import 'package:grup81_ai_jam/service/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final AuthService _firebaseService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "TextStyleFont"),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: HexColor(backgroundColor),
          appBar: AppBar(
            toolbarHeight: 70.0,
            leading: const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Icon(
                Icons.book,
                color: Colors.white,
                size: 38.0,
              ),
            ),
            title: const Text(
              "ANA SAYFA",
              style: TextStyle(fontSize: 34, color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: HexColor(headerColor),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 240,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: FloatingActionButton.extended(
                      backgroundColor: buttonBackgroundColor,
                      foregroundColor: Colors.black,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Login()));
                      },
                      icon: const Icon(
                        Icons.login,
                        size: 32,
                      ),
                      label: const Text(
                        'Giriş Yap',
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                      heroTag: 'loginHeroTag',
                    ),
                  ),
                ),
                SizedBox(
                  width: 240,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: FloatingActionButton.extended(
                      backgroundColor: buttonBackgroundColor,
                      foregroundColor: Colors.black,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Register()));
                      },
                      icon: const Icon(
                        Icons.app_registration,
                        size: 32,
                      ),
                      label: const Text(
                        'Kaydol',
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                      heroTag: 'registerHeroTag',
                    ),
                  ),
                ),
                SizedBox(
                  width: 240,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: FloatingActionButton.extended(
                      backgroundColor: buttonBackgroundColor,
                      foregroundColor: Colors.black,
                      onPressed: () {
                        _firebaseService.signInWithGoogle();
                      },
                      icon: Image.asset(
                        'lib/assets/images/google_icon.png',
                      ),
                      label: const Text(
                        "Google ile Giriş",
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                      heroTag: 'googleHeroTag',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
