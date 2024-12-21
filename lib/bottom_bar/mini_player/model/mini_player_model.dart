class MiniPlayerModel {
  String _trackName;
  String _artist;
  bool _isPlaying;

  MiniPlayerModel(this._trackName, this._artist, this._isPlaying);

  bool get isPlaying => _isPlaying;

  set isPlaying(bool value) {
    _isPlaying = value;
  }

  String get artist => _artist;

  set artist(String value) {
    _artist = value;
  }

  String get trackName => _trackName;

  set trackName(String value) {
    _trackName = value;
  }
// final String author;



}