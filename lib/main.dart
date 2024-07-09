import 'package:examproject1/viewModel/homeViewModel.dart';
import 'package:examproject1/widgets/discoverWidget.dart';
import 'package:examproject1/widgets/movieBox.dart';
import 'package:examproject1/widgets/trandWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/movie.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black, brightness: Brightness.dark),
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
  late final ScrollController mainScrollController = ScrollController()
    ..addListener(() {
      setState(() {
        scrollOffset = mainScrollController.offset;
      });
    });


  @override
  void initState() {
    super.initState();
    context.read<HomeViewModel>().callDiscover();
    context.read<HomeViewModel>().callTrending();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true, //Title text 가운데 정렬
          title: const Text("넷플릭스"),
          backgroundColor: Colors.transparent, //appBar 투명색
          // shadowColor: Colors.black,
          elevation: 0,//appBar 그림자 농도 설정 (값 0으로 제거)
        ),
        extendBodyBehindAppBar: true, //body 위에 appbar
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        controller: mainScrollController,
        slivers: const [
          // SliverAppBar(
          //   expandedHeight: 200.0,
          //   floating: false,
          //   pinned: true,
          //   flexibleSpace: FlexibleSpaceBar(
          //     title: Text('투명 앱바'),
          //
          //   ),
          //   // backgroundColor: Colors.black.withOpacity(appBarOpacity),
          // ),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              DiscoverWidget(),
              TrandWidget(),
              TrandWidget(),
              TrandWidget(),
              TrandWidget(),
              TrandWidget(),
            ]),
          ),
        ],
      ),
    );
  }
}
