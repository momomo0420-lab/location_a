import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_trial/app_navigator.dart';

void main() {
  runApp(
    const ProviderScope(
      child: AppNavigator(),
    ),
  );
}
