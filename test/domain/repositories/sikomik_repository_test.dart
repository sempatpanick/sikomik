import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:si_komik/common/failure.dart';
import 'package:si_komik/data/models/configuration_model.dart';
import 'package:si_komik/data/repositories/sikomik_repository_impl.dart';
import 'package:si_komik/domain/entities/configuration_entity.dart';
import 'package:si_komik/domain/repositories/sikomik_repository.dart';

import '../../data/datasources/sikomik_firebase_auth_data_source_test.mocks.dart';
import '../../data/datasources/sikomik_firebase_firestore_data_source_test.mocks.dart';
import '../../data/datasources/sikomik_remote_data_source_test.mocks.dart';

@GenerateMocks([SiKomikRepository])
void main() {
  late SiKomikRepositoryImpl repo;
  late MockSiKomikRemoteDataSource mockRemote;
  late MockSiKomikFirebaseAuthDataSource mockFirebaseAuth;
  late MockSiKomikFirebaseFirestoreDataSource mockFirebaseFirestore;

  setUp(() {
    mockRemote = MockSiKomikRemoteDataSource();
    mockFirebaseAuth = MockSiKomikFirebaseAuthDataSource();
    mockFirebaseFirestore = MockSiKomikFirebaseFirestoreDataSource();
    repo = SiKomikRepositoryImpl(
        remoteDataSource: mockRemote,
        firebaseAuthDataSource: mockFirebaseAuth,
        firebaseFirestoreDataSource: mockFirebaseFirestore);
  });

  group("get configuration", () {
    test('should return Configuration when remote call is successful',
        () async {
      final testData =
          ConfigurationModel(appVersion: "v1.0.0", url: "https://ddg.my.id");
      final testDataEntity =
          ConfigurationEntity(appVersion: "v1.0.0", url: "https://ddg.my.id");
      when(mockRemote.getConfiguration()).thenAnswer((_) async => testData);

      final result = await repo.getConfiguration();

      expect(result, Right(testDataEntity));
      verify(mockRemote.getConfiguration()).called(1);
      verifyNoMoreInteractions(mockRemote);
    });

    test('should return Failure when remote call is failed', () async {
      final failure = ResponseFailure("Invalid response");
      when(mockRemote.getConfiguration()).thenThrow(failure);

      final result = await repo.getConfiguration();

      expect(result, Left(failure));
      verify(mockRemote.getConfiguration()).called(1);
      verifyNoMoreInteractions(mockRemote);
    });
  });
}
