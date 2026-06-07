import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ghibli_entry/app/router.dart';

enum GhibliMainSection {
  gallery,
  favorites,
}

class GhibliScaffold extends StatelessWidget {
  const GhibliScaffold({
    required this.selectedSection,
    required this.title,
    required this.body,
    this.titleWidget,
    this.actions,
    super.key,
  });

  final GhibliMainSection selectedSection;
  final String title;
  final Widget body;
  final Widget? titleWidget;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final selectedDestination =
        _mainDestinations.firstWhereOrNull(
          (destination) => destination.section == selectedSection,
        ) ??
        _mainDestinations.first;

    return Scaffold(
      appBar: AppBar(
        centerTitle: titleWidget != null,
        title: titleWidget ?? Text(title),
        actions: actions,
      ),
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _mainDestinations.indexOf(selectedDestination),
        onDestinationSelected: (index) {
          final destination = _mainDestinations[index];
          if (destination.section == selectedSection) {
            return;
          }

          _navigateToMainSection(context, destination.routeName);
        },
        destinations: [
          for (final destination in _mainDestinations)
            NavigationDestination(
              key: ValueKey('main-nav-${destination.section.name}'),
              tooltip: destination.label,
              icon: Icon(destination.icon),
              selectedIcon: Icon(destination.selectedIcon),
              label: destination.label,
            ),
        ],
      ),
    );
  }
}

void _navigateToMainSection(BuildContext context, String routeName) {
  if (routeName == AppRoutes.gallery) {
    unawaited(
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.gallery,
        (route) => false,
      ),
    );
    return;
  }

  unawaited(Navigator.of(context).pushNamed(routeName));
}

class _MainDestination {
  const _MainDestination({
    required this.section,
    required this.routeName,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final GhibliMainSection section;
  final String routeName;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

const _mainDestinations = [
  _MainDestination(
    section: GhibliMainSection.gallery,
    routeName: AppRoutes.gallery,
    label: 'Gallery',
    icon: Icons.movie_outlined,
    selectedIcon: Icons.movie,
  ),
  _MainDestination(
    section: GhibliMainSection.favorites,
    routeName: AppRoutes.favorites,
    label: 'Favorites',
    icon: Icons.favorite_outline,
    selectedIcon: Icons.favorite,
  ),
];
