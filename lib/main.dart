import 'package:flutter/material.dart';

import 'app/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDependencyInjection.init();
  runApp(const CoffeeApp());
}
