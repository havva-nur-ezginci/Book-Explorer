import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:grup81_ai_jam/models/user.dart';

class DatabaseService {
  // Create a CollectionReference called users that references the firestore collection
  CollectionReference dbUsers = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(String fullName, String company, int age) {
    // Call the user's CollectionReference to add a new user
    return dbUsers
        .add({
          'full_name': fullName, // John Doe
          'company': company, // Stokes and Sons
          'age': age // 42
        })
        .then((value) => print(
            "kaydedilen veri:$value")) //kaydedilen veri:DocumentReference<Map<String, dynamic>>(users/7cc8ebnvqBb9pmfbKifR)
        .catchError((error) => print("Failed to add user: $error"));
  }

  /// Reads all documments from the users collection
  Future<List<NewUser>> getTopics() async {
    final snapshot = await dbUsers.get();
    final data = snapshot.docs.map((s) => s.data() as Map<String, dynamic>);
    final users = data.map((d) => NewUser.fromJson(d));
    return users.toList();
  }

  /// Retrieves a single user document
  Future<NewUser> getUser(String userId) async {
    final ref = dbUsers.doc(userId);
    final snapshot = await ref.get();
    return NewUser.fromJson(snapshot.data() as Map<String, dynamic>);
  }
}
