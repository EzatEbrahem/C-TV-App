import 'package:equatable/equatable.dart';
import 'package:movies_app/tv/domain/entities/tv_series_details.dart';
import 'package:movies_app/tv/domain/entities/tv_series_episode.dart';
import 'package:movies_app/tv/domain/entities/tv_series_recommendation.dart';
import 'package:movies_app/tv/domain/entities/tv_series_review.dart';

import '../../../core/utils/enums.dart';


class TvSeriesDetailsState extends Equatable{
  final List<TvSeriesReview> tvSeriesReviewList;
  final RequestState tvSeriesReviewState;
  final String tvSeriesReviewMessage;

  final TvSeriesDetails? tvSeriesDetails;
  final RequestState tvSeriesDetailsState;
  final String tvSeriesDetailsMessage;

  final List<TvSeriesRecommendation> tvSeriesRecommendations;
  final RequestState tvSeriesRecommendationsState;
  final String tvSeriesRecommendationsMessage;
  final List<bool> selectedButton;
  final int currentIndex;
  final bool show;


  final List<TvSeriesEpisode> tvSeriesEpisodes;
  final RequestState tvSeriesEpisodesState;
  final String tvSeriesEpisodesMessage;


  const TvSeriesDetailsState({
      this.tvSeriesEpisodes=const [],
      this.tvSeriesEpisodesState=RequestState.loading,
      this.tvSeriesEpisodesMessage="",
    this.show=false,
      this.selectedButton=const[true,false],
      this.currentIndex=0,
      this.tvSeriesRecommendations=const [],
      this.tvSeriesRecommendationsState=RequestState.loading,
      this.tvSeriesRecommendationsMessage="",
      this.tvSeriesReviewList=const[],
      this.tvSeriesReviewState=RequestState.loading,
      this.tvSeriesReviewMessage='',
      this.tvSeriesDetails,
      this.tvSeriesDetailsState=RequestState.loading,
      this.tvSeriesDetailsMessage='',

  });
  TvSeriesDetailsState copyWith({
     List<TvSeriesEpisode>? tvSeriesEpisodes,
     RequestState? tvSeriesEpisodesState,
     String? tvSeriesEpisodesMessage,
    bool?show,
    List<bool>? selectedButton,
    int? currentIndex,
    List<TvSeriesReview>? tvSeriesReviewList,
    RequestState? tvSeriesReviewState,
    String? tvSeriesReviewMessage,
    TvSeriesDetails? tvSeriesDetails,
    RequestState? tvSeriesDetailsState,
    String? tvSeriesDetailsMessage,
    List<TvSeriesRecommendation>? tvSeriesRecommendations,
    RequestState? tvSeriesRecommendationsState,
    String? tvSeriesRecommendationsMessage,

  }) {
    return TvSeriesDetailsState(
      tvSeriesEpisodes: tvSeriesEpisodes??this.tvSeriesEpisodes,
      tvSeriesEpisodesMessage:tvSeriesEpisodesMessage??this.tvSeriesEpisodesMessage ,
      tvSeriesEpisodesState:tvSeriesEpisodesState??this.tvSeriesEpisodesState ,
      show: show??this.show,
      currentIndex: currentIndex??this.currentIndex,
      selectedButton: selectedButton??this.selectedButton,
      tvSeriesReviewList: tvSeriesReviewList ?? this.tvSeriesReviewList,
      tvSeriesReviewState: tvSeriesReviewState ?? this.tvSeriesReviewState,
      tvSeriesReviewMessage: tvSeriesReviewMessage ?? this.tvSeriesReviewMessage,
      tvSeriesDetails: tvSeriesDetails ?? this.tvSeriesDetails,
      tvSeriesDetailsState: tvSeriesDetailsState ?? this.tvSeriesDetailsState,
      tvSeriesDetailsMessage: tvSeriesDetailsMessage ?? this.tvSeriesDetailsMessage,
      tvSeriesRecommendations: tvSeriesRecommendations ?? this.tvSeriesRecommendations,
      tvSeriesRecommendationsState: tvSeriesRecommendationsState ?? this.tvSeriesRecommendationsState,
      tvSeriesRecommendationsMessage: tvSeriesRecommendationsMessage ?? this.tvSeriesRecommendationsMessage,

    );
  }


  @override

  List<Object?> get props =>
      [
        tvSeriesEpisodes,
        tvSeriesEpisodesMessage,
        tvSeriesEpisodesState,
        show,
        currentIndex,
        selectedButton,
        tvSeriesReviewList,
        tvSeriesReviewState,
        tvSeriesReviewMessage,
        tvSeriesDetails,
        tvSeriesDetailsState,
        tvSeriesDetailsMessage,
        tvSeriesRecommendations,
        tvSeriesRecommendationsState,
        tvSeriesRecommendationsMessage,
      ];

}