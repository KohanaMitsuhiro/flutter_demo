import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// オリジナルウィジェット
import 'barcode_read.dart';

// provider変数
import '../provider/barcodeProvider.dart';

class barcodeWidget extends ConsumerWidget {
  const barcodeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final barcodeValue = ref.watch(barcodeValueProvider);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF66FF99),
        title: const Text('バーコードサンプル'),
      ),
    
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("バーコードの値を読み取ります"),

            SizedBox(height: 20,),

            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const barcodeReadWidget()),
                );
              },
              child: const Text('バーコード読取へ'),
            ),

            SizedBox(height: 20,),

            if(barcodeValue != null)
              Text(
                "バーコード値：${barcodeValue}",
                style: TextStyle(
                  color: Colors.blue, 
                  fontSize: 16,
                ),
              )
          ],
        )
      )
    );
  }
}

