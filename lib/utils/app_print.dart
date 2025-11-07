import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppLogs {
  static bool enableLogs = true;
  static List<String> ignoreTags = [];

  static void log(
      dynamic message, {
        String tag = 'LOG',
        Color color = Colors.blue,
      }) {
    if (!enableLogs) return;

    // Skip ignored tags
    for (final ignoreWord in ignoreTags) {
      if (tag.toLowerCase().contains(ignoreWord.toLowerCase())) return;
    }

    // Format message
    String output = _formatMessage(message);

    // Map Flutter Color to ANSI color code
    final ansiColor = _ansiColorCode(color);
    final reset = '\x1B[0m';

    debugPrint('$ansiColor[$tag] $output$reset');
  }

  /// Recursive helper to format Map/List inside any message
  static String _formatMessage(dynamic msg) {
    if (msg is Map || msg is List) {
      try {
        const encoder = JsonEncoder.withIndent('  ');
        return encoder.convert(msg);
      } catch (e) {
        return msg.toString();
      }
    } else if (msg is String) {
      return msg;
    } else {
      return msg.toString();
    }
  }

  static String _ansiColorCode(Color color) {
    if (color == Colors.red) return '\x1B[31m';
    if (color == Colors.green) return '\x1B[32m';
    if (color == Colors.yellow) return '\x1B[33m';
    if (color == Colors.blue) return '\x1B[34m';
    if (color == Colors.purpleAccent) return '\x1B[35m';
    if (color == Colors.cyan) return '\x1B[36m';
    if (color == Colors.white) return '\x1B[37m';
    return '\x1B[0m';
  }
}

