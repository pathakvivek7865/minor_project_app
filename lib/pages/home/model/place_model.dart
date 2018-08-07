import 'package:json_annotation/json_annotation.dart';

part 'place_model.g.dart';

@JsonSerializable()
class PlaceModel extends Object with _$PlaceModelSerializerMixin {

  final String name;
  final String address;
  final description;
  final String preferedActivities;

  PlaceModel(this.name,this.address, this.preferedActivities,this.description);

  factory PlaceModel.fromJson(Map<String, dynamic> json) => _$PlaceModelFromJson(json);
}

@JsonSerializable()
class PlaceResponse extends Object with _$PlaceResponseSerializerMixin{
  final List<PlaceModel> places;

  PlaceResponse(this.places);

  factory PlaceResponse.fromJson(Map<String, dynamic> json) => _$PlaceResponseFromJson(json);
}