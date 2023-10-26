import 'package:flutter/material.dart';
import 'package:location_trial/ui/location/location_screen.dart';
import 'package:location_trial/ui/start/start_screen.dart';

enum LocationAppScreens {
  start('/start'),
  location('/location'),
  ;

  final String screen;

  const LocationAppScreens(this.screen);
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '位置情報お試しアプリ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      routes: <String, WidgetBuilder> {
        LocationAppScreens.start.screen: (BuildContext context) {
          return StartScreen(
            navigateToNextScreen: () => Navigator.of(context).pushReplacementNamed(
              LocationAppScreens.location.screen,
            ),
          );
        },

        LocationAppScreens.location.screen: (BuildContext context) {
          return const LocationScreen();
        }
      },
      initialRoute: LocationAppScreens.start.screen,
    );
  }
}
