
import 'package:flutter_riverpod/flutter_riverpod.dart';

// カウントアップ用のプロバイダー変数
final countUpProvider = StateProvider((ref) => 0);

// API受け取り用のプロバイダー変数
final responseProvider = StateProvider((ref) => "");