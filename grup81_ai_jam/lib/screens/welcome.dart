import 'package:flutter/material.dart';
import 'package:grup81_ai_jam/constans/color.dart';
import 'package:grup81_ai_jam/screens/home.dart';
import 'package:grup81_ai_jam/screens/profil.dart';
import 'package:hexcolor/hexcolor.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(backgroundColor),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70.0,
          centerTitle: true,
          backgroundColor: HexColor(headerColor),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              "Keşfe Hoşgeldin",
              style: TextStyle(
                  fontFamily: "TextStyleFont",
                  fontSize: 28,
                  color: Colors.black),
            ),
            IconButton(
              icon: const Icon(
                Icons.logout,
                size: 28,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
          ]),
        ),
        bottomNavigationBar: BottomAppBar(
          color: HexColor(headerColor),
          height: 60.0, // Yüksekliği 60 piksele ayarla
          child: Row(children: [
            IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: () {}),
            const Spacer(),
            /*  IconButton(
                icon: Image.asset(
                  'lib/assets/images/icons-heart.png',
                  color: Colors.black,
                  fit: BoxFit.cover,
                  width: 24,
                  height: 40,
                ),
                onPressed: () {}),*/
            IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.black,
                  size: 40,
                ),
                onPressed: () {}),
            IconButton(
                icon: const Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Profil()));
                }),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: HexColor(backgroundColor),
          elevation: 6.0, // Adjust elevation as needed
          shape: const OvalBorder(
            // Add border here
            side: BorderSide(
              color: Colors.white, // Border color
              width: 4.0, // Border width
            ),
          ),
          child: const Icon(
            Icons.camera_alt,
            color: Colors.black,
            size: 40,
          ),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: const SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
