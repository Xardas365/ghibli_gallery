// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'person_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PersonDto {

 String get id; String get name; String get url; String? get gender; String? get age;@JsonKey(name: 'eye_color') String? get eyeColor;@JsonKey(name: 'hair_color') String? get hairColor; List<String> get films; String? get species;
/// Create a copy of PersonDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonDtoCopyWith<PersonDto> get copyWith => _$PersonDtoCopyWithImpl<PersonDto>(this as PersonDto, _$identity);

  /// Serializes this PersonDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.age, age) || other.age == age)&&(identical(other.eyeColor, eyeColor) || other.eyeColor == eyeColor)&&(identical(other.hairColor, hairColor) || other.hairColor == hairColor)&&const DeepCollectionEquality().equals(other.films, films)&&(identical(other.species, species) || other.species == species));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,url,gender,age,eyeColor,hairColor,const DeepCollectionEquality().hash(films),species);

@override
String toString() {
  return 'PersonDto(id: $id, name: $name, url: $url, gender: $gender, age: $age, eyeColor: $eyeColor, hairColor: $hairColor, films: $films, species: $species)';
}


}

/// @nodoc
abstract mixin class $PersonDtoCopyWith<$Res>  {
  factory $PersonDtoCopyWith(PersonDto value, $Res Function(PersonDto) _then) = _$PersonDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String url, String? gender, String? age,@JsonKey(name: 'eye_color') String? eyeColor,@JsonKey(name: 'hair_color') String? hairColor, List<String> films, String? species
});




}
/// @nodoc
class _$PersonDtoCopyWithImpl<$Res>
    implements $PersonDtoCopyWith<$Res> {
  _$PersonDtoCopyWithImpl(this._self, this._then);

  final PersonDto _self;
  final $Res Function(PersonDto) _then;

/// Create a copy of PersonDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? url = null,Object? gender = freezed,Object? age = freezed,Object? eyeColor = freezed,Object? hairColor = freezed,Object? films = null,Object? species = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as String?,eyeColor: freezed == eyeColor ? _self.eyeColor : eyeColor // ignore: cast_nullable_to_non_nullable
as String?,hairColor: freezed == hairColor ? _self.hairColor : hairColor // ignore: cast_nullable_to_non_nullable
as String?,films: null == films ? _self.films : films // ignore: cast_nullable_to_non_nullable
as List<String>,species: freezed == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonDto].
extension PersonDtoPatterns on PersonDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonDto value)  $default,){
final _that = this;
switch (_that) {
case _PersonDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonDto value)?  $default,){
final _that = this;
switch (_that) {
case _PersonDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String url,  String? gender,  String? age, @JsonKey(name: 'eye_color')  String? eyeColor, @JsonKey(name: 'hair_color')  String? hairColor,  List<String> films,  String? species)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonDto() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.gender,_that.age,_that.eyeColor,_that.hairColor,_that.films,_that.species);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String url,  String? gender,  String? age, @JsonKey(name: 'eye_color')  String? eyeColor, @JsonKey(name: 'hair_color')  String? hairColor,  List<String> films,  String? species)  $default,) {final _that = this;
switch (_that) {
case _PersonDto():
return $default(_that.id,_that.name,_that.url,_that.gender,_that.age,_that.eyeColor,_that.hairColor,_that.films,_that.species);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String url,  String? gender,  String? age, @JsonKey(name: 'eye_color')  String? eyeColor, @JsonKey(name: 'hair_color')  String? hairColor,  List<String> films,  String? species)?  $default,) {final _that = this;
switch (_that) {
case _PersonDto() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.gender,_that.age,_that.eyeColor,_that.hairColor,_that.films,_that.species);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonDto implements PersonDto {
  const _PersonDto({required this.id, required this.name, required this.url, this.gender, this.age, @JsonKey(name: 'eye_color') this.eyeColor, @JsonKey(name: 'hair_color') this.hairColor, final  List<String> films = const <String>[], this.species}): _films = films;
  factory _PersonDto.fromJson(Map<String, dynamic> json) => _$PersonDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String url;
@override final  String? gender;
@override final  String? age;
@override@JsonKey(name: 'eye_color') final  String? eyeColor;
@override@JsonKey(name: 'hair_color') final  String? hairColor;
 final  List<String> _films;
@override@JsonKey() List<String> get films {
  if (_films is EqualUnmodifiableListView) return _films;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_films);
}

@override final  String? species;

/// Create a copy of PersonDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonDtoCopyWith<_PersonDto> get copyWith => __$PersonDtoCopyWithImpl<_PersonDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.age, age) || other.age == age)&&(identical(other.eyeColor, eyeColor) || other.eyeColor == eyeColor)&&(identical(other.hairColor, hairColor) || other.hairColor == hairColor)&&const DeepCollectionEquality().equals(other._films, _films)&&(identical(other.species, species) || other.species == species));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,url,gender,age,eyeColor,hairColor,const DeepCollectionEquality().hash(_films),species);

@override
String toString() {
  return 'PersonDto(id: $id, name: $name, url: $url, gender: $gender, age: $age, eyeColor: $eyeColor, hairColor: $hairColor, films: $films, species: $species)';
}


}

/// @nodoc
abstract mixin class _$PersonDtoCopyWith<$Res> implements $PersonDtoCopyWith<$Res> {
  factory _$PersonDtoCopyWith(_PersonDto value, $Res Function(_PersonDto) _then) = __$PersonDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String url, String? gender, String? age,@JsonKey(name: 'eye_color') String? eyeColor,@JsonKey(name: 'hair_color') String? hairColor, List<String> films, String? species
});




}
/// @nodoc
class __$PersonDtoCopyWithImpl<$Res>
    implements _$PersonDtoCopyWith<$Res> {
  __$PersonDtoCopyWithImpl(this._self, this._then);

  final _PersonDto _self;
  final $Res Function(_PersonDto) _then;

/// Create a copy of PersonDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? url = null,Object? gender = freezed,Object? age = freezed,Object? eyeColor = freezed,Object? hairColor = freezed,Object? films = null,Object? species = freezed,}) {
  return _then(_PersonDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as String?,eyeColor: freezed == eyeColor ? _self.eyeColor : eyeColor // ignore: cast_nullable_to_non_nullable
as String?,hairColor: freezed == hairColor ? _self.hairColor : hairColor // ignore: cast_nullable_to_non_nullable
as String?,films: null == films ? _self._films : films // ignore: cast_nullable_to_non_nullable
as List<String>,species: freezed == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
