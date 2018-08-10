// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => new Place(
    json['id'] as int,
    json['name'] as String,
    json['address'] as String,
    json['featuredImage'] as String,
    json['description'] as String);

abstract class _$PlaceSerializerMixin {
  int get id;
  String get name;
  String get address;
  String get featuredImage;
  dynamic get description;
  
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id':id,
        'name': name,
        'address': address,
        'description': description,
        'featuredImage': featuredImage
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
