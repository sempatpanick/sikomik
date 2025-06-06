// Mocks generated by Mockito 5.4.6 from annotations
// in si_komik/test/data/datasources/sikomik_firebase_firestore_data_source_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:si_komik/data/datasources/sikomik_firebase_firestore_data_source.dart'
    as _i2;
import 'package:si_komik/data/models/user_comic_chapter_model.dart' as _i6;
import 'package:si_komik/data/models/user_comic_model.dart' as _i5;
import 'package:si_komik/data/models/user_model.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [SiKomikFirebaseFirestoreDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSiKomikFirebaseFirestoreDataSource extends _i1.Mock
    implements _i2.SiKomikFirebaseFirestoreDataSource {
  MockSiKomikFirebaseFirestoreDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.UserModel?> setUser({required _i4.UserModel? user}) =>
      (super.noSuchMethod(
        Invocation.method(
          #setUser,
          [],
          {#user: user},
        ),
        returnValue: _i3.Future<_i4.UserModel?>.value(),
      ) as _i3.Future<_i4.UserModel?>);

  @override
  _i3.Future<_i4.UserModel?> getUser({required String? userId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUser,
          [],
          {#userId: userId},
        ),
        returnValue: _i3.Future<_i4.UserModel?>.value(),
      ) as _i3.Future<_i4.UserModel?>);

  @override
  _i3.Future<_i5.UserComicModel?> setUserComic({
    required String? userId,
    required _i5.UserComicModel? data,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #setUserComic,
          [],
          {
            #userId: userId,
            #data: data,
          },
        ),
        returnValue: _i3.Future<_i5.UserComicModel?>.value(),
      ) as _i3.Future<_i5.UserComicModel?>);

  @override
  _i3.Future<_i5.UserComicModel?> getUserComicById({
    required String? userId,
    required String? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserComicById,
          [],
          {
            #userId: userId,
            #id: id,
          },
        ),
        returnValue: _i3.Future<_i5.UserComicModel?>.value(),
      ) as _i3.Future<_i5.UserComicModel?>);

  @override
  _i3.Future<List<_i5.UserComicModel>> getFavorites(
          {required String? userId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getFavorites,
          [],
          {#userId: userId},
        ),
        returnValue:
            _i3.Future<List<_i5.UserComicModel>>.value(<_i5.UserComicModel>[]),
      ) as _i3.Future<List<_i5.UserComicModel>>);

  @override
  _i3.Future<_i5.UserComicModel?> getFavoriteById({
    required String? userId,
    required String? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getFavoriteById,
          [],
          {
            #userId: userId,
            #id: id,
          },
        ),
        returnValue: _i3.Future<_i5.UserComicModel?>.value(),
      ) as _i3.Future<_i5.UserComicModel?>);

  @override
  _i3.Future<_i6.UserComicChapterModel?> setUserComicChapterRead({
    required String? userId,
    required _i6.UserComicChapterModel? data,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #setUserComicChapterRead,
          [],
          {
            #userId: userId,
            #data: data,
          },
        ),
        returnValue: _i3.Future<_i6.UserComicChapterModel?>.value(),
      ) as _i3.Future<_i6.UserComicChapterModel?>);

  @override
  _i3.Future<void> setBatchUserComicChapterRead({
    required String? userId,
    required List<_i6.UserComicChapterModel>? data,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #setBatchUserComicChapterRead,
          [],
          {
            #userId: userId,
            #data: data,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<_i6.UserComicChapterModel?> getUserComicChapterReadById({
    required String? userId,
    required String? userComicId,
    required String? id,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserComicChapterReadById,
          [],
          {
            #userId: userId,
            #userComicId: userComicId,
            #id: id,
          },
        ),
        returnValue: _i3.Future<_i6.UserComicChapterModel?>.value(),
      ) as _i3.Future<_i6.UserComicChapterModel?>);

  @override
  _i3.Future<List<_i6.UserComicChapterModel>> getUserComicChaptersRead({
    required String? userId,
    required String? userComicId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserComicChaptersRead,
          [],
          {
            #userId: userId,
            #userComicId: userComicId,
          },
        ),
        returnValue: _i3.Future<List<_i6.UserComicChapterModel>>.value(
            <_i6.UserComicChapterModel>[]),
      ) as _i3.Future<List<_i6.UserComicChapterModel>>);
}
