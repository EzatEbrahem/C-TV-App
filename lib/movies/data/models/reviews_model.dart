import 'package:movies_app/movies/data/models/author_details_model.dart';

import '../../domain/entities/reviews.dart';

class ReviewsMovieModel extends ReviewsMovie {
  const ReviewsMovieModel(
      {super.authorDetails,
      required super.author,
      required super.content,
      required super.createdAt,
      required super.id});

  factory ReviewsMovieModel.fromJson(Map<String, dynamic> json) =>
      ReviewsMovieModel(
          authorDetails: AuthorDetailsModel.fromJson(json["author_details"]),
          author: json["author"],
          content: json["content"],
          createdAt: json["created_at"],
          id: json["id"]);
}
