import 'package:flutter/material.dart';

// '할일이 없을 때 보여주는 화면'을 별도의 위젯으로 컴포넌트화
class NoToDoView extends StatelessWidget {
  final String title;
  const NoToDoView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // Center 대신 Align을 사용해 상단으로 이동
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        // 상단에도 20의 여백을 줌
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            // 다크모드 호환을 위해 테마의 surface 색 사용
            // Theme.of(context).colorScheme.surface는
            // 라이트 모드에서는 '흰색' 계열, 다크 모드에서는 '어두운 회색' 계열로 자동 변경됩니다.
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // 내용물 크기만큼만 차지
            children: [
              Image.asset(
                'assets/images/no_todo.webp',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 12),
              const Text(
                '아직 할 일이 없음',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '할 일을 추가하고 멋진 하루를\n보내보세요! $title\가 응원해요!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}