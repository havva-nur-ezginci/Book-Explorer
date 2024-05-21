import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiAI {
  String apiKey = 'AIzaSyDBLF-rTv6YXh_Ozrr25lfdniaoLtGRB-4';

  bool apiControl() {
    if (apiKey.isEmpty) {
      print('No \$API_KEY is empty');
      return false;
    }
    return true;
  }

  Future<String> fetchText(String profilInfo) async {
    if (apiControl()) {
      // ... (Gemini API'den metin alma işlemi) ...
      final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
      final content = [
        Content.text(
            'Bana kitap önerir misin? Her kitap için kitap adı,yazarı,kitap hakkında kısa bilgi içersin. Ayrıca $profilInfo')
      ];

      final response = await model.generateContent(content);
      print(response.text);

      return response.text!;
    }
    return "HATALI API GİRİŞİ";
  }

  List<String> split(String textInput) {
    textInput.replaceAll("*", "");
    List<String> kitaplar = textInput.split('\n\n');
    print("split-----${kitaplar.length}------");
    return kitaplar;
  }
}
