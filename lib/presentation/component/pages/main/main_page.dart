import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('홈'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('홈 화면입니다 👋'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('홈에서 버튼 클릭됨!');
              },
              child: const Text('테스트 버튼'),
            ),
          ],
        ),
      ),
    );
  }
}
