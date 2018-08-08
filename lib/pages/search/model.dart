import 'package:meta/meta.dart';

class TouristS {
  TouristS({
    @required this.id,
    @required this.name,
    @required this.rating,
    @required this.description,
    this.favored,
  });

  String id, name, rating, description;
  bool favored;

  TouristS.fromJson(Map json)
      : id = json["id"].toString(),
        name = json["poster_path"],
        rating = json["rating"].toString(),
        description = json["description"],
        favored = false;
}
