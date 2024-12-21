import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../album/model/album_model.dart';

class LastFmApi{

  final apiKey = '5d86e9d853b77f14081f0d225d5a9426';

  Future<List<AlbumModel>> _fetchAlbumByText(String albumText, { int limit = 20}) async {
    final url = Uri.parse(
      'https://ws.audioscrobbler.com/2.0/?format=json&method=album.search&album=$albumText&api_key=$apiKey&limit=$limit',
    );
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/${albumText}_cache.txt');
    List<AlbumModel> albums = [];
    try {
      final FileStat fileStat = await file.stat();
      var text = await file.readAsString();
      if (text.isNotEmpty &&
          fileStat.modified.compareTo(DateTime.now().subtract(Duration(days: 1))) > 0 ) {
        final data = json.decode(text);
        for (int i = 0; i < limit; i++) {
          albums.add(AlbumModel.fromJson(data[i]));
        }
      }
    } catch (e) {
      print('Exception: $e');
    }
    if (albums.isNotEmpty) {
      return albums;
    }
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final a = data['results']['albummatches']['album'];
        file.create(recursive: true);
        await file.writeAsString(json.encode(a));
        for (int i = 0; i < limit; i++) {
          albums.add(AlbumModel.fromJson(a[i]));
        }
      } else {}
    } catch (e) {
      print('Exception: $e');
    }
    return albums;
  }

  // Album? getAlbumById(albumId){
  //   Album? album;
  //   _fetchAlbum(albumId).then(
  //           (value) => album = value
  //   );
  //   return album;
  // }

  Future<List<AlbumModel>> getAlbumBulk(String textForSearch, int numberOfAlbums) async {
    var albums = _fetchAlbumByText(textForSearch, limit: numberOfAlbums);
    return albums;
  }

}
