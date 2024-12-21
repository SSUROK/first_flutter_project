import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_flutter_project/album/delegate/album.dart';
import 'package:first_flutter_project/bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AlbumFullScreen extends ConsumerWidget {
  const AlbumFullScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumModel = ref.watch(albumProvider);
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Colors.blue,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(albumModel.title),
          centerTitle: true,
          actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back), // Иконка назад
            onPressed: () {
            context.pop();
            },
          )
          ],
        ),
          bottomNavigationBar: const MyBottomBar(),
          body:
              Center(
                child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(padding: const EdgeInsets.all(10),
                        child:
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(imageUrl: albumModel.imageUrl,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                            const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error,
                              color: Colors.red,),
                          ),
                        )
                      ),
                      Flexible(
                          child: Text(albumModel.title,)),
                      Flexible(
                          child: Text(albumModel.author,)),
                    ],
                  ),
                  Expanded(
                    child:
                    ListView.builder(
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return Padding(padding: const EdgeInsets.all(5),
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent, // цвет фона
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  'Song from album ${albumModel.title}',
                                  style: const TextStyle(color: Colors.white,
                                    fontSize: 15,),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ));
                      },
                    )
                  )
                ],
              ))
    );
  }
}