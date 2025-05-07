import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
  final int id;
  final String backdropPath;
  final List<int> genreIds;
  final String name;
  final String overview;
  final  String firstAirDate;
  final double voteAverage;

  const TvSeries(
      { required this.id,
        required this.backdropPath,
        required this.genreIds,
        required this.name,
        required this.overview,
        required this.firstAirDate,
        required this.voteAverage
      });

  @override

  List<Object?> get props => [id,backdropPath,genreIds,name,overview,firstAirDate,voteAverage];
}
