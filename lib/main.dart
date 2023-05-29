import 'package:flutter/material.dart';

import 'screens/app/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  runApp(const CoffeeApp());
}
