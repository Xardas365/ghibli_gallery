import 'package:flutter_riverpod/flutter_riverpod.dart';

final ratingFilterProvider = NotifierProvider<RatingFilter, int?>(
  RatingFilter.new,
);

class RatingFilter extends Notifier<int?> {
  @override
  int? build() => null;

  int? get rating => state;

  set rating(int? value) => state = value;
}
