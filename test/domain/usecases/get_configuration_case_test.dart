import 'package:SiKomik/domain/entities/configuration_entity.dart';
import 'package:SiKomik/domain/usecases/get_configuration_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../repositories/sikomik_repository_test.mocks.dart';

void main() {
  late GetConfigurationCase useCase;
  late MockSiKomikRepository mockRepo;

  setUp(() {
    mockRepo = MockSiKomikRepository();
    useCase = GetConfigurationCase(repository: mockRepo);
  });

  test('should be get configuration', () async {
    // arrange
    final testData = ConfigurationEntity(
        appVersion: "v2.0.0", url: "https://comic.ddg.my.id");
    when(mockRepo.getConfiguration()).thenAnswer((_) async => Right(testData));

    // act
    final result = await useCase.execute();

    // assert
    expect(result, Right(testData));
    verify(mockRepo.getConfiguration()).called(1);
    verifyNoMoreInteractions(mockRepo);
  });
}
