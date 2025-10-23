import 'package:flutter/material.dart';
import 'screens/home_page.dart'; // HomePage를 사용하기 위해 import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks App',
      // 라이트 모드 테마
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.light,
        ),
        // 라이트 모드의 Scaffold 배경색
        scaffoldBackgroundColor: Colors.grey[50],
        useMaterial3: true,
      ),
      // 다크 모드 테마
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark, // 다크 모드
        ),
        // 다크 모드의 Scaffold 배경색
        scaffoldBackgroundColor: Colors.grey[900], // 다크 모드일때 배경색 설정.
        useMaterial3: true,
      ), 
      themeMode: ThemeMode.system, // 시스템 설정에 따라 라이트/다크 모드 자동 적용
     

      home: const HomePage(),
    );
  }
}

