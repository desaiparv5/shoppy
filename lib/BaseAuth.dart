import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(Map data);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();

  Future<void> addUser(Map data, String uid);
}

class Auth implements BaseAuth {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final databaseReference = Firestore.instance;

  @override
  Future<String> signUp(Map data) async {
    AuthResult authResult = await firebaseAuth.createUserWithEmailAndPassword(
        email: data['email'], password: data['password']);
    FirebaseUser user = authResult.user;
    addUser(data, user.uid);
    return user.uid;
  }

  @override
  Future<void> addUser(Map data, String uid) async {
    databaseReference.collection("Users").document(uid).setData({
      'Address': data['add1'] + " " + data["add2"],
      'Mobile': data['phone'],
      'Pincode': data['pin'],
      'Name': data['name'],
    });
    print('sign up');
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
}
