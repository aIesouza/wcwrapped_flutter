import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareCardHelper {
  static Future<void> shareBoundaryImage(
    RenderRepaintBoundary boundary, {
    String fileName = 'wrapped_recap_card.png',
    String text = 'My Wrapped Recap',
    double pixelRatio = 3.0,
  }) async {
    final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      throw Exception('Could not convert card to PNG bytes.');
    }

    final Uint8List pngBytes = byteData.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(pngBytes, flush: true);

    await Share.shareXFiles(
      [XFile(file.path)],
      text: text,
    );
  }
}