import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  late SharedPreferences sharedPreferences;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}){
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 120);
    token = "18|e3jwpgvQq4gsn669buj6xCtPlxkeW5fJDBt5Qalf1be7f406";
    _mainHeaders={
      'Content-type':'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      //"HttpHeaders.contentTypeHeader": "application/json"
    };
  }

  void updateHeader(String token){
    _mainHeaders={
      'Content-type':'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
  try {
    Response response = await get(
      uri,
      headers: headers ?? _mainHeaders,
    );
    print("Full Response: ${response.bodyString}");
    print("Response Status Code: ${response.statusCode}");
    return response;
  } catch (e) {
    print("Error during GET request: $e");
    return Response(statusCode: 1, statusText: e.toString());
  }
}


  Future<Response> postData(String uri, dynamic body)async{
    try{
      Response response = await post(uri, body, headers: _mainHeaders);
      return response;
    }catch(e){
      print(e.toString());
      return Response(statusText: e.toString(), statusCode: 1);
    }
  }

}