// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'species_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpeciesDto {

 String get id; String get name; String get url; String? get classification;@JsonKey(name: 'eye_colors') String? get eyeColors;@JsonKey(name: 'hair_colors') String? get hairColors; List<String> get people; List<String> get films;
/// Create a copy of SpeciesDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeciesDtoCopyWith<SpeciesDto> get copyWith => _$SpeciesDtoCopyWithImpl<SpeciesDto>(this as SpeciesDto, _$identity);

  /// Serializes this SpeciesDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeciesDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.classification, classification) || other.classification == classification)&&(identical(other.eyeColors, eyeColors) || other.eyeColors == eyeColors)&&(identical(other.hairColors, hairColors) || other.hairColors == hairColors)&&const DeepCollectionEquality().equals(other.people, people)&&const DeepCollectionEquality().equals(other.films, films));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,url,classification,eyeColors,hairColors,const DeepCollectionEquality().hash(people),const DeepCollectionEquality().hash(films));

@override
String toString() {
  return 'SpeciesDto(id: $id, name: $name, url: $url, classification: $classification, eyeColors: $eyeColors, hairColors: $hairColors, people: $people, films: $films)';
}


}

/// @nodoc
abstract mixin class $SpeciesDtoCopyWith<$Res>  {
  factory $SpeciesDtoCopyWith(SpeciesDto value, $Res Function(SpeciesDto) _then) = _$SpeciesDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String url, String? classification,@JsonKey(name: 'eye_colors') String? eyeColors,@JsonKey(name: 'hair_colors') String? hairColors, List<String> people, List<String> films
});




}
/// @nodoc
class _$SpeciesDtoCopyWithImpl<$Res>
    implements $SpeciesDtoCopyWith<$Res> {
  _$SpeciesDtoCopyWithImpl(this._self, this._then);

  final SpeciesDto _self;
  final $Res Function(SpeciesDto) _then;

/// Create a copy of SpeciesDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? url = null,Object? classification = freezed,Object? eyeColors = freezed,Object? hairColors = freezed,Object? people = null,Object? films = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,classification: freezed == classification ? _self.classification : classification // ignore: cast_nullable_to_non_nullable
as String?,eyeColors: freezed == eyeColors ? _self.eyeColors : eyeColors // ignore: cast_nullable_to_non_nullable
as String?,hairColors: freezed == hairColors ? _self.hairColors : hairColors // ignore: cast_nullable_to_non_nullable
as String?,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as List<String>,films: null == films ? _self.films : films // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SpeciesDto].
extension SpeciesDtoPatterns on SpeciesDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpeciesDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpeciesDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpeciesDto value)  $default,){
final _that = this;
switch (_that) {
case _SpeciesDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpeciesDto value)?  $default,){
final _that = this;
switch (_that) {
case _SpeciesDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String url,  String? classification, @JsonKey(name: 'eye_colors')  String? eyeColors, @JsonKey(name: 'hair_colors')  String? hairColors,  List<String> people,  List<String> films)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeciesDto() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.classification,_that.eyeColors,_that.hairColors,_that.people,_that.films);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String url,  String? classification, @JsonKey(name: 'eye_colors')  String? eyeColors, @JsonKey(name: 'hair_colors')  String? hairColors,  List<String> people,  List<String> films)  $default,) {final _that = this;
switch (_that) {
case _SpeciesDto():
return $default(_that.id,_that.name,_that.url,_that.classification,_that.eyeColors,_that.hairColors,_that.people,_that.films);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String url,  String? classification, @JsonKey(name: 'eye_colors')  String? eyeColors, @JsonKey(name: 'hair_colors')  String? hairColors,  List<String> people,  List<String> films)?  $default,) {final _that = this;
switch (_that) {
case _SpeciesDto() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.classification,_that.eyeColors,_that.hairColors,_that.people,_that.films);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpeciesDto implements SpeciesDto {
  const _SpeciesDto({required this.id, required this.name, required this.url, this.classification, @JsonKey(name: 'eye_colors') this.eyeColors, @JsonKey(name: 'hair_colors') this.hairColors, final  List<String> people = const <String>[], final  List<String> films = const <String>[]}): _people = people,_films = films;
  factory _SpeciesDto.fromJson(Map<String, dynamic> json) => _$SpeciesDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String url;
@override final  String? classification;
@override@JsonKey(name: 'eye_colors') final  String? eyeColors;
@override@JsonKey(name: 'hair_colors') final  String? hairColors;
 final  List<String> _people;
@override@JsonKey() List<String> get people {
  if (_people is EqualUnmodifiableListView) return _people;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_people);
}

 final  List<String> _films;
@override@JsonKey() List<String> get films {
  if (_films is EqualUnmodifiableListView) return _films;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_films);
}


/// Create a copy of SpeciesDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeciesDtoCopyWith<_SpeciesDto> get copyWith => __$SpeciesDtoCopyWithImpl<_SpeciesDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpeciesDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeciesDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.classification, classification) || other.classification == classification)&&(identical(other.eyeColors, eyeColors) || other.eyeColors == eyeColors)&&(identical(other.hairColors, hairColors) || other.hairColors == hairColors)&&const DeepCollectionEquality().equals(other._people, _people)&&const DeepCollectionEquality().equals(other._films, _films));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,url,classification,eyeColors,hairColors,const DeepCollectionEquality().hash(_people),const DeepCollectionEquality().hash(_films));

@override
String toString() {
  return 'SpeciesDto(id: $id, name: $name, url: $url, classification: $classification, eyeColors: $eyeColors, hairColors: $hairColors, people: $people, films: $films)';
}


}

/// @nodoc
abstract mixin class _$SpeciesDtoCopyWith<$Res> implements $SpeciesDtoCopyWith<$Res> {
  factory _$SpeciesDtoCopyWith(_SpeciesDto value, $Res Function(_SpeciesDto) _then) = __$SpeciesDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String url, String? classification,@JsonKey(name: 'eye_colors') String? eyeColors,@JsonKey(name: 'hair_colors') String? hairColors, List<String> people, List<String> films
});




}
/// @nodoc
class __$SpeciesDtoCopyWithImpl<$Res>
    implements _$SpeciesDtoCopyWith<$Res> {
  __$SpeciesDtoCopyWithImpl(this._self, this._then);

  final _SpeciesDto _self;
  final $Res Function(_SpeciesDto) _then;

/// Create a copy of SpeciesDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? url = null,Object? classification = freezed,Object? eyeColors = freezed,Object? hairColors = freezed,Object? people = null,Object? films = null,}) {
  return _then(_SpeciesDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,classification: freezed == classification ? _self.classification : classification // ignore: cast_nullable_to_non_nullable
as String?,eyeColors: freezed == eyeColors ? _self.eyeColors : eyeColors // ignore: cast_nullable_to_non_nullable
as String?,hairColors: freezed == hairColors ? _self.hairColors : hairColors // ignore: cast_nullable_to_non_nullable
as String?,people: null == people ? _self._people : people // ignore: cast_nullable_to_non_nullable
as List<String>,films: null == films ? _self._films : films // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
