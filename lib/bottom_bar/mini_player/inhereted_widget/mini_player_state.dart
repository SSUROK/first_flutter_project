import 'package:flutter/cupertino.dart';

class MiniPlayerState extends InheritedWidget {
  final String trackName;
  final String artist;
  final bool isPlaying;
  final Function() togglePlayPause;
  final Function(String, String) changeTrack;

  const MiniPlayerState({
    super.key,
    required this.trackName,
    required this.artist,
    required this.isPlaying,
    required this.togglePlayPause,
    required this.changeTrack,
    required super.child,
  });

  static MiniPlayerState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MiniPlayerState>();
  }

  @override
  bool updateShouldNotify(MiniPlayerState oldWidget) {
    return trackName != oldWidget.trackName ||
        artist != oldWidget.artist ||
        isPlaying != oldWidget.isPlaying;
  }
}
