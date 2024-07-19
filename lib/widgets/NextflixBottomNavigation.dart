import 'package:examproject1/widgets/NewAndHotScreen.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';


class NextflixBottomNavigation extends StatefulWidget {
  const NextflixBottomNavigation({super.key});

  @override
  State<NextflixBottomNavigation> createState() =>
      _NextflixBottomNavigationState();
}

class _NextflixBottomNavigationState extends State<NextflixBottomNavigation> {
  int _index = 0;
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
      onTap: (index) {

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
