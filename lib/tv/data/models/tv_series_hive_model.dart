import 'package:hive/hive.dart';

import 'package:movies_app/tv/domain/entities/tv_series.dart';

part 'tv_series_hive_model.g.dart';

@HiveType(typeId: 2)
class TvSeriesHiveModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? backdropPath;

  @HiveField(3)
  final List<int> genreIds;

  @HiveField(4)
  final String overview;

  @HiveField(5)
  final double voteAverage;

  @HiveField(6)
  final String firstAirDate;

  TvSeriesHiveModel({
    required this.id,
    required this.name,
    this.backdropPath,
    required this.genreIds,
    required this.overview,
    required this.voteAverage,
    required this.firstAirDate,
  });


  factory TvSeriesHiveModel.fromEntity(TvSeries tvSeries) => TvSeriesHiveModel(
    id: tvSeries.id,
    name: tvSeries.name,
    backdropPath: tvSeries.backdropPath,
    genreIds: tvSeries.genreIds,
    overview: tvSeries.overview,
    voteAverage: tvSeries.voteAverage,
    firstAirDate: tvSeries.firstAirDate,
  );


  TvSeries toEntity() => TvSeries(
    id: id,
    name: name,
    backdropPath: backdropPath!,
    genreIds: genreIds,
    overview: overview,
    voteAverage: voteAverage,
    firstAirDate: firstAirDate,
  );
}
