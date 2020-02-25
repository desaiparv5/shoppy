import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();

  Future<void> getShops();
}

class Auth implements BaseAuth {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final databaseReference = Firestore.instance;

  @override
  Future<String> signUp(String email, String password) async {
    AuthResult authResult = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = authResult.user;
    return user.uid;
  }

  @override
  Future<String> signIn(String email, String password) async {
    AuthResult authResult = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = authResult.user;
    return user.uid;
  }

  @override
  Future<void> signOut() {
    return firebaseAuth.signOut();
  }

  @override
  Future<FirebaseUser> getCurrentUser() async {
    // TODO: implement getCurrentUser
    FirebaseUser user = await firebaseAuth.currentUser();
    return user;
  }

  @override
  Future<bool> isEmailVerified() async {
    FirebaseUser user = await firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  @override
  Future<void> sendEmailVerification() async {
    FirebaseUser user = await firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<void> getShops() async {
    databaseReference
      .collection("Shops")
      .getDocuments()
      .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f) => print('${f.data}}'));
  });
  }
}
