import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';

@immutable
class ImageProvider {
  static const ImageProvider _instance = ImageProvider._internal();
  const ImageProvider._internal();

  factory ImageProvider() => _instance;

  Future<List<AssetEntity>> loadImages() async {
    PhotoManager.setIgnorePermissionCheck(true);
    final assets = await PhotoManager.getAssetPathList(type: RequestType.image);
    if (assets.isNotEmpty) {
      final images = await assets[0]
          .getAssetListRange(start: 0, end: await assets[0].assetCountAsync);
      return images;
    }
    return [];
  }

  Future<Uint8List?> getSelectedImage(int index) async {
    final images = await loadImages();
    final uint8List = await images[index].originBytes;
    return uint8List;
  }
}
