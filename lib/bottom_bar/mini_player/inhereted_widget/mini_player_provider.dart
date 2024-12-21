import 'mini_player_state.dart';
import 'package:flutter/cupertino.dart';

class PlayerProvider extends StatefulWidget {
  final Widget child;

  const PlayerProvider({super.key, required this.child});

  @override
  _PlayerProviderState createState() => _PlayerProviderState();
}

class _PlayerProviderState extends State<PlayerProvider> {
  String _trackName = "";
  String _artist = "";
  bool _isPlaying = false;

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _changeTrack(String trackName, String artist) {
    setState(() {
      _trackName = trackName;
      _artist = artist;
      _isPlaying = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MiniPlayerState(
      trackName: _trackName,
      artist: _artist,
      isPlaying: _isPlaying,
      togglePlayPause: _togglePlayPause,
      changeTrack: _changeTrack,
      child: widget.child,
    );
  }
}
