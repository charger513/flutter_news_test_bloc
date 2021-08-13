import 'package:flutter_news_test_bloc/features/news/data/models/source_model.dart';
import 'package:flutter_news_test_bloc/features/news/domain/entities/source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // ignore: prefer_const_constructors
  final tSource = SourceModel(id: 'id', name: 'name');

  test("should be a subclass of Source entity", () {
    expect(tSource, isA<Source>());
  });
}
