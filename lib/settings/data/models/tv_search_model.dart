import 'package:movies_app/settings/domain/Entities/tv_search.dart';

class TvSearchModel extends TvSearch{
  const TvSearchModel({required super.backdropPath,required super.name, required super.id});
  factory TvSearchModel.fromJson(Map<String,dynamic> json)=>
      TvSearchModel(
          backdropPath: json['backdrop_path']??json['poster_path']??'/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg',
          name: json['name'],
          id: json['id']);
}