// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) => new PlaceModel(
    json['name'] as String,
    json['address'] as String,
    json['preferedActivities'] as String,
    json['description']);

abstract class _$PlaceModelSerializerMixin {
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
        ?.map((e) => e == null
            ? null
            : new PlaceModel.fromJson(e as Map<String, dynamic>))
        ?.toList());

abstract class _$PlaceResponseSerializerMixin {
  List<PlaceModel> get places;
  Map<String, dynamic> toJson() => <String, dynamic>{'places': places};
}
