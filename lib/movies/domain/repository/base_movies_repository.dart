import 'package:dartz/dartz.dart';
import 'package:movies_app/movies/domain/entities/movie_details.dart';
import 'package:movies_app/movies/domain/entities/reviews.dart';
import 'package:movies_app/movies/domain/entities/trailer.dart';
import 'package:movies_app/movies/domain/usecases/get_movie_detail_usecase.dart';

import '../../../core/error/failure.dart';
import '../entities/movie.dart';
import '../entities/recommendation.dart';
import '../usecases/get_movie_reviews_usecase.dart';
import '../usecases/get_movie_trailer_usecase.dart';
import '../usecases/get_recommendation_movies_usecase.dart';

abstract class BaseMoviesRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

  Future<Either<Failure, List<Movie>>> getTopRatedMovies();

  Future<Either<Failure, List<Movie>>> getPopularMovies();

  Future<Either<Failure, MovieDetail>> getMovieDetail(MovieDetailsParameters parameter);

  Future<Either<Failure, TrailerMovie>> getMovieTrailer(MovieTrailerParameters parameter);

  Future<Either<Failure, List<ReviewsMovie>>> getMovieReviews(MovieReviewsParameters parameter);

  Future<Either<Failure, List<Recommendation>>> getRecommendationMovies(RecommendationParameters parameter);
}
