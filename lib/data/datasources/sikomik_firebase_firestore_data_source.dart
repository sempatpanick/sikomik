import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/utils/encode_decode_text.dart';
import '../models/user_comic_model.dart';
import '../models/user_model.dart';

abstract class SiKomikFirebaseFirestoreDataSource {
  Future<UserModel?> setUser({
    required UserModel user,
  });

  Future<UserModel?> getUser({
    required String userId,
  });

  Future<UserComicModel?> setUserComic({
    required String userId,
    required UserComicModel userComic,
  });

  Future<UserComicModel?> getUserComicById({
    required String userId,
    required String id,
  });

  Future<List<UserComicModel>> getFavorites({
    required String userId,
  });

  Future<UserComicModel?> getFavoriteById({
    required String userId,
    required String id,
  });
}

class SiKomikFirebaseFirestoreDataSourceImpl
    extends SiKomikFirebaseFirestoreDataSource {
  final FirebaseFirestore client;

  SiKomikFirebaseFirestoreDataSourceImpl({
    required this.client,
  });

  final usersCollectionName = "users";
  final userComicsCollectionName = "comics";

  @override
  Future<UserModel?> setUser({required UserModel user}) async {
    await client.collection(usersCollectionName).doc(user.id).set(
          (user..lastUpdated = DateTime.now().toUtc()).toJson(),
          SetOptions(merge: true),
        );

    return await getUser(userId: user.id ?? "");
  }

  @override
  Future<UserModel?> getUser({required String userId}) async {
    final getData =
        await client.collection(usersCollectionName).doc(userId).get();

    if (getData.data() == null || (getData.data() ?? {}).isEmpty) {
      return null;
    }
    return UserModel.fromJson(getData.data()!);
  }

  @override
  Future<UserComicModel?> setUserComic({
    required String userId,
    required UserComicModel userComic,
  }) async {
    await client
        .collection(usersCollectionName)
        .doc(userId)
        .collection(userComicsCollectionName)
        .doc(encodeText(userComic.id!))
        .set(
          (userComic..lastUpdated = DateTime.now().toUtc()).toJson(),
          SetOptions(merge: true),
        );

    return await getUserComicById(userId: userId, id: userComic.id ?? "");
  }

  @override
  Future<UserComicModel?> getUserComicById({
    required String userId,
    required String id,
  }) async {
    final getData = await client
        .collection(usersCollectionName)
        .doc(userId)
        .collection(userComicsCollectionName)
        .doc(encodeText(id))
        .get();

    if (getData.data() == null) {
      return null;
    }
    return UserComicModel.fromJson(getData.data()!);
  }

  @override
  Future<List<UserComicModel>> getFavorites({required String userId}) async {
    final getData = await client
        .collection(usersCollectionName)
        .doc(userId)
        .collection(userComicsCollectionName)
        .where("isFavorite", isEqualTo: true)
        .orderBy("lastUpdated", descending: true)
        .get();

    return getData.docs
        .map((item) => UserComicModel.fromJson(item.data()))
        .toList();
  }

  @override
  Future<UserComicModel?> getFavoriteById({
    required String userId,
    required String id,
  }) async {
    final getData = await client
        .collection(usersCollectionName)
        .doc(userId)
        .collection(userComicsCollectionName)
        .where(
          "id",
          isEqualTo: id,
        )
        .where("isFavorite", isEqualTo: true)
        .limit(1)
        .get();

    if (getData.size <= 0) {
      return null;
    }
    return UserComicModel.fromJson(getData.docs.first.data());
  }
}
