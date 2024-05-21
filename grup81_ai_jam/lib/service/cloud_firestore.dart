import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:grup81_ai_jam/models/user.dart';

class DatabaseService {
  // Create a CollectionReference called users that references the firestore collection
  CollectionReference dbProfil =
      FirebaseFirestore.instance.collection('profiles');

  Future<void> addUser(NewProfil profile) async {
    // Call the user's CollectionReference to add a new user
    try {
      await dbProfil.doc(profile.email).set(profile.toJson());
      print("Profile added successfully");
    } catch (e) {
      print("Failed to add profile: $e");
    }
  }

  /// Reads all documments from the users collection
  Future<List<NewProfil>> getProfiles() async {
    final snapshot = await dbProfil.get();
    final data = snapshot.docs.map((s) => s.data() as Map<String, dynamic>);
    final users = data.map((d) => NewProfil.fromJson(d));
    return users.toList();
  }

  /// Retrieves a single user document
  Future<String> getProfil(String userId) async {
    final ref = dbProfil.doc(userId);
    final snapshot = await ref.get();
    return NewProfil.fromJson(snapshot.data() as Map<String, dynamic>)
        .toString();
  }
}
