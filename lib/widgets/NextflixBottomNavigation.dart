// ignore_for_file: use_build_context_synchronously, file_names

import 'package:examproject1/widgets/NewAndHot/NewAndHotScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../viewModel/homeViewModel.dart';
import 'DownLoad/DownLoadScreen.dart';

class NextflixBottomNavigation extends StatefulWidget {
  const NextflixBottomNavigation({super.key});

  @override
  State<NextflixBottomNavigation> createState() =>
      NextflixBottomNavigationState();
}

class NextflixBottomNavigationState extends State<NextflixBottomNavigation> {
  final int navigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xff121212),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.home),
          activeIcon: Icon(LucideIcons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.youtube),
          activeIcon: Icon(LucideIcons.youtube),
          label: '공개예정',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.download),
          activeIcon: Icon(LucideIcons.download),
          label: '최근본영상',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: navigationIndex,
      selectedItemColor: Colors.white,
      onTap: (index) async {
        await context.read<HomeViewModel>().callDiscoverTV();
        await context.read<HomeViewModel>().callDiscoverMovie();
        if (index == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const NewAndHotScreen()));
        }
        if (index == 2) {
              Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const ProviderScope(child: DownLoadScreen())));
        }
      },
    );
  }
}
