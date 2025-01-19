import 'package:equatable/equatable.dart';

import '../../data/models/chapter_model.dart';

class ChapterEntity extends Equatable {
  final bool? status;
  final DataChapterEntity? data;

  const ChapterEntity({
    required this.status,
    required this.data,
  });

  ChapterModel toModel() => ChapterModel(
        status: status,
        data: data?.toModel(),
      );

  @override
  List<Object?> get props => [
        status,
        data,
      ];
}

class DataChapterEntity extends Equatable {
  final String? path;
  final String? title;
  final String? comicPath;
  final num? chapter;
  final String? uploadedDate;
  final List<String>? images;

  const DataChapterEntity({
    required this.path,
    required this.title,
    required this.comicPath,
    required this.chapter,
    required this.uploadedDate,
    required this.images,
  });

  DataChapterModel toModel() => DataChapterModel(
        path: path,
        title: title,
        comicPath: comicPath,
        chapter: chapter,
        uploadedDate: uploadedDate,
        images: images,
      );

  @override
  List<Object?> get props => [
        path,
        title,
        comicPath,
        chapter,
        uploadedDate,
        images,
      ];
}
