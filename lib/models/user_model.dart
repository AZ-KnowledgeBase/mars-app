// models/user_model.dart

// Holds the data for a registered user stored in Firestore
class UserModel {
  final String uid;       // Firebase unique user ID
  final String email;
  final String username;

  UserModel({
    required this.uid,
    required this.email,
    required this.username,
  });

  // Converts UserModel to a Map so it can be saved to Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
    };
  }
}