import 'dart:math';

import 'package:examproject1/widgets/NewAndHot/viewportOffset.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NewAndHotHeaderDelegate extends SliverPersistentHeaderDelegate {
  NewAndHotHeaderDelegate({required this.tabController, required this.scrollController,});

  final TabController tabController;
  final ScrollController scrollController;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(0xff010101),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text('공개예정',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              Stack(
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(LucideIcons.bell)),
                  Positioned(
                    right: 6.0,
                    top: 2.0,
                    child: Container(
                      padding: const EdgeInsets.all(1.0),
                      constraints: const BoxConstraints(
                        minWidth: 18.0,
                        minHeight: 18.0,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(100.0)),
                      child: const Text(
                        '1',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 38.0,
            child: TabBar(
              onTap: (index){

                    scrollController.animateTo(tabController.index * 3001.0,
                        curve: Curves.linear,
                        duration: const Duration(milliseconds: 50));

              },
              controller: tabController,
              indicatorPadding: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              isScrollable: true,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                color: const Color.fromARGB(255, 248, 248, 248),
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              splashFactory: NoSplash.splashFactory,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              tabs:[
                Tab(
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/popcorn.png",
                          width: 20.0,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        const Text(
                          'TV프로그램   ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                Tab(
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/fire.png",
                          width: 20.0,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        const Text(
                          '영화  ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                Tab(
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/controller.png",
                          width: 20.0,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        const Text(
                          '프로그램  ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 96.0;

  @override
  double get minExtent => 96.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
