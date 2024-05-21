class NewProfil {
  //nullable her zaman dolu olmayabilir.
  String? email;
  String? favoriteAuthor;
  String? favoriteBook;
  int? age;

  NewProfil(
      {required this.email,
      required this.favoriteAuthor,
      required this.favoriteBook,
      required this.age});

  // From json
  NewProfil.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    favoriteAuthor = json["favoriteAuthor"];
    favoriteBook = json["favoriteBook"];
    age = json["age"];
  }

  // To json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["email"] = email;
    data["favoriteAuthor"] = favoriteAuthor;
    data["favoriteBook"] = favoriteBook;
    data["age"] = age;
    return data;
  }

  // ToString metodu
  @override
  String toString() {
    return 'benim favori yazarım: $favoriteAuthor, favorite kitabım: $favoriteBook, yaşım: $age';
  }
}
