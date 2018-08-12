import 'package:json_annotation/json_annotation.dart';

part 'place.g.dart';

@JsonSerializable()
class Place extends Object with _$PlaceSerializerMixin {

  final String name;
  final String address;
  final description;
  final String featuredImage;
  bool favored = false;

  Place(this.name,this.address, this.featuredImage,this.description);

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
}

@JsonSerializable()
class PlaceResponse extends Object with _$PlaceResponseSerializerMixin{
  final List<Place> places;

  PlaceResponse(this.places);

  factory PlaceResponse.fromJson(Map<String, dynamic> json) => _$PlaceResponseFromJson(json);
}