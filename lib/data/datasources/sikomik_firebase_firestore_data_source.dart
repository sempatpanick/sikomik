import 'package:firebase_auth/firebase_auth.dart';

import '../../common/enums.dart';

abstract class SiKomikFirebaseFirestoreDataSource {
  Future<UserCredential> setFavorite({
    String? path,
  });
  Future<UserCredential> getFavorites();
  Future<void> getFavoriteById();
  Future<User?> getUser();
  Future<Stream<User?>> streamUser();
}

class SiKomikFirebaseAuthDataSourceImpl extends SiKomikFirebaseAuthDataSource {
  final FirebaseAuth client;

  SiKomikFirebaseAuthDataSourceImpl({
    required this.client,
  });

  @override
  Future<UserCredential> login({
    String? email,
    String? password,
    required LoginType type,
  }) async {
    if (client.currentUser != null) {
      await logout();
    }

    UserCredential? userCredential;

    switch (type) {
      case LoginType.email:
        if (email == null || password == null) {
          throw Exception("Email or password is not passed");
        }

        userCredential = await client.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        break;
      case LoginType.google:
        userCredential = await client.signInWithProvider(
          GoogleAuthProvider(),
        );
        break;
      case LoginType.facebook:
        userCredential = await client.signInWithProvider(
          FacebookAuthProvider(),
        );
        break;
    }

    return userCredential;
  }

  @override
  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    final userCredential = await client.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential;
  }

  @override
  Future<void> logout() async {
    return client.signOut();
  }

  @override
  Future<User?> getUser() async {
    return client.currentUser;
  }

  @override
  Future<Stream<User?>> streamUser() async {
    return client.userChanges();
  }
}
