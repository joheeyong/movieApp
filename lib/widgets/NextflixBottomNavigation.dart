import 'package:examproject1/widgets/NewAndHot/NewAndHotScreen.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../viewModel/homeViewModel.dart';

class NextflixBottomNavigation extends StatefulWidget {
  const NextflixBottomNavigation({super.key});

  @override
  State<NextflixBottomNavigation> createState() =>
      NextflixBottomNavigationState();
}

class NextflixBottomNavigationState extends State<NextflixBottomNavigation> {
  final int _index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xff121212),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.home),
          activeIcon: Icon(LucideIcons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.gamepad2),
          activeIcon: Icon(LucideIcons.gamepad2),
          label: 'Games',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.youtube),
          activeIcon: Icon(LucideIcons.youtube),
          label: 'New & Hot',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.smile),
          activeIcon: Icon(LucideIcons.smile),
          label: 'Fast Laughs',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.download),
          activeIcon: Icon(LucideIcons.download),
          label: 'Downloads',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _index,
      selectedItemColor: Colors.white,
      onTap: (index) async {
        await context.read<HomeViewModel>().callDiscoverTV();
        await context.read<HomeViewModel>().callDiscoverMovie();
          if(index==2){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const NewAndHotScreen()));
          }

      },
    );
  }
}
