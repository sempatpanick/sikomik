import 'package:SiKomik/common/enums.dart';
import 'package:SiKomik/common/failure.dart';
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

  final email = "john@example.com";
  final password = "123";
  final name = "John Doe";
  final failure = ResponseFailure('Invalid credentials');

  setUp(() {
    mockRepo = MockSiKomikRepository();
    useCase = AuthenticationCase(repository: mockRepo);
  });

  group("login test within the type", () {
    group("login with email", () {
      test('should be return User successfully on login with email', () async {
        final AuthCredential credential =
            EmailAuthProvider.credential(email: email, password: password);
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

      test('should be return Failure on login with email', () async {
        // arrange
        when(mockRepo.login(
                type: LoginType.email, email: email, password: password))
            .thenAnswer((_) async => Left(failure));

        // act
        final result = await useCase.login(
            type: LoginType.email, email: email, password: password);

        // assert
        expect(result, Left(failure));
        verify(mockRepo.login(
                type: LoginType.email, email: email, password: password))
            .called(1);
        verifyNoMoreInteractions(mockRepo);
      });
    });

    group("login with google", () {
      test('should be return User successfully on login with google', () async {
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

      test('should be return Failure on login with google', () async {
        // arrange
        when(mockRepo.login(type: LoginType.google))
            .thenAnswer((_) async => Left(failure));

        // act
        final result = await useCase.login(
          type: LoginType.google,
        );

        // assert
        expect(result, Left(failure));
        verify(mockRepo.login(
          type: LoginType.google,
        )).called(1);
        verifyNoMoreInteractions(mockRepo);
      });
    });

    group("login with facebook", () {
      test('should be return User successfully on login with facebook',
          () async {
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

      test('should be return Failure on login with facebook', () async {
        // arrange
        when(mockRepo.login(type: LoginType.facebook))
            .thenAnswer((_) async => Left(failure));

        // act
        final result = await useCase.login(
          type: LoginType.facebook,
        );

        // assert
        expect(result, Left(failure));
        verify(mockRepo.login(
          type: LoginType.facebook,
        )).called(1);
        verifyNoMoreInteractions(mockRepo);
      });
    });
  });

  group("register with email", () {
    test('should be return User successfully on register with email', () async {
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

    test('should be return Failure on register with email', () async {
      // arrange
      when(mockRepo.register(email: email, password: password))
          .thenAnswer((_) async => Left(failure));

      // act
      final result = await useCase.register(email: email, password: password);

      // assert
      expect(result, Left(failure));
      verify(mockRepo.register(email: email, password: password)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });

  group("get user", () {
    test('should be return User successfully on get user', () async {
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

    test('should be return Failure on get user', () async {
      // arrange
      when(mockRepo.getUser()).thenAnswer((_) async => Left(failure));

      // act
      final result = await useCase.getUser();

      // assert
      expect(result, Left(failure));
      verify(mockRepo.getUser()).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
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
