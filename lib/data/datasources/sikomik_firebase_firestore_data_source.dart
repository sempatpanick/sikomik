import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/utils/encode_decode_text.dart';
import '../models/user_comic_chapter_model.dart';
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
    required UserComicModel data,
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

  Future<UserComicChapterModel?> setUserComicChapterRead({
    required String userId,
    required UserComicChapterModel data,
  });

  Future<void> setBatchUserComicChapterRead({
    required String userId,
    required List<UserComicChapterModel> data,
  });

  Future<UserComicChapterModel?> getUserComicChapterReadById({
    required String userId,
    required String userComicId,
    required String id,
  });

  Future<List<UserComicChapterModel>> getUserComicChaptersRead({
    required String userId,
    required String userComicId,
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
  final userComicsChaptersReadCollectionName = "chapters_read";

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
    required UserComicModel data,
  }) async {
    await client
        .collection(usersCollectionName)
        .doc(userId)
        .collection(userComicsCollectionName)
        .doc(encodeText(data.id!))
        .set(
          (data..lastUpdated = DateTime.now().toUtc()).toJson(),
          SetOptions(merge: true),
        );

    return await getUserComicById(userId: userId, id: data.id ?? "");
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

  @override
  Future<UserComicChapterModel?> setUserComicChapterRead({
    required String userId,
    required UserComicChapterModel data,
  }) async {
    await client
        .collection(usersCollectionName)
        .doc(userId)
        .collection(userComicsCollectionName)
        .doc(encodeText(data.chapter!.comicPath!))
        .collection(userComicsChaptersReadCollectionName)
        .doc(encodeText(data.id!))
        .set(
          (data..lastUpdated = DateTime.now().toUtc()).toJson(),
          SetOptions(merge: true),
        );

    return await getUserComicChapterReadById(
      userId: userId,
      userComicId: data.chapter?.comicPath ?? "",
      id: data.id ?? "",
    );
  }

  @override
  Future<void> setBatchUserComicChapterRead({
    required String userId,
    required List<UserComicChapterModel> data,
  }) async {
    final batch = client.batch();

    for (final item in data) {
      final document = client
          .collection(usersCollectionName)
          .doc(userId)
          .collection(userComicsCollectionName)
          .doc(encodeText(item.id!))
          .collection(userComicsChaptersReadCollectionName)
          .doc(encodeText(item.chapter!.comicPath!));
      batch.set(document, item);
    }

    await batch.commit();
  }

  @override
  Future<UserComicChapterModel?> getUserComicChapterReadById({
    required String userId,
    required String userComicId,
    required String id,
  }) async {
    final getData = await client
        .collection(usersCollectionName)
        .doc(userId)
        .collection(userComicsCollectionName)
        .doc(encodeText(userComicId))
        .collection(userComicsChaptersReadCollectionName)
        .doc(encodeText(id))
        .get();

    if (getData.data() == null) {
      return null;
    }
    return UserComicChapterModel.fromJson(getData.data()!);
  }

  @override
  Future<List<UserComicChapterModel>> getUserComicChaptersRead({
    required String userId,
    required String userComicId,
  }) async {
    final getData = await client
        .collection(usersCollectionName)
        .doc(userId)
        .collection(userComicsCollectionName)
        .doc(encodeText(userComicId))
        .collection(userComicsChaptersReadCollectionName)
        .orderBy("lastUpdated", descending: true)
        .get();

    return getData.docs
        .map((item) => UserComicChapterModel.fromJson(item.data()))
        .toList();
  }
}
