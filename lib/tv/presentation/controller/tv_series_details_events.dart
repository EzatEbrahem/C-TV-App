import 'package:equatable/equatable.dart';
import 'package:movies_app/tv/utils/tv_series_parameter_id.dart';

abstract class TvSeriesDetailsEvent extends Equatable{


  const TvSeriesDetailsEvent();

  @override
  List<Object> get props => [];

}
class GetTvSeriesDetailsEvent extends TvSeriesDetailsEvent{
  final TvSeriesIdParameter tvSeriesIdParameter;
  const GetTvSeriesDetailsEvent(this.tvSeriesIdParameter);
}
class GetTvSeriesReviewsEvent extends TvSeriesDetailsEvent{
  final TvSeriesIdParameter tvSeriesIdParameter;
  const GetTvSeriesReviewsEvent( this.tvSeriesIdParameter) ;
}

class GetTvSeriesRecommendationsEvent extends TvSeriesDetailsEvent{
  final TvSeriesIdParameter tvSeriesIdParameter;
  const GetTvSeriesRecommendationsEvent(this.tvSeriesIdParameter);
}
class NavigateBetweenListEvent extends TvSeriesDetailsEvent{
  final int? index;
  final bool? show;
  const NavigateBetweenListEvent(this.index, this.show);

}

class GetTvSeriesEpisodeEvent extends TvSeriesDetailsEvent{
  final TvSeriesIdParameter tvSeriesIdParameter;
  const GetTvSeriesEpisodeEvent(this.tvSeriesIdParameter);
}