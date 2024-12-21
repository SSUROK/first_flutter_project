import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'mini_player/view/mini_player_view.dart';
import 'mini_player/delegate/mini_player.dart';

class MyBottomBar extends ConsumerStatefulWidget {
  const MyBottomBar({super.key});


  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends ConsumerState<MyBottomBar> {
  int _index = 0;

  // final Map _routes = {'Home':'/library', 'Articles': '/articles', 'Chats': '/chats'};

  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.music_note),
      label: 'Library',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.text_snippet),
      label: 'Articles',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.chat),
      label: 'Chats',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });

    String route = _items[index].label!;
    context.goNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    final miniPlayer = ref.watch(miniPlayerProvider);
    return
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
      children: [
        if (miniPlayer.trackName.isNotEmpty)
          const MiniPlayerView(),
        BottomNavigationBar(
        items: _items,
        currentIndex: _index, //New
        onTap: _onItemTapped,
      )
      ],
    );
  }
}