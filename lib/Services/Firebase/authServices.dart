import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authservices {
  // Creating the instance for FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Creating the instance for Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signup({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore
          .collection("Employees")
          .doc(userCredential.user!.uid)
          .set({'Name': name.trim(), 'Email': email.trim(), 'Role': role});

      return userCredential.user;
    } catch (e) {
      throw Exception("Signup Failed : $e");
    }
  }

  Future<User?> login({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetching the Data from Firestore to determine who can access which dashboards

      DocumentSnapshot userDoc =
          await _firestore
              .collection("Employees")
              .doc(userCredential.user!.uid)
              .get();
      return userCredential.user;
    } catch (e) {
      throw Exception("Login Failed : $e");
    }
  }

  Future<String?> fetchUserRole(String userId) async {
    DocumentSnapshot snapshot =
        await _firestore.collection("Employees").doc(userId).get();
    return snapshot.get('Role');
  }

  Future<String?> getUserName(String userId) async {
    DocumentSnapshot snapshot =
        await _firestore.collection("Employees").doc(userId).get();
    return snapshot.get('Name');
  }
  User? getCurrentUser(){
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return;
    }
  }
}
