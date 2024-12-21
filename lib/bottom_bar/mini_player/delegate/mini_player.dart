import '../model/mini_player_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mini_player.g.dart';

@riverpod
class MiniPlayer extends _$MiniPlayer {

  @override
  MiniPlayerModel build() =>
      MiniPlayerModel('', '', false);

  void update(String name, String artist) => state = MiniPlayerModel(name, artist, true);
}