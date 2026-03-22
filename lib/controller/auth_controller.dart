// controller/auth_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthController {
  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Registers a new user with email and password
  // Also saves their username to Firestore
  Future<String?> register({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      // Creates the user in Firebase Authentication
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Saves additional user details to Firestore under 'users' collection
      final user = UserModel(
        uid: credential.user!.uid,
        email: email.trim(),
        username: username.trim(),
      );
      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(user.toMap());

      return null; // null means success — no error
    } on FirebaseAuthException catch (e) {
      return _handleError(e.code);
    }
  }

  // Signs in an existing user with email and password
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null; // null means success
    } on FirebaseAuthException catch (e) {
      return _handleError(e.code);
    }
  }

  // Signs the current user out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Converts Firebase error codes into readable messages for the user
  String _handleError(String code) {
    switch (code) {
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}