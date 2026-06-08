// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'film_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FilmDetails {

 Film get film; String get originalTitle; String get originalTitleRomanised; List<String> get people; List<String> get species; List<String> get locations; List<String> get vehicles;
/// Create a copy of FilmDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilmDetailsCopyWith<FilmDetails> get copyWith => _$FilmDetailsCopyWithImpl<FilmDetails>(this as FilmDetails, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilmDetails&&(identical(other.film, film) || other.film == film)&&(identical(other.originalTitle, originalTitle) || other.originalTitle == originalTitle)&&(identical(other.originalTitleRomanised, originalTitleRomanised) || other.originalTitleRomanised == originalTitleRomanised)&&const DeepCollectionEquality().equals(other.people, people)&&const DeepCollectionEquality().equals(other.species, species)&&const DeepCollectionEquality().equals(other.locations, locations)&&const DeepCollectionEquality().equals(other.vehicles, vehicles));
}


@override
int get hashCode => Object.hash(runtimeType,film,originalTitle,originalTitleRomanised,const DeepCollectionEquality().hash(people),const DeepCollectionEquality().hash(species),const DeepCollectionEquality().hash(locations),const DeepCollectionEquality().hash(vehicles));

@override
String toString() {
  return 'FilmDetails(film: $film, originalTitle: $originalTitle, originalTitleRomanised: $originalTitleRomanised, people: $people, species: $species, locations: $locations, vehicles: $vehicles)';
}


}

/// @nodoc
abstract mixin class $FilmDetailsCopyWith<$Res>  {
  factory $FilmDetailsCopyWith(FilmDetails value, $Res Function(FilmDetails) _then) = _$FilmDetailsCopyWithImpl;
@useResult
$Res call({
 Film film, String originalTitle, String originalTitleRomanised, List<String> people, List<String> species, List<String> locations, List<String> vehicles
});


$FilmCopyWith<$Res> get film;

}
/// @nodoc
class _$FilmDetailsCopyWithImpl<$Res>
    implements $FilmDetailsCopyWith<$Res> {
  _$FilmDetailsCopyWithImpl(this._self, this._then);

  final FilmDetails _self;
  final $Res Function(FilmDetails) _then;

/// Create a copy of FilmDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? film = null,Object? originalTitle = null,Object? originalTitleRomanised = null,Object? people = null,Object? species = null,Object? locations = null,Object? vehicles = null,}) {
  return _then(_self.copyWith(
film: null == film ? _self.film : film // ignore: cast_nullable_to_non_nullable
as Film,originalTitle: null == originalTitle ? _self.originalTitle : originalTitle // ignore: cast_nullable_to_non_nullable
as String,originalTitleRomanised: null == originalTitleRomanised ? _self.originalTitleRomanised : originalTitleRomanised // ignore: cast_nullable_to_non_nullable
as String,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as List<String>,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as List<String>,locations: null == locations ? _self.locations : locations // ignore: cast_nullable_to_non_nullable
as List<String>,vehicles: null == vehicles ? _self.vehicles : vehicles // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of FilmDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FilmCopyWith<$Res> get film {
  
  return $FilmCopyWith<$Res>(_self.film, (value) {
    return _then(_self.copyWith(film: value));
  });
}
}


/// Adds pattern-matching-related methods to [FilmDetails].
extension FilmDetailsPatterns on FilmDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FilmDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FilmDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FilmDetails value)  $default,){
final _that = this;
switch (_that) {
case _FilmDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FilmDetails value)?  $default,){
final _that = this;
switch (_that) {
case _FilmDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Film film,  String originalTitle,  String originalTitleRomanised,  List<String> people,  List<String> species,  List<String> locations,  List<String> vehicles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FilmDetails() when $default != null:
return $default(_that.film,_that.originalTitle,_that.originalTitleRomanised,_that.people,_that.species,_that.locations,_that.vehicles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Film film,  String originalTitle,  String originalTitleRomanised,  List<String> people,  List<String> species,  List<String> locations,  List<String> vehicles)  $default,) {final _that = this;
switch (_that) {
case _FilmDetails():
return $default(_that.film,_that.originalTitle,_that.originalTitleRomanised,_that.people,_that.species,_that.locations,_that.vehicles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Film film,  String originalTitle,  String originalTitleRomanised,  List<String> people,  List<String> species,  List<String> locations,  List<String> vehicles)?  $default,) {final _that = this;
switch (_that) {
case _FilmDetails() when $default != null:
return $default(_that.film,_that.originalTitle,_that.originalTitleRomanised,_that.people,_that.species,_that.locations,_that.vehicles);case _:
  return null;

}
}

}

/// @nodoc


class _FilmDetails implements FilmDetails {
  const _FilmDetails({required this.film, required this.originalTitle, required this.originalTitleRomanised, required final  List<String> people, required final  List<String> species, required final  List<String> locations, required final  List<String> vehicles}): _people = people,_species = species,_locations = locations,_vehicles = vehicles;
  

@override final  Film film;
@override final  String originalTitle;
@override final  String originalTitleRomanised;
 final  List<String> _people;
@override List<String> get people {
  if (_people is EqualUnmodifiableListView) return _people;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_people);
}

 final  List<String> _species;
@override List<String> get species {
  if (_species is EqualUnmodifiableListView) return _species;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_species);
}

 final  List<String> _locations;
@override List<String> get locations {
  if (_locations is EqualUnmodifiableListView) return _locations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_locations);
}

 final  List<String> _vehicles;
@override List<String> get vehicles {
  if (_vehicles is EqualUnmodifiableListView) return _vehicles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vehicles);
}


/// Create a copy of FilmDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilmDetailsCopyWith<_FilmDetails> get copyWith => __$FilmDetailsCopyWithImpl<_FilmDetails>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilmDetails&&(identical(other.film, film) || other.film == film)&&(identical(other.originalTitle, originalTitle) || other.originalTitle == originalTitle)&&(identical(other.originalTitleRomanised, originalTitleRomanised) || other.originalTitleRomanised == originalTitleRomanised)&&const DeepCollectionEquality().equals(other._people, _people)&&const DeepCollectionEquality().equals(other._species, _species)&&const DeepCollectionEquality().equals(other._locations, _locations)&&const DeepCollectionEquality().equals(other._vehicles, _vehicles));
}


@override
int get hashCode => Object.hash(runtimeType,film,originalTitle,originalTitleRomanised,const DeepCollectionEquality().hash(_people),const DeepCollectionEquality().hash(_species),const DeepCollectionEquality().hash(_locations),const DeepCollectionEquality().hash(_vehicles));

@override
String toString() {
  return 'FilmDetails(film: $film, originalTitle: $originalTitle, originalTitleRomanised: $originalTitleRomanised, people: $people, species: $species, locations: $locations, vehicles: $vehicles)';
}


}

/// @nodoc
abstract mixin class _$FilmDetailsCopyWith<$Res> implements $FilmDetailsCopyWith<$Res> {
  factory _$FilmDetailsCopyWith(_FilmDetails value, $Res Function(_FilmDetails) _then) = __$FilmDetailsCopyWithImpl;
@override @useResult
$Res call({
 Film film, String originalTitle, String originalTitleRomanised, List<String> people, List<String> species, List<String> locations, List<String> vehicles
});


@override $FilmCopyWith<$Res> get film;

}
/// @nodoc
class __$FilmDetailsCopyWithImpl<$Res>
    implements _$FilmDetailsCopyWith<$Res> {
  __$FilmDetailsCopyWithImpl(this._self, this._then);

  final _FilmDetails _self;
  final $Res Function(_FilmDetails) _then;

/// Create a copy of FilmDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? film = null,Object? originalTitle = null,Object? originalTitleRomanised = null,Object? people = null,Object? species = null,Object? locations = null,Object? vehicles = null,}) {
  return _then(_FilmDetails(
film: null == film ? _self.film : film // ignore: cast_nullable_to_non_nullable
as Film,originalTitle: null == originalTitle ? _self.originalTitle : originalTitle // ignore: cast_nullable_to_non_nullable
as String,originalTitleRomanised: null == originalTitleRomanised ? _self.originalTitleRomanised : originalTitleRomanised // ignore: cast_nullable_to_non_nullable
as String,people: null == people ? _self._people : people // ignore: cast_nullable_to_non_nullable
as List<String>,species: null == species ? _self._species : species // ignore: cast_nullable_to_non_nullable
as List<String>,locations: null == locations ? _self._locations : locations // ignore: cast_nullable_to_non_nullable
as List<String>,vehicles: null == vehicles ? _self._vehicles : vehicles // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of FilmDetails
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FilmCopyWith<$Res> get film {
  
  return $FilmCopyWith<$Res>(_self.film, (value) {
    return _then(_self.copyWith(film: value));
  });
}
}

// dart format on
