
import 'package:flutter/material.dart';
import '../models/todo_entity.dart'; // ToDoEntity 모델 import

// ToDoEntity 를 인자로 받는 ToDoView 위젯 만들기
class ToDoView extends StatelessWidget {
  final ToDoEntity toDo; // final 속성으로 ToDoEntity 받음.
  final VoidCallback onToggleDone;
  final VoidCallback onToggleFavorite;
  final VoidCallback onDelete; // # 나만의 기능 추가 : 삭제 함수 추가
  final VoidCallback onTap; // 상세보기를 위한 탭 불러오기

  const ToDoView({  // 생성자
    super.key,
    required this.toDo,
    required this.onToggleDone,
    required this.onToggleFavorite,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // 탭할 때 상세보기 띄우기
      borderRadius: BorderRadius.circular(12), // 물결 효과가 둥글게 퍼지도록
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // 외부 여백: 수직 8, 수평 16
        padding: const EdgeInsets.symmetric(horizontal: 16), // 내부 여백 : 수평 16
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,  // 다크 모드 호환 배경색
          borderRadius: BorderRadius.circular(12), // 모서리 둥글게
          boxShadow: [  // 박스 그림자 효과 추가
            BoxShadow(
              color: Colors.black.withAlpha(13),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          
          children: [
            IconButton( // 'Done' 상태 아이콘
              visualDensity: VisualDensity.compact, // 아이콘 여백 줄이기
              icon: Icon(
                toDo.isDone ? Icons.check_circle : Icons.circle_outlined,
                color: toDo.isDone ? Colors.deepOrange : Colors.grey,
              ),
              onPressed: onToggleDone, // 외부 함수 호출
            ),
            const SizedBox(width: 12), // 아이콘과 텍스트 사이 간격

            Expanded(
              child: Text(
                toDo.title,
                style: TextStyle(
                  fontSize: 16,
                  decoration: toDo.isDone
                      ? TextDecoration.lineThrough // 완료된 할 일은 취소선 표시
                      : TextDecoration.none, // 완료되지 않은 할 일은 취소선 없음
                  color: toDo.isDone
                      ? Colors.grey
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),

            IconButton(  // 별표 아이콘 추가
              visualDensity: VisualDensity.compact, // 아이콘 여백 줄이기
              icon: Icon(
                toDo.isFavorite ? Icons.star : Icons.star_border,
                color: toDo.isFavorite ? Colors.amber : Colors.grey,
              ),
              onPressed: onToggleFavorite, // 외부 함수 호출
            ),

            IconButton( // 나만의 기능 추가 : 삭제 아이콘 버튼
              visualDensity: VisualDensity.compact, // 아이콘 여백 줄이기
              icon: const Icon(Icons.delete_outline, color: Colors.grey),
              onPressed: onDelete, // 외부 함수 호출
            ),
          ],
        ),
      ),
    );
  }
}
