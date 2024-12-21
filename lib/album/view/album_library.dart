import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_flutter_project/bottom_bar/mini_player/delegate/mini_player.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import '../../bottom_bar/bottom_bar.dart';
import 'package:first_flutter_project/bottom_bar/mini_player/inhereted_widget/mini_player_state.dart';
import '../../apis/last_fm.dart';
import 'package:get_it/get_it.dart';
import '../model/album_model.dart';
import 'album_full_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../delegate/album.dart';


class MusicLibrary extends ConsumerStatefulWidget {
  const MusicLibrary({super.key});

  @override
  _MusicLibraryState createState() => _MusicLibraryState();
}

class _MusicLibraryState extends ConsumerState<MusicLibrary> {
  bool showText = true;
  final int _albumCount = 20;
  final String _albumText = 'radiohead';
  LastFmApi lastFmApi = GetIt.instance<LastFmApi>();
  late final albums = lastFmApi.getAlbumBulk(_albumText, _albumCount);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Моя музыка'),
    ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.arrow_forward),
      //   onPressed: () { context.go('/articles'); },),
      bottomNavigationBar: const MyBottomBar(),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,      // Количество столбцов
              mainAxisSpacing: 10.0,   // Вертикальный отступ между элементами
              crossAxisSpacing: 10.0,  // Горизонтальный отступ между элементами
            ),
            shrinkWrap: true,
            itemCount: _albumCount,
            itemBuilder: (context, index) {
              return
                    FutureBuilder(
                        future: albums,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Пока ждем
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}"); // Обработка ошибок
                          } else if (snapshot.hasData) {
                            final albums = snapshot.data!;
                            return
                              GestureDetector(
                                key: ValueKey(index),
                                onTap: () => {
                                ref.read(albumProvider.notifier).update(albums[index]),
                                context.goNamed('Album')
                                },
                                child:Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0), // цвет фона
                                borderRadius: BorderRadius.circular(20),
                                ),
                                child:
                                    Center(
                                      child:
                                          Padding(padding: const EdgeInsets.all(10),
                                      child:
                                            Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                Container(
                                                  height: 90,
                                                  child:
                                                  ClipRRect(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                    child: CachedNetworkImage(imageUrl: albums[index].imageUrl,
                                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                      const CircularProgressIndicator(),
                                                      errorWidget: (context, url, error) => const Icon(Icons.error,
                                                        color: Colors.red,),
                                                    ),
                                                  )

                                                ),
                                                  Container(
                                                    child:
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Flexible(child:
                                                            Text(
                                                              albums[index].title,
                                                              style: const TextStyle(color: Colors.white),
                                                              textAlign: TextAlign.start,
                                                            )),
                                                          IconButton(
                                                            icon: const Icon(
                                                              Icons.play_arrow,
                                                              color: Colors.white,
                                                            ),
                                                            onPressed: () => {
                                                              ref.read(miniPlayerProvider.notifier).update(albums[index].title, albums[index].author),
                                                            },
                                                          ),
                                              ]
                                                      )
                                                  )
                                                ]
                                            )
                                          )
                                  )
                          )
                              );
                          } else {
                            return Text("Unknown state"); // Непредвиденная ситуация
                          }});
            },
            padding: const EdgeInsets.all(10),
          )
        )]
    )
    );
  }
}