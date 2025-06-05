import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:si_komik/common/failure.dart';
import 'package:si_komik/domain/entities/comic_detail_entity.dart';
import 'package:si_komik/domain/usecases/get_comic_detail_case.dart';

import '../repositories/sikomik_repository_test.mocks.dart';

void main() {
  late GetComicDetailCase useCase;
  late MockSiKomikRepository mockRepo;

  final failure = ResponseFailure('Invalid credentials');

  setUp(() {
    mockRepo = MockSiKomikRepository();
    useCase = GetComicDetailCase(repository: mockRepo);
  });

  group("get comic detail", () {
    test('should be return Comic Detail successfully on get comic detail',
        () async {
      // arrange
      final testData = ComicDetailEntity(
          status: true,
          data: DataComicDetailEntity(
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
          ));
      when(mockRepo.getComicDetail(path: "/solo-leveling"))
          .thenAnswer((_) async => Right(testData));

      // act
      final result = await useCase.execute(path: "/solo-leveling");

      // assert
      expect(result, Right(testData));
      verify(mockRepo.getComicDetail(path: "/solo-leveling")).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should be return Failure on get comic detail', () async {
      // arrange
      when(mockRepo.getComicDetail(path: "/solo-leveling"))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await useCase.execute(path: "/solo-leveling");

      // assert
      expect(result, Left(failure));
      verify(mockRepo.getComicDetail(path: "/solo-leveling")).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });
}
