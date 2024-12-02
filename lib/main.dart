import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'data/repositories/news_repository_impl.dart';
import 'domain/usecases/get_news_by_category.dart';
import 'presentation/pages/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NewsRepositoryImpl>(
          create: (context) => NewsRepositoryImpl(),
        ),
        Provider<GetNewsByCategory>(
          create: (context) => GetNewsByCategory(
            context.read<NewsRepositoryImpl>(),
          ),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
