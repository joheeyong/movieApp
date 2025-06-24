import 'package:examproject1/widgets/discoverWidget.dart';
import 'package:examproject1/widgets/trandWidget.dart';
import 'package:flutter/material.dart';

class CustomMainCustomScrollView extends StatelessWidget {
  ScrollController mainScrollController;

  CustomMainCustomScrollView(this.mainScrollController, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
    );
  }
}
