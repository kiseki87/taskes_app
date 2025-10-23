import 'package:flutter/material.dart';
import '../widgets/no_todo_view.dart'; // '할 일 없음' 위젯
import '../widgets/todo_view.dart'; // '할 일' 항목 위젯
import '../widgets/add_task_sheet.dart'; // '할 일 추가' 바텀 시트 위젯
import '../models/todo_entity.dart'; // 'ToDoEntity' 데이터 모델
import 'detail_page.dart'; // '상세보기' 페이지


// 'HomePage'라는 이름의 새로운 위젯 클래스를 선언합니다.
// 예를 들어, 할 일 목록이 추가되거나, 체크박스가 눌리는 등 화면의 변화가 필요할 때 사용합니다.
class HomePage extends StatefulWidget { // StatefulWidget을 상속. Statefulwidget으로 State를 가질 수 있게 적용.
  // 'const' 생성자입니다. 위젯의 기본 속성을 설정합니다.
  const HomePage({super.key});

  // '@override'는 부모 클래스(StatefulWidget)의 메서드를 재정의한다는 의미입니다.
  // 'createState' 메서드는 이 StatefulWidget과 짝이 되는 State 객체를 생성하여 반환합니다.
  // Flutter는 이 State 객체를 사용해 화면을 그리고 데이터를 관리합니다.
  @override
  State<HomePage> createState() => _HomePageState(); // State 클래스 생성.
}

// 'HomePage' 위젯의 실제 '상태(State)'를 관리하는 클래스입니다.
class _HomePageState extends State<HomePage> {
  // 할 일 목록을 담을 리스트 (State)
  final List<ToDoEntity> _tasks = [];

  // --- '할 일' 상태 변경 함수들 ---

  // '완료' 상태 토글 함수
  void _toggleDone(String id) {
    setState(() {
      // 리스트에서 ID가 일치하는 task(toDo)를 찾습니다.
      final task = _tasks.firstWhere((task) => task.id == id);
      // 리스트에서 해당 task의 인덱스(순서)를 찾습니다.
      final taskIndex = _tasks.indexOf(task);
      // 찾은 인덱스 위치의 task를 'isDone' 상태만 반전시킨 새 task 객체로 교체합니다.
      _tasks[taskIndex] = ToDoEntity(
        id: task.id,
        title: task.title,
        description: task.description,
        isDone: !task.isDone, // '완료' 상태를 반전 (toggle)
        isFavorite: task.isFavorite,
      );
    });
  }

  // '즐겨찾기' 상태 토글 함수
  void _toggleFavorite(String id) {
    setState(() {
      final task = _tasks.firstWhere((task) => task.id == id);
      final taskIndex = _tasks.indexOf(task);
      _tasks[taskIndex] = ToDoEntity(
        id: task.id,
        title: task.title,
        description: task.description,
        isDone: task.isDone,
        isFavorite: !task.isFavorite, // '즐겨찾기' 상태를 반전 (toggle)
      );
    });
  }

  // '할 일' 삭제 함수
  void _deleteTask(String id) {
    setState(() {
      // 리스트에서 ID가 일치하는 task를 제거합니다.
      _tasks.removeWhere((task) => task.id == id);
    });
  }

  // (신규) '상세보기' 페이지로 이동하는 함수
  void _navigateToDetail(ToDoEntity toDo) {
    // Navigator.push로 새 화면을 띄우고, .then()으로 돌아왔을 때의 값을 받습니다.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => DetailPage(toDo: toDo)),
    ).then((returnedFavoriteStatus) {
      // DetailPage에서 pop으로 반환한 값(즐겨찾기 상태)을 받습니다.
      // (과제 요구사항 #3)
      // 돌아온 값이 null이 아니고, 원래의 즐겨찾기 상태와 다르다면
      if (returnedFavoriteStatus != null &&
          returnedFavoriteStatus != toDo.isFavorite) {
        // HomePage의 _toggleFavorite 함수를 호출하여 _tasks 리스트의 상태를 갱신합니다.
        _toggleFavorite(toDo.id);
      }
    });
  }
  // ---

  // 플로팅 버튼(+)을 눌렀을 때 '바텀 시트'를 띄우는 함수
  void _addAddTodo() {
    // (과제 요구사항에 따라 'Task'에서 'ToDoEntity'로 이름 변경)
    showModalBottomSheet<ToDoEntity?>(
      context: context,
      isScrollControlled: true,
      // (도전 과제 #2) 분리된 AddTaskSheet 위젯 사용
      builder: (ctx) {
        return const AddTaskSheet();
      },
    ).then((newTask) {
      if (newTask != null) {
        setState(() {
          _tasks.add(newTask);
        });
      }
    });
  }

  // '@override'
  // 이 'build' 메서드는 '_HomePageState'의 UI를 그리는 핵심 메서드입니다.
  // 'setState()'가 호출될 때마다 이 'build' 메서드가 다시 실행되어 화면이 갱신됩니다.
  @override
  Widget build(BuildContext context) {
    const String appBarTitle = '창수의 Tasks'; // AppBar 제목을 변수로 사용

    // 'Scaffold'는 머티리얼 디자인 입니다.
    return Scaffold(
      // (과제 요구사항 #4)
      // resizeToAvoidBottomInset: false로 설정하면
      // 키보드가 올라와도 Scaffold의 본문(body)이 밀려 올라가지 않습니다.
      // 덕분에 FloatingActionButton의 위치가 고정됩니다.
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // (도전 과제 #1) AppBar의 배경색을 테마의 Scaffold 배경색과 맞춥니다.
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0, // AppBar 그림자 제거
        title: Text(
          appBarTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            // (도전 과제 #1) 테마에 맞는 텍스트 색상
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      // 'body' 속성: 조건부 렌더링
      // (과제 요구사항 #7)
      body: _tasks.isEmpty
          ? NoToDoView(title: appBarTitle) // 목록이 비었을 때
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                // 현재 인덱스에 해당하는 'toDo' 객체
                final toDo = _tasks[index];
                // (도전 과제 #2) 분리된 ToDoView 위젯 사용
                return ToDoView(
                  toDo: toDo,
                  // (과제 요구사항 #6) 함수(VoidCallback)를 외부에서 전달
                  onToggleDone: () => _toggleDone(toDo.id),
                  onToggleFavorite: () => _toggleFavorite(toDo.id),
                  onDelete: () => _deleteTask(toDo.id),
                  // (신규) '상세보기'로 이동하는 함수를 onTap으로 전달
                  onTap: () => _navigateToDetail(toDo),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAddTodo, // 위에서 정의한 바텀 시트 띄우는 함수 호출
        shape: const CircleBorder(),
        backgroundColor: Colors.deepOrange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
