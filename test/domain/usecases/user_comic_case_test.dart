import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:si_komik/common/failure.dart';
import 'package:si_komik/domain/entities/chapter_entity.dart';
import 'package:si_komik/domain/entities/comic_detail_entity.dart';
import 'package:si_komik/domain/entities/user_comic_entity.dart';
import 'package:si_komik/domain/usecases/user_comic_case.dart';

import '../repositories/sikomik_repository_test.mocks.dart';

void main() {
  late UserComicCase useCase;
  late MockSiKomikRepository mockRepo;

  final failure = ResponseFailure('Invalid credentials');

  setUp(() {
    mockRepo = MockSiKomikRepository();
    useCase = UserComicCase(repository: mockRepo);
  });

  group("set user comic", () {
    test('should be return User Comic successfully on set user comic',
        () async {
      // arrange
      final testData = UserComicEntity(
          id: "/solo-leveling",
          comic: DataComicDetailEntity(
            path: "/solo-leveling",
            title: "Solo Leveling",
            titleIndonesia: '',
            imageUrl: '',
            thumbnailUrl: '',
            synopsis: '',
            type: '',
            storyConcept: '',
            author: '',
            status: '',
            rating: null,
            genres: [],
            chapters: [],
          ),
          lastReadChapter: DataChapterEntity(
            path: "/solo-leveling",
            title: "Solo Leveling",
            comicPath: "/solo-leveling",
            chapter: 1,
            uploadedDate: "",
            images: [],
          ),
          isFavorite: true,
          createdAt: DateTime.now(),
          lastUpdated: DateTime.now());
      when(mockRepo.setUserComic(userId: "1", data: testData))
          .thenAnswer((_) async => Right(testData));

      // act
      final result = await useCase.setUserComic(userId: "1", data: testData);

      // assert
      expect(result, Right(testData));
      verify(mockRepo.setUserComic(userId: "1", data: testData)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should be return Failure on set user comic', () async {
      // arrange
      final testData = UserComicEntity(
          id: "/solo-leveling",
          comic: DataComicDetailEntity(
            path: "/solo-leveling",
            title: "Solo Leveling",
            titleIndonesia: '',
            imageUrl: '',
            thumbnailUrl: '',
            synopsis: '',
            type: '',
            storyConcept: '',
            author: '',
            status: '',
            rating: null,
            genres: [],
            chapters: [],
          ),
          lastReadChapter: DataChapterEntity(
            path: "/solo-leveling",
            title: "Solo Leveling",
            comicPath: "/solo-leveling",
            chapter: 1,
            uploadedDate: "",
            images: [],
          ),
          isFavorite: true,
          createdAt: DateTime.now(),
          lastUpdated: DateTime.now());
      when(mockRepo.setUserComic(userId: "1", data: testData))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await useCase.setUserComic(userId: "1", data: testData);

      // assert
      expect(result, Left(failure));
      verify(mockRepo.setUserComic(userId: "1", data: testData)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });

  group("get user comic", () {
    test('should be return User Comic successfully on get user comic',
        () async {
      // arrange
      final testData = UserComicEntity(
          id: "/solo-leveling",
          comic: DataComicDetailEntity(
            path: "/solo-leveling",
            title: "Solo Leveling",
            titleIndonesia: '',
            imageUrl: '',
            thumbnailUrl: '',
            synopsis: '',
            type: '',
            storyConcept: '',
            author: '',
            status: '',
            rating: null,
            genres: [],
            chapters: [],
          ),
          lastReadChapter: DataChapterEntity(
            path: "/solo-leveling",
            title: "Solo Leveling",
            comicPath: "/solo-leveling",
            chapter: 1,
            uploadedDate: "",
            images: [],
          ),
          isFavorite: true,
          createdAt: DateTime.now(),
          lastUpdated: DateTime.now());
      when(mockRepo.getUserComicById(userId: "1", id: "/solo-leveling"))
          .thenAnswer((_) async => Right(testData));

      // act
      final result =
          await useCase.getUserComicById(userId: "1", id: "/solo-leveling");

      // assert
      expect(result, Right(testData));
      verify(mockRepo.getUserComicById(userId: "1", id: "/solo-leveling"))
          .called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should be return Failure on get user comic', () async {
      // arrange
      when(mockRepo.getUserComicById(userId: "1", id: "/solo-leveling"))
          .thenAnswer((_) async => Left(failure));

      // act
      final result =
          await useCase.getUserComicById(userId: "1", id: "/solo-leveling");

      // assert
      expect(result, Left(failure));
      verify(mockRepo.getUserComicById(userId: "1", id: "/solo-leveling"))
          .called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });

  group("set favorites", () {
    test('should be return Favorites successfully on get favorites', () async {
      // arrange
      final testData = [
        UserComicEntity(
            id: "/solo-leveling",
            comic: DataComicDetailEntity(
              path: "/solo-leveling",
              title: "Solo Leveling",
              titleIndonesia: '',
              imageUrl: '',
              thumbnailUrl: '',
              synopsis: '',
              type: '',
              storyConcept: '',
              author: '',
              status: '',
              rating: null,
              genres: [],
              chapters: [],
            ),
            lastReadChapter: DataChapterEntity(
              path: "/solo-leveling",
              title: "Solo Leveling",
              comicPath: "/solo-leveling",
              chapter: 1,
              uploadedDate: "",
              images: [],
            ),
            isFavorite: true,
            createdAt: DateTime.now(),
            lastUpdated: DateTime.now())
      ];
      when(mockRepo.getFavorites(
        userId: "1",
      )).thenAnswer((_) async => Right(testData));

      // act
      final result = await useCase.getFavorites(
        userId: "1",
      );

      // assert
      expect(result, Right(testData));
      verify(mockRepo.getFavorites(
        userId: "1",
      )).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should be return Failure on get favorites', () async {
      // arrange
      when(mockRepo.getFavorites(
        userId: "1",
      )).thenAnswer((_) async => Left(failure));

      // act
      final result = await useCase.getFavorites(
        userId: "1",
      );

      // assert
      expect(result, Left(failure));
      verify(mockRepo.getFavorites(
        userId: "1",
      )).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });

  group("get favorite by id", () {
    test('should be return Favorite successfully on get favorite by id',
        () async {
      // arrange
      final testData = UserComicEntity(
          id: "/solo-leveling",
          comic: DataComicDetailEntity(
            path: "/solo-leveling",
            title: "Solo Leveling",
            titleIndonesia: '',
            imageUrl: '',
            thumbnailUrl: '',
            synopsis: '',
            type: '',
            storyConcept: '',
            author: '',
            status: '',
            rating: null,
            genres: [],
            chapters: [],
          ),
          lastReadChapter: DataChapterEntity(
            path: "/solo-leveling",
            title: "Solo Leveling",
            comicPath: "/solo-leveling",
            chapter: 1,
            uploadedDate: "",
            images: [],
          ),
          isFavorite: true,
          createdAt: DateTime.now(),
          lastUpdated: DateTime.now());
      when(mockRepo.getFavoriteById(userId: "1", id: "/solo-leveling"))
          .thenAnswer((_) async => Right(testData));

      // act
      final result =
          await useCase.getFavoriteById(userId: "1", id: "/solo-leveling");

      // assert
      expect(result, Right(testData));
      verify(mockRepo.getFavoriteById(userId: "1", id: "/solo-leveling"))
          .called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should be return Failure on get favorite by id', () async {
      // arrange
      when(mockRepo.getFavoriteById(userId: "1", id: "/solo-leveling"))
          .thenAnswer((_) async => Left(failure));

      // act
      final result =
          await useCase.getFavoriteById(userId: "1", id: "/solo-leveling");

      // assert
      expect(result, Left(failure));
      verify(mockRepo.getFavoriteById(userId: "1", id: "/solo-leveling"))
          .called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });
}
