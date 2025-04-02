import 'package:movies_app/tv/utils/tv_series_parameter_id.dart';

class ApiConstance {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String apiKey = "547786d3149e3043ec4a8ef6c91a3c32";
///movie API paths
  static const String nowPlayingMoviesPath =
      "$baseUrl/movie/now_playing?api_key=$apiKey";
  static const String popularMoviesPath =
      "$baseUrl/movie/popular?api_key=$apiKey";
  static const String topRatedMoviesPath =
      "$baseUrl/movie/top_rated?api_key=$apiKey";
  static  String movieDetailsPath(int movieId) =>
      "$baseUrl/movie/$movieId?api_key=$apiKey";
  static String recommendationPath(int movieId) =>
      "$baseUrl/movie/$movieId/recommendations?api_key=$apiKey";
  static String movieTrailerPath(int movieId) =>
      "$baseUrl/movie/$movieId/videos?api_key=$apiKey";
  static String movieReviewsPath(int movieId) =>
      "$baseUrl/movie/$movieId/reviews?api_key=$apiKey";
///image API path
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
  static String imageUrl(String path) => '$baseImageUrl$path';

///Tv API paths
  static const String airingTodayTvSeriesPath =
      "$baseUrl/tv/airing_today?api_key=$apiKey";
  static const String  topRatedTvSeriesPath  =
      "$baseUrl/tv/top_rated?api_key=$apiKey";
  static const String  popularTvSeriesPath  =
      "$baseUrl/tv/popular?api_key=$apiKey";
  static String tvSeriesReviewsPath(int tvSeriesId) =>
      "$baseUrl/tv/$tvSeriesId/reviews?api_key=$apiKey";
  static String tvSeriesDetailsPath(int tvSeriesId) =>
      "$baseUrl/tv/$tvSeriesId?api_key=$apiKey";
  static String tvSeriesRecommendationPath(int tvSeriesId) =>
      "$baseUrl/tv/$tvSeriesId/recommendations?api_key=$apiKey";
  static String tvSeriesEpisodesPath(TvSeriesIdParameter parameter) =>
      "$baseUrl/tv/${parameter.tvSeriesId}/season/${parameter.seasonNumber}?api_key=$apiKey";
///search API paths
  static String searchMoviePath(String query) =>
      "$baseUrl/search/movie?query=$query&api_key=$apiKey";
  static String searchTvPath(String query) =>
      "$baseUrl/search/tv?query=$query&api_key=$apiKey";
}
