import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grup81_ai_jam/constans/color.dart';
import 'package:grup81_ai_jam/models/user.dart';
import 'package:grup81_ai_jam/screens/welcome.dart';
import 'package:grup81_ai_jam/service/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';

class Profil extends StatefulWidget {
  final String email;
  const Profil({Key? key, required this.email}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final DatabaseService _cloudFirabese = DatabaseService();
  final TextEditingController _text1Controller = TextEditingController();
  final TextEditingController _text2Controller = TextEditingController();
  final TextEditingController _text3Controller = TextEditingController();

  bool _formIsValid = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: HexColor(backgroundColor),
      //appbar
      appBar: AppBar(
        toolbarHeight: 70.0,
        centerTitle: true,
        backgroundColor: HexColor(headerColor),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text(
            "Profil",
            style: TextStyle(
                fontFamily: "TextStyleFont", fontSize: 34, color: Colors.black),
          ),
          //SAVE button
          Tooltip(
            message: 'Save',
            waitDuration: const Duration(
                milliseconds: 10), // Tooltip'in daha hızlı görünmesini sağlar
            showDuration: const Duration(
                seconds:
                    2), // Tooltip'in ne kadar süreyle görünür kalacağını belirler
            child: IconButton(
              icon: const Icon(
                Icons.save,
                size: 32,
              ),
              onPressed: () {
                _formIsValid //form doldurulmuşsa firebase e kaydetme işlemini yap
                    ? _saveProfileInfo()
                    : ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profil bilgileri doldurulmalıdır  !!'),
                          duration: Duration(
                              seconds:
                                  3), // Mesajın ne kadar süreyle görüneceğini belirler
                        ),
                      );
              },
            ),
          ),
        ]),
      ),

      body: Column(children: [
        TextFormField(
          controller: _text1Controller,
          cursorColor: Theme.of(context).cardColor,
          maxLength: 30,
          decoration: const InputDecoration(
            icon: ImageIcon(
              AssetImage('lib/assets/images/author.png'),
              color: Colors.black,
              size: 38,
            ),
            labelText: 'Favorite Author text',
            helperText: 'Helper text',
            suffixIcon: Icon(
              Icons.check_circle,
            ),
          ),
          onChanged: (_) => _checkForm(),
        ),
        TextFormField(
          controller: _text2Controller,
          cursorColor: Theme.of(context).cardColor,
          maxLength: 30,
          decoration: const InputDecoration(
            icon: Icon(
              Icons.auto_stories_sharp,
              size: 35,
            ),
            labelText: 'Favorite Book text',
            helperText: 'Helper text',
            suffixIcon: Icon(
              Icons.check_circle,
            ),
          ),
          onChanged: (_) => _checkForm(),
        ),
        TextFormField(
          controller: _text3Controller,
          cursorColor: Theme.of(context).cardColor,
          maxLength: 3, //max 3 basamaklı olsun
          decoration: const InputDecoration(
            icon: ImageIcon(
              AssetImage('lib/assets/images/time.png'),
              color: Colors.black,
              size: 50,
            ),
            labelText: 'Age text',
            helperText: 'Helper text',
            suffixIcon: Icon(
              Icons.check_circle,
            ),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(
                RegExp(r'[1-9]')), //sadece sayı girilsin
          ],
          onChanged: (_) => _checkForm(),
        ),
      ]),
    ));
  }

  void _checkForm() {
    setState(() {
      _formIsValid = _text1Controller.text.isNotEmpty &&
          _text2Controller.text.isNotEmpty &&
          _text3Controller.text.isNotEmpty;
    });
  }

  void _saveProfileInfo() {
    _cloudFirabese.addUser(NewProfil(
        email: widget.email,
        favoriteAuthor: _text1Controller.text,
        favoriteBook: _text2Controller.text,
        age: int.parse(_text3Controller.text)));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Kaydedildi'),
        duration: Duration(
            seconds: 2), // Mesajın ne kadar süreyle görüneceğini belirler
      ),
    );
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Welcome(
              email: widget.email,
            )));
  }
}
