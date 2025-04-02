import 'package:dio/dio.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/network/api_constance.dart';

import '../models/movie_search_model.dart';
import '../models/tv_search_model.dart';

abstract class BaseSettingRemoteDataSource{
  Future<List<MovieSearchModel>> getMovieSearch(String query);
  Future<List<TvSearchModel>> getTvSearch(String query);
}
class SettingRemoteDataSource extends BaseSettingRemoteDataSource{
  @override
  Future<List<MovieSearchModel>> getMovieSearch(String query) async {
    final result=await Dio().get(ApiConstance.searchMoviePath(query));
    if(result.statusCode==200){
      return List<MovieSearchModel>.from(result.data['results'].map((e)=>MovieSearchModel.fromJson(e)));
    }else{
      throw ServerException(errorMessageModel: result.data);
    }
  }

  @override
  Future<List<TvSearchModel>> getTvSearch(String query)async {
    final result=await Dio().get(ApiConstance.searchTvPath(query));
    if(result.statusCode==200){
      return List<TvSearchModel>.from(result.data['results'].map((e)=>TvSearchModel.fromJson(e)));
    }else{
      throw ServerException(errorMessageModel: result.data);
    }
  }

}