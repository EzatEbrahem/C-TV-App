import 'package:dio/dio.dart';
import 'package:movies_app/core/error/error_message_model.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/network/api_constance.dart';
import 'package:movies_app/tv/data/models/tv_series_details_model.dart';
import 'package:movies_app/tv/data/models/tv_series_episode_model.dart';
import 'package:movies_app/tv/data/models/tv_series_model.dart';
import 'package:movies_app/tv/data/models/tv_series_recommendations_model.dart';
import 'package:movies_app/tv/data/models/tv_series_review_model.dart';
import 'package:movies_app/tv/utils/tv_series_parameter_id.dart';

abstract class BaseTvSeriesRemoteDataSource{
  Future<List<TvSeriesModel>> getAiringTodayTvSeries();
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesReviewModel>> getTvSeriesReviews(TvSeriesIdParameter parameter);
  Future<TvSeriesDetailsModel> getTvSeriesDetails(TvSeriesIdParameter parameter);
  Future<List<TvSeriesRecommendationsModel>> getTvSeriesRecommendations(TvSeriesIdParameter parameter);
  Future<List<TvSeriesEpisodeModel>> getTvSeriesEpisodes(TvSeriesIdParameter parameter);
}
class TvSeriesRemoteDataSource extends BaseTvSeriesRemoteDataSource{
  @override
  Future<List<TvSeriesModel>> getAiringTodayTvSeries()async {
    final result =await Dio().get(ApiConstance.airingTodayTvSeriesPath);
    if(result.statusCode==200){
     return List<TvSeriesModel>.from(result.data["results"].map((e)=>TvSeriesModel.fromJson(e)));
    }else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(result.data));
    }
    
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    final result =await Dio().get(ApiConstance.popularTvSeriesPath);
    if(result.statusCode==200){
      return List<TvSeriesModel>.from(result.data["results"].map((e)=>TvSeriesModel.fromJson(e)));
    }else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(result.data));
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    final result =await Dio().get(ApiConstance.topRatedTvSeriesPath);
  if(result.statusCode==200){
    return List<TvSeriesModel>.from(result.data["results"].map((e)=>TvSeriesModel.fromJson(e)));
  }else{
    throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(result.data));
  }
  }

  @override
  Future<TvSeriesDetailsModel> getTvSeriesDetails(TvSeriesIdParameter parameter) async {
   final result= await Dio().get(ApiConstance.tvSeriesDetailsPath(parameter.tvSeriesId));
   if(result.statusCode==200){
     return TvSeriesDetailsModel.fromJson(result.data);

   }else{
     throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(result.data));

   }
  }

  @override
  Future<List<TvSeriesReviewModel>> getTvSeriesReviews(TvSeriesIdParameter parameter) async{
    final result= await Dio().get(ApiConstance.tvSeriesReviewsPath(parameter.tvSeriesId));
    if(result.statusCode==200){
      return List<TvSeriesReviewModel>.from( result.data["results"].map((e)=>TvSeriesReviewModel.fromJson(e)));

    }else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(result.data));

    }
  }

  @override
  Future<List<TvSeriesRecommendationsModel>> getTvSeriesRecommendations(TvSeriesIdParameter parameter) async {
    final result = await Dio().get(ApiConstance.tvSeriesRecommendationPath(parameter.tvSeriesId));
    if(result.statusCode==200){
      return List<TvSeriesRecommendationsModel>.from( result.data["results"].map((e)=>TvSeriesRecommendationsModel.fromJson(e)));
    }
    else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(result.data));
    }
  }

  @override
  Future<List<TvSeriesEpisodeModel>> getTvSeriesEpisodes(TvSeriesIdParameter parameter) async{

    final result = await Dio().get(ApiConstance.tvSeriesEpisodesPath(parameter));
    if(result.statusCode==200){
      return List<TvSeriesEpisodeModel>.from( result.data["episodes"].map((e)=>TvSeriesEpisodeModel.fromJson(e)));
    }
    else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(result.data));
    }
  }
  
}