// ignore_for_file: unrelated_type_equality_checks, non_constant_identifier_names

import 'dart:math';
import 'package:examproject1/widgets/NewAndHot/viewportOffset.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/movie.dart';
import '../../viewModel/homeViewModel.dart';
import 'NewAndHotHeaderDelegate.dart';
import 'NewAndHotTile.dart';

class NewAndHotScreen extends StatefulWidget {
  const NewAndHotScreen({super.key});

  @override
  State<NewAndHotScreen> createState() => _NewAndHotScreenState();
}

class _NewAndHotScreenState extends State<NewAndHotScreen>
    with SingleTickerProviderStateMixin {
  late final ScrollController scrollController = ScrollController()
    ..addListener(() {
      if (scrollController.position.userScrollDirection !=
          ScrollDirection.idle) {
        int newIndex = max(0, min(scrollController.offset ~/ 3000, 2));
        if (tabController.index != newIndex) {
          tabController.animateTo(newIndex);
        }
      }
    });

  late final TabController tabController = TabController(length: 3, vsync: this)
    ..addListener(() {
      if (tabController.indexIsChanging &&
          scrollController.position.userScrollDirection ==
              ScrollDirection.idle) {
        var offset = scrollController.offset,
            minRange = offset - 300,
            maxRange = offset + 300,
            offsetTo = tabController.index * 3000.0;

        if (!(minRange <= offsetTo && maxRange >= offsetTo)) {
          scrollController.animateTo(tabController.index * 3000.0,
              curve: Curves.linear,
              duration: const Duration(milliseconds: 1000));
        }
      }
    });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPersistentHeader(
            delegate: NewAndHotHeaderDelegate(
              tabController: tabController,
              scrollController: scrollController,
            ),
            pinned: true,
          ),
          Builder(builder: (context) {
            Movie? DiscoverType = context.read<HomeViewModel>().DiscoverTV;
            return DiscoverType != null
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => NewAndHotTile(
                            movie: DiscoverType.results[index], type: "tv"),
                        childCount: DiscoverType.results.length))
                : const SliverToBoxAdapter();
          }),
          Builder(builder: (context) {
            Movie? DiscoverType = context.read<HomeViewModel>().DiscoverMovie;
            return DiscoverType != null
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => NewAndHotTile(
                            movie: DiscoverType.results[index], type: "movie"),
                        childCount: DiscoverType.results.length))
                : const SliverToBoxAdapter();
          }),
        ],
      ),
    );
  }
}
