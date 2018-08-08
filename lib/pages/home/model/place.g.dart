// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => new Place(
    json['name'] as String,
    json['address'] as String,
    json['preferedActivities'] as String,
    json['description']);

abstract class _$PlaceSerializerMixin {
  String get name;
  String get address;
  dynamic get description;
  String get preferedActivities;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'address': address,
        'description': description,
        'preferedActivities': preferedActivities
      };
}

PlaceResponse _$PlaceResponseFromJson(Map<String, dynamic> json) =>
    new PlaceResponse((json['places'] as List)
        ?.map((e) =>
            e == null ? null : new Place.fromJson(e as Map<String, dynamic>))
        ?.toList());

abstract class _$PlaceResponseSerializerMixin {
  List<Place> get places;
  Map<String, dynamic> toJson() => <String, dynamic>{'places': places};
}
