import 'package:flutter/material.dart';
import 'package:tracker/services/app_router.dart';
import 'package:tracker/services/background_location_services.dart';
import 'package:tracker/services/hive_service.dart';
import 'package:tracker/services/navigation_service.dart';
import 'package:tracker/views/tracker_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.instance.init();
  await BackgroundLocationService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.instance.navigatorKey,
      initialRoute: AppRouter.tracker,
      onGenerateRoute:
      AppRouter.generateRoute,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: TrackerView(),
    );
  }
}
