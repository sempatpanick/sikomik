import 'package:SiKomik/common/enums.dart';
import 'package:SiKomik/domain/usecases/authentication_case.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:mockito/mockito.dart';

import '../repositories/sikomik_repository_test.mocks.dart';

void main() {
  late AuthenticationCase useCase;
  late MockSiKomikRepository mockRepo;

  setUp(() {
    mockRepo = MockSiKomikRepository();
    useCase = AuthenticationCase(repository: mockRepo);
  });

  group("should be logged in within the login type", () {
    test('should be logged in with email from the repository', () async {
      final email = "john@example.com";
      final password = "123";
      final name = "John Doe";
      final AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: "123");
      // Sign in.
      final user = MockUser(
        isAnonymous: false,
        uid: "randomUid",
        email: email,
        displayName: name,
      );
      final auth = MockFirebaseAuth(mockUser: user);
      final userCredential = await auth.signInWithCredential(credential);
      // arrange
      when(mockRepo.login(
              type: LoginType.email, email: email, password: password))
          .thenAnswer((_) async => Right(userCredential));

      // act
      final result = await useCase.login(
          type: LoginType.email, email: email, password: password);

      // assert
      expect(result, Right(userCredential));
      verify(mockRepo.login(
              type: LoginType.email, email: email, password: password))
          .called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should be logged in with google from the repository', () async {
      final email = "john@example.com";
      final name = "John Doe";
      final googleSignIn = MockGoogleSignIn();
      final signInAccount = await googleSignIn.signIn();
      final googleAuth = await signInAccount?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Sign in.
      final user = MockUser(
        isAnonymous: false,
        uid: "randomUid",
        email: email,
        displayName: name,
      );
      final auth = MockFirebaseAuth(mockUser: user);
      final userCredential = await auth.signInWithCredential(credential);
      // arrange
      when(mockRepo.login(type: LoginType.google))
          .thenAnswer((_) async => Right(userCredential));

      // act
      final result = await useCase.login(
        type: LoginType.google,
      );

      // assert
      expect(result, Right(userCredential));
      verify(mockRepo.login(
        type: LoginType.google,
      )).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should be logged in with facebook from the repository', () async {
      final email = "john@example.com";
      final name = "John Doe";
      final AuthCredential credential =
          FacebookAuthProvider.credential("accessToken");
      // Sign in.
      final user = MockUser(
        isAnonymous: false,
        uid: "randomUid",
        email: email,
        displayName: name,
      );
      final auth = MockFirebaseAuth(mockUser: user);
      final userCredential = await auth.signInWithCredential(credential);
      // arrange
      when(mockRepo.login(type: LoginType.facebook))
          .thenAnswer((_) async => Right(userCredential));

      // act
      final result = await useCase.login(
        type: LoginType.facebook,
      );

      // assert
      expect(result, Right(userCredential));
      verify(mockRepo.login(
        type: LoginType.facebook,
      )).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });

  test('should be registered using email & password', () async {
    final email = "john@example.com";
    final password = "123";
    final name = "John Doe";
    // Sign in.
    final user = MockUser(
      isAnonymous: false,
      uid: "randomUid",
      email: email,
      displayName: name,
    );
    final auth = MockFirebaseAuth(mockUser: user);
    final userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    // arrange
    when(mockRepo.register(email: email, password: password))
        .thenAnswer((_) async => Right(userCredential));

    // act
    final result = await useCase.register(email: email, password: password);

    // assert
    expect(result, Right(userCredential));
    verify(mockRepo.register(email: email, password: password)).called(1);
    verifyNoMoreInteractions(mockRepo);
  });

  test('should be get the user', () async {
    final email = "john@example.com";
    final name = "John Doe";
    final user = MockUser(
      isAnonymous: false,
      uid: "randomUid",
      email: email,
      displayName: name,
    );
    // arrange
    when(mockRepo.getUser()).thenAnswer((_) async => Right(user));

    // act
    final result = await useCase.getUser();

    // assert
    expect(result, Right(user));
    verify(mockRepo.getUser()).called(1);
    verifyNoMoreInteractions(mockRepo);
  });

  // test('should be stream the user', () async {
  //   final email = "john@example.com";
  //   final name = "John Doe";
  //   final user = MockUser(
  //     isAnonymous: false,
  //     uid: "randomUid",
  //     email: email,
  //     displayName: name,
  //   ) as User?;
  //   // arrange
  //   when(mockRepo.streamUser())
  //       .thenAnswer((_) async => Right(Stream.value(user)));
  //
  //   // act
  //   final result = await useCase.streamUser();
  //
  //   // assert
  //   expect(result, Right(Stream.value(user)));
  //   verify(mockRepo.streamUser()).called(1);
  //   verifyNoMoreInteractions(mockRepo);
  // });
}
