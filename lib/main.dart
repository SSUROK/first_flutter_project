import 'package:first_flutter_project/article/delegate/article.dart';
import 'package:first_flutter_project/article/view/article_full_screen.dart';
import 'package:first_flutter_project/settings/data/provider.dart';
import 'package:first_flutter_project/settings/view/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'album/delegate/album.dart';
import 'album/view/album_full_screen.dart';
import 'apis/free_sound.dart';
import 'album/view/album_library.dart';
import 'article/view/article_creation_page.dart';
import 'article/view/articles_page.dart';
import 'apis/last_fm.dart';
import 'settings/data/shared_preferences_puller.dart';
import 'bottom_bar/mini_player/inhereted_widget/mini_player_provider.dart';

void main() {
  GetIt.instance.registerSingleton<LastFmApi>(LastFmApi());
  GetIt.instance.registerSingleton<VeryStupidFileDownloader>(VeryStupidFileDownloader());
  GetIt.instance.registerSingleton<SharedPreferencePuller>(SharedPreferencePuller());
  runApp(
    const ProviderScope(
      child:
        MyApp()
      // PlayerProvider(
      //     child:
      //       MyApp()
      // )
    )
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends ConsumerState<MyApp> {

  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  late GoRouter _router;
  Color appBarColor = Colors.blue;

  void _changeAppBarColor(color) {
    setState(() => appBarColor = color);
  }

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: '/library',
      navigatorKey: _rootNavigatorKey,
      routes: [
        GoRoute(
          path: '/library',
          name: 'Library',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: MusicLibrary(),
          ),
        ),
        GoRoute(
          path: '/library/album',
          name: 'Album',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: AlbumFullScreen(),
          ),
        ),
        GoRoute(
          path: '/articles',
          name: 'Articles',
          pageBuilder: (context, state) => NoTransitionPage(
            child: ArticlesPage(),
          ),
        ),
        GoRoute(
          path: '/chats',
          name: 'Chats',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SettingsScreen(),
          ),
        ),
        GoRoute(
          path: '/articles/create',
          name: 'Article Crate',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ArticleCreationPage(),
          ),
        ),
        GoRoute(
          path: '/articles/one',
          name: 'Article',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ArticleFullScreen(),
          ),
        ),
      ],
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ref.watch(articleProvider);
    ref.watch(albumProvider);
    final isDarkTheme = ref.watch(themeProvider);
    return
       MaterialApp.router(routerConfig: _router,
         theme: ThemeData.light(),
         darkTheme: ThemeData.dark(),
         themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,);
  }
}