import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/tv/domain/usecases/get_tv_series_episodes_use_case.dart';
import 'package:movies_app/tv/domain/usecases/get_tv_series_recommendations_use_case.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_details_events.dart';
import 'package:movies_app/tv/presentation/controller/tv_series_details_states.dart';
import 'package:movies_app/tv/utils/tv_series_parameter_id.dart';
import '../../domain/usecases/get_tv_series_details_use_case.dart';
import '../../domain/usecases/get_tv_series_reviews_use_case.dart';

class TvSeriesDetailsBloc extends Bloc<TvSeriesDetailsEvent,TvSeriesDetailsState>{
  final GetTvSeriesDetailsUseCase getTvSeriesDetailsUseCase;
  final GetTvSeriesReviewsUseCase getTvSeriesReviewsUseCase;
  final GetTvSeriesRecommendationsUseCase getTvSeriesRecommendationsUseCase;
  final GetTvSeriesEpisodesUseCase getTvSeriesEpisodesUseCase;

  TvSeriesDetailsBloc(
      this.getTvSeriesDetailsUseCase,
      this.getTvSeriesReviewsUseCase,
      this.getTvSeriesRecommendationsUseCase, this.getTvSeriesEpisodesUseCase):super(const TvSeriesDetailsState()){

    on<GetTvSeriesDetailsEvent> (_getTvSeriesDetails);
    on<GetTvSeriesReviewsEvent> (_getTvSeriesReviews);
    on<GetTvSeriesRecommendationsEvent> (_getTvSeriesRecommendations);
    on<NavigateBetweenListEvent>(_navigateList);
    on<GetTvSeriesEpisodeEvent>(_getTvSeriesEpisodeEvent);
  }



  FutureOr<void> _getTvSeriesDetails(GetTvSeriesDetailsEvent event, Emitter<TvSeriesDetailsState> emit) async{
    final result= await getTvSeriesDetailsUseCase( TvSeriesIdParameter(tvSeriesId: event.tvSeriesIdParameter.tvSeriesId));
    result.fold((l) => emit(
        state.copyWith(
            tvSeriesDetailsState: RequestState.error,
            tvSeriesDetailsMessage: l.message)
    ),
            (r) => emit(
              state.copyWith(
                tvSeriesDetails: r,
                tvSeriesDetailsState: RequestState.loaded
              )
            ));
  }

  FutureOr<void> _getTvSeriesReviews(GetTvSeriesReviewsEvent event, Emitter<TvSeriesDetailsState> emit) async {
    emit(state.copyWith(tvSeriesReviewState: RequestState.loading));
    final result= await getTvSeriesReviewsUseCase( TvSeriesIdParameter(tvSeriesId: event.tvSeriesIdParameter.tvSeriesId));
    result.fold((l) => emit(
        state.copyWith(
            tvSeriesReviewState: RequestState.error,
            tvSeriesReviewMessage: l.message)
    ),
            (r) => emit(
            state.copyWith(
                tvSeriesReviewList: r,
                tvSeriesReviewState: RequestState.loaded
            )
        ));
  }

  FutureOr<void> _getTvSeriesRecommendations(GetTvSeriesRecommendationsEvent event, Emitter<TvSeriesDetailsState> emit) async {
    final result=await getTvSeriesRecommendationsUseCase(TvSeriesIdParameter(tvSeriesId: event.tvSeriesIdParameter.tvSeriesId));
    result.fold(
            (l) => emit(
                state.copyWith(
                    tvSeriesRecommendationsMessage:l.message,
                    tvSeriesRecommendationsState: RequestState.error)),
            (r) => emit(
                state.copyWith(
                  tvSeriesRecommendationsState:RequestState.loaded ,
                  tvSeriesRecommendations: r,
            )));
  }

  FutureOr<void> _navigateList(NavigateBetweenListEvent event, Emitter<TvSeriesDetailsState> emit) {
    List<bool>l;
    bool? show;
    if(event.index==0){
      l=[true,false];
    }else{
      l=[false,true];
    }
    show=event.show;
    show=!show!;

  emit(state.copyWith(selectedButton: l,
      currentIndex: event.index,show: show));
  }

  FutureOr<void> _getTvSeriesEpisodeEvent(GetTvSeriesEpisodeEvent event, Emitter<TvSeriesDetailsState> emit) async{
    final result=await getTvSeriesEpisodesUseCase(event.tvSeriesIdParameter);
    result.fold(
            (l) => emit(
            state.copyWith(
                tvSeriesEpisodesMessage:l.message,
                tvSeriesEpisodesState: RequestState.error)),
            (r) => emit(
            state.copyWith(
              tvSeriesEpisodesState:RequestState.loaded ,
              tvSeriesEpisodes: r,
            )));
  }
}