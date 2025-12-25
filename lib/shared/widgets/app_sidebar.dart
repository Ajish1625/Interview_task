import 'package:flutter/material.dart';

class AppSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: 0,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.people),
          label: Text('Users'),
        ),
      ],
    );
  }
}
