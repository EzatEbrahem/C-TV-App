import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/domain/entities/movie_details.dart';
import 'package:movies_app/movies/domain/entities/recommendation.dart';
import 'package:movies_app/movies/domain/entities/reviews.dart';
import 'package:movies_app/movies/domain/entities/trailer.dart';
import 'package:movies_app/movies/domain/usecases/get_movie_detail_usecase.dart';
import 'package:movies_app/movies/domain/usecases/get_movie_reviews_usecase.dart';
import 'package:movies_app/movies/domain/usecases/get_movie_trailer_usecase.dart';
import 'package:movies_app/movies/domain/usecases/get_recommendation_movies_usecase.dart';

import '../../../core/error/exceptions.dart';
import '../../domain/repository/base_movies_repository.dart';

import '../datasource/movie_remote_data_source.dart';


class MoviesRepository extends BaseMoviesRepository {
  final BaseMovieRemoteDataSource baseMovieRemoteDataSource;


   MoviesRepository(this.baseMovieRemoteDataSource);

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies()async {
    final result= await baseMovieRemoteDataSource.getNowPlayingMovies();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies()  async {
    final result = await baseMovieRemoteDataSource.getPopularMovies();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>>getTopRatedMovies()  async {
    final result = await baseMovieRemoteDataSource.getTopRatedMovies();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(MovieDetailsParameters parameter) async {
    final result = await baseMovieRemoteDataSource.getMovieDetails(parameter);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Recommendation>>> getRecommendationMovies(RecommendationParameters parameter) async {
    final result = await baseMovieRemoteDataSource.getRecommendationMovies(parameter);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, TrailerMovie>> getMovieTrailer(MovieTrailerParameters parameter) async{
    final result=await baseMovieRemoteDataSource.getMovieTrailer(parameter);
    try {
      return Right(result);
    } on ServerException catch (failure) {
    return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<ReviewsMovie>>> getMovieReviews(MovieReviewsParameters parameter) async {
    final result = await baseMovieRemoteDataSource.getMovieReviews(parameter);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

}