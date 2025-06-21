import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// provider変数
import '../provider/counterProvider.dart';


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
