import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http; //包重命后改名
import 'package:travel/model/home_model.dart';

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

///首页大接口
class HomeDao {
  static Future<HomeModel> fetch() async {
    final response = await http.get(HOME_URL);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); //fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception('首页接口请求失败：${response.statusCode}');
    }
  }
}
