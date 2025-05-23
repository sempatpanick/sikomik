import 'package:SiKomik/domain/entities/chapter_entity.dart';
import 'package:SiKomik/domain/usecases/get_chapter_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../repositories/sikomik_repository_test.mocks.dart';

void main() {
  late GetChapterCase useCase;
  late MockSiKomikRepository mockRepo;

  setUp(() {
    mockRepo = MockSiKomikRepository();
    useCase = GetChapterCase(repository: mockRepo);
  });

  test('should get chapter from the repository', () async {
    // arrange
    final testData = ChapterEntity(
        status: true,
        data: DataChapterEntity(
          path: "/solo-leveling",
          title: "Solo Leveling",
          comicPath: "/solo-leveling",
          chapter: 1,
          uploadedDate: "",
          images: [],
        ));
    when(mockRepo.getChapter(path: "/solo-leveling"))
        .thenAnswer((_) async => Right(testData));

    // act
    final result = await useCase.execute(path: "/solo-leveling");

    // assert
    expect(result, Right(testData));
    verify(mockRepo.getChapter(path: "/solo-leveling")).called(1);
    verifyNoMoreInteractions(mockRepo);
  });
}
