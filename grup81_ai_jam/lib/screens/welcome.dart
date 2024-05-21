import 'package:flutter/material.dart';
import 'package:grup81_ai_jam/constans/color.dart';
import 'package:grup81_ai_jam/models/user.dart';
import 'package:grup81_ai_jam/screens/home.dart';
import 'package:grup81_ai_jam/screens/profil.dart';
import 'package:grup81_ai_jam/service/cloud_firestore.dart';
import 'package:grup81_ai_jam/service/gemini_ai.dart';
import 'package:hexcolor/hexcolor.dart';

class Welcome extends StatefulWidget {
  final String email;

  Welcome({Key? key, required this.email}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final DatabaseService _cloudFirabese = DatabaseService();
  GeminiAI aiService = GeminiAI();
  List<String>? kitaplar;
  bool isLoading = false;
  String? errorMessage;

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Kitap Keşfine Hoşgeldin",
                style: TextStyle(
                  fontFamily: "TextStyleFont",
                  fontSize: 28,
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: HexColor(headerColor),
          height: 60.0,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => Profil(email: widget.email)),
                  );
                },
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.black,
                  size: 40,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          width: 65,
          height: 65,
          child: FloatingActionButton(
            backgroundColor: HexColor(backgroundColor),
            elevation: 6.0,
            shape: const OvalBorder(
              side: BorderSide(
                color: Colors.black,
                width: 4.0,
              ),
            ),
            child: Image.asset(
              'lib/assets/images/ai.png',
              color: Colors.black,
              width: 45,
              height: 45,
            ),
            onPressed: () async {
              setState(() {
                isLoading = true;
                errorMessage = null;
              });

              try {
                String profilInfo =
                    await _cloudFirabese.getProfil(widget.email);
                print("======profil bilgisi:$profilInfo");
                String fetchedText = await aiService.fetchText(profilInfo);
                setState(() {
                  kitaplar = aiService.split(fetchedText);
                  isLoading = false;
                });
              } catch (error) {
                setState(() {
                  errorMessage = 'Error: $error';
                  isLoading = false;
                });
              }
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage != null
                ? Center(child: Text(errorMessage!))
                : kitaplar != null
                    ? ListView.builder(
                        itemCount: kitaplar!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.all(10.0),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: kitaplar![index]
                                    .split('\n')
                                    .map((line) => Text(line))
                                    .toList(),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text('No data yet. Press the button to fetch.'),
                      ),
      ),
    );
  }
}
