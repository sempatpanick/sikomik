import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:si_komik/common/failure.dart';
import 'package:si_komik/domain/entities/user_entity.dart';
import 'package:si_komik/domain/usecases/user_detail_case.dart';

import '../repositories/sikomik_repository_test.mocks.dart';

void main() {
  late UserDetailCase useCase;
  late MockSiKomikRepository mockRepo;

  final failure = ResponseFailure('Invalid credentials');

  setUp(() {
    mockRepo = MockSiKomikRepository();
    useCase = UserDetailCase(repository: mockRepo);
  });

  group("set user comic chapters", () {
    test(
        'should be return User Comic Chapters successfully on set user comic chapters',
        () async {
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

    test('should be return Failed on set user comic chapters', () async {
      // arrange
      final testData = UserEntity();
      when(mockRepo.setUser(user: testData))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await useCase.setUser(user: testData);

      // assert
      expect(result, Left(failure));
      verify(mockRepo.setUser(user: testData)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });

  group("get user comic chapters", () {
    test(
        'should be return User Comic Chapters successfully on get user comic chapters',
        () async {
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

    test('should be get user comic chapters', () async {
      // arrange
      when(mockRepo.getUserDetail(userId: "1"))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await useCase.getUserDetail(userId: "1");

      // assert
      expect(result, Left(failure));
      verify(mockRepo.getUserDetail(userId: "1")).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });
}
