import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

// オリジナルウィジェット
import 'barcode.dart';

// provider変数
import '../provider/barcodeProvider.dart';


class barcodeReadWidget extends ConsumerWidget {
  const barcodeReadWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF66FF99),
        title: const Text('バーコード読取サンプル'),
      ),
      body: Stack(
        children: [
          // バーコード読み取り
          MobileScanner(
            onDetect:(capture){
              final barcode = capture.barcodes.firstOrNull;
              if (barcode != null) {
                // Riverpod に値を保存
                ref.read(barcodeValueProvider.notifier).state = barcode.displayValue ?? "値なし";

                // 画面遷移(スタックせずに置き換えで移動)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const barcodeWidget()),
                );
              }
            }
          ),
        ],
      )
    );
  }
}

