/// part, part of 를 통해서 임포트를 쉐어할 수 있다.
part of 'screen.dart';

/*
이 코드는 Flutter 애플리케이션에 세로로 스와이프를 처리하는 사용자 정의 '_VerticalSwipeController' 클래스를 구현하는 것입니다. 
이 클래스는 주로 세로 스와이프 제스처의 상태와 애니메이션을 관리합니다. 
주요 구성요소와 메소드는 다음과 같습니다.

1. 클래스 구성 요소:
    - `ticker`: TickerProvider 인스턴스로, 애니메이션 프레임 간의 시간을 받을 때 사용됩니다.
    - `swipeAmt`: ValueNotifier를 사용하여 스와이프 된 양(백분율)을 관리하는 데 사용되며 0부터 1까지 범위입니다.
    - `isPointerDown`: 사용자가 화면 누르고 있는지 여부를 나타내는 ValueNotifier입니다.
    - `swipeReleaseAnim`: 사용자가 스와이프를 놓았을 때 재생되는 애니메이션 컨트롤러입니다    
    - `_pullToViewDetailsThreshold`: 스와이프 도중 완료되는 데 필요한 스와이프 거리입니다.
    - `onSwipeComplete`: 스와이프가 완료되면 호출되는 콜백입니다.

2. 주요 메소드:
    - `handleSwipeReleaseAnimTick`: 애니메이션이 진행됨에 따라 swiperAmt의 값과 동기화하는 데 사용됩니다.
    - `handleTapDown`: 포인터가 화면에 닿으면 호출되어 isPointerDown 값을 true로 설정합니다.
    - `handleTapCancelled`: 포인터가 화면에서 떨어졌거나 취소되면 호출되어 isPointerDown 값을 false로 설정합니다.
    - `handleVerticalSwipeCancelled`: 스와이프가 취소되면 호출되어 스와이프 애니메이션을 거꾸로 실행합니다.
    - `handleVerticalSwipeUpdate`: 세로 스와이프가 업데이트될 때 호출되며 스와이프 애니메이션 값을 조정하여 스와이프 1의 값을 만듭니다.
    
아래 두 가지 유틸리티 메서드는 위젯이나 제스처 디텍터 등의 구성 요에 리스너를 추가 또는 제거하는 것을 자동화합니다:

1. `buildListener`: 빌더 메소드에 swiperAmt와 isPointerDown을 전달하는 ValueListenableBuilder를 사용하여 빌더 패턴을 구현하는 메서드입니다.
2. `wrapGestureDetector`: 여러 제스처 인터페이스를 구현하는 제스처 디텍터를 만드는 메서드로 사용자가 탭 또는 드래그 액션을 수행할 때 처리를 캡슐화.

이 클래스를 사용하면 위젯을 둘러싸는 제스처 디텍터를 만들어 세로 스와이프를 쉽게 처리할 수 있으며 백분율 방식으로 애니메이션과 상호 작용을 구현할 수 있습니다.
 */
class _VerticalSwipeController {
  _VerticalSwipeController(this.ticker, this.onSwipeComplete);
  final TickerProvider ticker;
  final swipeAmt = ValueNotifier<double>(0);
  final isPointerDown = ValueNotifier<bool>(false);
  late final swipeReleaseAnim = AnimationController(vsync: ticker)
    ..addListener(handleSwipeReleaseAnimTick);
  final double _pullToViewDetailsThreshold = 150;
  final VoidCallback onSwipeComplete;

  /// When the _swipeReleaseAnim plays, sync its value to _swipeUpAmt
  void handleSwipeReleaseAnimTick() => swipeAmt.value = swipeReleaseAnim.value;
  void handleTapDown() => isPointerDown.value = true;
  void handleTapCancelled() => isPointerDown.value = false;

  void handleVerticalSwipeCancelled() {
    swipeReleaseAnim.duration = swipeAmt.value.seconds * .5;
    swipeReleaseAnim.reverse(from: swipeAmt.value);
    isPointerDown.value = false;
  }

  void handleVerticalSwipeUpdate(DragUpdateDetails details) {
    if (swipeReleaseAnim.isAnimating) swipeReleaseAnim.stop();

    isPointerDown.value = true;
    double value =
        (swipeAmt.value - details.delta.dy / _pullToViewDetailsThreshold)
            .clamp(0, 1);
    if (value != swipeAmt.value) {
      swipeAmt.value = value;
      if (swipeAmt.value == 1) {
        onSwipeComplete();
      }
    }

    //print(_swipeUpAmt.value);
  }

  /// Utility method to wrap a couple of ValueListenableBuilders and pass the values into a builder methods.
  /// Saves the UI some boilerplate when subscribing to changes.
  Widget buildListener(
      {required Widget Function(
              double swipeUpAmt, bool isPointerDown, Widget? child)
          builder,
      Widget? child}) {
    return ValueListenableBuilder<double>(
      valueListenable: swipeAmt,
      builder: (_, swipeAmt, __) => ValueListenableBuilder<bool>(
        valueListenable: isPointerDown,
        builder: (_, isPointerDown, __) {
          return builder(swipeAmt, isPointerDown, child);
        },
      ),
    );
  }

  /// Utility method to wrap a gesture detector and wire up the required handlers.
  Widget wrapGestureDetector(Widget child, {Key? key}) => GestureDetector(
      key: key,
      excludeFromSemantics: true,
      onTapDown: (_) => handleTapDown(),
      onTapUp: (_) => handleTapCancelled(),
      onVerticalDragUpdate: handleVerticalSwipeUpdate,
      onVerticalDragEnd: (_) => handleVerticalSwipeCancelled(),
      onVerticalDragCancel: handleVerticalSwipeCancelled,
      behavior: HitTestBehavior.translucent,
      child: child);
}
