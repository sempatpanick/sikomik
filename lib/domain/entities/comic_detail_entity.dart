import 'package:equatable/equatable.dart';

import '../../data/models/comic_detail_model.dart';

class ComicDetailEntity extends Equatable {
  final bool? status;
  final DataComicDetailEntity? data;

  const ComicDetailEntity({
    required this.status,
    required this.data,
  });

  ComicDetailModel toModel() => ComicDetailModel(
        status: status,
        data: data?.toModel(),
      );

  @override
  List<Object?> get props => [
        status,
        data,
      ];
}

class DataComicDetailEntity extends Equatable {
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
  final List<GenreDataComicDetailEntity>? genres;
  final List<ChapterDataComicDetailEntity>? chapters;

  const DataComicDetailEntity({
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

  DataComicDetailModel toModel() => DataComicDetailModel(
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

class GenreDataComicDetailEntity extends Equatable {
  final String? name;
  final String? path;

  const GenreDataComicDetailEntity({
    required this.name,
    required this.path,
  });

  GenreDataComicDetailModel toModel() => GenreDataComicDetailModel(
        name: name,
        path: path,
      );

  @override
  List<Object?> get props => [
        name,
        path,
      ];
}

class ChapterDataComicDetailEntity extends Equatable {
  final String? name;
  final num? chapter;
  final String? uploadedDate;
  final String? path;

  const ChapterDataComicDetailEntity({
    required this.name,
    required this.chapter,
    required this.uploadedDate,
    required this.path,
  });

  ChapterDataComicDetailModel toModel() => ChapterDataComicDetailModel(
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
