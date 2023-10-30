library image_to_color_palette;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'function.dart';

class Palette {
  List<Color> _palette = [];

  Future<Uint8List> _imageToBytes({required String imageUrl}) async {
    var imageBytes =
        (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
            .buffer
            .asUint8List();
    return imageBytes;
  }

  Future<List<Color>> _getPalette({required Uint8List bytes}) async {
    _palette = await compute(generatePalette,
        {keyPalette: extractPixelsColors(bytes), keyNoOfItems: 6});
    return _palette = sortColors(_palette);
  }

 Future<List<Color>> imagePalette({required String imageUrl}) async {
    final bytes = await _imageToBytes(imageUrl: imageUrl);
    return _getPalette(bytes: bytes);
  }
}
