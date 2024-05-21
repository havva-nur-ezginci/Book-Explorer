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

  Future<String> fetchText() async {
    if (apiControl()) {
      // ... (Gemini API'den metin alma işlemi) ...
      final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
      final content = [
        Content.text(
            'bana komedi türünde kitap öner.her kitap için kitap adı,yazarı ve kısa kitap hakkında bilgi içersin')
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
