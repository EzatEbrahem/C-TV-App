part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailEvent extends Equatable {

  const MovieDetailEvent();
  @override
  List<Object>  get props => [];
}
class GetMovieDetailEvent extends MovieDetailEvent{
  final int id;

  const GetMovieDetailEvent({required this.id});
  @override
  List<Object>  get props => [id];
}
class GetRecommendationMoviesEvent extends MovieDetailEvent{
final int id;

const GetRecommendationMoviesEvent({required this.id});
@override
List<Object>  get props => [id];
}

class GetTrailerMoviesEvent extends MovieDetailEvent{
  final int id;

  const GetTrailerMoviesEvent({required this.id});
  @override
  List<Object>  get props => [id];
}
class ChangePanelEvent extends MovieDetailEvent{
  final PanelController panelController;

  const ChangePanelEvent({required this.panelController});
  @override
  List<Object>  get props => [panelController];
}

class GetReviewsMoviesEvent extends MovieDetailEvent{
  final int id;

  const GetReviewsMoviesEvent({required this.id});
  @override
  List<Object>  get props => [id];
}
