import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 最後に読み取ったバーコードの値を保持
final barcodeValueProvider = StateProvider<String?>((ref) => null);
