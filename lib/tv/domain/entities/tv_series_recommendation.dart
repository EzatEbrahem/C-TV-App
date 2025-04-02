
import 'package:equatable/equatable.dart';

class TvSeriesRecommendation extends Equatable {
  final String? backdropPath;
  final int id;

  const TvSeriesRecommendation({this.backdropPath, required this.id});

  @override
  List<Object?> get props => [backdropPath, id];
}