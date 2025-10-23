📝 창수의 Tasks (Flutter To-Do 앱)

Flutter를 학습하며 만든 간단한 할 일 관리 앱입니다. 이 프로젝트는 Flutter의 핵심 위젯 사용법, 상태 관리, 화면 탐색(Navigation) 및 테마 적용까지의 과정을 연습하기 위해 만들어졌습니다.

✨ 주요 기능

이 앱에는 다음과 같은 기능들이 구현되어 있습니다.

할 일 추가: FloatingActionButton을 통해 새 할 일을 추가합니다.

바텀 시트(Bottom Sheet): 화면 하단에서 올라오는 입력창을 사용합니다.

세부 정보 & 즐겨찾기: 제목 외에 '세부 정보'와 '즐겨찾기' 여부를 함께 저장할 수 있습니다.

유효성 검사: 제목이 비어있으면 "할 일을 입력해주세요"라는 **스낵바(SnackBar)**가 표시됩니다.

할 일 목록 (메인 화면)

조건부 렌더링: 할 일이 없으면 '할 일 없음' 화면(NoToDoView)을, 할 일이 있으면 목록을 보여줍니다.

커스텀 UI: 각 할 일 항목을 '섬(Island)' 형태의 Container로 디자인했습니다.

완료 처리: 체크 아이콘을 눌러 할 일의 완료/미완료 상태를 토글할 수 있습니다. (완료 시 취소선 적용)

즐겨찾기: 별표 아이콘을 눌러 즐겨찾기 상태를 토글할 수 있습니다.

삭제: 휴지통 아이콘을 눌러 할 일을 삭제합니다.

할 일 상세 보기

할 일 항목을 클릭하면 별도의 '상세 보기' 페이지로 이동합니다.

페이지 내에서 '즐겨찾기' 상태를 변경할 수 있으며, 이 상태는 메인 목록 화면에도 즉시 반영됩니다.

다크 테마 지원

ThemeData 및 ThemeMode.system을 사용하여 시스템 설정(라이트/다크)에 맞는 테마를 자동으로 적용합니다.

UX/UI 개선

할 일 추가 시 키보드가 자동으로 올라오고, resizeToAvoidBottomInset을 사용해 FAB 버튼이 키보드에 가려지지 않도록 고정했습니다.

🚀 배운 내용들

이 프로젝트를 통해 다음과 같은 Flutter의 핵심 개념들을 연습했습니다.

상태 관리: StatefulWidget과 setState를 사용한 기본적인 상태 관리

위젯 분리: 코드를 models, screens, widgets 폴더로 나누어 관리하는 '컴포넌트화'

화면 이동: Navigator.push와 Navigator.pop을 사용한 페이지 이동 및 데이터 반환

UI 구현: ListView.builder, Scaffold, AppBar, ModalBottomSheet, Container, Row 등 다양한 위젯 활용

콜백(Callback): 부모 위젯의 함수(기능)를 자식 위젯으로 전달하여 실행

테마: ThemeData를 커스텀하여 darkTheme 적용

UX: SnackBar, FocusNode, MediaQuery 등을 활용한 사용자 경험 개선
