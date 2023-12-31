import 'package:equatable/equatable.dart';

import '../../data/models/manga_model.dart';

class MangaEntity extends Equatable {
  final bool status;
  final int page;
  final int maxPage;
  final List<DataMangaEntity> data;

  const MangaEntity({
    required this.status,
    required this.page,
    required this.maxPage,
    required this.data,
  });

  MangaModel toModel() => MangaModel(
        status: status,
        page: page,
        maxPage: maxPage,
        data: data.map((item) => item.toModel()).toList(),
      );

  @override
  List<Object?> get props => [
        status,
        page,
        maxPage,
        data,
      ];
}

class DataMangaEntity extends Equatable {
  final String title;
  final num chapter;
  final num rating;
  final String imagePath;
  final String path;

  const DataMangaEntity({
    required this.title,
    required this.chapter,
    required this.rating,
    required this.imagePath,
    required this.path,
  });

  DataMangaModel toModel() => DataMangaModel(
        title: title,
        chapter: chapter,
        rating: rating,
        imagePath: imagePath,
        path: path,
      );

  @override
  List<Object?> get props => [
        title,
        chapter,
        rating,
        imagePath,
        path,
      ];
}
