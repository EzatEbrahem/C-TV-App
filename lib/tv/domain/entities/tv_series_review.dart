import 'package:equatable/equatable.dart';
import 'package:movies_app/tv/domain/entities/tv_series_review_author_details.dart';



class TvSeriesReview extends Equatable {
  final String author;
  final String content;
  final String createdAt;
  final String id;
  final TvSeriesReviewAuthorDetails tvSeriesReviewAuthorDetails;

  const TvSeriesReview(
      {required this.author,
      required this.content,
      required this.createdAt,
      required this.id,
      required this.tvSeriesReviewAuthorDetails});

  @override
// TODO: implement props
  List<Object?> get props => [author, content, createdAt, id,tvSeriesReviewAuthorDetails];
}
