import 'package:movies_app/tv/domain/entities/tv_series_recommendation.dart';

class TvSeriesRecommendationsModel extends TvSeriesRecommendation{
  const TvSeriesRecommendationsModel({super.backdropPath,required super.id});
  factory TvSeriesRecommendationsModel.fromJson(Map<String,dynamic> json)=>TvSeriesRecommendationsModel(
  id: json["id"],
  backdropPath: json["backdrop_path"] ??json['poster_path']?? '/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg',
  );

}