import 'dart:async';

import 'package:flutter/services.dart';

class Xpath {
  static const MethodChannel _channel = const MethodChannel('com.ii6.xpath');

  static Future<dynamic> parse(String html) async {
    final val =
        await _channel.invokeMethod('parse', <String, String>{'html': html});

    return val;
  }

  /// return String or Null.
  static Future<String?> parseString(String rule) async {
    final String? node = await _channel
        .invokeMethod('parseString', <String, dynamic>{'rule': rule});

    return node;
  }

  /// return List or Null.
  static Future<List?> parseList(String rule) async {
    final List? node = await _channel
        .invokeMethod('parseList', <String, dynamic>{'rule': rule});

    return node;
  }

  /// return List title and href
  static Future<List?> parseListTitleAndHref(String rule) async {
    final node = await _channel
        .invokeMethod('parseListTitleAndHref', <String, dynamic>{'rule': rule});

    return node;
  }
}
