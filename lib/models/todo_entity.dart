

// 과제 기본 조건 'ToDoEntity' 데이터 모델 클래스
class ToDoEntity {
  final String id; // 고유 ID (DateTime.now()로 생성)
  final String title; // 할 일 제목
  final String? description; // 할 일 세부 설명 (nullable, '?'는 null이 될 수 있음을 의미)
  final bool isDone; // 완료 여부
  final bool isFavorite; // 즐겨찾기 여부

  ToDoEntity({
    required this.id,
    required this.title,
    this.description, // nullable로 설정
    this.isDone = false, // 기본값 false
    this.isFavorite = false, // 기본값 false
  });
}