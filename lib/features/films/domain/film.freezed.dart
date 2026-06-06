// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'film.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Film {

 String get id; String get title; String get description; String get director; String get producer; int? get releaseYear; int? get runningTimeMinutes; int? get rtScore; String get image; String get movieBanner;
/// Create a copy of Film
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilmCopyWith<Film> get copyWith => _$FilmCopyWithImpl<Film>(this as Film, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Film&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.director, director) || other.director == director)&&(identical(other.producer, producer) || other.producer == producer)&&(identical(other.releaseYear, releaseYear) || other.releaseYear == releaseYear)&&(identical(other.runningTimeMinutes, runningTimeMinutes) || other.runningTimeMinutes == runningTimeMinutes)&&(identical(other.rtScore, rtScore) || other.rtScore == rtScore)&&(identical(other.image, image) || other.image == image)&&(identical(other.movieBanner, movieBanner) || other.movieBanner == movieBanner));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,director,producer,releaseYear,runningTimeMinutes,rtScore,image,movieBanner);

@override
String toString() {
  return 'Film(id: $id, title: $title, description: $description, director: $director, producer: $producer, releaseYear: $releaseYear, runningTimeMinutes: $runningTimeMinutes, rtScore: $rtScore, image: $image, movieBanner: $movieBanner)';
}


}

/// @nodoc
abstract mixin class $FilmCopyWith<$Res>  {
  factory $FilmCopyWith(Film value, $Res Function(Film) _then) = _$FilmCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String director, String producer, int? releaseYear, int? runningTimeMinutes, int? rtScore, String image, String movieBanner
});




}
/// @nodoc
class _$FilmCopyWithImpl<$Res>
    implements $FilmCopyWith<$Res> {
  _$FilmCopyWithImpl(this._self, this._then);

  final Film _self;
  final $Res Function(Film) _then;

/// Create a copy of Film
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? director = null,Object? producer = null,Object? releaseYear = freezed,Object? runningTimeMinutes = freezed,Object? rtScore = freezed,Object? image = null,Object? movieBanner = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,director: null == director ? _self.director : director // ignore: cast_nullable_to_non_nullable
as String,producer: null == producer ? _self.producer : producer // ignore: cast_nullable_to_non_nullable
as String,releaseYear: freezed == releaseYear ? _self.releaseYear : releaseYear // ignore: cast_nullable_to_non_nullable
as int?,runningTimeMinutes: freezed == runningTimeMinutes ? _self.runningTimeMinutes : runningTimeMinutes // ignore: cast_nullable_to_non_nullable
as int?,rtScore: freezed == rtScore ? _self.rtScore : rtScore // ignore: cast_nullable_to_non_nullable
as int?,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,movieBanner: null == movieBanner ? _self.movieBanner : movieBanner // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Film].
extension FilmPatterns on Film {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Film value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Film() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Film value)  $default,){
final _that = this;
switch (_that) {
case _Film():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Film value)?  $default,){
final _that = this;
switch (_that) {
case _Film() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String director,  String producer,  int? releaseYear,  int? runningTimeMinutes,  int? rtScore,  String image,  String movieBanner)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Film() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.director,_that.producer,_that.releaseYear,_that.runningTimeMinutes,_that.rtScore,_that.image,_that.movieBanner);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String director,  String producer,  int? releaseYear,  int? runningTimeMinutes,  int? rtScore,  String image,  String movieBanner)  $default,) {final _that = this;
switch (_that) {
case _Film():
return $default(_that.id,_that.title,_that.description,_that.director,_that.producer,_that.releaseYear,_that.runningTimeMinutes,_that.rtScore,_that.image,_that.movieBanner);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String director,  String producer,  int? releaseYear,  int? runningTimeMinutes,  int? rtScore,  String image,  String movieBanner)?  $default,) {final _that = this;
switch (_that) {
case _Film() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.director,_that.producer,_that.releaseYear,_that.runningTimeMinutes,_that.rtScore,_that.image,_that.movieBanner);case _:
  return null;

}
}

}

/// @nodoc


class _Film implements Film {
  const _Film({required this.id, required this.title, required this.description, required this.director, required this.producer, required this.releaseYear, required this.runningTimeMinutes, required this.rtScore, required this.image, required this.movieBanner});
  

@override final  String id;
@override final  String title;
@override final  String description;
@override final  String director;
@override final  String producer;
@override final  int? releaseYear;
@override final  int? runningTimeMinutes;
@override final  int? rtScore;
@override final  String image;
@override final  String movieBanner;

/// Create a copy of Film
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilmCopyWith<_Film> get copyWith => __$FilmCopyWithImpl<_Film>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Film&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.director, director) || other.director == director)&&(identical(other.producer, producer) || other.producer == producer)&&(identical(other.releaseYear, releaseYear) || other.releaseYear == releaseYear)&&(identical(other.runningTimeMinutes, runningTimeMinutes) || other.runningTimeMinutes == runningTimeMinutes)&&(identical(other.rtScore, rtScore) || other.rtScore == rtScore)&&(identical(other.image, image) || other.image == image)&&(identical(other.movieBanner, movieBanner) || other.movieBanner == movieBanner));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,director,producer,releaseYear,runningTimeMinutes,rtScore,image,movieBanner);

@override
String toString() {
  return 'Film(id: $id, title: $title, description: $description, director: $director, producer: $producer, releaseYear: $releaseYear, runningTimeMinutes: $runningTimeMinutes, rtScore: $rtScore, image: $image, movieBanner: $movieBanner)';
}


}

/// @nodoc
abstract mixin class _$FilmCopyWith<$Res> implements $FilmCopyWith<$Res> {
  factory _$FilmCopyWith(_Film value, $Res Function(_Film) _then) = __$FilmCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String director, String producer, int? releaseYear, int? runningTimeMinutes, int? rtScore, String image, String movieBanner
});




}
/// @nodoc
class __$FilmCopyWithImpl<$Res>
    implements _$FilmCopyWith<$Res> {
  __$FilmCopyWithImpl(this._self, this._then);

  final _Film _self;
  final $Res Function(_Film) _then;

/// Create a copy of Film
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? director = null,Object? producer = null,Object? releaseYear = freezed,Object? runningTimeMinutes = freezed,Object? rtScore = freezed,Object? image = null,Object? movieBanner = null,}) {
  return _then(_Film(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,director: null == director ? _self.director : director // ignore: cast_nullable_to_non_nullable
as String,producer: null == producer ? _self.producer : producer // ignore: cast_nullable_to_non_nullable
as String,releaseYear: freezed == releaseYear ? _self.releaseYear : releaseYear // ignore: cast_nullable_to_non_nullable
as int?,runningTimeMinutes: freezed == runningTimeMinutes ? _self.runningTimeMinutes : runningTimeMinutes // ignore: cast_nullable_to_non_nullable
as int?,rtScore: freezed == rtScore ? _self.rtScore : rtScore // ignore: cast_nullable_to_non_nullable
as int?,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,movieBanner: null == movieBanner ? _self.movieBanner : movieBanner // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
