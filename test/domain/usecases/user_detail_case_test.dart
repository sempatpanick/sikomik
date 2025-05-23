import 'package:SiKomik/domain/entities/user_entity.dart';
import 'package:SiKomik/domain/usecases/user_detail_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../repositories/sikomik_repository_test.mocks.dart';

void main() {
  late UserDetailCase useCase;
  late MockSiKomikRepository mockRepo;

  setUp(() {
    mockRepo = MockSiKomikRepository();
    useCase = UserDetailCase(repository: mockRepo);
  });

  test('should be set user comic chapters', () async {
    // arrange
    final testData = UserEntity();
    when(mockRepo.setUser(user: testData))
        .thenAnswer((_) async => Right(testData));

    // act
    final result = await useCase.setUser(user: testData);

    // assert
    expect(result, Right(testData));
    verify(mockRepo.setUser(user: testData)).called(1);
    verifyNoMoreInteractions(mockRepo);
  });

  test('should be get user comic chapters', () async {
    // arrange
    final testData = UserEntity();
    when(mockRepo.getUserDetail(userId: "1"))
        .thenAnswer((_) async => Right(testData));

    // act
    final result = await useCase.getUserDetail(userId: "1");

    // assert
    expect(result, Right(testData));
    verify(mockRepo.getUserDetail(userId: "1")).called(1);
    verifyNoMoreInteractions(mockRepo);
  });
}
