import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:shopfeeforemployee/core/common/models/result.dart';
import 'package:shopfeeforemployee/core/global/global_data.dart';
import 'package:shopfeeforemployee/core/service/shared_service.dart';

class BaseService {
  static const String BASE_PATH = "http://10.0.2.2:8080/api/";

  //api route
  static const String authPath = "auth";
  static const String employeePath = "employee";
  static const String orderPath = "order";
  static const String transactionPath = "transaction";

  late Dio dio;

  //CONSTRUCTOR
  BaseService() {
    dio = Dio(
      BaseOptions(
        baseUrl: BASE_PATH,
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        responseType: ResponseType.json,
        contentType: Headers.jsonContentType,
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (GlobalData.ins.accessToken != null) {
            options.headers['Authorization'] =
            "Bearer ${GlobalData.ins.accessToken}";
          }
          // if (!await isConnected()) {
          //   // throw an error if there is no internet connection
          //   throw DioException(
          //     error: "No internet connection", requestOptions: e.requestOptions,
          //   );
          // }
          return handler.next(options);
        },
        onError: (DioError e, handler) async {
          // if (!await isConnected()) {
          //   // throw an error if there is no internet connection
          //   throw DioException(
          //     error: "No internet connection", requestOptions: e.requestOptions,
          //   );
          // }
          if (e.response?.statusCode == 401) {
            // If a 401 response is received, refresh the access token
            Map<String, dynamic> body = {
              "refreshToken": GlobalData.ins.refreshToken,
            };
            try {
              var response = await dio
                  .post("${BaseService.authPath}/employee/refresh-token", data: body);
              var result = Result(
                  success: response.data["success"],
                  message: response.data["message"],
                  data: response.data["data"]);

              if(result.success){
                SharedService.setAccessToken(response.data!["accessToken"]);
                SharedService.setAccessToken(response.data!["refreshToken"]);
                GlobalData.ins.accessToken = SharedService.getAccessToken();
                GlobalData.ins.refreshToken = SharedService.getRefreshToken();

                // Update the request header with the new access token
                e.requestOptions.headers['Authorization'] =
                'Bearer ${GlobalData.ins.accessToken}';
              }
            } catch (e) {
              print(e);
            }
            // Repeat the request with the updated header
            return handler.resolve(await dio.fetch(e.requestOptions));
          }
          return handler.next(e);
        },
      ),
    );
  }
}
Future<bool> isConnected() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;

}