

import 'package:flutter/material.dart';
import '../models/todo_entity.dart'; // ToDoEntity 모델 import

// '상세보기' 페이지 위젯
class DetailPage extends StatefulWidget {
  // (과제 요구사항 #2) ToDoEntity를 받아서 화면 컨텐츠를 채움
  final ToDoEntity toDo;

  const DetailPage({super.key, required this.toDo});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late bool _isFavorite; // bool 타입의 로컬 변수 선언 - 내부 상태 관리용

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.toDo.isFavorite; // 'toDo' 객체로부터 초기 '즐겨찾기' 상태를 가져와 로컬 변수에 저장
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       //AppBar - leading (뒤로 가기 버튼)
       //back button을 통해서 뒤로가기 구현
       //pop할 때 변경된 _isFavorite 값을 반환
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, _isFavorite); // 현재 즐겨찾기 상태를 반환
          },
        ),
        //  AppBar - actions (즐겨찾기 버튼)
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.star : Icons.star_border,
              color: _isFavorite ? Colors.amber : Colors.grey,
            ),
            // favorite 변경 구현
            onPressed: () {
              // setState를 호출하여 이 페이지의 '즐겨찾기' 상태를 토글
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
          ),
        ],
      ),
      //  ToDoEntity로 컨텐츠 채우기
      body: Padding(
        // 좌우 패딩 20
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 텍스트를 왼쪽 정렬
          children: [
            // '할 일' 제목
            Text(
              widget.toDo.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // '할 일' 세부 설명
            // description이 null이거나 비어있으면 '세부정보 없음' 표시
            Text(
              widget.toDo.description ?? '세부정보 없음',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}