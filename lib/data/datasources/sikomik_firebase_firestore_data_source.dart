import 'package:firebase_auth/firebase_auth.dart';

abstract class SiKomikFirebaseFirestoreDataSource {
  Future<UserCredential> setFavorite({
    String? path,
  });
  Future<UserCredential> getFavorites();
  Future<void> getFavoriteById();
  Future<User?> getUser();
  Future<Stream<User?>> streamUser();
}

class SiKomikFirebaseAuthDataSourceImpl
    extends SiKomikFirebaseFirestoreDataSource {
  final FirebaseAuth client;

  SiKomikFirebaseAuthDataSourceImpl({
    required this.client,
  });

  @override
  Future<void> getFavoriteById() {
    // TODO: implement getFavoriteById
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> getFavorites() {
    // TODO: implement getFavorites
    throw UnimplementedError();
  }

  @override
  Future<User?> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> setFavorite({String? path}) {
    // TODO: implement setFavorite
    throw UnimplementedError();
  }

  @override
  Future<Stream<User?>> streamUser() {
    // TODO: implement streamUser
    throw UnimplementedError();
  }
}
