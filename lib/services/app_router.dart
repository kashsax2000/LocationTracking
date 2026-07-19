import 'package:flutter/material.dart';
import 'package:tracker/views/location_history_view.dart';

import '../../views/tracker_view.dart';

class AppRouter {

  static const String tracker = '/';
  static const String locationHistory = '/locationHistory';


  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {

    switch (settings.name) {

      case tracker:
        return MaterialPageRoute(
          builder: (_) => const TrackerView(),
        );


      case locationHistory:
        return MaterialPageRoute(
          builder: (_) => const LocationHistoryView(),
        );


      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'Route ${settings.name} not found',
              ),
            ),
          ),
        );
    }
  }
}