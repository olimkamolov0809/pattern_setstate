import 'dart:convert';

import 'package:http/http.dart';
import 'package:pattern_setstate/services/log_servic.dart';

import '../model/post_model.dart';


class Network{
  static String BASE = "jsonplaceholder.typicode.com";
  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

/*Http Requests*/
  static Future<String?>  GET(String api, Map<String, String> params) async{
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    LogService.i(response.body);
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }

  static Future<String?>  POST(String api, Map<String, String> params)async{
    var uri = Uri.https(BASE, api);
    var response = await post(uri, headers: headers, body:jsonEncode(params));
    LogService.i(response.body);
    if(response.statusCode == 200 ){
      return response.body;
    }
    return null;
  }

  static Future<String?>  PUT(String api, Map<String, String> params)async{
    var uri = Uri.https(BASE, api);
    var response = await put(uri, headers: headers, body:jsonEncode(params));
    LogService.i(response.body);
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }

  static Future<String?>  DEL(String api, Map<String, String> params)async{
    var uri = Uri.https(BASE, api, params );
    var response = await delete(uri, headers: headers);
    LogService.i(response.body);
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }

  /* Http Params */

  static Map<String, String> paramsEmpty() {
    Map<String, String> params = Map();
    return params;
  }

  static Map<String, String> paramsCreate(Post post){
    Map<String, String> params = Map();
    params.addAll({
      'title': post.title,
      'body': post.body,
      'userId': post.userId.toString(),
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Post post){
    Map<String, String> params = Map();
    params.addAll({
      'id': post.id.toString(),
      'title': post.title,
      'body': post.body,
      'userId': post.userId.toString(),
    });
    return params;
  }


/*Http Parsing*/

 static List<Post> parsePostList(String respons) {
   dynamic json = jsonDecode(respons);
   var data = List<Post>.from(json.map((x) => Post.fromJson(x)));
   return data;
 }

  /*Http Apis*/
  static String API_LIST = "/post";
  static String API_CREATE = "/post"; //
  static String API_UPDATE = "/post"; // {id}
  static String API_DELETE = "/post"; // {id}


}