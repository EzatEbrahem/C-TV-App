import 'package:equatable/equatable.dart';
import 'package:movies_app/movies/domain/entities/author_details.dart';

class ReviewsMovie extends Equatable {
  final String author;
  final String content;
  final String createdAt;
  final String id;
  final AuthorDetails? authorDetails;

  const ReviewsMovie(
      {required this.author,
      required this.content,
      required this.createdAt,
      required this.id,
      this.authorDetails});

  @override
  // TODO: implement props
  List<Object?> get props => [author, content, createdAt, id];
}
