import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_entry/app/ghibli_app.dart';

void main() {
  runApp(const ProviderScope(child: GhibliApp()));
}
