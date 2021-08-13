import 'package:flutter/material.dart';
import 'package:flutter_news_test_bloc/features/news/presentation/page/news_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: NewsPage(),
    );
  }
}
