import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// 사용용도
/*
이 Dart 코드는 JsonPrefsFile이라는 클래스를 정의하고 있습니다. 
이 클래스는 JSON 형식의 데이터를 Shared Preferences에 저장하고, 불러오기 위한 기능을 제공합니다. 
이 클래스를 이용하면, 애플리케이션 설정이나 사용자 데이터와 같은 작은 정보들을 로컬 스토리지에 저장하고 관리할 수 있습니다. 
코드를 살펴보면 다음과 같은 기능을 확인할 수 있습니다.

1. 'dart:convert'와 'package:shared_preferences/shared_preferences.dart' 패키지를 가져옵니다.

2. JsonPrefsFile 클래스를 정의하고, 생성자에서 파일의 이름을 매개 변수로 받습니다.

3. `load()` 메서드: 이 메서드는 Shared Preferences 인스턴스에서 주어진 이름으로 저장된 데이터를 불러오는 기능을 합니다. 
데이터는 JSON 포맷의 문자열로 저장되어 있으며, 이 메서드를 호출하면 그 데이터를 파싱해서 Dart의 Map<String, dynamic> 형태로 반환해줍니다.

4. `save()` 메서드: 이 메서드는 Dart의 Map<String, dynamic> 형태로 되어 있는 데이터를 받아 JSON을 문자열로 인코딩하고, 
Shared Preferences 인스턴스에 해당 문자열을 저장합니다.

이 클래스를 사용하면, JSON 형태의 데이터를 로컬 스토리지에 쉽게 저장하고 불러올 수 있습니다. 
Shared Preferences는 애플리케이션의 설정이나 작은 사용자 데이터를 관리하는 데 적합한 방법입니다.

 */
class JsonPrefsFile {
  JsonPrefsFile(this.name);
  final String name;

  Future<Map<String, dynamic>> load() async {
    final p = (await SharedPreferences.getInstance()).getString(name);
    //print('loaded: $p');
    return Map<String, dynamic>.from(jsonDecode(p ?? '{}'));
  }

  Future<void> save(Map<String, dynamic> data) async {
    //print('saving $data');
    await (await SharedPreferences.getInstance())
        .setString(name, jsonEncode(data));
  }
}
