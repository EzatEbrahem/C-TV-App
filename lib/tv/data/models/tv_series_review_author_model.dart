import 'package:movies_app/tv/domain/entities/tv_series_review_author_details.dart';

class TvSeriesReviewAuthorDetailsModel extends TvSeriesReviewAuthorDetails{
  const TvSeriesReviewAuthorDetailsModel({ super.avatarPath, required super.rating});
  factory TvSeriesReviewAuthorDetailsModel.fromJson(Map<String,dynamic> json)=>
      TvSeriesReviewAuthorDetailsModel(
          avatarPath: json["avatar_path"]??"/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg",
          rating: json["rating"]
      );

}