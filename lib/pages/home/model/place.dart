import 'package:json_annotation/json_annotation.dart';

part 'place.g.dart';

@JsonSerializable()
class Place extends Object with _$PlaceSerializerMixin {

  final int id;
  final String name;
  final String address;
  final String description;
  final String established;
  final String preferedActivities;
  final String featuredImage;
  
  Place(this.id,this.name,this.address,this.description,this.preferedActivities,this.established, this.featuredImage);

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
}

@JsonSerializable()
class PlaceResponse extends Object with _$PlaceResponseSerializerMixin{
  final List<Place> places;

  PlaceResponse(this.places);

  factory PlaceResponse.fromJson(Map<String, dynamic> json) => _$PlaceResponseFromJson(json);
}