import 'package:examproject1/viewModel/trendingWeekList.dart';
import 'package:examproject1/widgets/movie_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/movie.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => TrendingWeekList()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Movie? movie;

  @override
  void initState() {
    super.initState();
    context.read<TrendingWeekList>().parsingData();
  }

  @override
  Widget build(BuildContext context) {
    try {
      movie = context.watch<TrendingWeekList>().movie;
      print(movie!.results[0].backdropPath.toString());
    } catch (e) {}
    return Scaffold(
        body: movie != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                      height: 230,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movie!.results.length,
                          itemBuilder: (context, index) {
                            return MovieBox(movie!.results[index]);
                          })),
                ],
              )
            : const CircularProgressIndicator()
// This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
