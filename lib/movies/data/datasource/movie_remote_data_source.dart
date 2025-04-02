
import 'package:dio/dio.dart';
import 'package:movies_app/core/error/error_message_model.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/network/api_constance.dart';
import 'package:movies_app/movies/data/models/movie_details_model.dart';
import 'package:movies_app/movies/data/models/recommendation_model.dart';
import 'package:movies_app/movies/data/models/reviews_model.dart';
import 'package:movies_app/movies/data/models/trailer_model.dart';

import 'package:movies_app/movies/domain/usecases/get_movie_detail_usecase.dart';
import 'package:movies_app/movies/domain/usecases/get_recommendation_movies_usecase.dart';

import '../../domain/usecases/get_movie_reviews_usecase.dart';
import '../../domain/usecases/get_movie_trailer_usecase.dart';
import '../models/movie_model.dart';

abstract class BaseMovieRemoteDataSource {

  Future<List<MovieModel>> getNowPlayingMovies();

  Future<List<MovieModel>> getPopularMovies();

  Future<List<MovieModel>> getTopRatedMovies();

  Future<MovieDetailsModel> getMovieDetails(MovieDetailsParameters parameters);

  Future<List<RecommendationModel>> getRecommendationMovies(RecommendationParameters parameters);

  Future<TrailerModel> getMovieTrailer(MovieTrailerParameters parameters);

  Future<List<ReviewsMovieModel>> getMovieReviews(MovieReviewsParameters parameters);
}

class MovieRemoteDataSource extends BaseMovieRemoteDataSource {
  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await Dio().get(ApiConstance.nowPlayingMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
          response.data["results"].map((e) => MovieModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await Dio().get(ApiConstance.popularMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
          response.data["results"].map((e) => MovieModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await Dio().get(ApiConstance.topRatedMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from(
          response.data["results"].map((e) => MovieModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(
      MovieDetailsParameters parameters) async {
    final response =
    await Dio().get(ApiConstance.movieDetailsPath(parameters.movieId));
    if (response.statusCode == 200) {
      return MovieDetailsModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<RecommendationModel>> getRecommendationMovies(
      RecommendationParameters parameters) async {
    final response =
    await Dio().get(ApiConstance.recommendationPath(parameters.id));
    if (response.statusCode == 200) {
      return List<RecommendationModel>.from((response.data["results"])
          .map((e) => RecommendationModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<TrailerModel> getMovieTrailer(
      MovieTrailerParameters parameters) async {
    final response = await Dio().get(
        ApiConstance.movieTrailerPath(parameters.movieId));
    if (response.statusCode == 200) {
      final l1 = List<TrailerModel>.from(
          (response.data["results"]).map((e) => TrailerModel.fromJson(e)));
      for (var v in l1) {
        if (v.name == "Official Trailer") {
          return v;
        }
      }
      return const TrailerModel(name: "",
          key: "",
          site: "",
          type: "",
          id: "");
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<ReviewsMovieModel>> getMovieReviews(
      MovieReviewsParameters parameters) async {
    final response = await Dio().get(
        ApiConstance.movieReviewsPath(parameters.movieId));
    if (response.statusCode == 200) {
      return List<ReviewsMovieModel>.from((response.data["results"])
          .map((e) => ReviewsMovieModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }
}