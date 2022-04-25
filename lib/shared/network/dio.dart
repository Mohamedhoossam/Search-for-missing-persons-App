import 'package:dio/dio.dart';

class DioHelper{

static late Dio dio;
static init(){

  dio = Dio(
  BaseOptions(

   baseUrl: "https://missingtest.herokuapp.com",
    receiveDataWhenStatusError: true,
    connectTimeout:20 * 1000,  //20 seconds
    receiveTimeout: 20 * 1000,  //20 seconds
   )
  );
}

static Future<Response> postData({
  required String url,
  required dynamic data,
  Map<String,dynamic>? query,
  String? token,
})async{
  dio.options.headers={
    'Authorization':token??'',
  };
    return await dio.post(url,data:data,queryParameters:query,);

}


static Future<Response> patchData(
    {
      required String url,
      String? token,
      Map<String,dynamic>?query,
      required dynamic data,

    }) async{
  dio.options.headers={
    'Authorization':token??'',
  };


  return await dio.patch(url,queryParameters: query,data:data );
}

static Future<Response> getData(
    {
      required String url,
      String? token,
      Map<String,dynamic>?query,

    }) async{

  dio.options.headers={
    'Authorization':token??'',
  };
  return await dio.get(url,queryParameters: query,);
}

static Future<Response> deleteData(
    {
      required String url,
      String? token,
      Map<String,dynamic>?query,
      Map<String,dynamic>? data,

    }) async{

  dio.options.headers={
    'Authorization':token??'',
  };
  return await dio.delete(url,queryParameters: query,data:data,);
}
}