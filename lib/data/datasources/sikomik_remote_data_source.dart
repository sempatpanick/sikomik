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
  });
  Future<ComicModel> getPopularComic({
    required int page,
  });
  Future<ComicModel> getMangaComic({
    required int page,
  });
  Future<ComicModel> getManhuaComic({
    required int page,
  });
  Future<ComicModel> getManhwaComic({
    required int page,
  });
  Future<ComicDetailModel> getComicDetail({
    required String path,
  });
  Future<ChapterModel> getChapter({
    required String path,
  });
  Future<ComicModel> searchComic({
    required String query,
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
        "Accept": "*",
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
  Future<ComicModel> getLatestComic({required int page}) async {
    final retryClient = RetryClient(client);

    final response = await retryClient.get(
      Uri.parse("$url/newest/page/$page"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "*",
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
  Future<ComicModel> getPopularComic({required int page}) async {
    final retryClient = RetryClient(client);

    final response = await retryClient.get(
      Uri.parse("$url/popular/page/$page"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "*",
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
  Future<ComicModel> getMangaComic({required int page}) async {
    final retryClient = RetryClient(client);

    final response = await retryClient.get(
      Uri.parse("$url/manga/page/$page"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "*",
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
  Future<ComicModel> getManhuaComic({required int page}) async {
    final retryClient = RetryClient(client);

    final response = await retryClient.get(
      Uri.parse("$url/manhua/page/$page"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "*",
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
  Future<ComicModel> getManhwaComic({required int page}) async {
    final retryClient = RetryClient(client);

    final response = await retryClient.get(
      Uri.parse("$url/manhwa/page/$page"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "*",
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
        "Accept": "*",
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
        "Accept": "*",
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

  @override
  Future<ComicModel> searchComic({required String query}) async {
    final retryClient = RetryClient(client);

    final response = await retryClient.get(
      Uri.parse("$url/search?query=$query"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "*",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ComicModel.fromJson(json.decode(response.body));
    } else {
      throw ResponseFailure(
        'Error search comic',
        statusCode: response.statusCode,
      );
    }
  }
}
