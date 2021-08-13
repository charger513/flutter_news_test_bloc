import 'package:flutter/material.dart';
import 'package:flutter_news_test_bloc/injection_container.dart' as di;

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const App());
}
