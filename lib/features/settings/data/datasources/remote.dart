import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../models/zone_model.dart';

class SettingsRemoteDataSource {

  final ApiHandel apiHandel;
  SettingsRemoteDataSource(this.apiHandel);

  Future<Either<DioException,List<ZoneModel>>> getZones()async{
    var response = await apiHandel.get('WorkZones/mobile/config');
    List<ZoneModel> list=[] ;
    return response.fold((l) => Left(l), (r) {
      for (var item in r.data['data']['zones']) {
        list.add(ZoneModel.fromJson(item));
      }
      return Right(list);
    });
  }


}