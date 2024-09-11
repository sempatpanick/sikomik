import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import '../../common/const.dart';
import '../../common/failure.dart';
import '../models/chapter_model.dart';
import '../models/comic_detail_model.dart';
import '../models/comic_model.dart';
import '../models/configuration_model.dart';

abstract class SiKomikRemoteDataSource {
  Future<ConfigurationModel> getConfiguration();
  Future<ComicModel> getLatestComic({
    required int page,
    String? q,
  });
  Future<ComicDetailModel> getComicDetail({
    required String path,
  });
  Future<ChapterModel> getChapter({
    required String path,
  });
}

class SiKomikRemoteDataSourceImpl implements SiKomikRemoteDataSource {
  static const url = baseUrl;

  final http.Client client;

  SiKomikRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<ConfigurationModel> getConfiguration() async {
    final retryClient = RetryClient(client);

    final response = await retryClient.get(
      Uri.parse("$url/configuration"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Access_Control_Allow_Origin": "*",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ConfigurationModel.fromJson(json.decode(response.body));
    } else {
      throw ResponseFailure(
        'Error get configuration',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<ComicModel> getLatestComic({required int page, String? q}) async {
    final retryClient = RetryClient(client);

    final response = await retryClient.get(
      Uri.parse("$url/newest/page/$page"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Access_Control_Allow_Origin": "*",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ComicModel.fromJson(json.decode(response.body));
    } else {
      throw ResponseFailure(
        'Error get comic list',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<ComicDetailModel> getComicDetail({required String path}) async {
    final retryClient = RetryClient(client);

    final response = await retryClient.get(
      Uri.parse("$url$path"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Access_Control_Allow_Origin": "*",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ComicDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ResponseFailure(
        'Error get comic detail',
        statusCode: response.statusCode,
      );
    }
  }

  @override
  Future<ChapterModel> getChapter({required String path}) async {
    final retryClient = RetryClient(client);

    final response = await retryClient.get(
      Uri.parse("$url$path"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Access_Control_Allow_Origin": "*",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ChapterModel.fromJson(json.decode(response.body));
    } else {
      throw ResponseFailure(
        'Error get chapter',
        statusCode: response.statusCode,
      );
    }
  }
}
