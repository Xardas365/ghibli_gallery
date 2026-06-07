import 'package:flutter/material.dart';
import 'package:ghibli_gallery/app/router.dart';
import 'package:ghibli_gallery/app/theme.dart';

class GhibliApp extends StatelessWidget {
  const GhibliApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ghibli Gallery',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialRoute: AppRoutes.gallery,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
