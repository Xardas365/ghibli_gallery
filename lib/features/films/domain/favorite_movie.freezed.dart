// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_movie.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FavoriteMovie {

 String get filmId; bool get isFavorite; int? get rating;
/// Create a copy of FavoriteMovie
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteMovieCopyWith<FavoriteMovie> get copyWith => _$FavoriteMovieCopyWithImpl<FavoriteMovie>(this as FavoriteMovie, _$identity);

  /// Serializes this FavoriteMovie to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteMovie&&(identical(other.filmId, filmId) || other.filmId == filmId)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.rating, rating) || other.rating == rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filmId,isFavorite,rating);

@override
String toString() {
  return 'FavoriteMovie(filmId: $filmId, isFavorite: $isFavorite, rating: $rating)';
}


}

/// @nodoc
abstract mixin class $FavoriteMovieCopyWith<$Res>  {
  factory $FavoriteMovieCopyWith(FavoriteMovie value, $Res Function(FavoriteMovie) _then) = _$FavoriteMovieCopyWithImpl;
@useResult
$Res call({
 String filmId, bool isFavorite, int? rating
});




}
/// @nodoc
class _$FavoriteMovieCopyWithImpl<$Res>
    implements $FavoriteMovieCopyWith<$Res> {
  _$FavoriteMovieCopyWithImpl(this._self, this._then);

  final FavoriteMovie _self;
  final $Res Function(FavoriteMovie) _then;

/// Create a copy of FavoriteMovie
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filmId = null,Object? isFavorite = null,Object? rating = freezed,}) {
  return _then(_self.copyWith(
filmId: null == filmId ? _self.filmId : filmId // ignore: cast_nullable_to_non_nullable
as String,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteMovie].
extension FavoriteMoviePatterns on FavoriteMovie {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteMovie value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteMovie() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteMovie value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteMovie():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteMovie value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteMovie() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String filmId,  bool isFavorite,  int? rating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteMovie() when $default != null:
return $default(_that.filmId,_that.isFavorite,_that.rating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String filmId,  bool isFavorite,  int? rating)  $default,) {final _that = this;
switch (_that) {
case _FavoriteMovie():
return $default(_that.filmId,_that.isFavorite,_that.rating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String filmId,  bool isFavorite,  int? rating)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteMovie() when $default != null:
return $default(_that.filmId,_that.isFavorite,_that.rating);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavoriteMovie implements FavoriteMovie {
  const _FavoriteMovie({required this.filmId, required this.isFavorite, this.rating}): assert(rating == null || (rating >= 1 && rating <= 5), 'Rating must be between 1 and 5.');
  factory _FavoriteMovie.fromJson(Map<String, dynamic> json) => _$FavoriteMovieFromJson(json);

@override final  String filmId;
@override final  bool isFavorite;
@override final  int? rating;

/// Create a copy of FavoriteMovie
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteMovieCopyWith<_FavoriteMovie> get copyWith => __$FavoriteMovieCopyWithImpl<_FavoriteMovie>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavoriteMovieToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteMovie&&(identical(other.filmId, filmId) || other.filmId == filmId)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.rating, rating) || other.rating == rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filmId,isFavorite,rating);

@override
String toString() {
  return 'FavoriteMovie(filmId: $filmId, isFavorite: $isFavorite, rating: $rating)';
}


}

/// @nodoc
abstract mixin class _$FavoriteMovieCopyWith<$Res> implements $FavoriteMovieCopyWith<$Res> {
  factory _$FavoriteMovieCopyWith(_FavoriteMovie value, $Res Function(_FavoriteMovie) _then) = __$FavoriteMovieCopyWithImpl;
@override @useResult
$Res call({
 String filmId, bool isFavorite, int? rating
});




}
/// @nodoc
class __$FavoriteMovieCopyWithImpl<$Res>
    implements _$FavoriteMovieCopyWith<$Res> {
  __$FavoriteMovieCopyWithImpl(this._self, this._then);

  final _FavoriteMovie _self;
  final $Res Function(_FavoriteMovie) _then;

/// Create a copy of FavoriteMovie
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filmId = null,Object? isFavorite = null,Object? rating = freezed,}) {
  return _then(_FavoriteMovie(
filmId: null == filmId ? _self.filmId : filmId // ignore: cast_nullable_to_non_nullable
as String,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
