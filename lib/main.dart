// ignore_for_file: prefer_const_constructors

import 'package:examproject1/viewModel/OpenAIAPIProvider.dart';
import 'package:examproject1/viewModel/homeViewModel.dart';
import 'package:examproject1/widgets/NextflixBottomNavigation.dart';
import 'package:examproject1/widgets/discoverWidget.dart';
import 'package:examproject1/widgets/trandWidget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';

double MediaQueryHeight= 0.0;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WakelockPlus.enable();

  try {
    await Firebase.initializeApp();

    final model =
    FirebaseVertexAI.instance.generativeModel(model: 'gemini-2.0-flash');

    final prompt = [Content.text('오늘 일자로 박스오피스 1위영화를 알려줘')];

    final response = await model.generateContent(prompt);
    print(response.text);
  }catch(e){}



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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  double scrollOffset = 0.0;
  Color appBarColor = Colors.transparent;
  late final ScrollController mainScrollController = ScrollController()
    ..addListener(() {
      setState(() {
        scrollOffset = mainScrollController.offset;
        if (scrollOffset > 100) {
          appBarColor = Colors.black38;
        } else {
          appBarColor = Colors.transparent;
        }
      });
    });

  @override
  void initState() {
    super.initState();

    // chkSplash(); //스플래시 체크

    context.read<HomeViewModel>().callDiscover(context);
    context.read<HomeViewModel>().trendingAllWeek();
    context.read<HomeViewModel>().trendingMovieDay();
    context.read<HomeViewModel>().trendingMovieWeek();
    context.read<HomeViewModel>().trendingTVDay();
  }

  chkSplash() {
    late AnimationController bottomPopupAniController;
    bottomPopupAniController = BottomSheet.createAnimationController(this);
    bottomPopupAniController.duration = const Duration(milliseconds: 0);
    bottomPopupAniController.reverseDuration =
        const Duration(milliseconds: 200);

    Future.delayed(const Duration(microseconds: 0), () {
      showModalBottomSheet(
          constraints: const BoxConstraints(
              maxWidth: double.infinity, minWidth: double.infinity),
          barrierColor: Colors.transparent,
          backgroundColor: Colors.white,
          isScrollControlled: true,
          transitionAnimationController: bottomPopupAniController,
          enableDrag: false,
          context: context,
          builder: (BuildContext context) {
            return Container(
              color: Colors.black,
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/netflix_logo.png',
                  width: MediaQuery.of(context).size.width >= 768
                      ? 768
                      : MediaQuery.of(context).size.width,
                  height: double.infinity,
                  fit: BoxFit.fitWidth),
            );
            // return your layout
          });
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: appBarColor,
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
        bottomNavigationBar: NextflixBottomNavigation());
  }
}
