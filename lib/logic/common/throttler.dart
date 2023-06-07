import 'dart:async';

import 'package:flutter/material.dart';

/// 사용용도
/*
이 Dart 코드는 Throttler라는 클래스를 정의하고 있습니다. 
이 클래스는 주어진 인터벌에 따라 연속적인 호출을 제한(Throttling)하는 역할을 합니다. 
이를 통해 스크롤 이벤트, 검색 필터링, 자동완성과 같은 메서드 호출의 량을 줄일 수 있습니다.

주어진 클래스의 구성요소는 다음과 같습니다.

1. 생성자(constructor)에서 interval 파라미터를 받아서 수행 간격을 설정합니다.
2. 필드 VoidCallback? _action은 가장 최근에 전달된 VoidCallback 작업을 저장합니다. 
3. 필드 Timer? _timer는 Timer 인스턴스를 참조하여 각 시간을 추적 및 관리합니다.

4. call(VoidCallback action, {bool immediateCall = true}) 메서드: 
이 메서드는 주어진 동작(action)을 호출하며, 연속된을 제한하기 위해 여러 작업이 주어지면 최근의 작업만 저장하게 됩니다. 
immediateCall 매개변수가 true(기본값)이면, 작업이 즉시 호출됩니다. 
그렇지 않으면 주어진 인터벌에 따라 호출되게 됩니다.
한 인터벌 내에 추가 호출이 발생할 경우 최근에 전달된 작업만 수행하고 그 전 작업은 제거됩니다.

5. _Action() 메서드: 내부에서만 호출되며, 가장 최근에 전달된 VoidCallback _action이 호출되게 하는 역할을 합니다. 
호출을 완료한 후 _timer을 null 설정하여 다음 호출을 준비합니다.

6. reset() 메서드: _action과 _timer을 null로 설정하여 초기 상태로 되돌립니다.

위 클래스를 사용하면, 연속적인 호출을 제한하여 리소스 사용량을 줄이고 더 나은 성능을 얻을 수 있습니다. 
이 클래스는 특히 이벤트 기반 동작이 빈번하게 발생하는 상황에서 유용하게 사용할 수 있습니다.
 */
class Throttler {
  Throttler(this.interval);
  final Duration interval;

  VoidCallback? _action;
  Timer? _timer;

  void call(VoidCallback action, {bool immediateCall = true}) {
    // Let the latest action override whatever was there before
    _action = action;
    // If no timer is running, we want to start one
    if (_timer == null) {
      //  If immediateCall is true, we handle the action now
      if (immediateCall) {
        _callAction();
      }
      // Start a timer that will temporarily throttle subsequent calls, and eventually make a call to whatever _action is (if anything)
      _timer = Timer(interval, _callAction);
    }
  }

  void _callAction() {
    _action?.call(); // If we have an action queued up, complete it.
    _timer = null;
  }

  void reset() {
    _action = null;
    _timer = null;
  }
}
