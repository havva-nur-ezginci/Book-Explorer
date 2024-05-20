class NewUser {
  //nullable her zaman dolu olmayabilir.
  String? fullName;
  String? company;
  int? age;

  NewUser({required this.fullName, required this.company, required this.age});

  // From json
  NewUser.fromJson(Map<String, dynamic> json) {
    fullName = json["id"];
    company = json["todo"];
    age = json["completed"];
  }

  // To json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["fullNmae"] = fullName;
    data["company"] = company;
    data["age"] = age;
    return data;
  }
}
