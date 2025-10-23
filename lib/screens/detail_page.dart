import 'package:flutter/material.dart';
import '../models/todo_entity.dart'; // ToDoEntity 모델 import

// '상세보기/수정' 페이지 위젯
class DetailPage extends StatefulWidget {
  final ToDoEntity toDo;

  const DetailPage({super.key, required this.toDo});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // '즐겨찾기'와 '세부정보'를 수정하기 위한 로컬 변수
  late bool _isFavorite;
  // (신규) '세부정보' 수정을 위한 텍스트 컨트롤러
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.toDo.isFavorite;
    //  컨트롤러를 'toDo' 객체의 'description' 값으로 초기화
    _descriptionController =
        TextEditingController(text: widget.toDo.description);
  }

 
  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  //  '뒤로 가기' 또는 '삭제' 시 HomePage로 데이터를 반환하는 함수
  void _popWithData(dynamic result) {
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // '뒤로 가기' 버튼 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // 뒤로 갈 때 '수정된 ToDoEntity' 객체를 반환
            final updatedTask = ToDoEntity(
              id: widget.toDo.id,
              title: widget.toDo.title,
              description: _descriptionController.text.isNotEmpty
                  ? _descriptionController.text
                  : null,
              isDone: widget.toDo.isDone,
              isFavorite: _isFavorite, // 수정된 즐겨찾기 상태
            );
            _popWithData(updatedTask);
          },
        ),
        // '즐겨찾기' 및 '삭제' 버튼
        actions: [
          // '즐겨찾기' 버튼
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.star : Icons.star_border,
              color: _isFavorite ? Colors.amber : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
          ),
          //  '삭제' 버튼
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.grey),
            onPressed: () {
              //  삭제 시 "DELETE" 문자열을 반환
              _popWithData("DELETE");
            },
          ),
        ],
      ),
      // '세부정보' 수정 본문 
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            // '세부정보'를 Text에서 TextField로 변경
            Expanded(
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: '세부정보 없음',
                  border: InputBorder.none, // 깔끔하게 밑줄 제거
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface,
                  height: 1.5,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null, // 무제한 줄바꿈
                autofocus: true, // 화면에 들어오면 바로 포커스
              ),
            ),
          ],
        ),
      ),
    );
  }
}
