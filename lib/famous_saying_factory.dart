import 'dart:convert';
import 'package:flutter/widgets.dart';

import 'famous_saying.dart';

class FamousSayingFactory {
  static FamousSayingFactory instance = FamousSayingFactory._internal();

  FamousSayingFactory._internal();

  Future<FamousSaying> create(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/famous_saying.json");
    final jsonResult = json.decode(data);
    int diff = DateTime.now().difference(new DateTime(2020, 1, 1)).inDays;
    var fsJson = jsonResult[diff % jsonResult.length];
    FamousSaying fs = FamousSaying(fsJson["phrase"], fsJson["speaker"]);
    return fs;
  }
}
