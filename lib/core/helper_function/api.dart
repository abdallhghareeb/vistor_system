import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../constants/constants.dart';
import 'convert.dart';
import 'prefs.dart';

class ApiHandel {
  static ApiHandel? _instance;
  late Dio dio;

  ApiHandel._();

  String? token;
  String? lang;
  late CancelToken cancelToken;

  static ApiHandel get getInstance {
    _instance ??= ApiHandel._(); // Instantiate if null
    return _instance!;
  }

  Future<void> init() async {
    lang = sharedPreferences.getString('language_code') ?? "ar";
    token = sharedPreferences.getString('token');
    dio = Dio(
      BaseOptions(
        baseUrl: Constants.domain,
        // will not throw errors
        validateStatus: (status) => true,
        headers: {
          "lang": lang ?? "ar",
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
      ),
    );

    // await Future.wait([
    //   for (var i in LanguageProvider.languages) Dio().get('${Constants.baseUri}app_languages/user/${i.languageCode}.json'),
    // ]).then((value) {
    //   Map data = {};
    //   for (int i = 0; i < LanguageProvider.languages.length; i++) {
    //     data[LanguageProvider.languages[i].languageCode] = value[i].data;
    //   }
    //   languages = data;
    // });
  }

  Map languages = {};

  void cancelFunction() async {
    cancelToken.cancel();
  }

  void updateHeader(String token, {String? language}) {
    this.token = token;
    if (language != null) {
      lang = language;
    }
    sharedPreferences.setString('token', token);
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.options.headers["lang"] = lang;
  }

  Future<Either<DioException, Response>> get(
    path, [
    Map<String, dynamic>? data,
  ]) async {
    try {
      await reLogin(path);
      cancelToken = CancelToken();
      Response response = await dio.get(
        path,
        queryParameters: data,
        cancelToken: cancelToken,
      );
      final isSuccess = response.statusCode == 200 || response.statusCode == 201;
      if (isSuccess) {
        return Right(response);
      }
      print('data is $response');
      print('error1 in $path');
      print('error1 inaaaaaaaaaaaaaa ${sharedPreferences.getString("token")}');
      print('$response');
      return Left(dioException(response));
    } on DioException catch (e) {
      print(e.toString());
      print(e.message);
      print({'get error2'});
      return Left(e.response == null ? e : dioException(e.response!));
    } catch (e) {
      print('error3');
      return Left(
        DioException(
          requestOptions: RequestOptions(baseUrl: Constants.domain, path: path),
          message: 'Server Error',
        ),
      );
    }
  }

  Future<Either<DioException, Response>> post(
    path,
    Map<String, dynamic> data, {bool isFormData = false}
  ) async {
    print(path);
    print(data);
    try {
      await reLogin(path);
      cancelToken = CancelToken();
      final formData = FormData.fromMap(data);

      Response response = await dio.post(path, data: isFormData ? formData :data, cancelToken: cancelToken);
      final isSuccess = response.statusCode == 200 || response.statusCode == 201;
      if (isSuccess) {
        return Right(response);
      }
      print("aaaaaaaaaaaaaaa$response");
      print('error${response.statusCode}');
      print('error1');
      return Left(dioException(response));
    } on DioException catch (e) {
      debugPrint(e.toString());
      debugPrint(e.message);
      // print(" ON $e");
      print('error2');
      return Left(e.response == null ? e : dioException(e.response!));
    } catch (e) {
      print('error3');
      debugPrint(e.toString());
      print("dioException ON $e");
      return Left(
        DioException(
          requestOptions: RequestOptions(baseUrl: Constants.domain, path: path),
          message: 'Server Error',
        ),
      );
    }
  }


  Future<Either<DioException, Response>> delete(
    path,
    Map<String, dynamic> data,
  ) async {
    print(path);
    print(data);
    try {
      await reLogin(path);
      cancelToken = CancelToken();
      Response response = await dio.delete(
        path,
        data: data,
        cancelToken: cancelToken,
      );
      final isSuccess =
          response.statusCode == 200 ;
      if (isSuccess) {
        return Right(response);
      }
      print("aaaaaaaaaaaaaaa$response");
      print('error${response.statusCode}');
      print('error1');
      return Left(dioException(response));
    } on DioException catch (e) {
      debugPrint(e.toString());
      debugPrint(e.message);
      // print(" ON $e");
      print('error2');
      return Left(e.response == null ? e : dioException(e.response!));
    } catch (e) {
      print('error3');
      debugPrint(e.toString());
      print("dioException ON $e");
      return Left(
        DioException(
          requestOptions: RequestOptions(baseUrl: Constants.domain, path: path),
          message: 'Server Error',
        ),
      );
    }
  }

  DioException dioException(Response response) {
    String msg = 'Server Error';

    if (response.data is Map) {
      final data = response.data;

      if (data['Message'] is Map) {
        msg = convertMapToString(data['Message']);
      } else if (data['Message'] is List) {
        msg = data['Message'].join('\n');
      } else if (data['Message'] is String) {
        msg = data['Message'];
      } else {
        msg = 'Server Error'; // fallback
      }
    }

    return DioException(
      requestOptions: response.requestOptions,
      message: msg,
      type: msg == 'Server Error'
          ? DioExceptionType.unknown
          : DioExceptionType.badResponse,
      response: response,
      error: msg,
    );
  }

  Future<Either<DioException, Response>> put(path, Map<String, dynamic> data) async {
    print(path);
    print(data);
    try {
      await reLogin(path);
      cancelToken = CancelToken();
      Response response = await dio.put(path, data: data, cancelToken: cancelToken);
      final isSuccess =
          response.statusCode == 200 ;
      if (isSuccess) {
        return Right(response);
      }
      print("aaaaaaaaaaaaaaa$response");
      print('error1');
      return Left(dioException(response));
    } on DioException catch (e) {
      debugPrint(e.toString());
      debugPrint(e.message);
      // print(" ON $e");
      print('error2');
      return Left(e.response == null ? e : dioException(e.response!));
    } catch (e) {
      print('error3');
      debugPrint(e.toString());
      print("dioException ON $e");
      return Left(
        DioException(
          requestOptions: RequestOptions(baseUrl: Constants.domain, path: path),
          message: 'Server Error',
        ),
      );
    }
  }

  Future reLogin(String url) async {
    String? token = sharedPreferences.getString('token');
    if (token != null) {
      if (!url.contains("GenrateNewToken") && token.isNotEmpty && JwtDecoder.isExpired(token)) {
        print('sssssssssssssssss');
        await Provider.of<AuthProvider>(Constants.globalContext(), listen: false,).refreshToken(token: token);
      }
    }
  }
}
