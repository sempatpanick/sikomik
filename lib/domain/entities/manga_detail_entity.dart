import 'package:equatable/equatable.dart';

import '../../data/models/manga_detail_model.dart';

class MangaDetailEntity extends Equatable {
  final bool status;
  final DataMangaDetailEntity data;

  const MangaDetailEntity({
    required this.status,
    required this.data,
  });

  MangaDetailModel toModel() => MangaDetailModel(
        status: status,
        data: data.toModel(),
      );

  @override
  List<Object?> get props => [
        status,
        data,
      ];
}

class DataMangaDetailEntity extends Equatable {
  final String title;
  final String? description;
  final num rating;
  final List<List<String>> informations;
  final List<GenreDataMangaDetailEntity> genres;
  final List<ChapterDataMangaDetailEntity> chapters;
  final String imagePath;

  const DataMangaDetailEntity({
    required this.title,
    this.description,
    required this.rating,
    required this.informations,
    required this.genres,
    required this.chapters,
    required this.imagePath,
  });

  DataMangaDetailModel toModel() => DataMangaDetailModel(
        title: title,
        description: description,
        rating: rating,
        informations: informations,
        genres: genres.map((item) => item.toModel()).toList(),
        chapters: chapters.map((item) => item.toModel()).toList(),
        imagePath: imagePath,
      );

  @override
  List<Object?> get props => [
        title,
        description,
        rating,
        informations,
        imagePath,
      ];
}

class GenreDataMangaDetailEntity extends Equatable {
  final String name;
  final String path;

  const GenreDataMangaDetailEntity({
    required this.name,
    required this.path,
  });

  GenreDataMangaDetailModel toModel() => GenreDataMangaDetailModel(
        name: name,
        path: path,
      );

  @override
  List<Object?> get props => [
        name,
        path,
      ];
}

class ChapterDataMangaDetailEntity extends Equatable {
  final num chapter;
  final String uploadAt;
  final String path;

  const ChapterDataMangaDetailEntity({
    required this.chapter,
    required this.uploadAt,
    required this.path,
  });

  ChapterDataMangaDetailModel toModel() => ChapterDataMangaDetailModel(
        chapter: chapter,
        uploadAt: uploadAt,
        path: path,
      );

  @override
  List<Object?> get props => [
        chapter,
        uploadAt,
        path,
      ];
}
