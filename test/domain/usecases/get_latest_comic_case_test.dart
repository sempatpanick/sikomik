import 'package:SiKomik/common/failure.dart';
import 'package:SiKomik/domain/entities/comic_entity.dart';
import 'package:SiKomik/domain/usecases/get_latest_comic_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../repositories/sikomik_repository_test.mocks.dart';

void main() {
  late GetLatestComicCase useCase;
  late MockSiKomikRepository mockRepo;

  final failure = ResponseFailure('Invalid credentials');

  setUp(() {
    mockRepo = MockSiKomikRepository();
    useCase = GetLatestComicCase(repository: mockRepo);
  });

  group("get latest comic", () {
    test('should be return Comics latest successfully on get latest comic',
        () async {
      // arrange
      final testData = ComicEntity(status: true, page: 1, maxPage: 1, data: [
        DataComicEntity(
            title: "Solo Leveling",
            imageUrl: "",
            chapter: 20,
            rating: 5,
            status: "Ongoing",
            lastUpdated: "",
            path: "/solo-leveling")
      ]);
      when(mockRepo.getLatestComic(page: 1))
          .thenAnswer((_) async => Right(testData));

      // act
      final result = await useCase.execute(page: 1);

      // assert
      expect(result, Right(testData));
      verify(mockRepo.getLatestComic(page: 1)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should be return Failure on get latest comic', () async {
      // arrange
      when(mockRepo.getLatestComic(page: 1))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await useCase.execute(page: 1);

      // assert
      expect(result, Left(failure));
      verify(mockRepo.getLatestComic(page: 1)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });
}
