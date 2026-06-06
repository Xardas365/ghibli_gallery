// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VehicleDto {

 String get id; String get name; String get url; String? get description;@JsonKey(name: 'vehicle_class') String? get vehicleClass; String? get length; String? get pilot; List<String> get films;
/// Create a copy of VehicleDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleDtoCopyWith<VehicleDto> get copyWith => _$VehicleDtoCopyWithImpl<VehicleDto>(this as VehicleDto, _$identity);

  /// Serializes this VehicleDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.description, description) || other.description == description)&&(identical(other.vehicleClass, vehicleClass) || other.vehicleClass == vehicleClass)&&(identical(other.length, length) || other.length == length)&&(identical(other.pilot, pilot) || other.pilot == pilot)&&const DeepCollectionEquality().equals(other.films, films));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,url,description,vehicleClass,length,pilot,const DeepCollectionEquality().hash(films));

@override
String toString() {
  return 'VehicleDto(id: $id, name: $name, url: $url, description: $description, vehicleClass: $vehicleClass, length: $length, pilot: $pilot, films: $films)';
}


}

/// @nodoc
abstract mixin class $VehicleDtoCopyWith<$Res>  {
  factory $VehicleDtoCopyWith(VehicleDto value, $Res Function(VehicleDto) _then) = _$VehicleDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String url, String? description,@JsonKey(name: 'vehicle_class') String? vehicleClass, String? length, String? pilot, List<String> films
});




}
/// @nodoc
class _$VehicleDtoCopyWithImpl<$Res>
    implements $VehicleDtoCopyWith<$Res> {
  _$VehicleDtoCopyWithImpl(this._self, this._then);

  final VehicleDto _self;
  final $Res Function(VehicleDto) _then;

/// Create a copy of VehicleDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? url = null,Object? description = freezed,Object? vehicleClass = freezed,Object? length = freezed,Object? pilot = freezed,Object? films = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,vehicleClass: freezed == vehicleClass ? _self.vehicleClass : vehicleClass // ignore: cast_nullable_to_non_nullable
as String?,length: freezed == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as String?,pilot: freezed == pilot ? _self.pilot : pilot // ignore: cast_nullable_to_non_nullable
as String?,films: null == films ? _self.films : films // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [VehicleDto].
extension VehicleDtoPatterns on VehicleDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VehicleDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VehicleDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VehicleDto value)  $default,){
final _that = this;
switch (_that) {
case _VehicleDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VehicleDto value)?  $default,){
final _that = this;
switch (_that) {
case _VehicleDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String url,  String? description, @JsonKey(name: 'vehicle_class')  String? vehicleClass,  String? length,  String? pilot,  List<String> films)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VehicleDto() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.description,_that.vehicleClass,_that.length,_that.pilot,_that.films);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String url,  String? description, @JsonKey(name: 'vehicle_class')  String? vehicleClass,  String? length,  String? pilot,  List<String> films)  $default,) {final _that = this;
switch (_that) {
case _VehicleDto():
return $default(_that.id,_that.name,_that.url,_that.description,_that.vehicleClass,_that.length,_that.pilot,_that.films);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String url,  String? description, @JsonKey(name: 'vehicle_class')  String? vehicleClass,  String? length,  String? pilot,  List<String> films)?  $default,) {final _that = this;
switch (_that) {
case _VehicleDto() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.description,_that.vehicleClass,_that.length,_that.pilot,_that.films);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VehicleDto implements VehicleDto {
  const _VehicleDto({required this.id, required this.name, required this.url, this.description, @JsonKey(name: 'vehicle_class') this.vehicleClass, this.length, this.pilot, final  List<String> films = const <String>[]}): _films = films;
  factory _VehicleDto.fromJson(Map<String, dynamic> json) => _$VehicleDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String url;
@override final  String? description;
@override@JsonKey(name: 'vehicle_class') final  String? vehicleClass;
@override final  String? length;
@override final  String? pilot;
 final  List<String> _films;
@override@JsonKey() List<String> get films {
  if (_films is EqualUnmodifiableListView) return _films;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_films);
}


/// Create a copy of VehicleDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VehicleDtoCopyWith<_VehicleDto> get copyWith => __$VehicleDtoCopyWithImpl<_VehicleDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VehicleDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VehicleDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.description, description) || other.description == description)&&(identical(other.vehicleClass, vehicleClass) || other.vehicleClass == vehicleClass)&&(identical(other.length, length) || other.length == length)&&(identical(other.pilot, pilot) || other.pilot == pilot)&&const DeepCollectionEquality().equals(other._films, _films));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,url,description,vehicleClass,length,pilot,const DeepCollectionEquality().hash(_films));

@override
String toString() {
  return 'VehicleDto(id: $id, name: $name, url: $url, description: $description, vehicleClass: $vehicleClass, length: $length, pilot: $pilot, films: $films)';
}


}

/// @nodoc
abstract mixin class _$VehicleDtoCopyWith<$Res> implements $VehicleDtoCopyWith<$Res> {
  factory _$VehicleDtoCopyWith(_VehicleDto value, $Res Function(_VehicleDto) _then) = __$VehicleDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String url, String? description,@JsonKey(name: 'vehicle_class') String? vehicleClass, String? length, String? pilot, List<String> films
});




}
/// @nodoc
class __$VehicleDtoCopyWithImpl<$Res>
    implements _$VehicleDtoCopyWith<$Res> {
  __$VehicleDtoCopyWithImpl(this._self, this._then);

  final _VehicleDto _self;
  final $Res Function(_VehicleDto) _then;

/// Create a copy of VehicleDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? url = null,Object? description = freezed,Object? vehicleClass = freezed,Object? length = freezed,Object? pilot = freezed,Object? films = null,}) {
  return _then(_VehicleDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,vehicleClass: freezed == vehicleClass ? _self.vehicleClass : vehicleClass // ignore: cast_nullable_to_non_nullable
as String?,length: freezed == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as String?,pilot: freezed == pilot ? _self.pilot : pilot // ignore: cast_nullable_to_non_nullable
as String?,films: null == films ? _self._films : films // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
