import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../delegate/mini_player.dart';


class MiniPlayerView extends ConsumerWidget {
  const MiniPlayerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final miniPlayerState = ref.watch(miniPlayerProvider);
    return GestureDetector(
      // onTap: onTap, // Переход в полный экран плеера
      child: Container(
        color: Colors.blueGrey[900],
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  miniPlayerState.trackName,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  miniPlayerState.artist,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                miniPlayerState.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: null,
            ),
          ],

        ),
      ),
    );
  }
}