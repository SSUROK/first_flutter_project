import 'package:first_flutter_project/album/model/album_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'album.g.dart';

@riverpod
class Album extends _$Album {

  @override
  AlbumModel build() => AlbumModel(title: '', imageUrl: '', author: '', id: '');

  void update(AlbumModel albumModel) => state = albumModel;
}