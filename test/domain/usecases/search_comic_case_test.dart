import 'package:SiKomik/common/failure.dart';
import 'package:SiKomik/domain/entities/comic_entity.dart';
import 'package:SiKomik/domain/usecases/search_comic_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../repositories/sikomik_repository_test.mocks.dart';

void main() {
  late SearchComicCase useCase;
  late MockSiKomikRepository mockRepo;

  final failure = ResponseFailure('Invalid credentials');

  setUp(() {
    mockRepo = MockSiKomikRepository();
    useCase = SearchComicCase(repository: mockRepo);
  });

  group("search comic", () {
    test('should be return Comics successfully on search comic', () async {
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
      when(mockRepo.searchComic(query: "solo leveling"))
          .thenAnswer((_) async => Right(testData));

      // act
      final result = await useCase.execute(query: "solo leveling");

      // assert
      expect(result, Right(testData));
      verify(mockRepo.searchComic(query: "solo leveling")).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should be return Failure on search comic', () async {
      // arrange
      when(mockRepo.searchComic(query: "solo leveling"))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await useCase.execute(query: "solo leveling");

      // assert
      expect(result, Left(failure));
      verify(mockRepo.searchComic(query: "solo leveling")).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });
}
