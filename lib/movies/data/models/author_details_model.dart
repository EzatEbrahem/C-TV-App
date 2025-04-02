import '../../domain/entities/author_details.dart';

class AuthorDetailsModel extends AuthorDetails {
  const AuthorDetailsModel({super.avatarPath, super.rating});

  factory AuthorDetailsModel.fromJson(Map<String, dynamic> json) =>
      AuthorDetailsModel(
          avatarPath: json["avatar_path"] ?? "/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg",
          rating: json["rating"]);
}
