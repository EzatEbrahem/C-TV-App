import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/movies/domain/entities/reviews.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

import '../../../core/usecase/base_usecase.dart';

class GetMovieReviewsUseCase extends BaseUseCase<List<ReviewsMovie>,MovieReviewsParameters>{
  final BaseMoviesRepository baseMoviesRepository;

  GetMovieReviewsUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, List<ReviewsMovie>>> call(parameters) async{
    return await baseMoviesRepository.getMovieReviews(parameters);
  }

}

class MovieReviewsParameters extends Equatable {
  final int movieId;

  const MovieReviewsParameters({required this.movieId});

  @override
  List<Object> get props => [movieId];
}