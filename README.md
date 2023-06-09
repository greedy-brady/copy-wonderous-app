# midas_coffee_app

midas-coffee-web-flutter

[x] getX로 상태관리 -> 사용안함, get_it_mixin 으로 상태관리
[v] go_router로 라우터 설정
[v] splash 화면 설정
[v] get_it: di 세팅
[v] locale 설정
[v] theme, size 설정
[] 화면 ui, animation 그려보기
[] data 구조도 생각해서 model 작성하기
[] firebase 통한 로그인 설정? // firebase appTracking 할 때 필요함
[] supabase 도 세팅해보기 // 기능이 전부 구현된게 아니라서,,, 써야함
[] api call 핸들링

- 라우터 구조

  1. 스플래시 // 처음에 사알짝 보여주는 거
  2. 인트로 ? // 처음에 소개 페이지?
  3. 홈 //
  4. 세팅 // 프로파일

- splash command
  `flutter pub run flutter_native_splash:create --path=flutter_native_splash.yaml`
  `flutter pub run flutter_native_splash:remove`

- 탭 구조

  1. 커피 종류
  2. 커피 관련된 탭들

---

현재 에러상황

1. locale과 관련해서 문제가 있는 듯 함. -> 앱 카피는 여기까지 하고, 다른 프로젝트를 만들면서 체크해 봐야겠음 !
