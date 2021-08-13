import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_test_bloc/features/news/presentation/bloc/news_bloc.dart';
import 'package:flutter_news_test_bloc/injection_container.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NewsBloc>(),
      child: const Scaffold(
        body: NewsList(),
      ),
    );
  }
}

class NewsList extends StatefulWidget {
  const NewsList({
    Key? key,
  }) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(GetNews());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is Empty) {
          return const Center(
            child: Text('No hay noticias widget'),
          );
        } else if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is Error) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is Loaded) {
          return ListView.builder(
            itemCount: state.news.articles.length,
            itemBuilder: (ctx, index) {
              final article = state.news.articles[index];
              return Container(
                padding: const EdgeInsets.all(10),
                height: 300,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: article.urlToImage != null
                          ? Image.network(
                              article.urlToImage!,
                              fit: BoxFit.contain,
                            )
                          : const Center(
                              child: Text('No hay Imagen'),
                            ),
                    ),
                    Text(article.title ?? 'Sin titulo'),
                    Text(article.description ?? 'Sin descripción'),
                    Text(article.url ?? 'Sin url'),
                  ],
                ),
              );
              // return ListTile(
              //   title: Text(article.title ?? 'Sin título'),
              //   subtitle: Text(article.description ?? 'No description'),
              // );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
