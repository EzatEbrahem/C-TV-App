import 'package:movies_app/tv/data/models/tv_series_review_author_model.dart';
import 'package:movies_app/tv/domain/entities/tv_series_review.dart';


class TvSeriesReviewModel extends TvSeriesReview{
  const TvSeriesReviewModel(
      {
        required super.author,
        required super.content,
        required super.createdAt,
        required super.id,
        required super.tvSeriesReviewAuthorDetails
      });

  factory TvSeriesReviewModel.fromJson(Map<String,dynamic> json)=>
      TvSeriesReviewModel(
          author: json["author"],
          content: json["content"],
          createdAt: json["created_at"],
          id: json["id"],
        tvSeriesReviewAuthorDetails: TvSeriesReviewAuthorDetailsModel.fromJson(json["author_details"]),
      );
}