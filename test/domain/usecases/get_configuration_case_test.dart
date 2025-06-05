import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:si_komik/common/failure.dart';
import 'package:si_komik/domain/entities/configuration_entity.dart';
import 'package:si_komik/domain/usecases/get_configuration_case.dart';

import '../repositories/sikomik_repository_test.mocks.dart';

void main() {
  late GetConfigurationCase useCase;
  late MockSiKomikRepository mockRepo;

  final failure = ResponseFailure('Invalid credentials');

  setUp(() {
    mockRepo = MockSiKomikRepository();
    useCase = GetConfigurationCase(repository: mockRepo);
  });

  group("get configuration", () {
    test('should be return Configuration successfully on get configuration',
        () async {
      // arrange
      final testData = ConfigurationEntity(
          appVersion: "v2.0.0", url: "https://comic.ddg.my.id");
      when(mockRepo.getConfiguration())
          .thenAnswer((_) async => Right(testData));

      // act
      final result = await useCase.execute();

      // assert
      expect(result, Right(testData));
      verify(mockRepo.getConfiguration()).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should be return Failure on get configuration', () async {
      // arrange
      when(mockRepo.getConfiguration()).thenAnswer((_) async => Left(failure));

      // act
      final result = await useCase.execute();

      // assert
      expect(result, Left(failure));
      verify(mockRepo.getConfiguration()).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });
}
