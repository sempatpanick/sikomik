import 'package:SiKomik/common/failure.dart';
import 'package:SiKomik/domain/entities/chapter_entity.dart';
import 'package:SiKomik/domain/entities/user_comic_chapter_entity.dart';
import 'package:SiKomik/domain/usecases/user_comic_chapter_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../repositories/sikomik_repository_test.mocks.dart';

void main() {
  late UserComicChapterCase useCase;
  late MockSiKomikRepository mockRepo;

  final failure = ResponseFailure('Invalid credentials');

  setUp(() {
    mockRepo = MockSiKomikRepository();
    useCase = UserComicChapterCase(repository: mockRepo);
  });

  group("set user comic chapter read", () {
    test(
        'should be return User Comic Chapter successfully on set user comic chapter read',
        () async {
      // arrange
      final testData = UserComicChapterEntity(
          id: "/solo-leveling",
          chapter: DataChapterEntity(
            path: "/solo-leveling",
            title: "Solo Leveling",
            comicPath: "/solo-leveling",
            chapter: 1,
            uploadedDate: "",
            images: [],
          ),
          createdAt: DateTime.now(),
          lastUpdated: DateTime.now());
      when(mockRepo.setUserComicChapterRead(userId: "1", data: testData))
          .thenAnswer((_) async => Right(testData));

      // act
      final result =
          await useCase.setUserComicChapterRead(userId: "1", data: testData);

      // assert
      expect(result, Right(testData));
      verify(mockRepo.setUserComicChapterRead(userId: "1", data: testData))
          .called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should be return Failure on set user comic chapter read', () async {
      // arrange
      final testData = UserComicChapterEntity(
          id: "/solo-leveling",
          chapter: DataChapterEntity(
            path: "/solo-leveling",
            title: "Solo Leveling",
            comicPath: "/solo-leveling",
            chapter: 1,
            uploadedDate: "",
            images: [],
          ),
          createdAt: DateTime.now(),
          lastUpdated: DateTime.now());
      when(mockRepo.setUserComicChapterRead(userId: "1", data: testData))
          .thenAnswer((_) async => Left(failure));

      // act
      final result =
          await useCase.setUserComicChapterRead(userId: "1", data: testData);

      // assert
      expect(result, Left(failure));
      verify(mockRepo.setUserComicChapterRead(userId: "1", data: testData))
          .called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });

  group("get user comic chapters read", () {
    test(
        'should be return User Comic Chapters Read successfully on get user comic chapters read',
        () async {
      // arrange
      final testData = [
        UserComicChapterEntity(
            id: "/solo-leveling",
            chapter: DataChapterEntity(
              path: "/solo-leveling",
              title: "Solo Leveling",
              comicPath: "/solo-leveling",
              chapter: 1,
              uploadedDate: "",
              images: [],
            ),
            createdAt: DateTime.now(),
            lastUpdated: DateTime.now())
      ];
      when(mockRepo.getUserComicChaptersRead(
              userId: "1", userComicId: "/solo-leveling"))
          .thenAnswer((_) async => Right(testData));

      // act
      final result = await useCase.getUserComicChaptersRead(
          userId: "1", userComicId: "/solo-leveling");

      // assert
      expect(result, Right(testData));
      verify(mockRepo.getUserComicChaptersRead(
              userId: "1", userComicId: "/solo-leveling"))
          .called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should be return Failed on get user comic chapters read', () async {
      // arrange
      final testData = [
        UserComicChapterEntity(
            id: "/solo-leveling",
            chapter: DataChapterEntity(
              path: "/solo-leveling",
              title: "Solo Leveling",
              comicPath: "/solo-leveling",
              chapter: 1,
              uploadedDate: "",
              images: [],
            ),
            createdAt: DateTime.now(),
            lastUpdated: DateTime.now())
      ];
      when(mockRepo.getUserComicChaptersRead(
              userId: "1", userComicId: "/solo-leveling"))
          .thenAnswer((_) async => Right(testData));

      // act
      final result = await useCase.getUserComicChaptersRead(
          userId: "1", userComicId: "/solo-leveling");

      // assert
      expect(result, Right(testData));
      verify(mockRepo.getUserComicChaptersRead(
              userId: "1", userComicId: "/solo-leveling"))
          .called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });

  group("get user comic chapter read by id", () {
    test(
        'should be return User Comic Chapter Read successfully on get user comic chapter read by id',
        () async {
      // arrange
      final testData = UserComicChapterEntity(
          id: "/solo-leveling",
          chapter: DataChapterEntity(
            path: "/solo-leveling",
            title: "Solo Leveling",
            comicPath: "/solo-leveling",
            chapter: 1,
            uploadedDate: "",
            images: [],
          ),
          createdAt: DateTime.now(),
          lastUpdated: DateTime.now());
      when(mockRepo.getUserComicChapterReadById(
              userId: "1", userComicId: "/solo-leveling", id: "randomUid"))
          .thenAnswer((_) async => Right(testData));

      // act
      final result = await useCase.getUserComicChapterReadById(
          userId: "1", userComicId: "/solo-leveling", id: "randomUid");

      // assert
      expect(result, Right(testData));
      verify(mockRepo.getUserComicChapterReadById(
              userId: "1", userComicId: "/solo-leveling", id: "randomUid"))
          .called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should be return Failure on get user comic chapter read by id',
        () async {
      // arrange
      when(mockRepo.getUserComicChapterReadById(
              userId: "1", userComicId: "/solo-leveling", id: "randomUid"))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await useCase.getUserComicChapterReadById(
          userId: "1", userComicId: "/solo-leveling", id: "randomUid");

      // assert
      expect(result, Left(failure));
      verify(mockRepo.getUserComicChapterReadById(
              userId: "1", userComicId: "/solo-leveling", id: "randomUid"))
          .called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });
}
