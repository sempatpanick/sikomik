import 'package:equatable/equatable.dart';

import '../../data/models/manga_detail_model.dart';

class MangaDetailEntity extends Equatable {
  final bool? status;
  final DataMangaDetailEntity? data;

  const MangaDetailEntity({
    required this.status,
    required this.data,
  });

  MangaDetailModel toModel() => MangaDetailModel(
        status: status,
        data: data?.toModel(),
      );

  @override
  List<Object?> get props => [
        status,
        data,
      ];
}

class DataMangaDetailEntity extends Equatable {
  final String? title;
  final String? titleIndonesia;
  final String? imageUrl;
  final String? thumbnailUrl;
  final String? synopsis;
  final String? type;
  final String? storyConcept;
  final String? author;
  final String? status;
  final num? rating;
  final List<GenreDataMangaDetailEntity>? genres;
  final List<ChapterDataMangaDetailEntity>? chapters;

  const DataMangaDetailEntity({
    required this.title,
    required this.titleIndonesia,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.synopsis,
    required this.type,
    required this.storyConcept,
    required this.author,
    required this.status,
    required this.rating,
    required this.genres,
    required this.chapters,
  });

  DataMangaDetailModel toModel() => DataMangaDetailModel(
        title: title,
        titleIndonesia: titleIndonesia,
        imageUrl: imageUrl,
        thumbnailUrl: thumbnailUrl,
        synopsis: synopsis,
        type: type,
        storyConcept: storyConcept,
        author: author,
        status: status,
        rating: rating,
        genres: genres?.map((item) => item.toModel()).toList(),
        chapters: chapters?.map((item) => item.toModel()).toList(),
      );

  @override
  List<Object?> get props => [
        title,
        titleIndonesia,
        imageUrl,
        thumbnailUrl,
        synopsis,
        type,
        storyConcept,
        author,
        status,
        rating,
        genres,
        chapters,
      ];
}

class GenreDataMangaDetailEntity extends Equatable {
  final String? name;
  final String? path;

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
  final String? name;
  final num? chapter;
  final String? uploadedDate;
  final String? path;

  const ChapterDataMangaDetailEntity({
    required this.name,
    required this.chapter,
    required this.uploadedDate,
    required this.path,
  });

  ChapterDataMangaDetailModel toModel() => ChapterDataMangaDetailModel(
        name: name,
        chapter: chapter,
        uploadedDate: uploadedDate,
        path: path,
      );

  @override
  List<Object?> get props => [
        name,
        chapter,
        uploadedDate,
        path,
      ];
}
