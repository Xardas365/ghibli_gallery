import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_gallery/app/ghibli_app.dart';

void main() {
  runApp(const ProviderScope(child: GhibliApp()));
}
