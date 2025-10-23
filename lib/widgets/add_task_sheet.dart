

import 'package:flutter/material.dart';
import '../models/todo_entity.dart'; // ToDoEntity 모델 import

// '할 일 추가' 바텀 시트 위젯
class AddTaskSheet extends StatefulWidget {// StatefulWidget 상속
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  // 텍스트 필드 제어를 위한 컨트롤러
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  // '새 할 일' TextField에 자동으로 포커스를 주기 위한 FocusNode
  final _titleFocusNode = FocusNode();

  // 바텀 시트 내부의 상태 변수
  bool _isFavorite = false;
  bool _isDescriptionVisible = false;
  bool _isSaveButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    //'새 할 일' TextField에 자동으로 포커스 잡기
    _titleFocusNode.requestFocus();

    // 텍스트 내용이 바뀔 때마다 _isSaveButtonEnabled 상태를 업데이트
    _titleController.addListener(() {
      setState(() {
        _isSaveButtonEnabled = _titleController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    // 컨트롤러와 포커스 노드는 메모리 누수 방지를 위해 반드시 dispose()
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  // '저장' 버튼을 누르거나 '새 할 일' 필드에서 '완료'를 눌렀을 때 호출
  void _saveTask() {
    final title = _titleController.text;
    final description = _descriptionController.text;

    // (도전 과제 #3) UX 개선: title이 비어있으면 스낵바를 띄움
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('할 일을 입력해주세요.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
      return; // 함수 종료
    }

    final newTask = ToDoEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // ID
      title: title,
      description: description.isNotEmpty ? description : null, // 비어있으면 null
      isFavorite: _isFavorite,
    );

    // (과제 요구사항 #2) Navigator.pop으로 'newTask' 객체를 HomePage로 반환
    Navigator.pop(context, newTask);
  }

  @override
  Widget build(BuildContext context) {
    // (과제 요구사항 #1) 키보드 위로 바텀 시트가 올라오도록
    // MediaQuery.of(context).viewInsets.bottom (키보드 높이) 만큼 패딩
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      // (과제 요구사항 #3) 세부사항(Expanded)이 늘어날 수 있도록 Flexible
      child: Flexible(
        // 다크모드 호환을 위해 Container 대신 Material 사용
        child: Material(
          // (과제 요구사항 #1) 좌우 패딩 20, 위 패딩 12
          child: Container(
            padding: const EdgeInsets.only(top: 12, left: 20, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 내용물 크기만큼만
              children: [
             
                TextField(
                  controller: _titleController,
                  focusNode: _titleFocusNode,
                  // (과제 요구사항 #1) 텍스트 스타일
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: '새 할 일',
                    border: InputBorder.none, // 밑줄 제거 
                    hintStyle: TextStyle(fontSize: 16),
                  ),
                
                  textInputAction: TextInputAction.done,
                  // '완료' 눌렀을 때 _saveTask 호출
                  onSubmitted: (_) => _saveTask(),
                ),

                // --- 2. '세부정보 추가' TextField (조건부 렌더링) ---
               
                if (_isDescriptionVisible)
                  // Expanded로 감싸서 남은 공간을 차지
                  Expanded(
                    child: TextField(
                      controller: _descriptionController,
                      autofocus: true, // 나타날 때 자동으로 포커스
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: '세부정보 추가',
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 14),
                      ),
                
                      keyboardType: TextInputType.multiline, // 줄바꿈이 가능하도록 설정
                      maxLines: null, // 무제한 줄
                    ),
                  ),

                // --- 3. 아이콘 및 저장 버튼 Row ---
                Row(
                  children: [
                    // 세부정보 아이콘
                    // _isDescriptionVisible가 false일 때만 보임
                    if (!_isDescriptionVisible)
                      IconButton(
                        icon: const Icon(Icons.short_text_rounded, size: 24),
                        onPressed: () {
                          setState(() {
                            _isDescriptionVisible = true;
                          });
                        },
                      ),

                    // 별표 아이콘
                    IconButton(
                      icon: Icon(
                        _isFavorite ? Icons.star : Icons.star_border,
                        size: 24,
                      ),
                      onPressed: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                      },
                    ),

                    const Spacer(), // 아이콘과 버튼 사이 공간

                    // 저장 버튼
                    TextButton(
                      // _isSaveButtonEnabled 상태에 따라 onPressed를 null로 (비활성화)
                      onPressed: _isSaveButtonEnabled ? _saveTask : null,
                      child: Text(
                        '저장',
                        style: TextStyle(
                          // 활성화/비활성화 색상 구분
                          color: _isSaveButtonEnabled
                              ? Colors.deepOrange
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}