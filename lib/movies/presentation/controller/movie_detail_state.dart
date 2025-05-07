

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/utils/enums.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/recommendation.dart';
import '../../domain/entities/reviews.dart';
import '../../domain/entities/trailer.dart';

@immutable
class MovieDetailState extends Equatable {
  final MovieDetail? movieDetail;
  final RequestState movieDetailsState;
  final String movieDetailsMessage;
  final List<Recommendation> recommendation;
  final RequestState recommendationState;
  final String recommendationMessage;
  final TrailerMovie? trailerMovie;
  final RequestState trailerMovieState;
  final String trailerMovieMessage;
  final List<ReviewsMovie?> reviewsMovie;
  final RequestState reviewsMovieState;
  final String reviewsMovieMessage;
  final String panelState;


  const MovieDetailState(
      {
    this.panelState="close",
      this.reviewsMovie = const [],
      this.reviewsMovieState = RequestState.loading,
      this.reviewsMovieMessage = "",
      this.trailerMovie,
      this.trailerMovieState = RequestState.loading,
      this.trailerMovieMessage = "",
      this.movieDetail,
      this.movieDetailsState = RequestState.loading,
      this.movieDetailsMessage = "",
      this.recommendation = const [],
      this.recommendationState = RequestState.loading,
      this.recommendationMessage = ""});

  MovieDetailState copyWith({
    MovieDetail? movieDetail,
    RequestState? movieDetailsState,
    String? movieDetailsMessage,
    List<Recommendation>? recommendation,
    RequestState? recommendationState,
    String? recommendationMessage,
    TrailerMovie? trailerMovie,
    RequestState? trailerMovieState,
    String? trailerMovieMessage,
    List<ReviewsMovie>? reviewsMovie,
    RequestState? reviewsMovieState,
    String? reviewsMovieMessage,
    String? panelState
  }) {
    return MovieDetailState(
        movieDetail: movieDetail ?? this.movieDetail,
        movieDetailsMessage: movieDetailsMessage ?? this.movieDetailsMessage,
        movieDetailsState: movieDetailsState ?? this.movieDetailsState,
        recommendation: recommendation ?? this.recommendation,
        recommendationMessage:
            recommendationMessage ?? this.recommendationMessage,
        recommendationState: recommendationState ?? this.recommendationState,
        trailerMovie: trailerMovie ?? this.trailerMovie,
        trailerMovieMessage: trailerMovieMessage ?? this.trailerMovieMessage,
        trailerMovieState: trailerMovieState ?? this.trailerMovieState,
        reviewsMovie: reviewsMovie ?? this.reviewsMovie,
        reviewsMovieMessage: reviewsMovieMessage ?? this.reviewsMovieMessage,
        reviewsMovieState: reviewsMovieState ?? this.reviewsMovieState,
    panelState: panelState??this.panelState);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        movieDetail,
        movieDetailsState,
        movieDetailsMessage,
        recommendation,
        recommendationState,
        recommendationMessage,
        trailerMovie,
        trailerMovieMessage,
        trailerMovieState,
        reviewsMovie,
        reviewsMovieMessage,
        reviewsMovieState,
     panelState
      ];
}
