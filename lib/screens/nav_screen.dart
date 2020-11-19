import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/cubits/cubits.dart';
import 'package:netflix/widgets/widgets.dart';
import 'screens.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    // PageStorageKey key 를 보내면 현재 다른 화면으로 갔다 와도 현재 스크롤 위치를 기억함
    HomeScreen(key: PageStorageKey('homeScreen')),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  final Map<String, IconData> _icons = const {
    'Home': Icons.home,
    'Search': Icons.search,
    'Comming Soon': Icons.queue_play_next,
    'Downloads' : Icons.file_download,
    'More': Icons.menu,
  };

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold( // 현재 선택된 화면을 나타냄.
      // BlocProvider cubit으로 현재 스크롤 offset 처리..?
      body: BlocProvider<AppBarCubit>(
          create: (_) => AppBarCubit(),
          child: _screens[_currentIndex]
      ), // _screen list에 있는 index 값에 따라 화면을 표시, 첫화면 0 index는 Homescreen
        // 데스크탑 모드가 아닐 경우에만 네비 바를 보여주고 : 그렇지 않으면 null 로 숨김
      bottomNavigationBar: !Responsive.isDesktop(context) ?
      BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: _icons
            .map(
              (title, icon) => MapEntry(
                title,
                BottomNavigationBarItem(
                  icon: Icon(icon, size: 30.0),
                  label: title
                ),
              ),
            )
            .values
            .toList(),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        selectedFontSize: 11.0,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 11.0,
        onTap: (index) => setState(() => _currentIndex = index ),
      ) : null
    );
  }
}
