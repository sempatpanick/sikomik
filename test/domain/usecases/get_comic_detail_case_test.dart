import 'package:SiKomik/domain/entities/comic_detail_entity.dart';
import 'package:SiKomik/domain/usecases/get_comic_detail_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../repositories/sikomik_repository_test.mocks.dart';

void main() {
  late GetComicDetailCase useCase;
  late MockSiKomikRepository mockRepo;

  setUp(() {
    mockRepo = MockSiKomikRepository();
    useCase = GetComicDetailCase(repository: mockRepo);
  });

  test('should be get comic detail', () async {
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
}
