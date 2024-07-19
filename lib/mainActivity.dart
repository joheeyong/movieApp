// ignore_for_file: prefer_const_constructors

import 'package:examproject1/viewModel/homeViewModel.dart';
import 'package:examproject1/widgets/NextflixBottomNavigation.dart';
import 'package:examproject1/widgets/discoverWidget.dart';
import 'package:examproject1/widgets/trandWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => HomeViewModel()),
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
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark)),
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
  double scrollOffset = 0.0;
  Color _appBarColor = Colors.transparent;
  late final ScrollController mainScrollController = ScrollController()
    ..addListener(() {
      setState(() {
        scrollOffset = mainScrollController.offset;
        if (scrollOffset > 100) {
          _appBarColor = Colors.black38;
        } else {
          _appBarColor = Colors.transparent;
        }
      });
    });

  @override
  void initState() {
    super.initState();
    context.read<HomeViewModel>().callDiscover();
    context.read<HomeViewModel>().trendingAllWeek();
    context.read<HomeViewModel>().trendingMovieDay();
    context.read<HomeViewModel>().trendingMovieWeek();
    context.read<HomeViewModel>().trendingTVDay();
  }

  @override
  Widget build(BuildContext context) {
    print("mainActivity.dart");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: _appBarColor,
        surfaceTintColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(72),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/netflixIcon.png',
                height: 72.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(LucideIcons.cast)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(LucideIcons.search)),
                ],
              )
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true, //body 위에 appbar
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        controller: mainScrollController,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              DiscoverWidget(),
              TrandWidget("allWeek"),
              TrandWidget("movieDay"),
              TrandWidget("movieWeek"),
              TrandWidget("TVDay"),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: NextflixBottomNavigation()
    );
  }
}
