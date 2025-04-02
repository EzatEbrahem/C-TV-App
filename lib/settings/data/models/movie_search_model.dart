import 'package:movies_app/settings/domain/Entities/tv_search.dart';

import '../../domain/Entities/movie_search.dart';

class MovieSearchModel extends MovieSearch{
  const MovieSearchModel({required super.backdropPath, required super.title, required super.id});

  factory MovieSearchModel.fromJson(Map<String,dynamic> json)=>
      MovieSearchModel(
          backdropPath: json['backdrop_path']??json['poster_path']??'/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg',
          title: json['title'],
          id: json['id']);
}