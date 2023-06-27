import 'package:equatable/equatable.dart';

import '../../data/models/chapter_model.dart';

class ChapterEntity extends Equatable {
  final bool status;
  final DataChapterEntity data;

  const ChapterEntity({
    required this.status,
    required this.data,
  });

  ChapterModel toModel() => ChapterModel(
        status: status,
        data: data.toModel(),
      );

  @override
  List<Object?> get props => [
        status,
        data,
      ];
}

class DataChapterEntity extends Equatable {
  final List<String> images;
  final String? previousChapterPath;
  final String? nextChapterPath;

  const DataChapterEntity({
    required this.images,
    this.previousChapterPath,
    this.nextChapterPath,
  });

  DataChapterModel toModel() => DataChapterModel(
        images: images,
        previousChapterPath: previousChapterPath,
        nextChapterPath: nextChapterPath,
      );

  @override
  List<Object?> get props => [
        images,
        previousChapterPath,
        nextChapterPath,
      ];
}
