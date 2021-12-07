import 'dart:convert';

import 'package:flutter/services.dart';

class ApiKeysDecoder {
  Future<dynamic> decoder() async {
    final String configFile =
        await rootBundle.loadString('assets/api_keys/api_keys.json');
    final configData = jsonDecode(configFile);
    return configData;
  }
}
