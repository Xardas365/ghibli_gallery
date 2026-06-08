// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'film_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FilmDto {

 String get id; String get title;@JsonKey(name: 'original_title') String get originalTitle;@JsonKey(name: 'original_title_romanised') String get originalTitleRomanised; String get image;@JsonKey(name: 'movie_banner') String get movieBanner; String get description; String get director; String get producer; String get url;@JsonKey(name: 'release_date') String? get releaseDate;@JsonKey(name: 'running_time') String? get runningTime;@JsonKey(name: 'rt_score') String? get rtScore; List<String> get people; List<String> get species; List<String> get locations; List<String> get vehicles;
/// Create a copy of FilmDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilmDtoCopyWith<FilmDto> get copyWith => _$FilmDtoCopyWithImpl<FilmDto>(this as FilmDto, _$identity);

  /// Serializes this FilmDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilmDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.originalTitle, originalTitle) || other.originalTitle == originalTitle)&&(identical(other.originalTitleRomanised, originalTitleRomanised) || other.originalTitleRomanised == originalTitleRomanised)&&(identical(other.image, image) || other.image == image)&&(identical(other.movieBanner, movieBanner) || other.movieBanner == movieBanner)&&(identical(other.description, description) || other.description == description)&&(identical(other.director, director) || other.director == director)&&(identical(other.producer, producer) || other.producer == producer)&&(identical(other.url, url) || other.url == url)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate)&&(identical(other.runningTime, runningTime) || other.runningTime == runningTime)&&(identical(other.rtScore, rtScore) || other.rtScore == rtScore)&&const DeepCollectionEquality().equals(other.people, people)&&const DeepCollectionEquality().equals(other.species, species)&&const DeepCollectionEquality().equals(other.locations, locations)&&const DeepCollectionEquality().equals(other.vehicles, vehicles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,originalTitle,originalTitleRomanised,image,movieBanner,description,director,producer,url,releaseDate,runningTime,rtScore,const DeepCollectionEquality().hash(people),const DeepCollectionEquality().hash(species),const DeepCollectionEquality().hash(locations),const DeepCollectionEquality().hash(vehicles));

@override
String toString() {
  return 'FilmDto(id: $id, title: $title, originalTitle: $originalTitle, originalTitleRomanised: $originalTitleRomanised, image: $image, movieBanner: $movieBanner, description: $description, director: $director, producer: $producer, url: $url, releaseDate: $releaseDate, runningTime: $runningTime, rtScore: $rtScore, people: $people, species: $species, locations: $locations, vehicles: $vehicles)';
}


}

/// @nodoc
abstract mixin class $FilmDtoCopyWith<$Res>  {
  factory $FilmDtoCopyWith(FilmDto value, $Res Function(FilmDto) _then) = _$FilmDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title,@JsonKey(name: 'original_title') String originalTitle,@JsonKey(name: 'original_title_romanised') String originalTitleRomanised, String image,@JsonKey(name: 'movie_banner') String movieBanner, String description, String director, String producer, String url,@JsonKey(name: 'release_date') String? releaseDate,@JsonKey(name: 'running_time') String? runningTime,@JsonKey(name: 'rt_score') String? rtScore, List<String> people, List<String> species, List<String> locations, List<String> vehicles
});




}
/// @nodoc
class _$FilmDtoCopyWithImpl<$Res>
    implements $FilmDtoCopyWith<$Res> {
  _$FilmDtoCopyWithImpl(this._self, this._then);

  final FilmDto _self;
  final $Res Function(FilmDto) _then;

/// Create a copy of FilmDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? originalTitle = null,Object? originalTitleRomanised = null,Object? image = null,Object? movieBanner = null,Object? description = null,Object? director = null,Object? producer = null,Object? url = null,Object? releaseDate = freezed,Object? runningTime = freezed,Object? rtScore = freezed,Object? people = null,Object? species = null,Object? locations = null,Object? vehicles = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,originalTitle: null == originalTitle ? _self.originalTitle : originalTitle // ignore: cast_nullable_to_non_nullable
as String,originalTitleRomanised: null == originalTitleRomanised ? _self.originalTitleRomanised : originalTitleRomanised // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,movieBanner: null == movieBanner ? _self.movieBanner : movieBanner // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,director: null == director ? _self.director : director // ignore: cast_nullable_to_non_nullable
as String,producer: null == producer ? _self.producer : producer // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,releaseDate: freezed == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as String?,runningTime: freezed == runningTime ? _self.runningTime : runningTime // ignore: cast_nullable_to_non_nullable
as String?,rtScore: freezed == rtScore ? _self.rtScore : rtScore // ignore: cast_nullable_to_non_nullable
as String?,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as List<String>,species: null == species ? _self.species : species // ignore: cast_nullable_to_non_nullable
as List<String>,locations: null == locations ? _self.locations : locations // ignore: cast_nullable_to_non_nullable
as List<String>,vehicles: null == vehicles ? _self.vehicles : vehicles // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [FilmDto].
extension FilmDtoPatterns on FilmDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FilmDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FilmDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FilmDto value)  $default,){
final _that = this;
switch (_that) {
case _FilmDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FilmDto value)?  $default,){
final _that = this;
switch (_that) {
case _FilmDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title, @JsonKey(name: 'original_title')  String originalTitle, @JsonKey(name: 'original_title_romanised')  String originalTitleRomanised,  String image, @JsonKey(name: 'movie_banner')  String movieBanner,  String description,  String director,  String producer,  String url, @JsonKey(name: 'release_date')  String? releaseDate, @JsonKey(name: 'running_time')  String? runningTime, @JsonKey(name: 'rt_score')  String? rtScore,  List<String> people,  List<String> species,  List<String> locations,  List<String> vehicles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FilmDto() when $default != null:
return $default(_that.id,_that.title,_that.originalTitle,_that.originalTitleRomanised,_that.image,_that.movieBanner,_that.description,_that.director,_that.producer,_that.url,_that.releaseDate,_that.runningTime,_that.rtScore,_that.people,_that.species,_that.locations,_that.vehicles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title, @JsonKey(name: 'original_title')  String originalTitle, @JsonKey(name: 'original_title_romanised')  String originalTitleRomanised,  String image, @JsonKey(name: 'movie_banner')  String movieBanner,  String description,  String director,  String producer,  String url, @JsonKey(name: 'release_date')  String? releaseDate, @JsonKey(name: 'running_time')  String? runningTime, @JsonKey(name: 'rt_score')  String? rtScore,  List<String> people,  List<String> species,  List<String> locations,  List<String> vehicles)  $default,) {final _that = this;
switch (_that) {
case _FilmDto():
return $default(_that.id,_that.title,_that.originalTitle,_that.originalTitleRomanised,_that.image,_that.movieBanner,_that.description,_that.director,_that.producer,_that.url,_that.releaseDate,_that.runningTime,_that.rtScore,_that.people,_that.species,_that.locations,_that.vehicles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title, @JsonKey(name: 'original_title')  String originalTitle, @JsonKey(name: 'original_title_romanised')  String originalTitleRomanised,  String image, @JsonKey(name: 'movie_banner')  String movieBanner,  String description,  String director,  String producer,  String url, @JsonKey(name: 'release_date')  String? releaseDate, @JsonKey(name: 'running_time')  String? runningTime, @JsonKey(name: 'rt_score')  String? rtScore,  List<String> people,  List<String> species,  List<String> locations,  List<String> vehicles)?  $default,) {final _that = this;
switch (_that) {
case _FilmDto() when $default != null:
return $default(_that.id,_that.title,_that.originalTitle,_that.originalTitleRomanised,_that.image,_that.movieBanner,_that.description,_that.director,_that.producer,_that.url,_that.releaseDate,_that.runningTime,_that.rtScore,_that.people,_that.species,_that.locations,_that.vehicles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FilmDto implements FilmDto {
  const _FilmDto({required this.id, required this.title, @JsonKey(name: 'original_title') required this.originalTitle, @JsonKey(name: 'original_title_romanised') required this.originalTitleRomanised, required this.image, @JsonKey(name: 'movie_banner') required this.movieBanner, required this.description, required this.director, required this.producer, required this.url, @JsonKey(name: 'release_date') this.releaseDate, @JsonKey(name: 'running_time') this.runningTime, @JsonKey(name: 'rt_score') this.rtScore, final  List<String> people = const <String>[], final  List<String> species = const <String>[], final  List<String> locations = const <String>[], final  List<String> vehicles = const <String>[]}): _people = people,_species = species,_locations = locations,_vehicles = vehicles;
  factory _FilmDto.fromJson(Map<String, dynamic> json) => _$FilmDtoFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey(name: 'original_title') final  String originalTitle;
@override@JsonKey(name: 'original_title_romanised') final  String originalTitleRomanised;
@override final  String image;
@override@JsonKey(name: 'movie_banner') final  String movieBanner;
@override final  String description;
@override final  String director;
@override final  String producer;
@override final  String url;
@override@JsonKey(name: 'release_date') final  String? releaseDate;
@override@JsonKey(name: 'running_time') final  String? runningTime;
@override@JsonKey(name: 'rt_score') final  String? rtScore;
 final  List<String> _people;
@override@JsonKey() List<String> get people {
  if (_people is EqualUnmodifiableListView) return _people;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_people);
}

 final  List<String> _species;
@override@JsonKey() List<String> get species {
  if (_species is EqualUnmodifiableListView) return _species;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_species);
}

 final  List<String> _locations;
@override@JsonKey() List<String> get locations {
  if (_locations is EqualUnmodifiableListView) return _locations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_locations);
}

 final  List<String> _vehicles;
@override@JsonKey() List<String> get vehicles {
  if (_vehicles is EqualUnmodifiableListView) return _vehicles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vehicles);
}


/// Create a copy of FilmDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilmDtoCopyWith<_FilmDto> get copyWith => __$FilmDtoCopyWithImpl<_FilmDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FilmDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilmDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.originalTitle, originalTitle) || other.originalTitle == originalTitle)&&(identical(other.originalTitleRomanised, originalTitleRomanised) || other.originalTitleRomanised == originalTitleRomanised)&&(identical(other.image, image) || other.image == image)&&(identical(other.movieBanner, movieBanner) || other.movieBanner == movieBanner)&&(identical(other.description, description) || other.description == description)&&(identical(other.director, director) || other.director == director)&&(identical(other.producer, producer) || other.producer == producer)&&(identical(other.url, url) || other.url == url)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate)&&(identical(other.runningTime, runningTime) || other.runningTime == runningTime)&&(identical(other.rtScore, rtScore) || other.rtScore == rtScore)&&const DeepCollectionEquality().equals(other._people, _people)&&const DeepCollectionEquality().equals(other._species, _species)&&const DeepCollectionEquality().equals(other._locations, _locations)&&const DeepCollectionEquality().equals(other._vehicles, _vehicles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,originalTitle,originalTitleRomanised,image,movieBanner,description,director,producer,url,releaseDate,runningTime,rtScore,const DeepCollectionEquality().hash(_people),const DeepCollectionEquality().hash(_species),const DeepCollectionEquality().hash(_locations),const DeepCollectionEquality().hash(_vehicles));

@override
String toString() {
  return 'FilmDto(id: $id, title: $title, originalTitle: $originalTitle, originalTitleRomanised: $originalTitleRomanised, image: $image, movieBanner: $movieBanner, description: $description, director: $director, producer: $producer, url: $url, releaseDate: $releaseDate, runningTime: $runningTime, rtScore: $rtScore, people: $people, species: $species, locations: $locations, vehicles: $vehicles)';
}


}

/// @nodoc
abstract mixin class _$FilmDtoCopyWith<$Res> implements $FilmDtoCopyWith<$Res> {
  factory _$FilmDtoCopyWith(_FilmDto value, $Res Function(_FilmDto) _then) = __$FilmDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title,@JsonKey(name: 'original_title') String originalTitle,@JsonKey(name: 'original_title_romanised') String originalTitleRomanised, String image,@JsonKey(name: 'movie_banner') String movieBanner, String description, String director, String producer, String url,@JsonKey(name: 'release_date') String? releaseDate,@JsonKey(name: 'running_time') String? runningTime,@JsonKey(name: 'rt_score') String? rtScore, List<String> people, List<String> species, List<String> locations, List<String> vehicles
});




}
/// @nodoc
class __$FilmDtoCopyWithImpl<$Res>
    implements _$FilmDtoCopyWith<$Res> {
  __$FilmDtoCopyWithImpl(this._self, this._then);

  final _FilmDto _self;
  final $Res Function(_FilmDto) _then;

/// Create a copy of FilmDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? originalTitle = null,Object? originalTitleRomanised = null,Object? image = null,Object? movieBanner = null,Object? description = null,Object? director = null,Object? producer = null,Object? url = null,Object? releaseDate = freezed,Object? runningTime = freezed,Object? rtScore = freezed,Object? people = null,Object? species = null,Object? locations = null,Object? vehicles = null,}) {
  return _then(_FilmDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,originalTitle: null == originalTitle ? _self.originalTitle : originalTitle // ignore: cast_nullable_to_non_nullable
as String,originalTitleRomanised: null == originalTitleRomanised ? _self.originalTitleRomanised : originalTitleRomanised // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,movieBanner: null == movieBanner ? _self.movieBanner : movieBanner // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,director: null == director ? _self.director : director // ignore: cast_nullable_to_non_nullable
as String,producer: null == producer ? _self.producer : producer // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,releaseDate: freezed == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as String?,runningTime: freezed == runningTime ? _self.runningTime : runningTime // ignore: cast_nullable_to_non_nullable
as String?,rtScore: freezed == rtScore ? _self.rtScore : rtScore // ignore: cast_nullable_to_non_nullable
as String?,people: null == people ? _self._people : people // ignore: cast_nullable_to_non_nullable
as List<String>,species: null == species ? _self._species : species // ignore: cast_nullable_to_non_nullable
as List<String>,locations: null == locations ? _self._locations : locations // ignore: cast_nullable_to_non_nullable
as List<String>,vehicles: null == vehicles ? _self._vehicles : vehicles // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
