import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sikomik/common/failure.dart';
import 'package:sikomik/domain/entities/configuration_entity.dart';
import 'package:sikomik/domain/entities/manga_entity.dart';

import '../../common/exception.dart';
import '../../domain/entities/chapter_entity.dart';
import '../../domain/entities/manga_detail_entity.dart';
import '../../domain/repositories/sikomik_repository.dart';
import '../datasources/sikomik_remote_data_source.dart';

class SiKomikRepositoryImpl implements SiKomikRepository {
  final SiKomikRemoteDataSource remoteDataSource;

  SiKomikRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, ConfigurationEntity>> getConfiguration() async {
    try {
      final result = await remoteDataSource.getConfiguration();

      return Right(result.toEntity());
    } on ResponseFailure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MangaEntity>> getLatestManga({
    required int page,
    String? q,
  }) async {
    try {
      final result = await remoteDataSource.getLatestManga(page: page, q: q);

      return Right(result.toEntity());
    } on ResponseFailure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MangaDetailEntity>> getMangaDetail({required String path}) async {
    try {
      final result = await remoteDataSource.getMangaDetail(path: path);

      return Right(result.toEntity());
    } on ResponseFailure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChapterEntity>> getChapter({required String path}) async {
    try {
      final result = await remoteDataSource.getChapter(path: path);

      return Right(result.toEntity());
    } on ResponseFailure catch (e) {
      return Left(e);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
