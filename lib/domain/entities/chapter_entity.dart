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
  final String? title;
  final int? chapter;
  final String? uploadedDate;
  final List<String>? images;

  const DataChapterEntity({
    required this.title,
    required this.chapter,
    required this.uploadedDate,
    required this.images,
  });

  DataChapterModel toModel() => DataChapterModel(
        title: title,
        chapter: chapter,
        uploadedDate: uploadedDate,
        images: images,
      );

  @override
  List<Object?> get props => [
        title,
        chapter,
        uploadedDate,
        images,
      ];
}
