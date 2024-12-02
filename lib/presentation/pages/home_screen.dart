import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/repositories/news_repository_impl.dart';
import '../../domain/entities/article.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<String> categories = [
    'political',
    'covid',
    'entertainment',
    'sports',
    'business'
  ];

  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  saveSelectedTab(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _selectedIndex,
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFF6699),
          title: const Row(
            children: [
              Text(
                "Read",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, top: 7),
                child: Text(
                  "News Today",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: Colors.black,
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.normal),
            tabs: [
              ...categories
                  .map((category) => Tab(text: category.toUpperCase())),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ...categories.map((category) {
              return NewsTab(category: category);
            }),
          ],
        ),
      ),
    );
  }
}

class NewsTab extends StatefulWidget {
  final String category;

  const NewsTab({super.key, required this.category});

  @override
  NewsTabState createState() => NewsTabState();
}

class NewsTabState extends State<NewsTab> {
  late Future<List<Article>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = fetchNews(widget.category);
  }

  Future<List<Article>> fetchNews(String category) async {
    final newsRepository = NewsRepositoryImpl();
    return await newsRepository.fetchNews(category);
  }

  Future<void> _refreshNews() async {
    setState(() {
      _newsFuture = fetchNews(widget.category);
    });
  }

  String formatDateTime(String dateTime) {
    try {
      final parsedDate = DateTime.parse(dateTime);
      return DateFormat('dd MMM yyyy, HH:mm').format(parsedDate);
    } catch (e) {
      return dateTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshNews,
      child: FutureBuilder<List<Article>>(
        future: _newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: CircularProgressIndicator(color: Color(0xFFFF6699)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No news available"));
          } else {
            final articles = snapshot.data!;
            return ListView.separated(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 5, right: 4),
                  child: Row(
                    children: [
                      Image.network(article.urlToImage,
                          height: 100, width: 125),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(article.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              Text(
                                "Author : ${article.author}",
                                style: const TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 5),
                              Text(article.description, maxLines: 4),
                              const SizedBox(height: 7),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                      "Published at : ${formatDateTime(article.publishedAt)}",
                                      style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            );
          }
        },
      ),
    );
  }
}
