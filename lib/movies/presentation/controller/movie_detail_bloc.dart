
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/movies/domain/entities/reviews.dart';
import 'package:movies_app/movies/domain/entities/trailer.dart';
import 'package:movies_app/movies/domain/usecases/get_recommendation_movies_usecase.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../core/utils/enums.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/recommendation.dart';
import '../../domain/usecases/get_movie_detail_usecase.dart';
import '../../domain/usecases/get_movie_reviews_usecase.dart';
import '../../domain/usecases/get_movie_trailer_usecase.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetailUseCase getMovieDetailUseCase;
  final GetRecommendationUseCase getRecommendationUseCase;
  final GetMovieTrailerUseCase getMovieTrailerUseCase;
  final GetMovieReviewsUseCase getMovieReviewsUseCase;

  MovieDetailBloc(
      this.getMovieDetailUseCase,
      this.getRecommendationUseCase,
      this.getMovieTrailerUseCase,
      this.getMovieReviewsUseCase)
      : super(const MovieDetailState()) {
    on<GetMovieDetailEvent>((event, emit) async {
      final result = await getMovieDetailUseCase(
          MovieDetailsParameters(movieId: event.id));
      result.fold(
          (l) => emit(state.copyWith(
              movieDetailsState: RequestState.error,
              movieDetailsMessage: l.message)),
          (r) => emit(state.copyWith(
              movieDetailsState: RequestState.loaded, movieDetail: r)));
    });
    on<GetRecommendationMoviesEvent>((event, emit) async {
      final result =
          await getRecommendationUseCase(RecommendationParameters(event.id));
      result.fold(
          (l) => emit(state.copyWith(
              recommendationState: RequestState.error,
              recommendationMessage: l.message)),
          (r) => emit(state.copyWith(
              recommendationState: RequestState.loaded, recommendation: r)));
    });

    on<GetTrailerMoviesEvent>((event, emit) async {
      final result =
      await getMovieTrailerUseCase(MovieTrailerParameters(movieId: event.id));
      result.fold(
              (l) => emit(state.copyWith(
              trailerMovieState: RequestState.error,
              trailerMovieMessage: l.message,)),
              (r) => emit(state.copyWith(
              trailerMovieState: RequestState.loaded, trailerMovie: r)));
    });
    on<GetReviewsMoviesEvent>((event, emit) async {
      final result =
      await getMovieReviewsUseCase(MovieReviewsParameters(movieId: event.id));
      result.fold(
              (l) => emit(state.copyWith(
            reviewsMovieState: RequestState.error,
            reviewsMovieMessage: l.message,)),
              (r) => emit(state.copyWith(
              reviewsMovieState: RequestState.loaded, reviewsMovie: r)));
    });
    on<ChangePanelEvent>((event, emit)  {
      if(event.panelController.isPanelOpen){
        event.panelController.close();
        emit(state.copyWith(panelState: "close"));
      }else{
        event.panelController.open();
        emit(state.copyWith(panelState: "open"));
      }

    });
  }
}
