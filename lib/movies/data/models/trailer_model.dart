import 'package:movies_app/movies/domain/entities/trailer.dart';

class TrailerModel extends TrailerMovie {
  const TrailerModel(
      {required super.name,
      required super.key,
      required super.site,
      required super.type,
      required super.id});

  factory TrailerModel.fromJson(Map<String, dynamic> json) => TrailerModel(
        id: json["id"],
        name: json["name"],
        site: json["site"],
        type: json["type"],
        key: json["key"],
      );
}
