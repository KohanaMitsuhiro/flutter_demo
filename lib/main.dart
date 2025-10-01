import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // jsonを使用するのに用いている

// オリジナルウィジェット
import 'barcode/barcode.dart';

// provider変数
import '../provider/counterProvider.dart';
import '../provider/barcodeProvider.dart';


// --- メイン関数 ---
void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: "tech0サンプル",
        home: const countUpDemo(),
      )
    )
  );
}

// --- ページ作成 ---
class countUpDemo extends ConsumerWidget {
  const countUpDemo({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final conuntNum = ref.watch(countUpProvider);
    final res = ref.watch(responseProvider);


    return Scaffold(
      // --- ヘッダー部分 ---
      appBar: AppBar(
        title: Text("カウントアップデモ"),
        centerTitle: true, // タイトルを中央に配置
      ),

      // --- ページの中身 ---
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("+ボタンを押すとカウントアップします"),

            SizedBox(height: 20,),

            Text(
              "$conuntNum",
              style: TextStyle(
                color: Colors.black, 
                fontSize: 24,
              ),
            ),

            SizedBox(height: 20,),
            
            ElevatedButton(
              onPressed: () {
                // カウントアップの数値を送る
                final res = sendCount(conuntNum);
                res.then((value) {
                  ref.read(responseProvider.notifier).state = value;
                });
              },
              child: const Text('送信'),
            ),

            if(res != null) 
              Text("結果: $res"),
            
            SizedBox(height: 40,),

            Text("====== 以下、Want宿題用 ======"),

            SizedBox(height: 20,),

            ElevatedButton(
              onPressed: () {
                // バーコード値をクリア
                ref.read(barcodeValueProvider.notifier).state = null;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const barcodeWidget()),
                );
              },
              child: const Text('バーコード読取へ'),
            ),
          ],
        ),
      ),

      // --- ボタン作成 ---
      floatingActionButton:FloatingActionButton(
        // ボタンを押した時の処理
        onPressed:(){
            // リバーポッド変数の読込みと更新
            final _cntNotifier = ref.read(countUpProvider.notifier);
            _cntNotifier.state += 1;
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), 
    );
  }
}


// httpリクエスト関数
// --- backend
const baseUrl = "localhost:8000"; // backendのURL

Future<String> sendCount(int count) async {
  final url = Uri.http(baseUrl, '/count', {'value': count.toString()});
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['result'];
    } else {
      return "${response.statusCode}";
    }
  } catch (e) {
    return "エラー！";
  }
  
}
